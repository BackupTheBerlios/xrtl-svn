unit xrtl_io_object_Reference;

{$INCLUDE xrtl.inc}

interface

uses
  Windows,
  SysUtils;

type
  TXRTLInstanceReference = class
  private
    FAllowShared: Boolean;
    FIsNil: Boolean;
    FReferenceId: string;
    FSelfRef: Boolean;
  protected
    procedure  InitReference(const Obj: TObject);
  public
    constructor Create(const Obj: TObject; const _AllowShared: Boolean);
    constructor CreateSelfReference(const Ref: TXRTLInstanceReference);
    destructor Destroy; override;
    property   AllowShared: Boolean read FAllowShared;
    property   IsNil: Boolean read FIsNil;
    property   ReferenceId: string read FReferenceId;
    property   SelfRef: Boolean read FSelfRef;
  end;

implementation

uses
  xrtl_util_Value,
  xrtl_reflect_ClassDescriptor, xrtl_reflect_Introspector, xrtl_reflect_Property,
  xrtl_reflect_PropertyList;

var
  FReferenceCount: Integer = 0;

type
  TXRTLInstanceReferenceIntrospector = class(TXRTLIntrospector)
  public
    procedure  DefineProperties(const Descriptor: IXRTLClassDescriptor;
                                const Properties: IXRTLPropertyList); override;
    procedure  GetValues(const Obj: TObject; const Properties: IXRTLPropertyList); override;
    procedure  SetValues(const Obj: TObject; const Properties: IXRTLPropertyList); override;
  end;

{ TXRTLInstanceReferenceIntrospector }

procedure TXRTLInstanceReferenceIntrospector.DefineProperties(const Descriptor: IXRTLClassDescriptor;
  const Properties: IXRTLPropertyList);
begin
  Properties.Add(TXRTLProperty.Create('AllowShared', XRTLValue(False)));
  Properties.Add(TXRTLProperty.Create('IsNil',       XRTLValue(False)));
  Properties.Add(TXRTLProperty.Create('ReferenceId', XRTLValue('')));
  Properties.Add(TXRTLProperty.Create('SelfRef',     XRTLValue(False)));
end;

procedure TXRTLInstanceReferenceIntrospector.GetValues(const Obj: TObject;
  const Properties: IXRTLPropertyList);
var
  LObj: TXRTLInstanceReference;
begin
  LObj:= Obj as TXRTLInstanceReference;
  XRTLSetValue(Properties.GetByName('AllowShared').Value, LObj.FAllowShared);
  XRTLSetValue(Properties.GetByName('IsNil').Value,       LObj.FIsNil);
  XRTLSetValue(Properties.GetByName('ReferenceId').Value, LObj.FReferenceId);
  XRTLSetValue(Properties.GetByName('SelfRef').Value,     LObj.FSelfRef);
end;

procedure TXRTLInstanceReferenceIntrospector.SetValues(const Obj: TObject;
  const Properties: IXRTLPropertyList);
var
  LObj: TXRTLInstanceReference;
begin
  LObj:= Obj as TXRTLInstanceReference;
  LObj.FAllowShared:= XRTLGetAsBoolean(Properties.GetByName('AllowShared').Value);
  LObj.FIsNil:=       XRTLGetAsBoolean(Properties.GetByName('IsNil').Value);
  LObj.FReferenceId:= XRTLGetAsWideString(Properties.GetByName('ReferenceId').Value);
  LObj.FSelfRef:=     XRTLGetAsBoolean(Properties.GetByName('SelfRef').Value);
end;

{ TXRTLInstanceReference }

constructor TXRTLInstanceReference.Create(const Obj: TObject; const _AllowShared: Boolean);
begin
  inherited Create;
  FSelfRef:= False;
  FAllowShared:= _AllowShared;
  InitReference(Obj);
end;

constructor TXRTLInstanceReference.CreateSelfReference(const Ref: TXRTLInstanceReference);
begin
  inherited Create;
  FSelfRef:= True;
  FAllowShared:= Ref.FAllowShared;
  FReferenceId:= Ref.FReferenceId;
  FIsNil:= False;
end;

destructor TXRTLInstanceReference.Destroy;
begin
  inherited;
end;

procedure TXRTLInstanceReference.InitReference(const Obj: TObject);
begin
  FIsNil:= not Assigned(Obj);
  FReferenceId:= '';
  if not FIsNil then
  begin
    FReferenceId:= Format('obj_%.8x_%.8x_%.8x', [Cardinal(Obj), GetTickCount,
                                                 InterlockedExchangeAdd(FReferenceCount, 1)]);
  end;
end;

initialization
begin
  XRTLRegisterClassDescriptor(TXRTLClassDescriptor.Create(TXRTLInstanceReference, 'xrtl:ref',
                                                          TXRTLInstanceReferenceIntrospector.Create));
end;

end.