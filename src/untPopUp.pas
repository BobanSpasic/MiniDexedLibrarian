{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 A self-closing pop-up message
}

unit untPopUp;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, Controls, Forms, Graphics, LCLIntf, LCLType, StdCtrls, SysUtils, Types;

procedure PopUp(const AText: string; ADuration: integer);

implementation

procedure PopUp(const AText: string; ADuration: integer);
var
  Form: TForm;
  Prompt: TLabel;
  DialogUnits: TPoint;
  nX, Lines: integer;
  ABitmap: TBitmap;
  sl: TStringList;

  function LongestLine(sl: TStringList): string;
  var
    i: integer;
  begin
    Result := '';
    for i := 0 to sl.Count - 1 do
      if Length(sl[i]) > Length(Result) then Result := sl[i];
  end;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    I: integer;
    Buffer: array[0..51] of char;
  begin
    Result := Default(TPoint);
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;

begin
  Form := TForm.Create(Application);
  Lines := 0;
  sl := TStringList.Create;
  sl.Text := AText;
  for nX := 1 to Length(AText) do
    if AText[nX] = #13 then Inc(Lines);

  with Form do
    try
      Color := clBtnFace;
      Font.Name := 'Consolas';
      Font.Size := 20;
      Font.Style := [fsBold];
      Font.Color := clDefault; // hex 002D423E;
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsNone;
      FormStyle := fsStayOnTop;
      ClientWidth := MulDiv(Screen.Width div 4, DialogUnits.X, 4);
      ClientHeight := MulDiv(23 + (Lines * 10), DialogUnits.Y, 8);
      Position := poScreenCenter;
      //AutoSize := True;
      {$IFDEF LCLGTK2}
      Show;
      {$ENDIF}
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := AText;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
      end;

      Form.Width := Prompt.Canvas.GetTextWidth(LongestLine(sl)) + 2 * Prompt.Left;
      ABitmap := TBitmap.Create;
      ABitmap.Monochrome := True;
      ABitmap.Width := Width; // or Form.Width
      ABitmap.Height := Height; // or Form.Height
      ABitmap.Canvas.Brush.Color := clBlack;
      ABitmap.Canvas.FillRect(0, 0, Width, Height);
      ABitmap.Canvas.Brush.Color := clWhite;
      ABitmap.Canvas.RoundRect(0, 0, Width, Height, 50, 50);
      {$IFDEF LCLGTK2}
      SetShape(ABitmap);
      {$ENDIF}
      {$IFNDEF LCLGTK2}
      Canvas.Draw(0, 0, ABitmap);
      SetShape(ABitmap);
      Show;
      {$ENDIF}
      Application.ProcessMessages;
    finally
      Sleep(ADuration * 1000);
      ABitmap.Free;
      sl.Free;
      Form.Free;
    end;
end;

end.
