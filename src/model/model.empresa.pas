unit model.empresa;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.empresa, KrConstantes;

 type
   Tempresa = class(TInterfacedObject, iEmpresa)
   private
     FFDQuery : TFDQuery;
     FCodigo: integer;
     FCNPJ : String;
     FDescricao : String;
   public
     class function New:iEmpresa;

     Constructor Create;
     Destructor Destroy; override;

     function Codigo(Value: integer) :iEmpresa; overload;
     function Codigo :integer; overload;

     function CNPJ(Value: String) :iEmpresa; overload;
     function CNPJ: String; overload;

     function Descricao(Value: String) :iEmpresa; overload;
     function Descricao: String; overload;
     function IncluirEmpresa:iEmpresa;
     function Open(aTabela : string; aDataSource : TDataSource):iEmpresa; overload;

     function getEmpresa(aCodigo : integer):iEmpresa; overload;
     function Insert:iEmpresa; overload;
     function Update:iEmpresa; overload;
   end;

implementation

{ Tempresa }

uses model.connection;

function Tempresa.Codigo(Value: integer): iEmpresa;
begin
  Result := Self;
  FCodigo := Value;
end;

constructor Tempresa.Create;
begin
  FFDQuery := TFDQuery.Create(nil);
end;

destructor Tempresa.Destroy;
begin

end;

function Tempresa.IncluirEmpresa: iEmpresa;
var aQry : TFDQuery;
    aUltimaPosicao : integer;
begin
  aQry := TFDQuery.Create(nil);
  try
    try
      aQry.Close;
      aQry.Connection := connection.FDConnection;
      aQry.SQL.Clear;
      aQry.SQL.Add(' select max(emp_codigo) as UltimaPosicao from empresa ');
      aQry.Open;
      aUltimaPosicao := aQry.FieldByName('UltimaPosicao').AsInteger;
      inc(aUltimaPosicao);
      FCodigo := aUltimaPosicao;
      Result := Self;
    except on E: Exception do
      begin
        raise Exception.Create(mProblemasNaExecucaoDaConsulta +' - '+ E.Message);
      end;
    end;
  finally
    aQry.Close;
    aQry.Free;
  end;
end;

function Tempresa.Insert: iEmpresa;
var
   aQry : TFDQuery;
   aTransacao : TFdTransaction;
begin
  aQry := TFDQuery.Create(nil);
  aTransacao := TFdTransaction.Create(nil);
  try
    try
      aQry.Connection := Connection.FDConnection;
      aTransacao.Connection := Connection.FDConnection;
      FormatSettings.DecimalSeparator := '.';
      aTransacao.StartTransaction;
      aQry.Close;
      aQry.SQL.Clear;
      aQry.SQL.Add(' INSERT INTO empresa(');
//        aQry.SQL.Add(' emp_codigo '); No caso do sql server o codigo está como autoincremento
      aQry.SQL.Add(' emp_cnpj ');
      aQry.SQL.Add(' ,emp_rzsocial ');
      aQry.SQL.Add(' ) VALUES( ');
//        aQry.SQL.Add(IntToStr(FCodigo));
      aQry.SQL.Add(' '+QuotedStr(FCNPJ));
      aQry.SQL.Add(' ,'+QuotedStr(FDescricao));
      aQry.SQL.Add(' ) ');
      aQry.ExecSQL;
    except on E: Exception do
      begin
        aTransacao.RollbackRetaining;
        raise Exception.Create(mProblemsAoPersistirDadosEmBanco +E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
    FreeandNil(aTransacao);
    FormatSettings.DecimalSeparator := ',';
  end;
end;

class function Tempresa.New: iEmpresa;
begin
  Result := Self.Create;
end;

function Tempresa.Open(aTabela: string; aDataSource: TDataSource): iEmpresa;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' select emp_codigo, emp_rzsocial, emp_cnpj');
    FFDQuery.Sql.Add(' from empresa ');
    FFDQuery.Sql.Add(' where 1=1 ');
    FFDQuery.Open();
    aDataSource.DataSet := FFDQuery;
    Result := self;
  finally

  end;
end;

function Tempresa.Update: iEmpresa;
var
   aQry : TFDQuery;
   aTransacao : TFdTransaction;
begin
  aQry := TFDQuery.Create(nil);
  aTransacao := TFdTransaction.Create(nil);
  try
    try
      aQry.Connection := Connection.FDConnection;
      aTransacao.Connection := Connection.FDConnection;
      FormatSettings.DecimalSeparator := '.';
      aTransacao.StartTransaction;
      aQry.Close;
      aQry.SQL.Clear;
      aQry.SQL.Add(' update empresa');
      aQry.SQL.Add(' set emp_cnpj ='+QuotedStr(FCNPJ));
      aQry.SQL.Add(' ,emp_rzsocial ='+QuotedStr(FDescricao));
      aQry.SQL.Add(' where emp_codigo = '+IntToStr(FCodigo));
      aQry.ExecSQL;
      except on E: Exception do
      begin
        aTransacao.RollbackRetaining;
        raise Exception.Create(mProblemsAoPersistirDadosEmBanco +E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
    FreeandNil(aTransacao);
    FormatSettings.DecimalSeparator := ',';
  end;
end;

function Tempresa.Descricao: String;
begin
  Result := FDescricao;
end;

function Tempresa.Descricao(Value: String): iEmpresa;
begin
  Result := Self;
  FDescricao := Value;
end;

function Tempresa.CNPJ: String;
begin
  Result := FCNPJ;
end;

function Tempresa.CNPJ(Value: String): iEmpresa;
begin
  Result := Self;
  FCNPJ := Value;
end;

function Tempresa.Codigo: integer;
begin
  Result := FCodigo;
end;

function Tempresa.getEmpresa(aCodigo: integer): iEmpresa;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' select emp_codigo, emp_rzsocial, emp_fantasia, emp_cnpj');
    FFDQuery.Sql.Add(' from empresa ');
    FFDQuery.Sql.Add(' where 1=1 ');
    FFDQuery.Sql.Add(' and emp_codigo = '+IntTostr(aCodigo));
    FFDQuery.Open();

    if not FFDQuery.IsEmpty then
    begin
      self.Codigo(FFDQuery.FieldByName('emp_codigo').AsInteger);
      self.Descricao(FFDQuery.FieldByName('emp_rzsocial').AsString);
      self.CNPJ(FFDQuery.FieldByName('emp_cnpj').AsString);
      Result := Self;
    end;
  except on E: Exception do
    begin
      raise Exception.Create(mProblemasNaExecucaoDaConsulta +E.Message);
    end;
  end;
end;

end.
