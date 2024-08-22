// Eduardo - 04/08/2024
unit frame.conteudo.imagem;

interface

uses
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Objects,
  frame.mensagem.conteudo;

type
  TFrameConteudoImagem = class(TFrameConteudo)
    imgImagem: TImage;
  public
    function Target(Largura: Single): TTarget; override;
  end;

implementation

uses
  System.Math;

{$R *.fmx}

{ TConteudoImagem }

function TFrameConteudoImagem.Target(Largura: Single): TTarget;
var
  Proporcao: Single;
begin
  Proporcao := Min(Largura / imgImagem.Bitmap.Width, Max(30, imgImagem.Bitmap.Height) / imgImagem.Bitmap.Height);
  Result.Width := Max(100, Round(imgImagem.Bitmap.Width * Proporcao));
  Result.Height := Round(imgImagem.Bitmap.Height * Proporcao);
end;

end.
