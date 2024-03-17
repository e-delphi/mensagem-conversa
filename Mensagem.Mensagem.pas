// Eduardo - 13/01/2024
unit Mensagem.Mensagem;

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
  FMX.Layouts,
  Mensagem.Tema,
  Mensagem.Texto,
  Mensagem.Imagem;

type
  TMensagem = class(TFrame)
    rtgMensagem: TRectangle;
    lbRemetente: TLabel;
    lbHorario: TLabel;
    lytConteudo: TLayout;
    procedure lytConteudoResized(Sender: TObject);
  private
    FMinha: Boolean;
    FItens: TArray<TFrame>;
  public
    constructor Create(AOwner: TComponent); override;
    function Remetente(Value: String): TMensagem;
    function Minha(Value: Boolean): TMensagem;
    procedure Redimencionar;
    function NovoTexto: TTexto;
    function NovaImagem: TImagem;
  end;

implementation

uses
  System.Math;

{$R *.fmx}

{ TMensagem }

constructor TMensagem.Create(AOwner: TComponent);
begin
  inherited;
  TTema.Registrar(
    Self,
    procedure(Sender: TObject; Tema: TTema)
    begin
      TMensagem(Sender).lbRemetente.TextSettings.FontColor := Tema.CorTexto;
      TMensagem(Sender).lbHorario.TextSettings.FontColor := Tema.CorTexto;

      if TMensagem(Sender).FMinha then
        TMensagem(Sender).rtgMensagem.Fill.Color := Tema.CorFundoMensagemMinha
      else
        TMensagem(Sender).rtgMensagem.Fill.Color := Tema.CorFundoMensagemDeles;
    end
  );
end;

function TMensagem.Remetente(Value: String): TMensagem;
begin
  lbRemetente.Text := Value;
  Result := Self;
end;

function TMensagem.Minha(Value: Boolean): TMensagem;
begin
  FMinha := Value;
  if FMinha then
    rtgMensagem.Align := TAlignLayout.Right
  else
    rtgMensagem.Align := TAlignLayout.Left;
  Result := Self;
end;

function TMensagem.NovoTexto: TTexto;
begin
  Result := TTexto.Create(Self);
  Result.Name := 'frm'+ ComponentCount.ToString +'_'+ FormatDateTime('hhnnsszzz', Now);
  lytConteudo.AddObject(Result);
  FItens := FItens + [Result];
end;

function TMensagem.NovaImagem: TImagem;
begin
  Result := TImagem.Create(Self);
  Result.Name := 'frm'+ ComponentCount.ToString +'_'+ FormatDateTime('hhnnsszzz', Now);
  lytConteudo.AddObject(Result);
  FItens := FItens + [Result];
end;

procedure TMensagem.Redimencionar;
var
  iSoma: Integer;
  I: Integer;
  sz: TSize;
  iWidth: Integer;
  iHeight: Integer;
begin
  iWidth := 0;
  iHeight := 0;
  for var Item in FItens do
    if Item is TTexto then
    begin
      sz := TTexto(Item).Redimencionar;
      iWidth := Max(iWidth, sz.cx);
      iHeight := Max(iHeight, sz.cy)
    end
    else
    if Item is TImagem then
      TImagem(Item).Redimencionar;

  Height :=
    lbRemetente.Margins.Top +
    lbRemetente.Height +
    lbRemetente.Margins.Bottom +
    iHeight +
    lbHorario.Margins.Top +
    lbHorario.Height +
    lbHorario.Margins.Bottom +
    10;

  if iWidth > 0 then
    rtgMensagem.Width := iWidth + 25;

  lbHorario.RecalcSize;

//  iSoma := 0;
//  for I := 0 to Pred(lytConteudo.ControlsCount) do
//    iSoma := iSoma + Round(TFrame(lytConteudo.Controls[I]).Size.Height);
//  Height :=
//    lbRemetente.Margins.Top +
//    lbRemetente.Height +
//    lbRemetente.Margins.Bottom +
//    iSoma +
//    lbHorario.Margins.Top +
//    lbHorario.Height +
//    lbHorario.Margins.Bottom +
//    10;
end;

procedure TMensagem.lytConteudoResized(Sender: TObject);
begin
  Redimencionar;
end;

end.
