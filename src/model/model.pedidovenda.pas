unit model.pedidovenda;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.pedidovenda;

 type
   TPedidoVenda = class(TInterfacedObject, iPedidoVenda)
   private
     FFDQuery : TFDQuery;
     FNumeroPedido: integer;
     FDataEmissao : TDateTime;
     FCodigoCliente : integer;
     FValorTotal : Currency;
   public
     Constructor Create;
     Destructor Destroy; override;

     class function New:iPedidoVenda;

     function NumeroPedido(Value: integer) :iPedidoVenda; overload;
     function NumeroPedido :integer; overload;

     function DataEmissao(Value: TDatetime) :iPedidoVenda; overload;
     function DataEmissao: TDateTime; overload;

     function CodigoCliente(Value: integer) :iPedidoVenda; overload;
     function CodigoCliente: integer; overload;

     function ValorTotal(Value: Currency) :iPedidoVenda; overload;
     function ValorTotal: Currency; overload;

     function Open(aDataSource : TDataSource):iPedidoVenda; overload;
     function getPedido(aCodigo:integer):iPedidoVenda; overload;
   end;

implementation
{ TPedidoVenda }

uses model.connection;

constructor TPedidoVenda.Create;
begin
  FFDQuery := TFDQuery.Create(nil);
end;

destructor TPedidoVenda.Destroy;
begin
  FreeAndNil(FFDQuery);
  inherited;
end;

class function TPedidoVenda.New: iPedidoVenda;
begin
  Result := Self.Create;
end;

function TPedidoVenda.NumeroPedido(Value: integer): iPedidoVenda;
begin
  Result := Self;
  FNumeroPedido := Value;
end;

function TPedidoVenda.NumeroPedido: integer;
begin
  Result := FNumeroPedido;
end;

function TPedidoVenda.CodigoCliente(Value: integer): iPedidoVenda;
begin
  Result := Self;
  FCodigoCliente := Value;
end;

function TPedidoVenda.CodigoCliente: integer;
begin
  Result := FCodigoCliente;
end;

function TPedidoVenda.DataEmissao: TDateTime;
begin
  Result := FDataEmissao;
end;

function TPedidoVenda.DataEmissao(Value: TDatetime): iPedidoVenda;
begin
  Result := Self;
  FDataEmissao := Value;
end;

function TPedidoVenda.ValorTotal(Value: Currency): iPedidoVenda;
begin
  Result := Self;
  FValorTotal := Value;
end;

function TPedidoVenda.ValorTotal: Currency;
begin
  Result := FValorTotal;
end;

function TPedidoVenda.Open(aDataSource : TDataSource): iPedidoVenda;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT p.numeropedido, p.dataemissao, p.codigocliente, p.valortotal, c.nome, (CONVERT(c.codigo,char)||'+QuotedStr(' - ')+'||c.nome) as CLIENTE');
    FFDQuery.Sql.Add(' FROM pedido_dados_gerais p');
    FFDQuery.Sql.Add(' left outer join clientes c on(c.codigo = p.codigocliente)');
    FFDQuery.Open();
    aDataSource.DataSet := FFDQuery;
    Result := self;

  except on E: Exception do
    raise;
  end;
end;      

function TPedidoVenda.getPedido(aCodigo: integer): iPedidoVenda;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT codigo, login, senha');
    FFDQuery.Sql.Add(' FROM Funcionarios');
    FFDQuery.Open();
    if not FFDQuery.IsEmpty then
    begin
      Self.NumeroPedido(FFDQuery.FieldByName('codigo').AsInteger);
    end;
    Result := self;
  finally

  end;
end;
end.
