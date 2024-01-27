// Eduardo - 07/01/2024
unit Mensagem.Texto;

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
  FMX.Controls.Presentation,
  FMX.Memo.Types,
  FMX.ScrollBox;

type
  TTexto = class(TFrame)
    txtMensagem: TText;
  public
    constructor Create(AOwner: TComponent); override;
    function Conteudo(Value: String): TTexto;
    procedure Redimencionar;
  end;

implementation

{$R *.fmx}

uses
  Mensagem.Tema;

constructor TTexto.Create(AOwner: TComponent);
begin
  inherited;
  TTema.Registrar(
    Self,
    procedure(Sender: TObject; Tema: TTema)
    begin
      TTexto(Sender).txtMensagem.TextSettings.FontColor := Tema.CorTexto;
    end
  );
end;

function TTexto.Conteudo(Value: String): TTexto;
begin
  txtMensagem.Text := Value;
  Result := Self;
  TTema.Atualizar;
end;

procedure TTexto.Redimencionar;
var
  R: TRectF;
begin
  if not Assigned(txtMensagem.Canvas) then
    Exit;

  R := RectF(0, 0, txtMensagem.Width, 10000);
  txtMensagem.Canvas.MeasureText(R, txtMensagem.Text, True, [], TTextAlign.Leading, TTextAlign.Leading);

  if R.Bottom < 10 then
    Exit;

  Height := R.Bottom + 10;
end;

end.
