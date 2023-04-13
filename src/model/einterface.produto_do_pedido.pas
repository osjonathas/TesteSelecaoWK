unit einterface.produto_do_pedido;

interface
uses Data.DB,
     System.Classes;
  type
  iProduto_do_Pedido = interface
  ['{C92134C8-1654-4D98-B27A-B1C6CDCDC128}']

  function NumeroPedido(Value: integer) :iProduto_do_Pedido; overload;
  function NumeroPedido :integer; overload;

  function Codigo(Value: integer) :iProduto_do_Pedido; overload;
  function Codigo :integer; overload;

  function ValorUnitario(Value: Currency) :iProduto_do_Pedido; overload;
  function ValorUnitario: Currency; overload;

  function Quantidade(Value: Currency) :iProduto_do_Pedido; overload;
  function Quantidade: Currency; overload;

  function Total(Value: Currency) :iProduto_do_Pedido; overload;
  function Total: Currency; overload;

 end;
implementation

end.
