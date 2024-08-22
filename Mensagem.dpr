program Mensagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  Mensagem.Teste in 'Mensagem.Teste.pas' {Inicio},
  chat.so in 'chat\chat.so.pas',
  chat.tipos in 'chat\chat.tipos.pas',
  chat.visualizador in 'chat\chat.visualizador.pas',
  frame.base in 'chat\frames\frame.base.pas' {FrameBase: TFrame},
  frame.anexo.item in 'chat\frames\frame.anexo.item.pas',
  frame.anexo in 'chat\frames\frame.anexo.pas',
  frame.chat in 'chat\frames\frame.chat.pas' {FrameChat: TFrame},
  frame.conteudo.anexo in 'chat\frames\frame.conteudo.anexo.pas',
  frame.conteudo.imagem in 'chat\frames\frame.conteudo.imagem.pas',
  frame.conteudo.texto in 'chat\frames\frame.conteudo.texto.pas',
  frame.editor in 'chat\frames\frame.editor.pas' {FrameEditor: TFrame},
  frame.mensagem.conteudo in 'chat\frames\frame.mensagem.conteudo.pas' {FrameConteudo: TFrame},
  frame.mensagem in 'chat\frames\frame.mensagem.pas' {FrameMensagem: TFrame},
  frame.ultima in 'chat\frames\frame.ultima.pas' {FrameUltima: TFrame},
  chat.editor in 'chat\chat.editor.pas',
  frame.separador.data in 'chat\frames\frame.separador.data.pas' {FrameSeparadorData: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.Run;
end.
