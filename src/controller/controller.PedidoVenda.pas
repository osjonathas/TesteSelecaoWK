unit controller.PedidoVenda;

interface
  uses classes, System.StrUtils, System.SysUtils, Data.DB, FireDAC.Comp.Client, einterface.controller.pedidovenda,
  einterface.pedidovenda, model.pedidovenda, einterface.cliente, KrUtil, Generics.Collections, einterface.produto_do_pedido;

 type
   TControllerPedidoVenda = class(TInterfacedObject, iContPedidoVenda)
   private
     FFDQuery       : TFDQuery;
     FNumeroPedido  : integer;
     FCodigoCliente : integer;
     FEstadoPedido  : TEstado;
     FValorTotalPedido  : Currency;
     FPedidoVenda   :iPedidoVenda;
     FCliente       :iCliente;
     FItensPedido   :TList<iProduto_do_Pedido>;

     function getUltimoNumero:integer;
     function getCliente:iContPedidoVenda; overload;
     function getItensPedido:iContPedidoVenda; overload;
   public
     Constructor Create;
     Destructor Destroy; override;

     class function New:iContPedidoVenda;
     class function getDescricaoProduto(aCodigoProduto: integer): string;

     function NumeroPedido(Value: integer) :iContPedidoVenda; overload;
     function NumeroPedido: integer; overload;

     function CodigoCliente(Value: integer) :iContPedidoVenda; overload;
     function CodigoCliente: integer;overload;

     function EstadoPedido(Value: TEstado) :iContPedidoVenda; overload;
     function EstadoPedido: TEstado;overload;

     function ValorTotalPedido(Value: Currency) :iContPedidoVenda; overload;
     function ValorTotalPedido: Currency;overload;

     function PedidoVenda(Value: iPedidoVenda) :iContPedidoVenda; overload;
     function PedidoVenda: iPedidoVenda;overload;

     function ItensPedido(Value: TList<iProduto_do_Pedido>) :iContPedidoVenda; overload;
     function ItensPedido: TList<iProduto_do_Pedido>;overload;

     function Cliente(Value: iCliente) :iContPedidoVenda; overload;
     function Cliente: iCliente;overload;

     function Open(aDataSource : TDataSource):iContPedidoVenda; overload;
     function getPedidoVenda:iContPedidoVenda; overload;

     function ColocarEmEstadoInclusao:iContPedidoVenda;
     function IncluirPedidoVenda(aMemTableItens: TFDMemTable):iContPedidoVenda;
     function AlterarPedidoVenda(aMemTableItens: TFDMemTable):iContPedidoVenda;
     function ExcluirPedido:iContPedidoVenda;
   end;

implementation
uses model.connection, model.cliente, model.produto_do_pedido;
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

function TControllerPedidoVenda.ItensPedido: TList<iProduto_do_Pedido>;
begin
  Result := FItensPedido;
end;

function TControllerPedidoVenda.ItensPedido(Value: TList<iProduto_do_Pedido>): iContPedidoVenda;
begin
  Result := Self;
  FItensPedido := Value;
end;

function TControllerPedidoVenda.Cliente(Value: iCliente): iContPedidoVenda;
begin
  Result := Self;
  FCliente := Value;
end;

function TControllerPedidoVenda.AlterarPedidoVenda(aMemTableItens: TFDMemTable): iContPedidoVenda;
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

      aQry.Sql.Add(' UPDATE pedido_dados_gerais set');
      aQry.Sql.Add('  dataemissao = '+QuotedStr(FormatDateTime('dd/mm/yyyy', Now)));
      aQry.Sql.Add(' ,codigocliente ='+IntToStr(FCodigoCliente));
      aQry.Sql.Add(' ,valortotal = '+QuotedStr(FormatFloat('0.00',FValorTotalPedido)));
      aQry.Sql.Add(' WHERE numeropedido = '+IntToStr(FNumeroPedido));
      aQry.ExecSQL;

      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' DELETE from produtos_do_pedido ');
      aQry.Sql.Add(' WHERE numeropedido = '+IntToStr(FNumeroPedido));
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

function TControllerPedidoVenda.Cliente: iCliente;
begin
  Result := FCliente;
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
  FItensPedido   := TList<iProduto_do_Pedido>.Create;
end;

destructor TControllerPedidoVenda.Destroy;
begin

  inherited;
end;

function TControllerPedidoVenda.EstadoPedido: TEstado;
begin
  Result := FEstadoPedido;
end;

function TControllerPedidoVenda.ExcluirPedido: iContPedidoVenda;
var aTransacao : TFDTransaction;
    aQry : TFDQuery;
