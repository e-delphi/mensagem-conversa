// Eduardo - 04/08/2024
unit frame.conteudo.anexo;

interface

uses
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts,
  frame.mensagem.conteudo;

type
  TFrameConteudoAnexo = class(TFrameConteudo)
    Path: TPath;
    Layout: TLayout;
    lbTamanho: TLabel;
    lbNome: TLabel;
  public
    function Target(Largura: Single): TTarget; override;
  end;

implementation

{$R *.fmx}

{ TAnexo }

function TFrameConteudoAnexo.Target(Largura: Single): TTarget;
begin
  Result.Width := 250;
  Result.Height := 20;
end;

end.
