// Eduardo - 04/08/2024
unit frame.editor;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  frame.base;

type
  TFrameEditor = class(TFrameBase)
    rtgFundo: TRectangle;
    rtgMensagem: TRectangle;
    mmMensagem: TMemo;
    txtMensagem: TText;
    lytCarinha: TLayout;
    pthCarinha: TPath;
    lytAnexo: TLayout;
    pthAnexo: TPath;
    lytEnviar: TLayout;
    pthEnviar: TPath;
    procedure FrameResized(Sender: TObject);
    procedure mmMensagemChangeTracking(Sender: TObject);
    procedure mmMensagemKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    function GetOnAnexoClick: TNotifyEvent;
    procedure SetOnAnexoClick(const Value: TNotifyEvent);
    function GetOnEmojiClick: TNotifyEvent;
    procedure SetOnEmojiClick(const Value: TNotifyEvent);
    function GetOnEnviarClick: TNotifyEvent;
    procedure SetOnEnviarClick(const Value: TNotifyEvent);
  public
    procedure AfterConstruction; override;
    property OnAnexoClick: TNotifyEvent read GetOnAnexoClick write SetOnAnexoClick;
    property OnEmojiClick: TNotifyEvent read GetOnEmojiClick write SetOnEmojiClick;
    property OnEnviarClick: TNotifyEvent read GetOnEnviarClick write SetOnEnviarClick;
  end;

implementation

uses
  System.Math;

{$R *.fmx}

{ TEditor }

procedure TFrameEditor.AfterConstruction;
begin
  inherited;
  mmMensagem.NeedStyleLookup;
  mmMensagem.ApplyStyleLookup;
  mmMensagem.StylesData['background.Source'] := nil;
end;

procedure TFrameEditor.FrameResized(Sender: TObject);
var
  TamanhoTexto: TRectF;
  cHeight: Single;
begin
  rtgMensagem.Width := Min(500, Self.Width);

  if not Assigned(mmMensagem.Canvas) then
    Exit;

  if mmMensagem.Width < 50 then
    Exit;

  TamanhoTexto := RectF(0, 0, mmMensagem.ContentSize.Width, 10000);
  mmMensagem.Canvas.MeasureText(TamanhoTexto, mmMensagem.Lines.Text, True, [], TTextAlign.Center, TTextAlign.Leading);
  cHeight := TamanhoTexto.Bottom + mmMensagem.Margins.Top + mmMensagem.Margins.Bottom;

  if cHeight > 40 then
    cHeight := cHeight + 5;
  Self.Height := Min(212, Max(40, cHeight));
  mmMensagem.ShowScrollBars := Self.Height > 200;
end;

procedure TFrameEditor.mmMensagemChangeTracking(Sender: TObject);
begin
  txtMensagem.Visible := mmMensagem.Lines.Text.IsEmpty;
  FrameResized(Self);
end;

procedure TFrameEditor.mmMensagemKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) and (Shift = []) then
  begin
    Key := 0;
    KeyChar := #0;
    if Assigned(lytEnviar.OnClick) then
      lytEnviar.OnClick(lytEnviar);
  end;
end;

function TFrameEditor.GetOnAnexoClick: TNotifyEvent;
begin
  Result := lytAnexo.OnClick;
end;

procedure TFrameEditor.SetOnAnexoClick(const Value: TNotifyEvent);
begin
  lytAnexo.OnClick := Value;
end;

function TFrameEditor.GetOnEmojiClick: TNotifyEvent;
begin
  Result := lytCarinha.OnClick;
end;

procedure TFrameEditor.SetOnEmojiClick(const Value: TNotifyEvent);
begin
  lytCarinha.OnClick := Value;
end;

function TFrameEditor.GetOnEnviarClick: TNotifyEvent;
begin
  Result := lytEnviar.OnClick;
end;

procedure TFrameEditor.SetOnEnviarClick(const Value: TNotifyEvent);
begin
  lytEnviar.OnClick := Value;
end;

end.
