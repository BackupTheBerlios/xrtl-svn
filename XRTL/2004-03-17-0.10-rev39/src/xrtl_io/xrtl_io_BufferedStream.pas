unit xrtl_io_BufferedStream;

{$INCLUDE xrtl.inc}

interface

uses
  Math,
  xrtl_util_CPUUtils,
  xrtl_io_Stream;

const
  XRTLDefaultBufferSize = 4096;

type
  TXRTLBufferedInputStream = class(TXRTLFilterInputStream)
  private
    FBufferData: Pointer;
    FBufferSize: Integer;
    FBufferLength: Integer;
    FReadPointer: Integer;
    procedure  SetBufferSize(const Value: Integer);
    procedure  FillBuffer;
  protected
    function   _ReadBuffer(var Buffer; const Count: Integer): Integer; override;
  public
    constructor Create(const ACoreStream: TXRTLInputStream;
                       AOwnCoreStream: Boolean = True;
                       const ABufferSize: Integer = XRTLDefaultBufferSize);
    destructor Destroy; override;
    property   BufferData: Pointer read FBufferData;
    property   BufferSize: Integer read FBufferSize write SetBufferSize;
    property   BufferLength: Integer read FBufferLength;
    function   BytesAvailable: Int64; override;
    function   BytesInBuffer: Int64;
    function   MarkPosition: TXRTLMarkData; override;
    procedure  RestorePosition(const MarkData: TXRTLMarkData); override;
    function   Skip(const Count: Int64): Int64; override;
  end;

  TXRTLBufferedOutputStream = class(TXRTLFilterOutputStream)
  private
    FBufferData: Pointer;
    FBufferSize: Integer;
    FWritePointer: Integer;
    procedure  SetBufferSize(const Value: Integer);
    function   BytesInBuffer: Integer;
  protected
    procedure  DoClose; override;
    procedure  _WriteBuffer(const Buffer; const Count: Integer); override;
  public
    constructor Create(const ACoreStream: TXRTLOutputStream;
                       AOwnCoreStream: Boolean = True;
                       const ABufferSize: Integer = XRTLDefaultBufferSize);
    destructor Destroy; override;
    property   BufferData: Pointer read FBufferData;
    property   BufferSize: Integer read FBufferSize write SetBufferSize;
    procedure  Flush; override;
  end;

implementation

uses
  xrtl_util_MemoryUtils;

type
  TXRTLBufferedInputStreamMarkData = class(TXRTLMarkData)
  public
    ReadPointer: Integer;
    BufferLength: Integer;
    BufferSize: Integer;
    Buffer: Pointer;
  end;

{ TXRTLBufferedInputStream }

constructor TXRTLBufferedInputStream.Create(const ACoreStream: TXRTLInputStream;
                                          AOwnCoreStream: Boolean = True;
                                          const ABufferSize: Integer = XRTLDefaultBufferSize);
begin
  inherited Create(ACoreStream, AOwnCoreStream);
  FBufferData:= nil;
  FReadPointer:= 0;
  FBufferLength:= 0;
  BufferSize:= ABufferSize;
end;

destructor TXRTLBufferedInputStream.Destroy;
begin
  XRTLFreeMemory(FBufferData);
  inherited;
end;

procedure TXRTLBufferedInputStream.SetBufferSize(const Value: Integer);
var
  ABuffer: Pointer;
  ABufferSize: Integer;
begin
// check if new size is smaller than current data present in buffer
  if Value < BytesInBuffer then
    Exit;
  ABufferSize:= Max(Value, 16);
  ABuffer:= XRTLGetMemory(ABufferSize);
  if FBufferData <> nil then
  begin
    XRTLMoveMemory(Pointer(Integer(FBufferData) + FReadPointer), ABuffer, BytesInBuffer);
    FBufferLength:= BytesInBuffer;
    XRTLFreeMemory(FBufferData);
  end;
  FBufferData:= ABuffer;
  FBufferSize:= ABufferSize;
  FReadPointer:= 0;
end;

function TXRTLBufferedInputStream.BytesAvailable: Int64;
begin
  Result:= BytesInBuffer + CoreStream.BytesAvailable;
end;

function TXRTLBufferedInputStream.BytesInBuffer: Int64;
begin
  Result:= FBufferLength - FReadPointer;
end;

function TXRTLBufferedInputStream.MarkPosition: TXRTLMarkData;
var
  MD: TXRTLBufferedInputStreamMarkData;
begin
  MD:= TXRTLBufferedInputStreamMarkData.Create(Self, inherited MarkPosition);
  MD.ReadPointer:= FReadPointer;
  MD.BufferLength:= FBufferLength;
  MD.Buffer:= XRTLGetMemory(BufferSize);
  XRTLMoveMemory(FBufferData, MD.Buffer, BufferSize);
  MD.BufferSize:= BufferSize;
  Result:= MD;
