program Mensagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  Mensagem.Teste in 'Mensagem.Teste.pas' {Inicio},
  chat.emoji in 'chat\chat.emoji.pas',
  chat.ordenador in 'chat\chat.ordenador.pas',
  chat.so in 'chat\chat.so.pas',
  chat.tipos in 'chat\chat.tipos.pas',
  chat.visualizador in 'chat\chat.visualizador.pas',
  chat.base in 'chat\frames\chat.base.pas' {ChatBase: TFrame},
  chat.conteudo.anexo in 'chat\frames\chat.conteudo.anexo.pas' {ChatConteudoAnexo: TFrame},
  chat.conteudo.imagem in 'chat\frames\chat.conteudo.imagem.pas' {ChatConteudoImagem: TFrame},
  chat.conteudo.mensagem.audio in 'chat\frames\chat.conteudo.mensagem.audio.pas' {ChatConteudoMensagemAudio: TFrame},
  chat.conteudo.texto in 'chat\frames\chat.conteudo.texto.pas' {ChatConteudoTexto: TFrame},
  chat.editor.anexo.item in 'chat\frames\chat.editor.anexo.item.pas' {ChatAnexoItem: TFrame},
  chat.editor.anexo in 'chat\frames\chat.editor.anexo.pas' {ChatEditorAnexo: TFrame},
  chat.editor.audio in 'chat\frames\chat.editor.audio.pas' {ChatEditorAudio: TFrame},
  chat.editor.base in 'chat\frames\chat.editor.base.pas' {ChatEditorBase: TFrame},
  chat.editor in 'chat\frames\chat.editor.pas' {ChatEditor: TFrame},
  chat.editor.texto in 'chat\frames\chat.editor.texto.pas' {ChatEditorTexto: TFrame},
  chat.expositor in 'chat\frames\chat.expositor.pas' {ChatExpositor: TFrame},
  chat.mensagem.conteudo in 'chat\frames\chat.mensagem.conteudo.pas' {ChatConteudo: TFrame},
  chat.mensagem in 'chat\frames\chat.mensagem.pas' {ChatMensagem: TFrame},
  chat.separador.data in 'chat\frames\chat.separador.data.pas' {ChatSeparadorData: TFrame},
  chat.separador.lidas in 'chat\frames\chat.separador.lidas.pas' {ChatSeparadorLidas: TFrame},
  chat.ultima in 'chat\frames\chat.ultima.pas' {ChatUltima: TFrame},
  chat.selectfile in 'chat\chat.selectfile.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.Run;
end.
