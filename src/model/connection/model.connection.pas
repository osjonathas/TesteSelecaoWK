unit model.connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Comp.UI,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase;

type
  TConnection = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function Conectar(aServidor, aBanco, aUsuario, aSenha : string):boolean;
    procedure PrepareStatement(aSQL: String);
    procedure SetValue(aIndex: Integer; aValue: Variant);
    procedure ExecSQL;
    procedure StartTransation;
    procedure Commit;
    procedure Rollback;
  end;

var
  Connection: TConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses KrUtil;

{$R *.dfm}

{ TConnection }

procedure TConnection.Commit;
begin
  FDConnection.Commit;
end;

function TConnection.Conectar(aServidor, aBanco, aUsuario, aSenha: string): boolean;
begin
  try
    FDPhysMySQLDriverLink.VendorHome := GetCurrentDir;
    FDPhysMySQLDriverLink.VendorLib  := 'libmysql.dll';

    FDConnection.Connected   := False;
    FDConnection.Params.Clear;
    FDConnection.LoginPrompt := False;
    FDConnection.DriverName  := 'MySQL';

    FDConnection.Params.Add('DriverID='        + 'MySQL');
    FDConnection.Params.Add('DataBase='        + aBanco);
    FDConnection.Params.Add('User_Name='       + aUsuario);
    FDConnection.Params.Add('Password='        + aSenha);
    FDConnection.Params.Add('LoginTimeout='    + '30');
    FDConnection.Params.Add('Server='          + aServidor);
//    FDServidor.Open;
    FDConnection.Connected := True;
    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(mProblemasNaConexaoComBanco+E.message);
    end;
  end;
end;

procedure TConnection.ExecSQL;
begin
  FDQuery.ExecSQL;
end;

procedure TConnection.PrepareStatement(aSQL: String);
begin
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(aSQL);
end;

procedure TConnection.Rollback;
begin
  FDConnection.Rollback;
end;

procedure TConnection.SetValue(aIndex: Integer; aValue: Variant);
begin
  FDQuery.Params.Add;
  FDQuery.Params[aIndex].Value := aValue;
end;

procedure TConnection.StartTransation;
begin
  FDConnection.StartTransaction;
end;

end.
