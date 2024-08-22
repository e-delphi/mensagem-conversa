// Eduardo - 17/08/2024
unit chat.so;

interface

uses
  FMX.Forms;

function IsFormActive(Parent: TFrame): Boolean;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
  FMX.Platform.Win,
{$ELSE}

{$ENDIF}
  FMX.Types;

{$IFDEF MSWINDOWS}
function IsFormActive(Parent: TFrame): Boolean;
var
  Last: TFmxObject;
  ParentForm: HWND;
  WindowsActiveForm: HWND;
begin
  Result := False;

  Last := Parent;
  while Assigned(Last) and Last.HasParent do
    Last := Last.Parent;

  if not Assigned(Last) or not Last.InheritsFrom(TForm) then
    Exit;

  ParentForm := FormToHWND(TForm(Last));
  if not IsWindowVisible(ParentForm) or not IsWindow(ParentForm) or not IsWindowEnabled(ParentForm) or IsIconic(ParentForm) then
    Exit;

  WindowsActiveForm := GetForegroundWindow;

  if not ((WindowsActiveForm = ParentForm) or (WindowsActiveForm = ApplicationHWND)) then
    Exit;

  Result := True;
end;
{$ELSE}
function IsFormActive(Parent: TForm): Boolean;
begin
  Result := True;
end;
{$ENDIF}

end.
