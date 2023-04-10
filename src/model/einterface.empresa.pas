unit einterface.empresa;

interface
uses Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;


  type
  iEmpresa = interface

  ['{1EDAFFDC-33D9-4AAD-B9E5-BCF078A8B951}']

    function Codigo(Value: integer) :iEmpresa; overload;
    function Codigo :integer; overload;

    function CNPJ(Value: String) :iEmpresa; overload;
    function CNPJ: String; overload;

    function Descricao(Value: String) :iEmpresa; overload;
    function Descricao: String; overload;
    function Open(aTabela : string; aDataSource : TDataSource):iEmpresa; overload;
    function IncluirEmpresa:iEmpresa; overload;
    function getEmpresa(aCodigo : integer):iEmpresa; overload;
    function Insert:iEmpresa; overload;
    function Update:iEmpresa; overload;
  end;


implementation

end.
