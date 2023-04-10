unit einterface.usuario;

interface
uses Data.DB,
     System.Classes;
  type
  iUsuario = interface

  ['{DB0433D7-1DB5-4BDF-AD77-83C4612BF2F3}']
  function Codigo(Value: integer) :iUsuario; overload;
  function Codigo :integer; overload;

  function Login(Value: String) :iUsuario; overload;
  function Login: String; overload;

  function Senha(Value: String) :iUsuario; overload;
  function Senha: String; overload;

  function Open(aDataSource : TDataSource):iUsuario; overload;
  function getUsuario:iUsuario; overload;

  end;


implementation

end.