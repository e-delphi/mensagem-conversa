// Eduardo - 21/08/2024
unit frame.separador.data;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  frame.base;

type
  TFrameSeparadorData = class(TFrameBase)
    rtgFundo: TRectangle;
    txtData: TText;
  private
    FData: TDateTime;
    function GetData: TDateTime; reintroduce;
    procedure SetData(const Value: TDateTime); reintroduce;
  public
    property Data: TDateTime read GetData write SetData;
  end;

implementation

{$R *.fmx}

{ TFrameSeparadorData }

function TFrameSeparadorData.GetData: TDateTime;
begin
  Result := FData;
end;

procedure TFrameSeparadorData.SetData(const Value: TDateTime);
begin
  FData := Value;
  txtData.Text := FormatDateTime('dd/mm', Value);
end;

end.
