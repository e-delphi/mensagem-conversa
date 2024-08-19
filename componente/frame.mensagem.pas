// Eduardo - 03/08/2024
unit frame.mensagem;

interface

uses
  System.Classes,
  System.Types,
  System.UITypes,
  FMX.Objects,
  FMX.Types,
  FMX.Controls,
  FMX.Layouts,
  FMX.Forms,
  FMX.Graphics,
  FMX.Ani,
  visualizador.tipos,
  visualizador.so,
  frame.base,
  frame.mensagem.conteudo;

type
  TFrameMensagem = class(TFrameBase)
    lytLargura: TLayout;
    rtgFundo: TRectangle;
    txtNome: TText;
    lytBottom: TLayout;
    txtHora: TText;
    pthStatus: TPath;
    procedure FrameResized(Sender: TObject);
    procedure FramePaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  private
    FConteudos: TArray<TFrameConteudo>;
    FStatus: TStatus;
    FNome: String;
    FNomeVisivel: Boolean;
    FVisualizada: Boolean;
    FAoVisualizar: TEventoMensagem;
    function GetLado: TLado;
    procedure SetLado(const Value: TLado);
    procedure SetStatus(const Value: TStatus);
    procedure SetNomeVisivel(const Value: Boolean);
    function GetNomeVisivel: Boolean;
    procedure SetNome(const Value: String);
    procedure SetVisualizada(const Value: Boolean);
    function CorFundo(const Value: TLado): TAlphaColor;
  public
    procedure AfterConstruction; override;
    property Lado: TLado read GetLado write SetLado;
    property Status: TStatus read FStatus write SetStatus;
    property Nome: String read FNome write SetNome;
    property NomeVisivel: Boolean read GetNomeVisivel write SetNomeVisivel;
    property Visualizada: Boolean read FVisualizada write SetVisualizada;
    property AoVisualizar: TEventoMensagem read FAoVisualizar write FAoVisualizar;
    procedure AddConteudo(Conteudo: TFrameConteudo);
    procedure Piscar(Cor: TAlphaColor; Tempo: Single = 0.2);
  end;

implementation

uses
  System.Math,
  System.SysUtils;

{$R *.fmx}

procedure TFrameMensagem.AfterConstruction;
begin
  inherited;
  FNomeVisivel := True;
  FVisualizada := False;
end;

function TFrameMensagem.GetLado: TLado;
begin
  Result := TLado(lytLargura.Align);
end;

function TFrameMensagem.CorFundo(const Value: TLado): TAlphaColor;
begin
  case Value of
    TLado.Direito:  Result := $FFCFE7FF;
    TLado.Esquerdo: Result := $FFEDEDED;
  else
    Result := 0;
  end;
end;

procedure TFrameMensagem.SetLado(const Value: TLado);
begin
  lytLargura.Align := TAlignLayout(Value);

  SetStatus(Status);

  case Value of
    TLado.Direito:
    begin
      Self.Margins.Left  := 30;
      Self.Margins.Right := 0;
    end;
    TLado.Esquerdo:
    begin
      Self.Margins.Left  := 0;
      Self.Margins.Right := 30;
    end;
  end;

  rtgFundo.Fill.Color := CorFundo(Value);
end;

procedure TFrameMensagem.SetStatus(const Value: TStatus);
begin
  FStatus := Value;

  case Lado of
    TLado.Direito:
    begin
      case Value of
      TStatus.Pendente:
      begin
        pthStatus.Data.Data := 'M382,-240 L154,-468 L211,-525 L382,-354 L749,-721 L806,-664 L382,-240 Z';
        pthStatus.Fill.Color := TAlphaColors.Gray;
        pthStatus.Size.Width := 10;
        pthStatus.Size.Height := 10;
      end;
      TStatus.Recebida:
      begin
        pthStatus.Data.Data :=
          'M268,-240 L42,-466 L99,-522 L269,-352 L325,-296 L268,-240 Z M494,-240 L268,-466 '+
          'L324,-523 L494,-353 L862,-721 L918,-664 L494,-240 Z M494,-466 L437,-522 L635,-720 L692,-664 L494,-466 Z';
        pthStatus.Fill.Color := TAlphaColors.Gray;
        pthStatus.Size.Width := 14;
        pthStatus.Size.Height := 14;
      end;
      TStatus.Visualizada:
      begin
        pthStatus.Data.Data :=
          'M268,-240 L42,-466 L99,-522 L269,-352 L325,-296 L268,-240 Z M494,-240 L268,-466 '+
          'L324,-523 L494,-353 L862,-721 L918,-664 L494,-240 Z M494,-466 L437,-522 L635,-720 L692,-664 L494,-466 Z';
        pthStatus.Fill.Color := $FF007DFF;
        pthStatus.Size.Width := 14;
        pthStatus.Size.Height := 14;
      end;
    end;
    end;
    TLado.Esquerdo:
    begin
      pthStatus.Data.Data := '';
      pthStatus.Size.Width := 1;
    end;
  end;
end;

function TFrameMensagem.GetNomeVisivel: Boolean;
begin
  Result := FNomeVisivel;
end;

procedure TFrameMensagem.SetNome(const Value: String);
begin
  FNome := Value;
  SetNomeVisivel(FNomeVisivel);
end;

procedure TFrameMensagem.SetNomeVisivel(const Value: Boolean);
begin
  FNomeVisivel := Value;
  if FNomeVisivel then
  begin
    txtNome.Text := FNome;
    txtNome.Height := 22;
  end
  else
  begin
    txtNome.Text := '';
    txtNome.Height := 5;
  end;

  FrameResized(Self);
end;

procedure TFrameMensagem.SetVisualizada(const Value: Boolean);
begin
  FVisualizada := Value;
  if Assigned(AoVisualizar) then
    AoVisualizar(Self.Tag);
end;

procedure TFrameMensagem.AddConteudo(Conteudo: TFrameConteudo);
begin
  FConteudos := FConteudos + [Conteudo];
  rtgFundo.AddObject(Conteudo);
end;

procedure TFrameMensagem.Piscar(Cor: TAlphaColor; Tempo: Single);
begin
  rtgFundo.Fill.Color := Cor;
  TAnimator.StopPropertyAnimation(rtgFundo, 'Fill.Color');
  TAnimator.AnimateColor(rtgFundo, 'Fill.Color', CorFundo(Lado), Tempo, TAnimationType.InOut, TInterpolationType.Cubic);
end;

procedure TFrameMensagem.FrameResized(Sender: TObject);
var
  Target: TTarget;
  Conteudo: TFrameConteudo;
  iSomaAltura: Single;
  iMaxLargura: Single;
  Largura: Single;
begin
  if Length(FConteudos) = 0 then
    Exit;

  iSomaAltura := 0;
  iMaxLargura := 0;

  Largura := Self.Width - (lytLargura.Margins.Left + lytLargura.Margins.Right);
  
  for Conteudo in FConteudos do
  begin    
    Target := Conteudo.Target(Largura);
    iSomaAltura := iSomaAltura + Target.Height;
    iMaxLargura := Max(iMaxLargura, Min(Target.Width, Largura));
    Conteudo.Height := Target.Height;
  end;

  if txtNome.Visible then
    iSomaAltura := iSomaAltura + txtNome.Height;
  iSomaAltura := iSomaAltura + txtHora.Height;

  lytLargura.Width := iMaxLargura;
  Self.Height := iSomaAltura;
end;

procedure TFrameMensagem.FramePaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
  inherited;
  if not Visualizada {$IFDEF MSWINDOWS} and IsFormActive(Self) {$ENDIF} then
    Visualizada := True;
end;

end.
