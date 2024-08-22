// Eduardo - 03/08/2024
unit frame.chat;

interface

uses
  System.Types,
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.StdCtrls,
  FMX.Layouts,
  frame.base,
  frame.ultima;

type
  TFrameChat = class(TFrameBase)
    sbxCentro: TVertScrollBox;
    scroll: TSmallScrollBar;
    procedure FrameResized(Sender: TObject);
    procedure FrameMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure sbxCentroViewportPositionChange(Sender: TObject; const OldViewportPosition, NewViewportPosition: TPointF; const ContentSizeChanged: Boolean);
    procedure scrollChange(Sender: TObject);
  private
    FLarguraMaximaConteudo: Integer;
    procedure SetLarguraMaximaConteudo(const Value: Integer);
  public
    OnScrollChange: TNotifyEvent;
    property LarguraMaximaConteudo: Integer read FLarguraMaximaConteudo write SetLarguraMaximaConteudo;
  end;

implementation

uses
  System.Math,
  FMX.Objects;

{$R *.fmx}

procedure TFrameChat.FrameResized(Sender: TObject);
begin
  sbxCentro.Width := Min(LarguraMaximaConteudo, Self.Width);
end;

procedure TFrameChat.FrameMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  scroll.Value := scroll.Value - WheelDelta;
end;

procedure TFrameChat.sbxCentroViewportPositionChange(Sender: TObject; const OldViewportPosition, NewViewportPosition: TPointF; const ContentSizeChanged: Boolean);
begin
  scroll.Max := sbxCentro.ContentBounds.Height;
  scroll.ViewportSize := Self.Height;
  scroll.Value := NewViewportPosition.Y;
end;

procedure TFrameChat.scrollChange(Sender: TObject);
begin
  sbxCentro.ViewportPosition := TPointF.Create(0, scroll.Value);
  if Assigned(OnScrollChange) then
    OnScrollChange(Sender);
end;

procedure TFrameChat.SetLarguraMaximaConteudo(const Value: Integer);
begin
  FLarguraMaximaConteudo := Value;
  FrameResized(Self);
end;

end.
