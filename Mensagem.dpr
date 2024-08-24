﻿program Mensagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  Mensagem.Teste in 'Mensagem.Teste.pas' {Inicio},
  chat.so in 'chat\chat.so.pas',
  chat.tipos in 'chat\chat.tipos.pas',
  chat.visualizador in 'chat\chat.visualizador.pas',
  chat.base in 'chat\frames\chat.base.pas' {ChatBase: TFrame},
  chat.anexo.item in 'chat\frames\chat.anexo.item.pas' {ChatAnexoItem},
  chat.anexo in 'chat\frames\chat.anexo.pas' {ChatAnexo},
  chat.expositor in 'chat\frames\chat.expositor.pas' {ChatExpositor: TFrame},
  chat.conteudo.anexo in 'chat\frames\chat.conteudo.anexo.pas' {ChatConteudoAnexo},
  chat.conteudo.imagem in 'chat\frames\chat.conteudo.imagem.pas' {ChatConteudoImagem},
  chat.conteudo.texto in 'chat\frames\chat.conteudo.texto.pas' {ChatConteudoTexto},
  chat.editor.entrada in 'chat\frames\chat.editor.entrada.pas' {ChatEditorEntrada: TFrame},
  chat.mensagem.conteudo in 'chat\frames\chat.mensagem.conteudo.pas' {ChatConteudo: TFrame},
  chat.mensagem in 'chat\frames\chat.mensagem.pas' {ChatMensagem: TFrame},
  chat.ultima in 'chat\frames\chat.ultima.pas' {ChatUltima: TFrame},
  chat.editor in 'chat\chat.editor.pas',
  chat.separador.data in 'chat\frames\chat.separador.data.pas' {ChatSeparadorData: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TInicio, Inicio);
  Application.Run;
end.
