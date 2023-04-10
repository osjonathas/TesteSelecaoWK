unit model.produto;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.produto;

 type
   TProduto = class(TInterfacedObject, iProduto)
   private
     FFDQuery : TFDQuery;
     FCodigo: integer;
     FDescricao : String;
     FPrecoVenda : Currency;
   public
     Constructor Create;
     Destructor Destroy; override;

     class function New:iProduto;

     function Codigo(Value: integer) :iProduto; overload;
     function Codigo :integer; overload;

     function Descricao(Value: String) :iProduto; overload;
     function Descricao: String; overload;

     function PrecoVenda(Value: Currency) :iProduto; overload;
     function PrecoVenda: Currency; overload;

     function Open(aDataSource : TDataSource):iProduto; overload;
     function getProduto:iProduto; overload;
   end;

implementation

uses model.connection;

function TProduto.Codigo(Value: integer): iProduto;
begin
  Result := Self;
  FCodigo := Value;
end;

function TProduto.Codigo: integer;
begin
  Result := FCodigo;
end;

constructor TProduto.Create;
begin
  FFDQuery := TFDQuery.Create(nil);
end;

function TProduto.Descricao: String;
begin
  Result := FDescricao;
end;

destructor TProduto.Destroy;
begin

end;

function TProduto.Descricao(Value: String): iProduto;
begin
  Result := Self;
  FDescricao := Value;
end;

function TProduto.getProduto: iProduto;
var aDts : TDataSource;
begin
  aDts := TDataSource.Create(nil);
  try
    Self.Open(aDts);
    if not aDts.Dataset.IsEmpty then
    begin
      Self.Codigo(aDts.Dataset.FieldByName('codigo').AsInteger);
      Self.Descricao(aDts.Dataset.FieldByName('descricao').AsString);
      Self.PrecoVenda(aDts.Dataset.FieldByName('precovenda').AsFloat);
    end;
    Result := self;
  finally
    FreeAndNil(aDts);
  end;
end;

class function TProduto.New: iProduto;
begin
  Result := Self.Create;
end;

function TProduto.Open(aDataSource: TDataSource): iProduto;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT codigo, descricao, precovenda');
    FFDQuery.Sql.Add(' FROM produtos');
    FFDQuery.Sql.Add(' WHERE 1=1 ');
    if Self.Codigo > 0 then
      FFDQuery.Sql.Add(' AND codigo = '+IntToStr(Self.Codigo));

    if trim(Self.Descricao) <> EmptyStr then
      FFDQuery.Sql.Add(' AND descricao like '+QuotedStr(Self.Descricao+'%'));

    FFDQuery.Open();
    aDataSource.DataSet := FFDQuery;
    Result := self;
  finally

  end;
end;

function TProduto.PrecoVenda(Value: Currency): iProduto;
begin
  Result:= Self;
  FPrecoVenda := Value;
end;

function TProduto.PrecoVenda: Currency;
begin
  Result := FPrecoVenda;
end;

end.
