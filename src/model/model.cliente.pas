unit model.cliente;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.cliente;

 type
   TCliente = class(TInterfacedObject, iCliente)
   private
     FFDQuery : TFDQuery;
     FCodigo: integer;
     FNome : String;
     FCidade : String;
     FUF : String;
   public
     Constructor Create;
     Destructor Destroy; override;

     class function New:iCliente;

     function Codigo(Value: integer) :iCliente; overload;
     function Codigo :integer; overload;

     function Nome(Value: String) :iCliente; overload;
     function Nome: String; overload;

     function Cidade(Value: String) :iCliente; overload;
     function Cidade: String; overload;

     function UF(Value: String) :iCliente; overload;
     function UF: String; overload;

     function Open(aDataSource : TDataSource):iCliente; overload;
     function getCliente:iCliente; overload;
   end;

implementation

{ TUsuario }

uses model.connection;

constructor TCliente.Create;
begin
  FFDQuery := TFDQuery.Create(nil);
end;

destructor TCliente.Destroy;
begin

end;

class function TCliente.New: iCliente;
begin
  Result := Self.Create;
end;

function TCliente.Codigo(Value: integer): iCliente;
begin
  Result := Self;
  FCodigo := Value;
end;

function TCliente.Codigo: integer;
begin
  Result := FCodigo;
end;

function TCliente.Nome(Value: String): iCliente;
begin
  Result := Self;
  FNome := Value;
end;

function TCliente.Nome: String;
begin
  Result := FNome;
end;

function TCliente.Cidade(Value: String): iCliente;
begin
  Result := Self;
  FCidade := Value;
end;

function TCliente.Cidade: String;
begin
  Result := FCidade;
end;

function TCliente.UF: String;
begin
  Result := FUF;
end;

function TCliente.UF(Value: String): iCliente;
begin
  Result := Self;
  FUF := Value;
end;


function TCliente.Open(aDataSource: TDataSource): iCliente;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT codigo, nome, cidade, uf');
    FFDQuery.Sql.Add(' FROM Clientes');
    FFDQuery.Sql.Add(' WHERE 1=1 ');
    if Self.Codigo > 0 then
      FFDQuery.Sql.Add(' AND codigo = '+IntToStr(Self.Codigo));

    if trim(Self.Nome) <> EmptyStr then
      FFDQuery.Sql.Add(' AND nome like '+QuotedStr(Self.Nome+'%'));

    FFDQuery.Open();
    aDataSource.DataSet := FFDQuery;
    Result := self;
  finally

  end;
end;

function TCliente.getCliente: iCliente;
var aDts : TDataSource;
begin
  aDts := TDataSource.Create(nil);
  try
    Self.Open(aDts);
    if not aDts.Dataset.IsEmpty then
    begin
      Self.Codigo(aDts.Dataset.FieldByName('codigo').AsInteger);
      Self.Nome(aDts.Dataset.FieldByName('nome').AsString);
      Self.Cidade(aDts.Dataset.FieldByName('cidade').AsString);
      Self.UF(aDts.Dataset.FieldByName('uf').AsString);
    end;
    Result := self;
  finally
    FreeAndNil(aDts);
  end;
end;
end.