unit einterface.pedidovenda;

interface
uses Data.DB,
     System.Classes;
  type
  iPedidoVenda = interface
    ['{B2737524-40A7-4108-A701-D5D977EDE79C}']
    function NumeroPedido(Value: integer) :iPedidoVenda; overload;
    function NumeroPedido :integer; overload;

    function DataEmissao(Value: TDatetime) :iPedidoVenda; overload;
    function DataEmissao: TDateTime; overload;

    function CodigoCliente(Value: integer) :iPedidoVenda; overload;
    function CodigoCliente: integer; overload;

    function ValorTotal(Value: Currency) :iPedidoVenda; overload;
    function ValorTotal: Currency; overload;
  end;


implementation

end.
