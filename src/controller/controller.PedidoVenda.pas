unit controller.PedidoVenda;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.controller.pedidovenda,
  einterface.pedidovenda, einterface.cliente, KrUtil;

 type
   TControllerPedidoVenda = class(TInterfacedObject, iContPedidoVenda)
   private
     FFDQuery       : TFDQuery;
     FNumeroPedido  : integer;
     FCodigoCliente : integer;
     FEstadoPedido  : TEstado;
     FValorTotalPedido  : Currency;

     function getUltimoNumero:integer;
   public
     Constructor Create;
     Destructor Destroy; override;

     class function New:iContPedidoVenda;

     function NumeroPedido(Value: integer) :iContPedidoVenda; overload;
     function NumeroPedido: integer; overload;

     function CodigoCliente(Value: integer) :iContPedidoVenda; overload;
     function CodigoCliente: integer;overload;

     function EstadoPedido(Value: TEstado) :iContPedidoVenda; overload;
     function EstadoPedido: TEstado;overload;

     function ValorTotalPedido(Value: Currency) :iContPedidoVenda; overload;
     function ValorTotalPedido: Currency;overload;

     function ColocarEmEstadoInclusao:iContPedidoVenda;
     function IncluirPedidoVenda(aMemTableItens: TFDMemTable):iContPedidoVenda;

   end;

implementation
uses model.connection;
{ TControllerPedidoVenda }

function TControllerPedidoVenda.IncluirPedidoVenda(aMemTableItens: TFDMemTable): iContPedidoVenda;
var aTransacao : TFDTransaction;
    aQry : TFDQuery;
begin
  aTransacao := TFDTransaction.Create(nil);
  aQry := TFDQuery.Create(nil);
  try
    aTransacao.Connection := Connection.FDConnection;
    aQry.Connection := Connection.FDConnection;
    FormatSettings.DecimalSeparator := '.';
    try
      aTransacao.StartTransaction;

      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add('INSERT INTO pedido_dados_gerais (');
      aQry.Sql.Add('            numeropedido,');
      aQry.Sql.Add('            dataemissao,');
      aQry.Sql.Add('            codigocliente,');
      aQry.Sql.Add('            valortotal )');
      aQry.Sql.Add(' VALUES (');
      aQry.Sql.Add(IntToStr(FNumeroPedido));
      aQry.Sql.Add(' ,'+QuotedStr(FormatDateTime('dd/mm/yyyy', Now)));
      aQry.Sql.Add(' ,'+IntToStr(FCodigoCliente));
      aQry.Sql.Add(' ,'+QuotedStr(FormatFloat('0.00',FValorTotalPedido)));
      aQry.Sql.Add(' )');
      aQry.ExecSQL;

      aMemTableItens.First;
      while not aMemTableItens.Eof do
      begin
        aQry.Close;
        aQry.Sql.Clear;
        aQry.Sql.Add('INSERT INTO produtos_do_pedido (');
        aQry.Sql.Add('            numeropedido,');
        aQry.Sql.Add('            codigoproduto,');
        aQry.Sql.Add('            quantidade,');
        aQry.Sql.Add('            vlrunitario,');
        aQry.Sql.Add('            vlrtotal)');
        aQry.Sql.Add(' VALUES (');;
        aQry.Sql.Add(IntToStr(FNumeroPedido));
        aQry.Sql.Add(' ,'+IntToStr(aMemTableItens.FieldByName('codigoproduto').AsInteger));
        aQry.Sql.Add(' ,'+QuotedStr(FormatFloat('0.000',aMemTableItens.FieldByName('quantidade').AsFloat)));
        aQry.Sql.Add(' ,'+QuotedStr(FormatFloat('0.00',aMemTableItens.FieldByName('vlrunitario').AsFloat)));
        aQry.Sql.Add(' ,'+QuotedStr(FormatFloat('0.00',aMemTableItens.FieldByName('vlrtotal').AsFloat)));
        aQry.Sql.Add(' )');
        aQry.ExecSQL;
        aMemTableItens.Next;
      end;
      aTransacao.CommitRetaining;
    except on E: Exception do
      begin
        aTransacao.RollbackRetaining;
        raise Exception.Create(mProblemsAoPersistirDadosEmBanco+E.Message);
      end;
    end;
  finally
    FreeAndNil(aTransacao);
    FormatSettings.DecimalSeparator := ',';
  end;
end;

function TControllerPedidoVenda.CodigoCliente: integer;
begin
  Result := FCodigoCliente;
end;

function TControllerPedidoVenda.CodigoCliente(Value: integer): iContPedidoVenda;
begin
  Result := Self;
  FCodigoCliente := Value;
end;

function TControllerPedidoVenda.ColocarEmEstadoInclusao: iContPedidoVenda;
begin
  FNumeroPedido := getUltimoNumero + 1;
  FEstadoPedido := tpInclusao;
  Result := Self;
end;

constructor TControllerPedidoVenda.Create;
begin
  FEstadoPedido := eLivre;
  FFDQuery := TFDQuery.Create(nil);
end;

destructor TControllerPedidoVenda.Destroy;
begin

  inherited;
end;

function TControllerPedidoVenda.EstadoPedido: TEstado;
begin
  Result := FEstadoPedido;
end;

function TControllerPedidoVenda.EstadoPedido(Value: TEstado): iContPedidoVenda;
begin
  Result := Self;
  FEstadoPedido := Value;
end;

function TControllerPedidoVenda.getUltimoNumero: integer;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT max(NumeroPedido) as UltimaPosicao');
    FFDQuery.Sql.Add(' FROM pedido_dados_gerais');
    FFDQuery.Open();
    Result := FFDQuery.FieldByName('UltimaPosicao').AsInteger;
  except on E: Exception do
    raise;
  end;
end;

class function TControllerPedidoVenda.New: iContPedidoVenda;
begin
  Result := Self.Create;
end;

function TControllerPedidoVenda.NumeroPedido: integer;
begin
  Result:= FNumeroPedido;
end;

function TControllerPedidoVenda.ValorTotalPedido: Currency;
begin
  Result := FValorTotalPedido;
end;

function TControllerPedidoVenda.ValorTotalPedido(Value: Currency): iContPedidoVenda;
begin
  Result := Self;
  FValorTotalPedido := Value;
end;

function TControllerPedidoVenda.NumeroPedido(Value: integer): iContPedidoVenda;
begin
  Result := Self;
  FNUmeroPedido := Value;
end;
end.