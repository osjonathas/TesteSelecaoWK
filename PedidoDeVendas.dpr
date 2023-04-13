program PedidoDeVendas;

uses
  Vcl.Forms,
  uPrincipal in 'src\view\uPrincipal.pas' {fmPrincipal},
  unfraPesquisa in 'src\view\unfraPesquisa.pas' {fraPesquisa: TFrame},
  uframeCadastroBase in 'src\view\uframeCadastroBase.pas' {frameCadastroBase: TFrame},
  uframeCadUsuario in 'src\view\uframeCadUsuario.pas' {frameCadUsuario: TFrame},
  UnClasseSistema in 'src\model\UnClasseSistema.pas',
  ufrmLogin in 'src\view\ufrmLogin.pas' {frmLogin},
  model.connection in 'src\model\connection\model.connection.pas' {Connection: TDataModule},
  KrUtil in 'src\KrUtil.pas',
  UnitPergunta in 'src\view\UnitPergunta.pas' {frmPergunta},
  einterface.usuario in 'src\model\einterface.usuario.pas',
  model.usuario in 'src\model\model.usuario.pas',
  UnMensagem in 'src\view\UnMensagem.pas' {FrmMensagem},
  unframePedidoVenda in 'src\view\unframePedidoVenda.pas' {framePedidoVenda: TFrame},
  einterface.pedidovenda in 'src\model\einterface.pedidovenda.pas',
  model.pedidovenda in 'src\model\model.pedidovenda.pas',
  controller.PedidoVenda in 'src\controller\controller.PedidoVenda.pas',
  einterface.controller.pedidovenda in 'src\model\einterface.controller.pedidovenda.pas',
  einterface.cliente in 'src\model\einterface.cliente.pas',
  model.cliente in 'src\model\model.cliente.pas',
  einterface.produto in 'src\model\einterface.produto.pas',
  model.produto in 'src\model\model.produto.pas',
  einterface.produto_do_pedido in 'src\model\einterface.produto_do_pedido.pas',
  model.produto_do_pedido in 'src\model\model.produto_do_pedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConnection, Connection);
  Application.CreateForm(TfmPrincipal, fmPrincipal);
  Application.Run;
end.
