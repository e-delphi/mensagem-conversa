program Mensagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  Mensagem.Teste in 'Mensagem.Teste.pas' {Inicio},
  chat.so in 'chat\chat.so.pas',
  chat.tipos in 'chat\chat.tipos.pas',
  chat.visualizador in 'chat\chat.visualizador.pas',
  chat.base in 'chat\frames\chat.base.pas' {ChatBase: TFrame},
  chat.anexo.item in 'chat\frames\chat.anexo.item.pas' {ChatAnexoItem},
  chat.expositor in 'chat\frames\chat.expositor.pas' {ChatExpositor: TFrame},
  chat.conteudo.anexo in 'chat\frames\chat.conteudo.anexo.pas' {ChatConteudoAnexo},
  chat.conteudo.imagem in 'chat\frames\chat.conteudo.imagem.pas' {ChatConteudoImagem},
  chat.conteudo.texto in 'chat\frames\chat.conteudo.texto.pas' {ChatConteudoTexto},
  chat.editor in 'chat\frames\chat.editor.pas' {ChatEditor: TFrame},
  chat.mensagem.conteudo in 'chat\frames\chat.mensagem.conteudo.pas' {ChatConteudo: TFrame},
  chat.mensagem in 'chat\frames\chat.mensagem.pas' {ChatMensagem: TFrame},
  chat.ultima in 'chat\frames\chat.ultima.pas' {ChatUltima: TFrame},
  chat.separador.data in 'chat\frames\chat.separador.data.pas' {ChatSeparadorData: TFrame},
  chat.ordenador in 'chat\chat.ordenador.pas',
  chat.separador.lidas in 'chat\frames\chat.separador.lidas.pas' {ChatSeparadorLidas: TFrame},
  chat.emoji in 'chat\chat.emoji.pas',
  System.Skia.API in 'chat\skia\System.Skia.API.pas',
  System.Skia in 'chat\skia\System.Skia.pas',
  FMX.Skia.Canvas.GL in 'chat\skia\FMX\FMX.Skia.Canvas.GL.pas',
  FMX.Skia.Canvas.Metal in 'chat\skia\FMX\FMX.Skia.Canvas.Metal.pas',
  FMX.Skia.Canvas in 'chat\skia\FMX\FMX.Skia.Canvas.pas',
  FMX.Skia in 'chat\skia\FMX\FMX.Skia.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.Run;
end.
