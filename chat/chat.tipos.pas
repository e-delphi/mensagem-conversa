// Eduardo - 10/08/2024
unit chat.tipos;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes,
  FMX.Types,
  FMX.Graphics;

type
  TLado = (Direito = Integer(TAlignLayout.Right), Esquerdo = Integer(TAlignLayout.Left));
  TStatus = (Pendente, Recebida, Visualizada);
  TTipo = (Texto, Imagem, Arquivo);
  TEventoMensagem = procedure(Index: Integer) of object;

  TConteudo = record
  public
    Tipo: TTipo;
    Conteudo: String;
    constructor Create(ATipo: TTipo; AConteudo: String);
  end;

  TEventoEnvio = procedure(Conteudos: TArray<TConteudo>) of object;

implementation

{ TConteudo }

constructor TConteudo.Create(ATipo: TTipo; AConteudo: String);
begin
  Tipo     := ATipo;
  Conteudo := AConteudo;
end;

end.
