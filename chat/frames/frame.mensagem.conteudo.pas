// Eduardo - 03/08/2024
unit frame.mensagem.conteudo;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  frame.base;

type
  TTarget = record
    Width: Single;
    Height: Single;
  end;

  TFrameConteudo = class(TFrameBase)
  public
    function Target(Largura: Single): TTarget; virtual; abstract;
  end;

implementation

{$R *.fmx}

{ TConteudo }

end.
