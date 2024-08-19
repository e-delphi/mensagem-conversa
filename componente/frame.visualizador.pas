// Eduardo - 10/08/2024
unit frame.visualizador;

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
  frame.base,
  frame.chat,
  frame.editor,
  frame.anexo,
  frame.mensagem,
  frame.conteudo.texto,
  frame.conteudo.imagem,
  frame.conteudo.anexo,
  frame.ultima;

type
  TFrameVisualizador = class(TFrameBase)
  private
    procedure EditorAnexoClick(Sender: TObject);
    procedure AnexoEnviarClick(Sender: TObject);
    procedure ChatScrollChange(Sender: TObject);
  public
    Chat: TFrameChat;
    Editor: TFrameEditor;
    Anexo: TFrameAnexo;
    Ultima: TFrameUltima;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

{ TVisualizador }

procedure TFrameVisualizador.AfterConstruction;
begin
  inherited;
  Chat := TFrameChat.Create(Self);
  Self.AddObject(Chat);

  Editor := TFrameEditor.Create(Self);
  Self.AddObject(Editor);

  Anexo := TFrameAnexo.Create(Self);
  Self.AddObject(Anexo);

  Ultima := TFrameUltima.Create(Chat.scroll);
  Chat.AddObject(Ultima);

  Anexo.OnEnviarClick := AnexoEnviarClick;
  Editor.OnAnexoClick := EditorAnexoClick;
  Chat.OnScrollChange := ChatScrollChange;
end;

procedure TFrameVisualizador.AnexoEnviarClick(Sender: TObject);
var
  sTemp: String;
begin
  for var Item in Anexo.Selecionados do
    sTemp := sTemp + Item + sLineBreak;
  ShowMessage(sTemp.Trim);
end;

procedure TFrameVisualizador.ChatScrollChange(Sender: TObject);
begin
  Ultima.Change;
end;

procedure TFrameVisualizador.EditorAnexoClick(Sender: TObject);
begin
  Anexo.Exibir;
end;

end.
