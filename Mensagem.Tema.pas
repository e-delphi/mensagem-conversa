// Eduardo - 13/01/2024
unit Mensagem.Tema;

interface

uses
  FMX.Types,
  System.UITypes,
  System.SysUtils,
  System.Generics.Collections;

type
  TTema = record
  private
    FCalbacks: TArray<TPair<TObject, TProc<TObject, TTema>>>;
    procedure Add(Componente: TObject; Callback: TProc<TObject, TTema>);
  public
    CorTexto: TAlphaColor;
    CorFundo: TAlphaColor;
    CorFundoMensagemMinha: TAlphaColor;
    CorFundoMensagemDeles: TAlphaColor;
    class procedure Atualizar; static;
    class procedure Registrar(Componente: TObject; Callback: TProc<TObject, TTema>); static;
  end;

  function RGB(r, g, b: Word): TAlphaColor;

implementation

uses
  FMX.Forms;

var
  TemaAtual: TTema;

{ TTema }

class procedure TTema.Registrar(Componente: TObject; Callback: TProc<TObject, TTema>);
begin
  TemaAtual.Add(Componente, Callback);
end;

class procedure TTema.Atualizar;
begin
  for var Callback in TemaAtual.FCalbacks do
    Callback.Value(Callback.Key, TemaAtual);
end;

procedure TTema.Add(Componente: TObject; Callback: TProc<TObject, TTema>);
begin
  FCalbacks := FCalbacks + [TPair<TObject, TProc<TObject, TTema>>.Create(Componente, Callback)];
  Callback(Componente, TemaAtual);
end;

function RGB(r, g, b: Word): TAlphaColor;
begin
  TAlphaColorRec(Result).A := 255;
  TAlphaColorRec(Result).R := r;
  TAlphaColorRec(Result).B := b;
  TAlphaColorRec(Result).G := g;
end;

initialization
  TemaAtual                       := Default(TTema);
  TemaAtual.CorTexto              := TAlphaColors.White;
  TemaAtual.CorFundo              := RGB(44, 44, 44);
  TemaAtual.CorFundoMensagemMinha := RGB(0, 92, 75);
  TemaAtual.CorFundoMensagemDeles := RGB(54, 54, 54);

  // carregar os temas
  // Defir o tema atual

end.
