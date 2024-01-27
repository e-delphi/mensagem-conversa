// Eduardo - 07/01/2024
program AppMensagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  Mensagem.Inicio in 'Mensagem.Inicio.pas' {Inicio},
  Mensagem.Texto in 'Mensagem.Texto.pas' {Texto: TFrame},
  Mensagem.Imagem in 'Mensagem.Imagem.pas' {Imagem: TFrame},
  Mensagem.Mensagem in 'Mensagem.Mensagem.pas' {Mensagem: TFrame},
  Mensagem.Tema in 'Mensagem.Tema.pas',
  Mensagem.Conteudo in 'Mensagem.Conteudo.pas' {Conteudo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.Run;
end.
