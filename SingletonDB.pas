unit SingletonDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Phys.Intf, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Stan.Option, FireDAC.Stan.Pool;

type
  TSingletonDB = class
  private
    class var FInstance: TSingletonDB;
    class var FLock: TObject;
    FConnection: TFDConnection;
    constructor Create;
  public
    class function GetInstance: TSingletonDB;
    function ExecuteQuery(SQL: string): TFDQuery;
    destructor Destroy; override;
  end;

implementation

uses
  System.SyncObjs;

{ TSingletonDB }

constructor TSingletonDB.Create;
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'SQLite';
  FConnection.Params.Database := 'C:\Bancos\TesteThread';
  FConnection.LoginPrompt := False;
  FConnection.LoginPrompt := False;
  FConnection.FetchOptions.Mode := fmAll;
  FConnection.Connected := True;
end;

destructor TSingletonDB.Destroy;
begin
  FConnection.Free;
  inherited;
end;

function TSingletonDB.ExecuteQuery(SQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConnection;
  Result.SQL.Text := SQL;
  Result.Open;
end;

class function TSingletonDB.GetInstance: TSingletonDB;
begin
  TMonitor.Enter(FLock);
  try
    if FInstance = nil then
      FInstance := TSingletonDB.Create;
    Result := FInstance;
  finally
    TMonitor.Exit(FLock);
  end;
end;

initialization
  TSingletonDB.FLock := TObject.Create;

finalization
  FreeAndNil(TSingletonDB.FInstance);
  FreeAndNil(TSingletonDB.FLock);

end.

