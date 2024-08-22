// Eduardo - 04/08/2024
unit frame.anexo;

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
  FMX.Memo.Types,
  FMX.ListBox,
  FMX.Layouts,
  FMX.Objects,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Controls.Presentation,
  frame.base,
  frame.anexo.item;

type
  TFrameAnexo = class(TFrameBase)
    odlgArquivo: TOpenDialog;
    rtgEditor: TRectangle;
    lytBotoes: TLayout;
    sbtCancelar: TSpeedButton;
    sbtEnviar: TSpeedButton;
    sbtAdicionar: TSpeedButton;
    lbTitulo: TLabel;
    vsbxConteudo: TVertScrollBox;
    procedure sbtAdicionarClick(Sender: TObject);
    procedure sbtCancelarClick(Sender: TObject);
    procedure sbtEnviarClick(Sender: TObject);
  private
    FEnviar: TNotifyEvent;
    procedure AdicionarItem(sArquivo: String);
    procedure RemoverItens;
    procedure AnexoRemoverClick(Sender: TObject);
    function GetAoEnviarClick: TNotifyEvent;
    procedure SetAoEnviarClick(const Value: TNotifyEvent);
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Exibir;
    function Selecionados: TArray<String>;
    property AoEnviarClick: TNotifyEvent read GetAoEnviarClick write SetAoEnviarClick;
  end;

implementation

uses
  System.IOUtils;

{$R *.fmx}

{ TAnexo }

const
  QUANTIDADE_VISIVEL = 5;

procedure TFrameAnexo.AfterConstruction;
begin
  inherited;
  Self.Visible := False;
end;

destructor TFrameAnexo.Destroy;
begin
  RemoverItens;
  inherited;
end;

procedure TFrameAnexo.AdicionarItem(sArquivo: String);
var
  Anexo: TFrameAnexoItem;
begin
  Anexo := TFrameAnexoItem.Create(vsbxConteudo, sArquivo);
  vsbxConteudo.Position.Y := Pred(vsbxConteudo.ComponentCount) * Anexo.Height;
  Anexo.OnRemoverClick := AnexoRemoverClick;

  if Pred(vsbxConteudo.ComponentCount) <= QUANTIDADE_VISIVEL then
    Self.Height := Self.Height + 55;

  if Pred(vsbxConteudo.ComponentCount) <= QUANTIDADE_VISIVEL then
    Self.Width := 296
  else
    Self.Width := 310;
end;

procedure TFrameAnexo.AnexoRemoverClick(Sender: TObject);
begin
  vsbxConteudo.RemoveObject(TFrameAnexoItem(Sender));
  TFrameAnexoItem(Sender).Free;

  if Pred(vsbxConteudo.ComponentCount) < QUANTIDADE_VISIVEL then
    Self.Height := Self.Height - 55;

  if Pred(vsbxConteudo.ComponentCount) <= QUANTIDADE_VISIVEL then
    Self.Width := 296
  else
    Self.Width := 310;
end;

procedure TFrameAnexo.RemoverItens;
var
  I: Integer;
  Item: TFrameAnexoItem;
begin
  for I := Pred(vsbxConteudo.ComponentCount) downto 0 do
  begin
    if vsbxConteudo.Components[I] is TFrameAnexoItem then
    begin
      Item := vsbxConteudo.Components[I] as TFrameAnexoItem;
      vsbxConteudo.RemoveObject(Item);
      Item.Free;
    end;
  end;
end;

procedure TFrameAnexo.sbtAdicionarClick(Sender: TObject);
begin
  if odlgArquivo.Execute then
    for var sArquivo in odlgArquivo.Files do
      AdicionarItem(sArquivo);
end;

procedure TFrameAnexo.sbtCancelarClick(Sender: TObject);
begin
  RemoverItens;
  Self.Visible := False;
end;

procedure TFrameAnexo.sbtEnviarClick(Sender: TObject);
begin
  if Assigned(FEnviar) then
    FEnviar(Self);

  RemoverItens;

  Self.Visible := False;
end;

function TFrameAnexo.GetAoEnviarClick: TNotifyEvent;
begin
  Result := FEnviar;
end;

procedure TFrameAnexo.SetAoEnviarClick(const Value: TNotifyEvent);
begin
  FEnviar := Value;
end;

function TFrameAnexo.Selecionados: TArray<String>;
var
  I: Integer;
  Item: TFrameAnexoItem;
begin
  Result := [];
  for I := 0 to Pred(vsbxConteudo.ComponentCount) do
  begin
    if vsbxConteudo.Components[I] is TFrameAnexoItem then
    begin
      Item := vsbxConteudo.Components[I] as TFrameAnexoItem;
      Result := Result + [Item.Arquivo];
    end;
  end;
end;

procedure TFrameAnexo.Exibir;
begin
  Self.Visible := True;
  Self.Height := 70;
end;

end.

