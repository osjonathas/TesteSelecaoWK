unit einterface.controller.pedidovenda;

interface
uses Data.DB,
     System.Classes,
     FireDAC.Comp.Client,
     einterface.pedidovenda;
  type
  iContPedidoVenda = interface
    ['{B3A48BEF-A34B-48CD-A004-72B6E3F6CCAF}']
    function NumeroPedido(Value: integer) :iContPedidoVenda; overload;
    function NumeroPedido: integer;overload;

    function CodigoCliente(Value: integer) :iContPedidoVenda; overload;
    function CodigoCliente: integer;overload;

    function ValorTotalPedido(Value: Currency) :iContPedidoVenda; overload;
    function ValorTotalPedido: Currency;overload;

    function PedidoVenda(Value: iPedidoVenda) :iContPedidoVenda; overload;
    function PedidoVenda: iPedidoVenda;overload;

    function Open(aDataSource : TDataSource):iContPedidoVenda; overload;
    function ColocarEmEstadoInclusao:iContPedidoVenda;
    function IncluirPedidoVenda(aMemTableItens: TFDMemTable):iContPedidoVenda;
  end;


implementation

end.
