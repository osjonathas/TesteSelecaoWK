unit einterface.produto;

interface
uses Data.DB,
     System.Classes;
  type
  iProduto = interface
  ['{C072F26E-ADC1-4A17-BCE8-EBE61D7B9414}']
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

end.
