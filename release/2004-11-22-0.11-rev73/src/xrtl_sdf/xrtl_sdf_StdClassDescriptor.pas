unit xrtl_sdf_StdClassDescriptor;

{$INCLUDE xrtl.inc}

interface

uses
  SysUtils,
  xrtl_util_Compat,
  xrtl_reflect_ClassDescriptor, xrtl_reflect_Introspector;

type
  TXRTLValueCardinalClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueIntegerClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueInt64ClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueSingleClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueDoubleClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueExtendedClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueInterfaceClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueWideStringClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueObjectClassDescriptor = class(TXRTLClassDescriptor)
  protected
    procedure  DoDefineProperties(const Properties: IXRTLPropertyList); override;
    procedure  DoGetValues(const Obj: TObject; const Properties: IXRTLPropertyList); override;
    procedure  DoSetValues(const Obj: TObject; const Properties: IXRTLPropertyList); override;
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueVariantClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueCurrencyClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueCompClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueClassClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueGUIDClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

  TXRTLValueBooleanClassDescriptor = class(TXRTLClassDescriptor)
  protected
    function   DoCreateInstance: TObject; override;
  end;

procedure XRTLRegisterStdClassDescriptors;

implementation

uses
  {$IFDEF HAS_UNIT_VARIANTS}Variants, {$ENDIF}
  xrtl_util_ValueImpl, xrtl_sdf_Reference, xrtl_util_Value, xrtl_util_Container;

procedure XRTLRegisterStdClassDescriptors;
begin
  XRTLIntrospectorRegistry.Register(TXRTLInstanceReference, TXRTLInstanceReferenceIntrospector.Create);
  XRTLRegisterClassDescriptor(
    TXRTLClassDescriptor.Create(XRTLInstanceReferenceClassId, TXRTLInstanceReference));
  XRTLRegisterClassDescriptor(TXRTLValueCardinalClassDescriptor.Create(
                                'xrtl::value::Cardinal', TXRTLValueCardinal));
  XRTLRegisterClassDescriptor(TXRTLValueIntegerClassDescriptor.Create(
                                'xrtl::value::Integer', TXRTLValueInteger));
  XRTLRegisterClassDescriptor(TXRTLValueInt64ClassDescriptor.Create(
                                'xrtl::value::Int64', TXRTLValueInt64));
  XRTLRegisterClassDescriptor(TXRTLValueSingleClassDescriptor.Create(
                                'xrtl::value::Single', TXRTLValueSingle));
  XRTLRegisterClassDescriptor(TXRTLValueDoubleClassDescriptor.Create(
                                'xrtl::value::Double', TXRTLValueDouble));
  XRTLRegisterClassDescriptor(TXRTLValueExtendedClassDescriptor.Create(
                                'xrtl::value::Extended', TXRTLValueExtended));
  XRTLRegisterClassDescriptor(TXRTLValueInterfaceClassDescriptor.Create(
                                'xrtl::value::Interface', TXRTLValueInterface));
  XRTLRegisterClassDescriptor(TXRTLValueWideStringClassDescriptor.Create(
                                'xrtl::value::WideString', TXRTLValueWideString));
  XRTLRegisterClassDescriptor(TXRTLValueObjectClassDescriptor.Create(
                                'xrtl::value::Object', TXRTLValueObject));
  XRTLRegisterClassDescriptor(TXRTLValueVariantClassDescriptor.Create(
                                'xrtl::value::Variant', TXRTLValueVariant));
  XRTLRegisterClassDescriptor(TXRTLValueCurrencyClassDescriptor.Create(
                                'xrtl::value::Currency', TXRTLValueCurrency));
  XRTLRegisterClassDescriptor(TXRTLValueCompClassDescriptor.Create(
                                'xrtl::value::Comp', TXRTLValueComp));
  XRTLRegisterClassDescriptor(TXRTLValueClassClassDescriptor.Create(
                                'xrtl::value::Class', TXRTLValueClass));
  XRTLRegisterClassDescriptor(TXRTLValueGUIDClassDescriptor.Create(
                                'xrtl::value::GUID', TXRTLValueGUID));
  XRTLRegisterClassDescriptor(TXRTLValueBooleanClassDescriptor.Create(
                                'xrtl::value::Boolean', TXRTLValueBoolean));
  XRTLRegisterClassDescriptor(TXRTLClassDescriptor.Create(
                                'xrtl::container::SequentialContainer', TXRTLSequentialContainer));
  XRTLRegisterClassDescriptor(TXRTLClassDescriptor.Create(
                                'xrtl::container::SetContainer', TXRTLSetContainer));
  XRTLRegisterClassDescriptor(TXRTLClassDescriptor.Create(
                                'xrtl::container::KeyValueContainer', TXRTLKeyValueContainer));
