// Eduardo - 10/08/2024
unit chat.visualizador;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Types,
  FMX.Controls,
  chat.tipos,
  frame.base,
  frame.chat,
  frame.editor,
  frame.anexo,
  frame.ultima,
  frame.mensagem,
  frame.conteudo.texto,
  frame.conteudo.imagem,
  frame.conteudo.anexo,
  frame.separador.data;

type
  TChatVisualizador = class(TControl, IControl)
  strict private
    FMensagens: TArray<TFrameMensagem>;
    FSeparadores: TArray<TFrameBase>;
  private
    Chat: TFrameChat;
    Ultima: TFrameUltima;
    FAoVisualizar: TEventoMensagem;
    function GetCount: Integer;
    function GetVisivel(const Index: Integer): Boolean;
    procedure AoVisualizarInterno(Index: Integer);
    procedure ChatScrollChange(Sender: TObject);
    function GetLarguraMaximaConteudo: Integer;
    procedure SetLarguraMaximaConteudo(const Value: Integer);
    function GetMensagem(const Index: Integer): TFrameMensagem;
  public
    constructor Create(AOwner: TComponent); override;
    function AdicionarMensagem(Usuario: String; Data: TDateTime; Conteudos: TArray<TConteudo>; PosTop: Single = -1): Integer; // retorna o index da mensagem, para quem criar a armazernar e recupera-la depois
    procedure RemoverMensagem(Index: Integer);
    function AdicionarSeparadorData(Data: TDateTime; PosTop: Single): Integer; // retorna o index do separador, para quem criar armazenar e recupera-lo depois
    function AdicionarSeparadorVisualizacao(PosTop: Single): Integer; // retorna o index do separador, para quem criar armazenar e recupera-lo depois
    procedure RemoveSeparador(Index: Integer);
    property LarguraMaximaConteudo: Integer read GetLarguraMaximaConteudo write SetLarguraMaximaConteudo;
    property Mensagem[const Index: Integer]: TFrameMensagem read GetMensagem;
    property Visivel[const Index: Integer]: Boolean read GetVisivel;
    property Count: Integer read GetCount;
    procedure Posicionar(Index: Integer = -1);
    procedure Piscar(Index: Integer; Cor: TAlphaColor; Tempo: Single = 0.2);
    function Visiveis: TArray<Integer>;
    function Listar: TArray<Integer>;
    property AoVisualizar: TEventoMensagem read FAoVisualizar write FAoVisualizar;
  end;

implementation

uses
  System.SysUtils;

{ TChatVisualizador }

constructor TChatVisualizador.Create(AOwner: TComponent);
begin
  inherited;
  Chat := TFrameChat.Create(Self);
  Self.AddObject(Chat);

  Ultima := TFrameUltima.Create(Chat.scroll);
  Chat.AddObject(Ultima);

  Chat.OnScrollChange := ChatScrollChange;
end;

procedure TChatVisualizador.ChatScrollChange(Sender: TObject);
begin
  Ultima.Change;
end;

function TChatVisualizador.AdicionarMensagem(Usuario: String; Data: TDateTime; Conteudos: TArray<TConteudo>; PosTop: Single = -1): Integer;
var
  Item: TConteudo;
  frmMensagem: TFrameMensagem;
  frmTexto: TFrameConteudoTexto;
  frmImagem: TFrameConteudoImagem;
  frmAnexo: TFrameConteudoAnexo;
begin
  frmMensagem := TFrameMensagem.Create(Self);
  frmMensagem.Nome := Usuario;
  frmMensagem.txtHora.Text := FormatDateTime('hh:nn', Data);
  frmMensagem.AoVisualizar := AoVisualizarInterno;

  for Item in Conteudos do
  begin
    case Item.Tipo of
      TTipo.Texto:
      begin
        frmTexto := TFrameConteudoTexto.Create(Self);
        frmTexto.txtMensagem.Text := Item.Conteudo;
        frmMensagem.AddConteudo(frmTexto);
      end;
      TTipo.Imagem:
      begin
        frmImagem := TFrameConteudoImagem.Create(Self);
        frmImagem.imgImagem.Bitmap.LoadFromFile(Item.Conteudo);
        frmMensagem.AddConteudo(frmImagem);
      end;
      TTipo.Arquivo:
      begin
        frmAnexo := TFrameConteudoAnexo.Create(Self);
        frmAnexo.lbNome.Text := ExtractFileName(Item.Conteudo);
        frmMensagem.AddConteudo(frmAnexo);
      end;
    end;
  end;

  Chat.sbxCentro.Content.AddObject(frmMensagem);
  FMensagens := FMensagens + [frmMensagem];
  Result := Pred(Length(FMensagens));

  // Armazena na mensagem o index dela para retornar nos eventos
  frmMensagem.Tag := Result;

  if PosTop = -1 then
    frmMensagem.Position.Y := Chat.scroll.Max
  else
    frmMensagem.Position.Y := PosTop;