end;

procedure TXRTLBufferedInputStream.RestorePosition(const MarkData: TXRTLMarkData);
var
  MD: TXRTLBufferedInputStreamMarkData;
begin
  MarkData.CheckOwner(Self);
  inherited RestorePosition(MarkData.Next);
  MD:= MarkData as TXRTLBufferedInputStreamMarkData;
  XRTLGetMemory(FBufferData, MD.BufferSize);
  FBufferSize:= MD.BufferSize;
  XRTLMoveMemory(MD.Buffer, FBufferData, BufferSize);
  FBufferLength:= MD.BufferLength;
  FReadPointer:= MD.ReadPointer;
end;

procedure TXRTLBufferedInputStream.FillBuffer;
begin
  FReadPointer:= 0;
  FBufferLength:= inherited _ReadBuffer(FBufferData^, FBufferSize);
end;

function TXRTLBufferedInputStream._ReadBuffer(var Buffer; const Count: Integer): Integer;
var
  Step: Integer;
  InBuffer: Pointer;
begin
  Result:= 0;
  if Count = 0 then
    Exit;
  InBuffer:= @Buffer;
  while Result <> XRTLEndOfStreamValue do
  begin
    if BytesInBuffer <= 0 then
      FillBuffer;
    if BytesInBuffer > 0 then
    begin
      Step:= Min(Count - Result, BytesInBuffer);
      XRTLMoveMemory(XRTLPointerAdd(FBufferData, FReadPointer), InBuffer, Step);
      Inc(FReadPointer, Step);
      Inc(Result, Step);
      InBuffer:= XRTLPointerAdd(InBuffer, Step);
      if Result = Count then
        Break;
    end
    else
    begin
      if Result > 0 then
        Break
      else
        Result:= XRTLEndOfStreamValue;
    end;
  end;
end;

function TXRTLBufferedInputStream.Skip(const Count: Int64): Int64;
begin
  Result:= Min(Count, BytesInBuffer);
  Inc(FReadPointer, Result);
  if Result < Count then
    Result:= inherited Skip(Count - Result) + Result;
end;

{ TXRTLBufferedOutputStream }

constructor TXRTLBufferedOutputStream.Create(const ACoreStream: TXRTLOutputStream;
                                             AOwnCoreStream: Boolean = True;
                                             const ABufferSize: Integer = XRTLDefaultBufferSize);
begin
  inherited Create(ACoreStream, AOwnCoreStream);
  FBufferData:= nil;
  FWritePointer:= 0;
  BufferSize:= ABufferSize;
end;

destructor TXRTLBufferedOutputStream.Destroy;
begin
  XRTLFreeMemory(FBufferData);
  inherited;
end;

function TXRTLBufferedOutputStream.BytesInBuffer: Integer;
begin
  Result:= FWritePointer;
end;

procedure TXRTLBufferedOutputStream.SetBufferSize(const Value: Integer);
var
  ABuffer: Pointer;
  ABufferSize: Integer;
begin
// check if new size is smaller than current data present in buffer
  if Value < BytesInBuffer then
    Flush;
  ABufferSize:= Max(Value, 16);
  ABuffer:= XRTLGetMemory(ABufferSize);
  if FBufferData <> nil then
  begin
    XRTLMoveMemory(FBufferData, ABuffer, BytesInBuffer);
    XRTLFreeMemory(FBufferData);
  end;
  FBufferData:= ABuffer;
  FBufferSize:= ABufferSize;
end;

procedure TXRTLBufferedOutputStream.Flush;
begin
  if BytesInBuffer > 0 then
  begin
    inherited _WriteBuffer(FBufferData^, FWritePointer);
    FWritePointer:= 0;
  end;
end;

procedure TXRTLBufferedOutputStream._WriteBuffer(const Buffer; const Count: Integer);
var
  RCount, Step: Integer;
  InBuffer: Pointer;
begin
  RCount:= Count;
  InBuffer:= @Buffer;
  while RCount > 0 do
  begin
    Step:= Min(RCount, BufferSize - BytesInBuffer);
    XRTLMoveMemory(InBuffer, XRTLPointerAdd(FBufferData, FWritePointer), Step);
    Inc(FWritePointer, Step);
    Dec(RCount, Step);
    InBuffer:= XRTLPointerAdd(InBuffer, Step);
    if BytesInBuffer = BufferSize then
      Flush;
  end;
end;

procedure TXRTLBufferedOutputStream.DoClose;
begin
  Flush;
  inherited;
end;

end.