end;

{ TXRTLValueCardinalClassDescriptor }

function TXRTLValueCardinalClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueCardinal.Create(0);
end;

{ TXRTLValueIntegerClassDescriptor }

function TXRTLValueIntegerClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueInteger.Create(0);
end;

{ TXRTLValueInt64ClassDescriptor }

function TXRTLValueInt64ClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueInt64.Create(0);
end;

{ TXRTLValueSingleClassDescriptor }

function TXRTLValueSingleClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueSingle.Create(0);
end;

{ TXRTLValueDoubleClassDescriptor }

function TXRTLValueDoubleClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueDouble.Create(0);
end;

{ TXRTLValueExtendedClassDescriptor }

function TXRTLValueExtendedClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueExtended.Create(0);
end;

{ TXRTLValueInterfaceClassDescriptor }

function TXRTLValueInterfaceClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueInterface.Create(nil);
end;

{ TXRTLValueWideStringClassDescriptor }

function TXRTLValueWideStringClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueWideString.Create('');
end;

{ TXRTLValueObjectClassDescriptor }

procedure TXRTLValueObjectClassDescriptor.DoDefineProperties(const Properties: IXRTLPropertyList);
begin
  Properties.Add(TXRTLProperty.Create('OwnValue', XRTLValue(False)));
end;

procedure TXRTLValueObjectClassDescriptor.DoGetValues(const Obj: TObject;
  const Properties: IXRTLPropertyList);
var
  LObj: TXRTLValueObject;
begin
  LObj:= Obj as TXRTLValueObject;
  XRTLSetValue(Properties.GetByName('OwnValue').Value, LObj.OwnValue);
end;

procedure TXRTLValueObjectClassDescriptor.DoSetValues(const Obj: TObject;
  const Properties: IXRTLPropertyList);
var
  LObj: TXRTLValueObject;
begin
  LObj:= Obj as TXRTLValueObject;
  LObj.OwnValue:= XRTLGetAsBoolean(Properties.GetByName('OwnValue').Value);
end;

function TXRTLValueObjectClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueObject.Create(nil, False);
end;

{ TXRTLValueVariantClassDescriptor }

function TXRTLValueVariantClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueVariant.Create(Unassigned);
end;

{ TXRTLValueCurrencyClassDescriptor }

function TXRTLValueCurrencyClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueCurrency.Create(0);
end;

{ TXRTLValueCompClassDescriptor }

function TXRTLValueCompClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueComp.Create(0);
end;

{ TXRTLValueClassClassDescriptor }

function TXRTLValueClassClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueClass.Create(nil);
end;

{ TXRTLValueGUIDClassDescriptor }

function TXRTLValueGUIDClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueGUID.Create(StringToGUID('{00000000-0000-0000-0000-000000000000}'));
end;

{ TXRTLValueBooleanClassDescriptor }

function TXRTLValueBooleanClassDescriptor.DoCreateInstance: TObject;
begin
  Result:= TXRTLValueBoolean.Create(False);
end;

end.
