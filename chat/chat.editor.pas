// Eduardo - 21/08/2024
unit chat.editor;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Types,
  FMX.Controls,
  chat.tipos,
  frame.editor,
  frame.anexo;

type
  TChatEditor = class(TControl, IControl)
  private
    Editor: TFrameEditor;
    Anexo: TFrameAnexo;
    procedure AnexoEnviarClick(Sender: TObject);
    procedure EditorAnexoClick(Sender: TObject);
    function GetLarguraMaximaConteudo: Integer;
    procedure SetLarguraMaximaConteudo(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    property LarguraMaximaConteudo: Integer read GetLarguraMaximaConteudo write SetLarguraMaximaConteudo;
  end;

implementation

uses
  System.SysUtils,
  FMX.Dialogs;

{ TChatEditor }

constructor TChatEditor.Create(AOwner: TComponent);
begin
  inherited;
  Editor := TFrameEditor.Create(Self);
  Self.AddObject(Editor);

  Anexo := TFrameAnexo.Create(Self);
  Self.AddObject(Anexo);

  Anexo.OnEnviarClick := AnexoEnviarClick;
  Editor.OnAnexoClick := EditorAnexoClick;
end;

procedure TChatEditor.AnexoEnviarClick(Sender: TObject);
var
  sTemp: String;
begin
  for var Item in Anexo.Selecionados do
    sTemp := sTemp + Item + sLineBreak;
  ShowMessage(sTemp.Trim);
end;

procedure TChatEditor.EditorAnexoClick(Sender: TObject);
begin
  Anexo.Exibir;
end;

function TChatEditor.GetLarguraMaximaConteudo: Integer;
begin
  Result := Editor.LarguraMaximaConteudo;
end;

procedure TChatEditor.SetLarguraMaximaConteudo(const Value: Integer);
begin
  Editor.LarguraMaximaConteudo := Value;
end;

end.
