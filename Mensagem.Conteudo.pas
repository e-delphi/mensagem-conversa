// Eduardo - 14/01/2024
unit Mensagem.Conteudo;

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
  FMX.Layouts,
  FMX.Objects,
  Mensagem.Mensagem;

type
  TConteudo = class(TFrame)
    sbxMensagens: TScrollBox;
    rtgFundo: TRectangle;
    procedure sbxMensagensResized(Sender: TObject);
  private
    FItens: TArray<TFrame>;
  public
    class function New(AOwner: TFmxObject): TConteudo;
    constructor Create(AOwner: TComponent); override;
    procedure PosicionarUltima;
    function NovaMensagem: TMensagem;
    procedure Redimencionar;
  end;

implementation

uses
  Mensagem.Tema;

{$R *.fmx}

{ TConteudo }

function TConteudo.NovaMensagem: TMensagem;
begin
  Result := TMensagem.Create(Self);
  Result.Name := 'frm'+ ComponentCount.ToString +'_'+ FormatDateTime('hhnnsszzz', Now);
  Result.lbRemetente.Text := sbxMensagens.ComponentCount.ToString;
  Result.Position.Y := sbxMensagens.ContentBounds.Height;
  sbxMensagens.AddObject(Result);
  FItens := FItens + [Result];
end;

constructor TConteudo.Create(AOwner: TComponent);
begin
  inherited;
  TTema.Registrar(
    Self,
    procedure(Sender: TObject; Tema: TTema)
    begin
      TConteudo(Sender).rtgFundo.Fill.Color := Tema.CorFundo;
    end
  );
end;

class function TConteudo.New(AOwner: TFmxObject): TConteudo;
begin
  Result := TConteudo.Create(AOwner);
  Result.Name := 'frm'+ AOwner.ComponentCount.ToString +'_'+ FormatDateTime('hhnnsszzz', Now);
  AOwner.AddObject(Result);
end;

procedure TConteudo.PosicionarUltima;
begin
  sbxMensagens.ViewportPosition := TPointF.Create(0, sbxMensagens.ContentBounds.Height);
end;

procedure TConteudo.sbxMensagensResized(Sender: TObject);
begin
  Redimencionar;
end;

procedure TConteudo.Redimencionar;
begin
  for var Item in FItens do
    TMensagem(Item).Redimencionar;
end;

end.
