// Eduardo - 10/08/2024
unit chat.visualizador;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Types,
  FMX.Controls,
  chat.tipos,
  frame.chat,
  frame.editor,
  frame.anexo,
  frame.ultima,
  frame.mensagem,
  frame.conteudo.texto,
  frame.conteudo.imagem,
  frame.conteudo.anexo;

type
  TChatVisualizador = class(TControl, IControl)
  strict private
    FMensagens: TArray<TFrameMensagem>;
  private
    Chat: TFrameChat;
    Ultima: TFrameUltima;
    FAoVisualizar: TEventoMensagem;
    function GetStatus(const Index: Integer): TStatus;
    procedure SetStatus(const Index: Integer; const Value: TStatus);
    function GetLado(const Index: Integer): TLado;
    procedure SetLado(const Index: Integer; const Value: TLado);
    function GetNomeVisivel(const Index: Integer): Boolean;
    procedure SetNomeVisivel(const Index: Integer; const Value: Boolean);
    function GetNome(const Index: Integer): String;
    procedure SetNome(const Index: Integer; const Value: String);
    function GetPosTop(const Index: Integer): Single;
    function GetCount: Integer;
    function GetVisivel(const Index: Integer): Boolean;
    procedure AoVisualizarInterno(Index: Integer);
    procedure ChatScrollChange(Sender: TObject);
    function GetLarguraMaximaConteudo: Integer;
    procedure SetLarguraMaximaConteudo(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    function AdicionarMensagem(Usuario: String; Hora: TDateTime; Conteudos: TArray<TConteudo>; PosTop: Single = -1): Integer; // retorna o index da mensagem, para quem criar a mensagem armazernar e recupera-la depois
    property LarguraMaximaConteudo: Integer read GetLarguraMaximaConteudo write SetLarguraMaximaConteudo;
    property Status[const Index: Integer]: TStatus read GetStatus write SetStatus;
    property Lado[const Index: Integer]: TLado read GetLado write SetLado;
    property Nome[const Index: Integer]: String read GetNome write SetNome;
    property NomeVisivel[const Index: Integer]: Boolean read GetNomeVisivel write SetNomeVisivel;
    property Visivel[const Index: Integer]: Boolean read GetVisivel;
    property Top[const Index: Integer]: Single read GetPosTop;
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

function TChatVisualizador.AdicionarMensagem(Usuario: String; Hora: TDateTime; Conteudos: TArray<TConteudo>; PosTop: Single = -1): Integer;
var
  Item: TConteudo;
  frmMensagem: TFrameMensagem;
  frmTexto: TFrameConteudoTexto;
  frmImagem: TFrameConteudoImagem;
  frmAnexo: TFrameConteudoAnexo;
begin
  frmMensagem := TFrameMensagem.Create(Self);
  frmMensagem.Nome := Usuario;
  frmMensagem.txtHora.Text := FormatDateTime('hh:nn', Hora);
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

function TChatVisualizador.GetStatus(const Index: Integer): TStatus;
begin
  Result := FMensagens[Index].Status;
end;

function TChatVisualizador.GetPosTop(const Index: Integer): Single;
begin
  Result := FMensagens[Index].Position.Y;
end;

procedure TChatVisualizador.SetStatus(const Index: Integer; const Value: TStatus);
begin
  FMensagens[Index].Status := Value;
end;

function TChatVisualizador.GetLado(const Index: Integer): TLado;
begin
  Result := FMensagens[Index].Lado;
end;

procedure TChatVisualizador.SetLado(const Index: Integer; const Value: TLado);
begin
  FMensagens[Index].Lado := Value;
end;

function TChatVisualizador.GetNome(const Index: Integer): String;
begin
  Result := FMensagens[Index].Nome;
end;

procedure TChatVisualizador.SetNome(const Index: Integer; const Value: String);
begin
  FMensagens[Index].Nome := Value;
end;

function TChatVisualizador.GetNomeVisivel(const Index: Integer): Boolean;
begin
  Result := FMensagens[Index].NomeVisivel;
end;

procedure TChatVisualizador.SetNomeVisivel(const Index: Integer; const Value: Boolean);
begin
  FMensagens[Index].NomeVisivel := Value;
end;

end.
