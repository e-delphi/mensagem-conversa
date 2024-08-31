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
  FMX.DateTimeCtrls,
  FMX.Menus,
  chat.visualizador,
  chat.editor,
  chat.tipos;

type
  TInicio = class(TForm)
    Panel2: TPanel;
    dtEditor: TDateEdit;
    tmEditor: TTimeEdit;
    Label1: TLabel;
    MenuBar1: TMenuBar;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
  private
    FID: Integer;
    FUltimaSelecionada: Integer;
    Visualizador: TChatVisualizador;
    Editor: TChatEditor;
    procedure AoVisualizar(Frame: TFrame);
    procedure AoEnviar(Conteudos: TArray<TConteudo>);
    procedure AoClicar(Frame: TFrame; Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure AoChegarLimite(Limite: TLimite);
  end;

var
  Inicio: TInicio;

implementation

uses
  System.DateUtils,
  System.TypInfo,
  chat.mensagem;

{$R *.fmx}

procedure TInicio.FormCreate(Sender: TObject);
begin
  FUltimaSelecionada := 0;

  Visualizador := TChatVisualizador.Create(Self);
  Self.AddObject(Visualizador);
  Visualizador.Align := TAlignLayout.Client;
  Visualizador.LarguraMaximaConteudo := 500;
  Visualizador.AoVisualizar := AoVisualizar;
  Visualizador.AoClicar := AoClicar;
  Visualizador.AoChegarLimite := AoChegarLimite;

  Editor := TChatEditor.Create(Self);
  Self.AddObject(Editor);
  Editor.Align := TAlignLayout.Bottom;
  Editor.LarguraMaximaConteudo := 500;
  Editor.AoEnviar := AoEnviar;

  FID := -1;
end;

procedure TInicio.AoVisualizar(Frame: TFrame);
begin
  if Frame is TChatMensagem then
    TChatMensagem(Frame).Piscar(TAlphaColorRec.Blue, 0.5);
end;

procedure TInicio.AoChegarLimite(Limite: TLimite);
var
  I: Integer;
  sBottom: Single;
begin
  Label1.Text := 'Limite: '+ GetEnumName(TypeInfo(TLimite), Integer(Limite)) +' às '+ FormatDateTime('hh:nn:ss.zzz', Now);

  if Limite = TLimite.Superior then
  begin
    sBottom := Visualizador.Bottom;
    Visualizador.OcultarSeparadoresData;

    for I := 1 to 10 do
    begin
      Inc(FID);
      Visualizador.AdicionarMensagem(
        FID,
        'Usuário 1',
        IncDay(Now, -FID),
        [
          TConteudo.Create(TTipo.Texto, 'Mensagem: '+ I.ToString),
          TConteudo.Create(TTipo.Texto, FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', IncDay(Now, -FID)))
        ]
      );
      Visualizador.Mensagem[FID].Lado := TLado.Direito;



      Inc(FID);
      Visualizador.AdicionarMensagem(
        FID,
        'Usuário 2',
        IncDay(Now, -FID),
        [
          TConteudo.Create(TTipo.Texto, 'Mensagem: '+ I.ToString),
          TConteudo.Create(TTipo.Texto, FormatDateTime('dd/mm/yyyy hh:nn:ss', IncDay(Now, -FID)))
        ]
      );
      Visualizador.Mensagem[FID].Lado := TLado.Esquerdo;
    end;

    Visualizador.Bottom := sBottom;
    Visualizador.ExibirSeparadoresData;
  end;
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
  Visualizador.OcultarSeparadoresData;

  Inc(FID);
  Visualizador.AdicionarMensagem(FID, 'ChatEditor', Now, Conteudos);
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Posicionar(FID);

  Visualizador.ExibirSeparadoresData;
end;

procedure TInicio.MenuItem2Click(Sender: TObject);
var
  I: Integer;
  dHora: TDateTime;
begin
  Visualizador.OcultarSeparadoresData;

  dHora := dtEditor.Date + tmEditor.Time;
  for I := 1 to 10 do
  begin
    dHora := IncMinute(dHora);
    Inc(FID);
    Visualizador.AdicionarMensagem(
      FID,
      'Usuário 1',
      dHora,
      [
        TConteudo.Create(TTipo.Texto, 'Mensagem: '+ I.ToString),
        TConteudo.Create(TTipo.Texto, FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', dHora))
      ]
    );
    Visualizador.Mensagem[FID].Lado := TLado.Direito;
    Visualizador.Posicionar(FID);



    dHora := IncMinute(dHora);
    Inc(FID);
    Visualizador.AdicionarMensagem(
      FID,
      'Usuário 2',
      dHora,
      [
        TConteudo.Create(TTipo.Texto, 'Mensagem: '+ I.ToString),
        TConteudo.Create(TTipo.Texto, FormatDateTime('dd/mm/yyyy hh:nn:ss', dHora))
      ]
    );
    Visualizador.Mensagem[FID].Lado := TLado.Esquerdo;
    Visualizador.Posicionar(FID);
  end;

  Visualizador.ExibirSeparadoresData;
end;

procedure TInicio.MenuItem3Click(Sender: TObject);
begin
  Visualizador.OcultarSeparadoresData;

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

  Visualizador.ExibirSeparadoresData;
end;

procedure TInicio.MenuItem4Click(Sender: TObject);
begin
  Visualizador.OcultarSeparadoresData;

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

  Visualizador.ExibirSeparadoresData;
end;

procedure TInicio.MenuItem5Click(Sender: TObject);
begin
  Visualizador.Posicionar(FUltimaSelecionada);
  Visualizador.Mensagem[FUltimaSelecionada].Piscar(TAlphaColorRec.Green, 0.5)
end;

procedure TInicio.MenuItem7Click(Sender: TObject);
begin
  case Visualizador.Mensagem[FUltimaSelecionada].Status of
    TStatus.Pendente:    Visualizador.Mensagem[FUltimaSelecionada].Status := TStatus.Recebida;
    TStatus.Recebida:    Visualizador.Mensagem[FUltimaSelecionada].Status := TStatus.Visualizada;
    TStatus.Visualizada: Visualizador.Mensagem[FUltimaSelecionada].Status := TStatus.Pendente;
  end;
end;

procedure TInicio.MenuItem8Click(Sender: TObject);
begin
  case Visualizador.Mensagem[FUltimaSelecionada].Lado of
    TLado.Direito:  Visualizador.Mensagem[FUltimaSelecionada].Lado := TLado.Esquerdo;
    TLado.Esquerdo: Visualizador.Mensagem[FUltimaSelecionada].Lado := TLado.Direito;
  end;
end;

procedure TInicio.MenuItem9Click(Sender: TObject);
begin
  Visualizador.Mensagem[FUltimaSelecionada].NomeVisivel := not Visualizador.Mensagem[FUltimaSelecionada].NomeVisivel;
end;

procedure TInicio.MenuItem10Click(Sender: TObject);
begin
  Visualizador.OcultarSeparadoresData;

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

  Visualizador.ExibirSeparadoresData;
end;

procedure TInicio.MenuItem11Click(Sender: TObject);
var
  sTemp: String;
begin
  for var I in Visualizador.Visiveis do
    sTemp := sTemp +','+ I.ToString;
  ShowMessage(sTemp);
end;

procedure TInicio.MenuItem13Click(Sender: TObject);
begin
  Visualizador.RemoverMensagem(FUltimaSelecionada);
end;

procedure TInicio.MenuItem16Click(Sender: TObject);
begin
  Visualizador.ExibirSeparadorLidas(FUltimaSelecionada);
end;

procedure TInicio.MenuItem17Click(Sender: TObject);
begin
  Visualizador.OcultarSeparadorLidas;
end;

procedure TInicio.MenuItem19Click(Sender: TObject);
begin
  Visualizador.ExibirSeparadoresData;
end;

procedure TInicio.MenuItem20Click(Sender: TObject);
begin
  Visualizador.OcultarSeparadoresData;
end;

procedure TInicio.MenuItem21Click(Sender: TObject);
begin
  Editor.AdicionarAnexo('C:\Users\Eduar\Pictures\Screenshots\Captura de tela 2023-10-15 170059.png');
end;

end.
