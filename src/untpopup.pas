unit untPopUp;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, StdCtrls, LCLIntf, LCLType, Controls, Graphics, Types;

procedure PopUp(const AText: string; ADuration: integer);

implementation

procedure PopUp(const AText: string; ADuration: integer);
var
  Form: TForm;
  Prompt: TLabel;
  DialogUnits: TPoint;
  nX, Lines: integer;
  ABitmap: TBitmap;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    I: integer;
    Buffer: array[0..51] of char;
  begin
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;

begin
  Form := TForm.Create(Application);
  Lines := 0;

  for nX := 1 to Length(AText) do
    if AText[nX] = #13 then Inc(Lines);

  with Form do
    try
      Color := clBtnFace;
      Font.Name := 'Consolas';
      Font.Size := 20;
      Font.Style := [fsBold];
      Font.Color := $002D423E;
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsNone;
      FormStyle := fsStayOnTop;
      ClientWidth := MulDiv(Screen.Width div 4, DialogUnits.X, 4);
      ClientHeight := MulDiv(23 + (Lines * 10), DialogUnits.Y, 8);
      Position := poScreenCenter;
      //AutoSize := True;

      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := AText;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
      end;

      Form.Width := Prompt.Width + Prompt.Left + Prompt.Left;
      ABitmap := TBitmap.Create;
      ABitmap.Monochrome := True;
      ABitmap.Width := Width; // or Form.Width
      ABitmap.Height := Height; // or Form.Height
      ABitmap.Canvas.Brush.Color := clBlack;
      ABitmap.Canvas.FillRect(0, 0, Width, Height);
      ABitmap.Canvas.Brush.Color := clWhite;
      ABitmap.Canvas.RoundRect(0, 0, Width, Height, 50, 50);
      Canvas.Draw(0, 0, ABitmap);
      SetShape(ABitmap);
      Show;
      Application.ProcessMessages;
    finally
      Sleep(ADuration * 1000);
      ABitmap.Free;
      Form.Free;
    end;
end;

end.