begin
  aTransacao := TFDTransaction.Create(nil);
  aQry := TFDQuery.Create(nil);
  try
    try
      aTransacao.Connection := Connection.FDConnection;
      aQry.Connection := Connection.FDConnection;
      aTransacao.StartTransaction;
      FormatSettings.DecimalSeparator := '.';

      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' Delete from produtos_do_pedido ');
      aQry.Sql.Add(' Where numeropedido = '+IntToStr(FNumeroPedido));
      aQry.ExecSQL;

      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' Delete from pedido_dados_gerais ');
      aQry.Sql.Add(' Where numeropedido = '+IntToStr(FNumeroPedido));
      aQry.ExecSQL;

      aTransacao.CommitRetaining;
      Result := Self;
    except on E: Exception do
      begin
        aTransacao.RollbackRetaining;
        raise Exception.Create(mProblemasNaExecucaoDaConsulta+E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
  end;
end;

function TControllerPedidoVenda.EstadoPedido(Value: TEstado): iContPedidoVenda;
begin
  Result := Self;
  FEstadoPedido := Value;
end;

function TControllerPedidoVenda.getCliente: iContPedidoVenda;
  var aQry : TFDQuery;
begin
  try
    aQry := TFDQuery.Create(nil);
    aQry.Connection := Connection.FDConnection;
    try
      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' Select codigo, nome');
      aQry.Sql.Add(' from clientes ');
      aQry.Sql.Add(' Where codigo = '+IntToStr(FCodigoCliente));
      aQry.Open;

      FCliente := TCliente.New;
      FCliente.Codigo(aQry.FieldByName('codigo').AsInteger);
      FCliente.Nome(aQry.FieldByName('nome').AsString);
      Result := Self;
    except on E: Exception do
      begin
        raise Exception.Create(mProblemasNaExecucaoDaConsulta+E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
  end;
end;

class function TControllerPedidoVenda.getDescricaoProduto(aCodigoProduto: integer): string;
var aQry : TFDQuery;
begin
  try
    aQry := TFDQuery.Create(nil);
    aQry.Connection := Connection.FDConnection;
    try
      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' SELECT descricao from Produtos ');
      aQry.Sql.Add(' Where codigo = '+IntToStr(aCodigoProduto));
      aQry.Open;

      Result := aQry.FieldByName('Descricao').AsString;
    except on E: Exception do
      begin
        raise Exception.Create(mProblemasNaExecucaoDaConsulta+E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
  end;
end;

function TControllerPedidoVenda.getItensPedido: iContPedidoVenda;
var aQry : TFDQuery;
    aItemPedido : iProduto_do_Pedido;
begin
  try
    aQry := TFDQuery.Create(nil);
    aQry.Connection := Connection.FDConnection;
    try
      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' SELECT numeropedido,  codigoproduto,  quantidade, vlrunitario, vlrtotal ');
      aQry.Sql.Add(' FROM produtos_do_pedido ');
      aQry.Sql.Add(' Where numeropedido = '+IntToStr(FNumeroPedido));
      aQry.Open;

      if not aQry.IsEmpty then
      begin
        FItensPedido.Clear;
        while not aQry.eof do
        begin
          aItemPedido := TProduto_do_Pedido.New;
          aItemPedido.NumeroPedido(aQry.FieldByName('NumeroPedido').AsInteger);
          aItemPedido.Codigo(aQry.FieldByName('CodigoProduto').AsInteger);
          aItemPedido.Quantidade(aQry.FieldByName('Quantidade').AsFloat);
          aItemPedido.ValorUnitario(aQry.FieldByName('VlrUnitario').AsFloat);
          aItemPedido.Total(aQry.FieldByName('VlrTotal').AsFloat);

          FItensPedido.Add(aItemPedido);
          aQry.Next;
        end;
      end;

      Result := Self;
    except on E: Exception do
      begin
        raise Exception.Create(mProblemasNaExecucaoDaConsulta+E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
  end;
end;

function TControllerPedidoVenda.getPedidoVenda: iContPedidoVenda;
var aQry : TFDQuery;
begin
  try
    aQry := TFDQuery.Create(nil);
    aQry.Connection := Connection.FDConnection;
    try
      aQry.Close;
      aQry.Sql.Clear;
      aQry.Sql.Add(' Select numeropedido, dataemissao, codigocliente, valortotal');
      aQry.Sql.Add(' from pedido_dados_gerais ');
      aQry.Sql.Add(' Where NumeroPedido = '+IntToStr(FNumeroPedido));
      aQry.Open;

      FPedidoVenda := TPedidoVenda.New;
      FPedidoVenda.NumeroPedido(aQry.FieldByName('NumeroPedido').AsInteger);
      FPedidoVenda.DataEmissao(aQry.FieldByName('DataEmissao').AsDateTime);
      FPedidoVenda.CodigoCliente(aQry.FieldByName('CodigoCliente').AsInteger);
      FPedidoVenda.ValorTotal(aQry.FieldByName('ValorTotal').AsFloat);

      FNumeroPedido := aQry.FieldByName('NumeroPedido').AsInteger;
      FCodigoCliente := aQry.FieldByName('CodigoCliente').AsInteger;
      getCliente;
      getItensPedido;

      Result := Self;
    except on E: Exception do
      begin
        raise Exception.Create(mProblemasNaExecucaoDaConsulta+E.Message);
      end;
    end;
  finally
    FreeAndNil(aQry);
  end;
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

function TControllerPedidoVenda.Open(aDataSource: TDataSource): iContPedidoVenda;
begin
  try
    FFDQuery.Close;
    FFDQuery.Connection := connection.FDConnection;
    FFDQuery.Sql.Clear;
    FFDQuery.Sql.Add(' SELECT p.numeropedido, p.dataemissao, p.codigocliente, p.valortotal, c.nome, CONCAT(CONVERT(c.codigo, char),'+QuotedStr(' - ')+',c.nome) as CLIENTE ');
    FFDQuery.Sql.Add(' FROM pedido_dados_gerais p');
    FFDQuery.Sql.Add(' left outer join clientes c on(c.codigo = p.codigocliente)');
    FFDQuery.Open();
    aDataSource.DataSet := FFDQuery;
    Result := self;

  except on E: Exception do
    raise;
  end;

end;

function TControllerPedidoVenda.PedidoVenda: iPedidoVenda;
begin
  Result := FPedidoVenda;
end;

function TControllerPedidoVenda.PedidoVenda(Value: iPedidoVenda): iContPedidoVenda;
begin
  Result := Self;
  FPedidoVenda := Value;
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
