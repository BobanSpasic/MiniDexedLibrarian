program prMiniDexedCC;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, uecontrols, untMain, untDX7Bank, untDX7SysExDefs, untDX7Utils,
  untDX7Voice, untUtils, untMiniINI;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='MiniDexed Control Center';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

