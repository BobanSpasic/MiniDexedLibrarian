{
 *****************************************************************************
  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************

 Author: Boban Spasic

 Unit description:
 In the beginning, all the SQL-related functions were par of the untMain,
 that made the unit less readable.
 Now, all the SQL-related functions and procedures are in this unit/class.
}

unit untSQLProxy;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, SQLite3DS, DB,
  Dialogs, Controls, Grids, StdCtrls, StrUtils;

type
  TSQLProxy = class(TPersistent)
  private
    SQLite3Con: TSQLite3Connection;
    SQLTrans: TSQLTransaction;
    SQLQuery: TSQLQuery;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateTables;
    procedure CreateDefaultCategories;
    procedure Connect;
    procedure AddBinVoice(aID, aName, aCategory, aOrigin: string;
      aSuppVer: integer; var aData, aSuppData: TMemoryStream);
    procedure GetBinVoice(aID: string; var FVersion: integer;
      var msData, msSuppl: TMemoryStream);
    procedure DeleteVoice(aID: string);
    procedure AddPerformance(aID: string; aVersion: integer;
      aName, aCategory, aOrigin: string; var aData: TMemoryStream);
    procedure GetPerformance(aID: string; var aVersion: integer;
      var aName, aCategory, aOrigin: string; var aData: TMemoryStream);
    procedure DeletePerformance(aID: string);
    procedure LoadCategories(sgCategories: TStringGrid);
    procedure SaveCategories(sgCategories: TStringGrid);
    procedure Vacuum;
    procedure CleanTable(ATable: string);
    procedure Commit(aID, aName, aCategory, aOrigin: string);
    procedure GUIUpdateCategoryLists(sgDB: TStringGrid;
      cbPerfCategory, cbVoicesCategory: TComboBox);
    procedure GUIGridRefresh(sgDB: TStringGrid);
    procedure GUIGridRefreshFiltered(sgDB: TStringGrid; Filter: string;
      FilterType: integer);
    procedure GUIPerfSelGridRefresh(sgDB: TStringGrid);
    function GetDbFileName: string;
    procedure SetDbFileName(DbFileName: string);
    property DbFileName: string read GetDbFileName write SetDbFileName;
    function GetVoiceCount: integer;
    procedure GetVoiceList(var sl: TStringList);
  end;

const
  transSupplVer: array[0..3] of string = ('DX7', 'DX7II', 'TX7', 'MDX');

implementation

constructor TSQLProxy.Create;
begin
  inherited;
  SQLite3Con := TSQLite3Connection.Create(nil);
  SQLTrans := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  SQLite3Con.Transaction := SQLTrans;
  SQLite3Con.AlwaysUseBigint := False;
  SQLite3Con.Connected := False;
  SQLite3Con.KeepConnection := False;
  SQLite3Con.LoginPrompt := False;
  SQLTrans.Active := False;
  SQLTrans.DataBase := SQLite3Con;
  SQLQuery.DataBase := SQLite3Con;
  SQLQuery.Transaction := SQLTrans;
end;

destructor TSQLProxy.Destroy;
begin
  SQLite3Con.Connected := False;
  SQLite3Con.Free;
  SQLTrans.Free;
  SQLQuery.Free;
  inherited;
end;

function TSQLProxy.GetDbFileName: string;
begin
  Result := SQLite3Con.DatabaseName;
end;

procedure TSQLProxy.SetDbFileName(DbFileName: string);
begin
  SQLite3Con.DatabaseName := DbFileName;
end;

procedure TSQLProxy.CreateTables;
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS CATEGORY (NAME VARCHAR(32) UNIQUE NOT NULL, COMMENT VARCHAR(64));';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
    SQLQuery.Close;

    SQLQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS BIN_VOICES (ID VARCHAR(64) UNIQUE NOT NULL, NAME VARCHAR(32) NOT NULL, CATEGORY VARCHAR(32) NOT NULL, DATA BLOB, SUPPL_VER INTEGER, SUPPL BLOB, ORIGIN VARCHAR(128));';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;

    SQLQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS PERFORMANCES (ID VARCHAR(64) UNIQUE NOT NULL, VERSION INTEGER, NAME VARCHAR(32) NOT NULL, CATEGORY VARCHAR(32) NOT NULL, DATA BLOB, ORIGIN VARCHAR(128));';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;

    //Update older db files without VERSION column
    SQLQuery.SQL.Text :=
      'PRAGMA table_info (''PERFORMANCES'');';
    SQLQuery.Open;
    if not SQLQuery.Locate('NAME', 'VERSION', []) then
    begin
      SQLQuery.Close;
      SQLQuery.SQL.Text :=
        'ALTER TABLE PERFORMANCES ADD COLUMN VERSION INTEGER;';
      SQLQuery.ExecSQL;
      SQLTrans.Commit;
    end;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.CreateDefaultCategories;
