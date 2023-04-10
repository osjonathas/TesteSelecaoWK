unit model.usuario;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.usuario;

 type
   TUsuario = class(TInterfacedObject, iUsuario)
   private
     FFDQuery : TFDQuery;
     FCodigo: integer;
     FLogin : String;
     FSenha : String;
   public
     Constructor Create;
     Destructor Destroy; override;

     class function New:iUsuario;

     function Codigo(Value: integer) :iUsuario; overload;
     function Codigo :integer; overload;

     function Login(Value: String) :iUsuario; overload;
     function Login: String; overload;

     function Senha(Value: String) :iUsuario; overload;
     function Senha: String; overload;

     function Open(aDataSource : TDataSource):iUsuario; overload;
     function getUsuario:iUsuario; overload;
   end;

implementation

{ TUsuario }

uses model.connection;

constructor TUsuario.Create;
begin
  FFDQuery := TFDQuery.Create(nil);
end;

destructor TUsuario.Destroy;
begin

end;

class function TUsuario.New: iUsuario;
begin
  Result := Self.Create;
end;

function TUsuario.Codigo(Value: integer): iUsuario;
begin
  Result := Self;
  FCodigo := Value;
end;

function TUsuario.Codigo: integer;
begin
  Result := FCodigo;
end;

function TUsuario.Login(Value: String): iUsuario;
begin
  Result := Self;
  FLogin := Value;
end;

function TUsuario.Login: String;
begin
  Result := FLogin;
end;

function TUsuario.Senha(Value: String): iUsuario;
begin
  Result := Self;
  FSenha := Value;
end;

function TUsuario.Senha: String;
begin
  Result := FSenha;
end;

function TUsuario.Open(aDataSource: TDataSource): iUsuario;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT codigo, login, senha');
    FFDQuery.Sql.Add(' FROM Funcionarios');
    FFDQuery.Sql.Add(' WHERE 1=1 ');
    if Self.Codigo > 0 then
      FFDQuery.Sql.Add(' AND codigo = '+IntToStr(Self.Codigo));

    if trim(Self.Login) <> EmptyStr then
      FFDQuery.Sql.Add(' AND login like '+QuotedStr(Self.Login+'%'));

    FFDQuery.Open();
    aDataSource.DataSet := FFDQuery;
    Result := self;
  finally

  end;
end;

function TUsuario.getUsuario: iUsuario;
var aDts : TDataSource;
begin
  aDts := TDataSource.Create(nil);
  try
    Self.Open(aDts);
    if not aDts.Dataset.IsEmpty then
    begin
      Self.Codigo(aDts.Dataset.FieldByName('codigo').AsInteger);
      Self.Login(aDts.Dataset.FieldByName('login').AsString);
      Self.Senha(aDts.Dataset.FieldByName('senha').AsString);
    end;
    Result := self;
  finally
    FreeAndNil(aDts);
  end;
end;
end.