end;

procedure TChatVisualizador.RemoverMensagem(Index: Integer);
var
  frmMensagem: TFrameMensagem;
begin
  frmMensagem := FMensagens[Index];
  Chat.sbxCentro.Content.RemoveObject(frmMensagem);
  FreeAndNil(frmMensagem);
  FMensagens[Index] := nil;
end;

function TChatVisualizador.AdicionarSeparadorData(Data: TDateTime; PosTop: Single): Integer;
var
  frmData: TFrameSeparadorData;
begin
  frmData := TFrameSeparadorData.Create(Self);
  Chat.sbxCentro.Content.AddObject(frmData);
  frmData.Data := Data;
  FSeparadores := FSeparadores + [frmData];
  Result := Pred(Length(FSeparadores));

  // Armazena no separador o index dele para poder remover depois
  frmData.Tag := Result;

  frmData.Position.Y := PosTop;
end;

function TChatVisualizador.AdicionarSeparadorVisualizacao(PosTop: Single): Integer;
begin
  Result := -1;
end;

procedure TChatVisualizador.RemoveSeparador(Index: Integer);
var
  frmBase: TFrameBase;
begin
  frmBase := FSeparadores[Index];
  Chat.sbxCentro.Content.RemoveObject(frmBase);
  FreeAndNil(frmBase);
  FSeparadores[Index] := nil;
end;

procedure TChatVisualizador.AoVisualizarInterno(Index: Integer);
begin
  if Assigned(AoVisualizar) then
    AoVisualizar(Index);
end;

procedure TChatVisualizador.Posicionar(Index: Integer = -1);
begin
  if Index = -1 then
    Chat.scroll.Value := Chat.scroll.Max - Chat.scroll.ViewportSize
  else
  begin
    if Visivel[Index] then
      Exit;

    if Chat.scroll.Value < FMensagens[Index].Position.Y then
      Chat.scroll.Value := FMensagens[Index].Position.Y - Chat.scroll.ViewportSize + FMensagens[Index].Size.Height
    else
      Chat.scroll.Value := FMensagens[Index].Position.Y;
  end;
end;

procedure TChatVisualizador.Piscar(Index: Integer; Cor: TAlphaColor; Tempo: Single);
begin
  FMensagens[Index].Piscar(Cor, Tempo);
end;

function TChatVisualizador.GetCount: Integer;
begin
  Result := Length(FMensagens);
end;

function TChatVisualizador.Visiveis: TArray<Integer>;
var
  I: Integer;
begin
  Result := [];
  for I := 0 to Pred(Count) do
    if Visivel[I] then
      Result := Result + [I];
end;

function TChatVisualizador.GetVisivel(const Index: Integer): Boolean;
begin
  Result :=
    (FMensagens[Index].Position.Y > Chat.scroll.Value) and
    (FMensagens[Index].Position.Y + FMensagens[Index].Size.Height < Chat.scroll.Value + Chat.scroll.ViewportSize);
end;

function TChatVisualizador.Listar: TArray<Integer>;
var
  I: Integer;
begin
  Result := [];
  for I := 0 to Pred(Count) do
    Result := Result + [I];
end;

function TChatVisualizador.GetLarguraMaximaConteudo: Integer;
begin
  Result := Chat.LarguraMaximaConteudo;
end;

procedure TChatVisualizador.SetLarguraMaximaConteudo(const Value: Integer);
begin
  Chat.LarguraMaximaConteudo := Value;
end;

function TChatVisualizador.GetMensagem(const Index: Integer): TFrameMensagem;
begin
  Result := FMensagens[Index];
end;


end.
