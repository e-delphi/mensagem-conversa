program Mensagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  frame.chat in 'componente\frame.chat.pas' {FrameChat: TFrame},
  Mensagem.Teste in 'Mensagem.Teste.pas' {Inicio},
  frame.mensagem in 'componente\frame.mensagem.pas' {FrameMensagem: TFrame},
  frame.mensagem.conteudo in 'componente\frame.mensagem.conteudo.pas' {FrameConteudo: TFrame},
  frame.conteudo.texto in 'componente\frame.conteudo.texto.pas' {FrameConteudoTexto: TFrame},
  frame.conteudo.imagem in 'componente\frame.conteudo.imagem.pas' {FrameConteudoImagem: TFrame},
  frame.editor in 'componente\frame.editor.pas' {FrameEditor: TFrame},
  frame.conteudo.anexo in 'componente\frame.conteudo.anexo.pas' {FrameConteudoAnexo: TFrame},
  frame.anexo in 'componente\frame.anexo.pas' {FrameAnexo: TFrame},
  frame.anexo.item in 'componente\frame.anexo.item.pas' {FrameAnexoItem: TFrame},
  frame.ultima in 'componente\frame.ultima.pas' {FrameUltima: TFrame},
  frame.visualizador in 'componente\frame.visualizador.pas' {FrameVisualizador: TFrame},
  visualizador in 'componente\visualizador.pas',
  visualizador.tipos in 'componente\visualizador.tipos.pas',
  frame.base in 'componente\frame.base.pas' {FrameBase: TFrame},
  visualizador.so in 'componente\visualizador.so.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.Run;
end.
