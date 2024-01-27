// Eduardo - 07/01/2024
unit Mensagem.Imagem;

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
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.Effects;

type
  TImagem = class(TFrame)
    img: TImage;
    procedure imgDblClick(Sender: TObject);
  public
    procedure Redimencionar;
    function Imagem(bmp: TBitmap): TImagem;
  end;

implementation

{$R *.fmx}

uses
  System.Math,
  FMX.Layouts,
  Mensagem.Tema;

function TImagem.Imagem(bmp: TBitmap): TImagem;
begin
  img.Bitmap.Assign(bmp);
  Result := Self;
  TTema.Atualizar;
end;

procedure TImagem.imgDblClick(Sender: TObject);
var
  lyt: TLayout;
  img2: TImage;
begin
  lyt := TLayout.Create(Application.MainForm);
  lyt.Align := TAlignLayout.Contents;

  img2 := TImage.Create(lyt);
  lyt.AddObject(img2);
  img2.Align := TAlignLayout.Client;

  img2.Bitmap.Assign(img.Bitmap);

  Application.MainForm.AddObject(lyt);
end;

procedure TImagem.Redimencionar;
begin
  if not Assigned(img.Bitmap) then
    Exit;

  Height := Max(100, Min((img.Width * img.Bitmap.Height) / img.Bitmap.Width, img.Bitmap.Height));
end;

end.
