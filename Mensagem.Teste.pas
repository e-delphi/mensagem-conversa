// Eduardo - 03/08/2024
unit Mensagem.Teste;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  chat.visualizador,
  chat.editor,
  chat.tipos,
  FMX.DateTimeCtrls;

type
  TInicio = class(TForm)
    Panel1: TPanel;
    btnTextoEsquerdo: TButton;
    btnTextoDireito: TButton;
    btnImagemDireito: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Panel2: TPanel;
    dtEditor: TDateEdit;
    tmEditor: TTimeEdit;
    Button7: TButton;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTextoEsquerdoClick(Sender: TObject);
    procedure btnTextoDireitoClick(Sender: TObject);
    procedure btnImagemDireitoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    FID: Integer;
    FUltimaSelecionada: Integer;
    Visualizador: TChatVisualizador;
    Editor: TChatEditor;
    procedure AoVisualizar(Frame: TFrame);
    procedure AoEnviar(Conteudos: TArray<TConteudo>);
    procedure AoClicar(Frame: TFrame; Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

var
  Inicio: TInicio;

implementation

uses
  System.DateUtils,
  chat.mensagem;

{$R *.fmx}

procedure TInicio.FormCreate(Sender: TObject);
begin
  FUltimaSelecionada := 0;

  Visualizador := TChatVisualizador.Create(Self);
  Self.AddObject(Visualizador);
  Visualizador.Align := TAlignLayout.Client;
  Visualizador.AoVisualizar := AoVisualizar;
  Visualizador.AoClicar := AoClicar;
  Visualizador.LarguraMaximaConteudo := 500;

  Editor := TChatEditor.Create(Self);
  Self.AddObject(Editor);
  Editor.Align := TAlignLayout.Bottom;
  Editor.AoEnviar := AoEnviar;
  Editor.LarguraMaximaConteudo := 500;

  FID := -1;
end;

procedure TInicio.AoVisualizar(Frame: TFrame);
begin
  if Frame is TChatMensagem then
    TChatMensagem(Frame).Piscar(TAlphaColorRec.Blue, 0.5);
end;

procedure TInicio.AoClicar(Frame: TFrame; Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Frame is TChatMensagem then
  begin
    FUltimaSelecionada := TChatMensagem(Frame).ID;
    TChatMensagem(Frame).Piscar(TAlphaColorRec.Red, 0.5);
  end;
end;

procedure TInicio.AoEnviar(Conteudos: TArray<TConteudo>);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(FID, 'ChatEditor', Now, Conteudos);
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Posicionar(FID);
end;

procedure TInicio.btnTextoDireitoClick(Sender: TObject);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(
    FID,
    'Eduardo',
    dtEditor.Date + tmEditor.DateTime,
    [
      TConteudo.Create(TTipo.Texto, dtEditor.Text),
      TConteudo.Create(TTipo.Texto, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam finibus lectus sit amet purus convallis auctor.'),
      TConteudo.Create(TTipo.Texto, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout')
    ]
  );
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Posicionar(FID);

  dtEditor.Date := IncDay(dtEditor.Date, -1);
end;

procedure TInicio.btnTextoEsquerdoClick(Sender: TObject);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(
    FID,
    'Eduardo',
    dtEditor.Date + tmEditor.DateTime,
    [
      TConteudo.Create(TTipo.Texto, dtEditor.Text),
      TConteudo.Create(TTipo.Texto, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam finibus lectus sit amet purus convallis auctor.'),
      TConteudo.Create(TTipo.Texto, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout')
    ]
  );
  Visualizador.Mensagem[FID].Lado := TLado.Esquerdo;
  Visualizador.Posicionar(FID);

  tmEditor.DateTime := IncMinute(tmEditor.DateTime);
end;

procedure TInicio.Button1Click(Sender: TObject);
begin
  case Visualizador.Mensagem[FUltimaSelecionada].Status of
    TStatus.Pendente:    Visualizador.Mensagem[FUltimaSelecionada].Status := TStatus.Recebida;
    TStatus.Recebida:    Visualizador.Mensagem[FUltimaSelecionada].Status := TStatus.Visualizada;
    TStatus.Visualizada: Visualizador.Mensagem[FUltimaSelecionada].Status := TStatus.Pendente;
  end;
end;

procedure TInicio.Button2Click(Sender: TObject);
begin
  case Visualizador.Mensagem[FUltimaSelecionada].Lado of
    TLado.Direito:  Visualizador.Mensagem[FUltimaSelecionada].Lado := TLado.Esquerdo;
    TLado.Esquerdo: Visualizador.Mensagem[FUltimaSelecionada].Lado := TLado.Direito;
  end;
end;

procedure TInicio.Button3Click(Sender: TObject);
begin
  Visualizador.Mensagem[FUltimaSelecionada].NomeVisivel := not Visualizador.Mensagem[FUltimaSelecionada].NomeVisivel;
end;

procedure TInicio.Button4Click(Sender: TObject);
begin
  Visualizador.Posicionar(FUltimaSelecionada);
  Visualizador.Mensagem[FUltimaSelecionada].Piscar(TAlphaColorRec.Green, 0.5)
end;

procedure TInicio.Button5Click(Sender: TObject);
var
  sTemp: String;
begin
  for var I in Visualizador.Visiveis do
    sTemp := sTemp +','+ I.ToString;
  ShowMessage(sTemp);
end;

procedure TInicio.btnImagemDireitoClick(Sender: TObject);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(
    FID,
    'Eduardo',
    Now,
    [
      TConteudo.Create(TTipo.Imagem, 'C:\Users\Eduar\Pictures\Screenshots\Captura de tela 2023-10-15 170059.png'),
      TConteudo.Create(TTipo.Imagem, 'C:\Users\Eduar\Pictures\Screenshots\Captura de tela 2023-10-15 170059.png'),
      TConteudo.Create(TTipo.Texto, 'Ísis'),
      TConteudo.Create(TTipo.Texto, 'Ayla')
    ]
  );
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Mensagem[FID].NomeVisivel := True;
end;

procedure TInicio.Button6Click(Sender: TObject);
begin
  Visualizador.RemoverMensagem(FUltimaSelecionada);
end;

procedure TInicio.Button7Click(Sender: TObject);
begin
  Visualizador.ExibirSeparadorLidas(FUltimaSelecionada);
end;

procedure TInicio.Button8Click(Sender: TObject);
begin
  Visualizador.OcultarSeparadorLidas;
end;

end.
