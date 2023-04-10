unit einterface.cliente;

interface
uses Data.DB,
     System.Classes;
  type
  iCliente = interface
  ['{B7FC8A29-B6AB-4579-86E3-94951D15396B}']
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

end.