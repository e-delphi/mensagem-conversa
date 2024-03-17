// Eduardo - 07/01/2024
unit Mensagem.Inicio;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Objects,
  Mensagem.Conteudo;

type
  TInicio = class(TForm)
    rtgMensagem: TRectangle;
    mmMensagem: TMemo;
    btnEnviar: TButton;
    procedure btnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FConteudo: TConteudo;
  end;

var
  Inicio: TInicio;

implementation

{$R *.fmx}

uses
  Mensagem.Texto,
  Mensagem.Imagem,
  Mensagem.Mensagem,
  Mensagem.Tema;

{ TForm1 }

procedure TInicio.FormCreate(Sender: TObject);
var
  bmp: TBitmap;
  I: Integer;
  msg: TMensagem;
begin
  FConteudo := TConteudo.New(Self);

  bmp := TBitmap.Create;
  try
    bmp.LoadFromFile('D:\teste.png');

    for I := 1 to 2 do
    begin
      if I mod 10 = 0 then
      begin
        msg := FConteudo.NovaMensagem;
        msg.Remetente('Usuario1');
        msg.Minha(False);
//        msg.NovaImagem.Imagem(bmp);
        msg.NovoTexto.Conteudo(I.ToString +' - '+ 'Mensagem de teste para validar as quebras de linha!');
      end
      else
      begin
        FConteudo.NovaMensagem
          .Remetente('Usuario2')
          .Minha(True)
          .NovoTexto.Conteudo(I.ToString +' - '+ 'Mensagem de teste para validar as quebras de linha!');
      end;
    end;
  finally
    bmp.Free;
  end;

  // Posiciona no fim
  FConteudo.Redimencionar;
  FConteudo.PosicionarUltima;

  TTema.Registrar(
    Self,
    procedure(Sender: TObject; Tema: TTema)
    begin
      TInicio(Sender).rtgMensagem.Fill.Color := Tema.CorFundo;
    end
  );
end;

procedure TInicio.btnEnviarClick(Sender: TObject);
begin
  if mmMensagem.Text.Trim.IsEmpty then
    Exit;

  FConteudo.NovaMensagem
    .Remetente('Eduardo')
    .Minha(True)
    .NovoTexto.Conteudo(mmMensagem.Lines.Text.Trim);

  // Posiciona no fim
  FConteudo.Redimencionar;
  FConteudo.PosicionarUltima;

  mmMensagem.Lines.Clear;
end;

end.