begin
  //create default category
  SQLQuery.Close;
  SQLQuery.SQL.Text :=
    'INSERT OR REPLACE INTO CATEGORY (NAME, COMMENT) VALUES (''Default'', ''Default category'');';
  SQLQuery.ExecSQL;
  SQLTrans.Commit;
end;

procedure TSQLProxy.Connect;
begin
  SQLite3Con.Connected := True;
end;

procedure TSQLProxy.AddBinVoice(aID, aName, aCategory, aOrigin: string;
  aSuppVer: integer; var aData, aSuppData: TMemoryStream);
var
  aExists: boolean;
  aExName: string;
begin
  aExists := False;
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    aExName := '';
    SQLQuery.SQL.Text :=
      'SELECT * FROM BIN_VOICES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        aExName := SQLQuery.Fields[1].AsString;
        //do not bother the user with confirmation dialog if the names are the same
        //category and origin will be updated with the new ones
        if trim(aName) <> trim(aExName) then
          aExists := True;
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;

    if aExists and (MessageDlg('Duplicate', aName + ' is a duplicate of ' +
      aExName + #13#10 + 'Overwrite?', mtConfirmation, mbYesNo, 0) = mrNo) then
      Exit
    else
    begin
      SQLQuery.SQL.Text :=
        'INSERT OR REPLACE INTO BIN_VOICES (ID, NAME, CATEGORY, DATA, SUPPL_VER, SUPPL, ORIGIN) VALUES (:AID, :AName, :ACategory, :AData, :ASuppl_ver, :ASuppl, :AOrigin);';
      SQLQuery.Params.ParamByName('AID').AsString := aID;
      SQLQuery.Params.ParamByName('AName').AsString := aName;
      SQLQuery.Params.ParamByName('ACategory').AsString := aCategory;
      SQLQuery.Params.ParamByName('AData').LoadFromStream(aData, ftBlob);
      SQLQuery.Params.ParamByName('ASuppl_ver').AsInteger := aSuppVer;
      SQLQuery.Params.ParamByName('ASuppl').LoadFromStream(aSuppData, ftBlob);
      SQLQuery.Params.ParamByName('AOrigin').AsString := aOrigin;
      SQLQuery.ExecSQL;
      SQLTrans.Commit;
    end;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.GetBinVoice(aID: string; var FVersion: integer;
  var msData, msSuppl: TMemoryStream);
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'SELECT * FROM BIN_VOICES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        FVersion := SQLQuery.FieldByName('SUPPL_VER').AsInteger;
        TBlobField(SQLQuery.FieldByName('DATA')).SaveToStream(msData);
        if FVersion > 0 then
          TBlobField(SQLQuery.FieldByName('SUPPL')).SaveToStream(msSuppl);
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
  end;
end;

procedure TSQLProxy.DeleteVoice(aID: string);
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'DELETE FROM BIN_VOICES WHERE ID = ''' + aID + ''';';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.AddPerformance(aID: string; aVersion: integer;
  aName, aCategory, aOrigin: string; var aData: TMemoryStream);
var
  aExists: boolean;
  aExName: string;
begin
  aExists := False;
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    aExName := '';
    SQLQuery.SQL.Text :=
      'SELECT * FROM PERFORMANCES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        aExName := SQLQuery.Fields[1].AsString;
        //do not bother the user with confirmation dialog if the names are the same
        //category and origin will be updated with the new ones
        if aName <> aExName then
          aExists := True;
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;

    if aExists and (MessageDlg('Duplicate', aName + ' is a duplicate of ' +
      aExName + #13#10 + 'Overwrite?', mtConfirmation, mbYesNo, 0) = mrNo) then
      Exit
    else
    begin
      SQLQuery.SQL.Text :=
        'INSERT OR REPLACE INTO PERFORMANCES (ID, VERSION, NAME, CATEGORY, DATA, ORIGIN) VALUES (:AID, :AVersion, :AName, :ACategory, :AData, :AOrigin);';
      SQLQuery.Params.ParamByName('AID').AsString := aID;
      SQLQuery.Params.ParamByName('AName').AsString := aName;
      SQLQuery.Params.ParamByName('AVersion').AsInteger := aVersion;
      SQLQuery.Params.ParamByName('ACategory').AsString := aCategory;
      SQLQuery.Params.ParamByName('AData').LoadFromStream(aData, ftBlob);
      SQLQuery.Params.ParamByName('AOrigin').AsString := aOrigin;
      SQLQuery.ExecSQL;
      SQLTrans.Commit;
    end;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.GetPerformance(aID: string; var aVersion: integer;
  var aName, aCategory, aOrigin: string; var aData: TMemoryStream);
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'SELECT * FROM PERFORMANCES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        aVersion := SQLQuery.FieldByName('VERSION').AsInteger;
        aName := SQLQuery.FieldByName('NAME').AsString;
        aCategory := SQLQuery.FieldByName('CATEGORY').AsString;
        aOrigin := SQLQuery.FieldByName('ORIGIN').AsString;
        TBlobField(SQLQuery.FieldByName('DATA')).SaveToStream(aData);
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
  end;
end;

procedure TSQLProxy.LoadCategories(sgCategories: TStringGrid);
var
  sl: TStringList;
  i: integer;
begin
  if SQLite3Con.Connected then
  begin
    sgCategories.BeginUpdate;
    sl := TStringList.Create;
    sl.Delimiter := ';';
    SQLQuery.SQL.Text := 'SELECT * FROM CATEGORY';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      sl.Add('"' + SQLQuery.Fields[0].AsString + '";"' +
        SQLQuery.Fields[1].AsString + '"');
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgCategories.RowCount := sl.Count + 1;
    for i := 0 to sl.Count - 1 do
    begin
      sgCategories.Rows[i + 1].Delimiter := ';';
      sgCategories.Rows[i + 1].QuoteChar := '"';
      sgCategories.Rows[i + 1].StrictDelimiter := True;
      sgCategories.Rows[i + 1].DelimitedText := sl[i];
    end;
    sl.Free;
    sgCategories.EndUpdate(True);
    if sgCategories.RowCount = 1 then sgCategories.RowCount := 2;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.SaveCategories(sgCategories: TStringGrid);
var
  i: integer;
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'DELETE FROM CATEGORY WHERE (NAME = '''');';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
    for i := 1 to sgCategories.RowCount - 1 do
    begin
      if trim(sgCategories.Cells[0, i]) <> '' then
      begin
        SQLQuery.SQL.Text :=
          'INSERT OR REPLACE INTO CATEGORY (NAME, COMMENT) VALUES (:AName, :AComment);';
        SQLQuery.Params.ParamByName('AName').AsString := sgCategories.Cells[0, i];
        SQLQuery.Params.ParamByName('AComment').AsString := sgCategories.Cells[1, i];
        SQLQuery.ExecSQL;
      end;
    end;
    SQLTrans.Commit;
  end;
end;

procedure TSQLProxy.GUIUpdateCategoryLists(sgDB: TStringGrid;
  cbPerfCategory, cbVoicesCategory: TComboBox);
var
  sl: TStringList;
begin
  if SQLite3Con.Connected then
  begin
    sl := TStringList.Create;
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'SELECT * FROM CATEGORY';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      sl.Add(SQLQuery.Fields[0].AsString);
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgDB.Columns[1].PickList := sl;
    cbPerfCategory.Items := sl;
    if cbPerfCategory.Items.Count > 0 then cbPerfCategory.ItemIndex := 0;
    cbVoicesCategory.Items := sl;
    if cbVoicesCategory.Items.Count > 0 then cbVoicesCategory.ItemIndex := 0;
    sl.Free;
  end;
end;

procedure TSQLProxy.GUIGridRefresh(sgDB: TStringGrid);
var
  sl: TStringList;
  i: integer;
  sName, sCategory, sOrigin, sID, sSupplVer: string;
begin
  sgDB.RowCount := 1;
  if SQLite3Con.Connected then
  begin
    sgDB.BeginUpdate;
    sl := TStringList.Create;
    sl.Delimiter := ';';
    SQLQuery.SQL.Text := 'SELECT * FROM BIN_VOICES';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      //(ID, NAME, CATEGORY, DATA, SUPPL_VER, SUPPL, ORIGIN)
      sName := SQLQuery.FieldByName('NAME').AsString;
      sCategory := SQLQuery.FieldByName('CATEGORY').AsString;
      sOrigin := SQLQuery.FieldByName('ORIGIN').AsString;
      sID := SQLQuery.FieldByName('ID').AsString;
      sSupplVer := transSupplVer[SQLQuery.FieldByName('SUPPL_VER').AsInteger];
      sName := ReplaceStr(sName, '"', ' ');
      sCategory := ReplaceStr(sCategory, '"', ' ');
      sOrigin := ReplaceStr(sOrigin, '"', ' ');
      sl.Add('"' + sName + '";"' + sCategory + '";"' + sOrigin +
        '";"' + sID + '";"' + sSupplVer + '"');
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgDB.RowCount := sl.Count + 1;
    for i := 0 to sl.Count - 1 do
    begin
      sgDB.Rows[i + 1].Delimiter := ';';
      sgDB.Rows[i + 1].QuoteChar := '"';
      sgDB.Rows[i + 1].StrictDelimiter := True;
      sgDB.Rows[i + 1].DelimitedText := sl[i];
    end;
    sl.Free;
    sgDB.EndUpdate(True);
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.GUIGridRefreshFiltered(sgDB: TStringGrid;
  Filter: string; FilterType: integer);
var
  sl: TStringList;
  i: integer;
  sName, sCategory, sOrigin, sID, sSupplVer: string;
begin
  sgDB.RowCount := 1;
  if SQLite3Con.Connected then
  begin
    sgDB.BeginUpdate;
    sl := TStringList.Create;
    sl.Delimiter := ';';
    case FilterType of
      1: SQLQuery.SQL.Text := 'SELECT * FROM BIN_VOICES WHERE NAME LIKE ''%' +
          Filter + '%''';
      2: SQLQuery.SQL.Text := 'SELECT * FROM BIN_VOICES WHERE ORIGIN LIKE ''%' +
          Filter + '%''';
      else
        SQLQuery.SQL.Text := 'SELECT * FROM BIN_VOICES';
    end;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      //(ID, NAME, CATEGORY, DATA, SUPPL_VER, SUPPL, ORIGIN)
      sName := SQLQuery.FieldByName('NAME').AsString;
      sCategory := SQLQuery.FieldByName('CATEGORY').AsString;
      sOrigin := SQLQuery.FieldByName('ORIGIN').AsString;
      sID := SQLQuery.FieldByName('ID').AsString;
      sSupplVer := transSupplVer[SQLQuery.FieldByName('SUPPL_VER').AsInteger];
      sName := ReplaceStr(sName, '"', ' ');
      sCategory := ReplaceStr(sCategory, '"', ' ');
      sOrigin := ReplaceStr(sOrigin, '"', ' ');
      sl.Add('"' + sName + '";"' + sCategory + '";"' + sOrigin +
        '";"' + sID + '";"' + sSupplVer + '"');
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgDB.RowCount := sl.Count + 1;
    for i := 0 to sl.Count - 1 do
    begin
      sgDB.Rows[i + 1].Delimiter := ';';
      sgDB.Rows[i + 1].QuoteChar := '"';
      sgDB.Rows[i + 1].StrictDelimiter := True;
      sgDB.Rows[i + 1].DelimitedText := sl[i];
    end;
    sl.Free;
    sgDB.EndUpdate(True);
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.GUIPerfSelGridRefresh(sgDB: TStringGrid);
var
  sl: TStringList;
  i: integer;
begin
  sgDB.RowCount := 1;
  if SQLite3Con.Connected then
  begin
    sgDB.BeginUpdate;
    sl := TStringList.Create;
    sl.Delimiter := ';';
    SQLQuery.SQL.Text := 'SELECT * FROM PERFORMANCES';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      //ID, VERSION, NAME, CATEGORY, DATA BLOB, ORIGIN
      sl.Add('"' + SQLQuery.FieldByName('NAME').AsString + '";"' +
        SQLQuery.FieldByName('CATEGORY').AsString + '";"' +
        SQLQuery.FieldByName('ORIGIN').AsString + '";"' +
        SQLQuery.FieldByName('ID').AsString + '"');
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    sgDB.RowCount := sl.Count + 1;
    for i := 0 to sl.Count - 1 do
    begin
      sgDB.Rows[i + 1].Delimiter := ';';
      sgDB.Rows[i + 1].QuoteChar := '"';
      sgDB.Rows[i + 1].StrictDelimiter := True;
      sgDB.Rows[i + 1].DelimitedText := sl[i];
    end;
    sl.Free;
    sgDB.EndUpdate(True);
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.Commit(aID, aName, aCategory, aOrigin: string);
var
  aExists: boolean;
  aVersion: integer;
  msData, msSuppl: TMemoryStream;
begin
  if SQLite3Con.Connected then
  begin
    msData := TMemoryStream.Create;
    msSuppl := TMemoryStream.Create;
    aExists := False;
    aVersion := 0;
    SQLQuery.Close;
    SQLQuery.SQL.Text :=
      'SELECT * FROM BIN_VOICES WHERE ID = :AID';
    SQLQuery.Params.ParamByName('AID').AsString := aID;
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      if SQLQuery.FieldCount > 0 then
      begin
        aVersion := SQLQuery.FieldByName('SUPPL_VER').AsInteger;
        TBlobField(SQLQuery.FieldByName('DATA')).SaveToStream(msData);
        if aVersion > 0 then
          TBlobField(SQLQuery.FieldByName('SUPPL')).SaveToStream(msSuppl);
        aExists := True;
        Break;
      end;
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
    if aExists then
    begin
      SQLQuery.SQL.Text :=
        'INSERT OR REPLACE INTO BIN_VOICES (ID, NAME, CATEGORY, DATA, SUPPL_VER, SUPPL, ORIGIN) VALUES (:AID, :AName, :ACategory, :AData, :ASuppl_ver, :ASuppl, :AOrigin);';
      SQLQuery.Params.ParamByName('AID').AsString := aID;
      SQLQuery.Params.ParamByName('AName').AsString := aName;
      SQLQuery.Params.ParamByName('ACategory').AsString := aCategory;
      SQLQuery.Params.ParamByName('AData').LoadFromStream(msData, ftBlob);
      SQLQuery.Params.ParamByName('ASuppl_ver').AsInteger := aVersion;
      SQLQuery.Params.ParamByName('ASuppl').LoadFromStream(msSuppl, ftBlob);
      SQLQuery.Params.ParamByName('AOrigin').AsString := aOrigin;
      SQLQuery.ExecSQL;
      SQLTrans.Commit;
    end;
    msData.Free;
    msSuppl.Free;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.Vacuum;
var
  tmpDataset: TSqlite3Dataset;
  wasConnected: boolean;
begin
  wasConnected := SQLite3Con.Connected;

  SQLite3Con.Close;
  repeat
  until not SQLite3Con.Connected;

  tmpDataset := TSqlite3Dataset.Create(nil);
  tmpDataset.FileName := SQLite3Con.DatabaseName;
  tmpDataset.ExecSQL('VACUUM;');
  tmpDataset.Free;

  SQLite3Con.Connected := wasConnected;
end;

procedure TSQLProxy.CleanTable(ATable: string);
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'DELETE FROM ' + ATable;
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
  end
  else
    ShowMessage('No database file assigned');
end;

procedure TSQLProxy.DeletePerformance(aID: string);
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'DELETE FROM PERFORMANCES WHERE ID = ''' + aID + ''';';
    SQLQuery.ExecSQL;
    SQLTrans.Commit;
  end
  else
    ShowMessage('No database file assigned');
end;

function TSQLProxy.GetVoiceCount: integer;
begin
  Result := 0;
  if SQLite3Con.Connected then
  begin
    SQLQuery.Close;
    SQLQuery.SQL.Text := 'SELECT COUNT(*) AS cnt FROM BIN_VOICES;';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    Result := SQLQuery.Fields[0].AsInteger;
    SQLQuery.Close;
    SQLTrans.Commit;
  end;
end;

procedure TSQLProxy.GetVoiceList(var sl: TStringList);
var
  sName, sID: string;
begin
  if SQLite3Con.Connected then
  begin
    SQLQuery.SQL.Text := 'SELECT * FROM BIN_VOICES';
    SQLTrans.StartTransaction;
    SQLQuery.Open;
    while not SQLQuery.EOF do
    begin
      sName := SQLQuery.FieldByName('NAME').AsString;
      sID := SQLQuery.FieldByName('ID').AsString;
      sl.AddPair(sID, sName);
      SQLQuery.Next;
    end;
    SQLQuery.Close;
    SQLTrans.Commit;
  end
  else
    ShowMessage('No database file assigned');
end;

end.
