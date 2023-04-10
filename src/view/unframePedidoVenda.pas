unit unframePedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, model.connection, einterface.pedidovenda, model.pedidovenda, unfraPesquisa, uframeCadastroBase,
  Vcl.ComCtrls, Vcl.WinXCtrls, Vcl.Mask, einterface.controller.pedidovenda, FireDAC.Stan.StorageBin, einterface.cliente, model.cliente,
  KrUtil, Vcl.NumberBox, einterface.produto;

type
  TframePedidoVenda = class(TframeCadastroBase)
    FDConsultanumeropedido: TIntegerField;
    FDConsultadataemissao: TStringField;
    FDConsultacodigocliente: TIntegerField;
    FDConsultavalortotal: TBCDField;
    FDConsultanome: TStringField;
    FDConsultaCLIENTE: TLargeintField;
    pbDadosPedido: TPanel;
    DBGrid1: TDBGrid;
    pnTituloItens: TPanel;
    pnCabecalho: TPanel;
    edtCliente: TSearchBox;
    edtNumeroPedido: TLabeledEdit;
    edtDataEmissao: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    pnIncluirMinisterio: TPanel;
    btn_incluirItem: TSpeedButton;
    pnRemoverItem: TPanel;
    btn_RemoverItem: TSpeedButton;
    Label3: TLabel;
    lbTotalPedido: TLabel;
    dsItens: TDataSource;
    FDMemTableItens: TFDMemTable;
    FDMemTable1numeropedido: TIntegerField;
    FDMemTable1codigoproduto: TIntegerField;
    FDMemTable1quantidade: TBCDField;
    FDMemTable1vlrunitario: TBCDField;
    FDMemTable1vlrtotal: TBCDField;
    FDMemTable1descricao: TStringField;
    dsConsultaCliente: TDataSource;
    FDPesquisaCliente: TFDQuery;
    FDPesquisaClientecodigo: TFDAutoIncField;
    FDPesquisaClientenome: TStringField;
    FDPesquisaClientecidade: TStringField;
    FDPesquisaClienteuf: TStringField;
    pnConsultaCliente: TPanel;
    pnTituloConsultaCliente: TPanel;
    pnRodapeConsultaCliente: TPanel;
    pnButtonAplicarCliente: TPanel;
    btn_AplicarCliente: TSpeedButton;
    pnButtonCancelCliente: TPanel;
    btn_CancelCliente: TSpeedButton;
    DBGItens: TDBGrid;
    pnInserirItens: TPanel;
    pnTituloInserirProduto: TPanel;
    Panel3: TPanel;
    pnbuttonAplicarItem: TPanel;
    btn_AplicarItem: TSpeedButton;
    pnbuttonCancelItem: TPanel;
    btn_CancelItem: TSpeedButton;
    edtCodigoProduto: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtValorUnit: TLabeledEdit;
    edtQuantidade: TLabeledEdit;
    edtValorTotal: TLabeledEdit;
    procedure FrameResize(Sender: TObject);
    procedure edtClienteInvokeSearch(Sender: TObject);
    procedure btn_CancelClienteClick(Sender: TObject);
    procedure btn_AplicarClienteClick(Sender: TObject);
    procedure btn_CancelItemClick(Sender: TObject);
    procedure btn_incluirItemClick(Sender: TObject);
    procedure edtCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure btn_AplicarItemClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btn_RemoverItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FContPedVenda : iContPedidoVenda;
    FProduto : iProduto;
    procedure ExecutarPesquisa; override;
    procedure ColocarEmEstadoInclusao; override;
    procedure Persistir; override;

    procedure LimparDadosPedido;
    procedure LimparDadosItens;
    procedure ConsultarCliente;
    procedure CancelarConsultaCliente;
    procedure CancelarInserirItem;
    procedure setConsultaCliente;
    procedure ChamarInserirItem;
    procedure CarregarDadosProduto;
    procedure CalcularTotarItem;
    procedure ConfirmarInsercaoItem;
    procedure AtualizarTotalPedido;
    procedure RemoverItem;
  end;

var
  framePedidoVenda: TframePedidoVenda;

implementation

uses
  controller.PedidoVenda, UnMensagem, model.produto, UnitPergunta;

{$R *.dfm}

{ TframePedidoVenda }

procedure TframePedidoVenda.CalcularTotarItem;
begin
  if Assigned(FProduto) then
  begin
    edtValorTotal.Text := FormatFloat(',0.00', FProduto.PrecoVenda * StrToFloat(edtQuantidade.Text));
  end;
end;

procedure TframePedidoVenda.CancelarConsultaCliente;
begin
  FDMemTableItens.Close;
  pnConsultaCliente.Enabled := False;
  pnConsultaCliente.Visible := False;
  pnConsultaCliente.SendToBack;
end;

procedure TframePedidoVenda.CancelarInserirItem;
begin
  pnInserirItens.Enabled := False;
  pnInserirItens.Visible := False;
  pnInserirItens.SendToBack;
end;

procedure TframePedidoVenda.CarregarDadosProduto;
begin
  FProduto := TProduto
               .New
               .Codigo(StrToInt(edtCodigoProduto.Text))
                .getProduto;

  if Assigned(FProduto) then
  begin
    edtDescricao.Text := FProduto.Descricao;
    edtValorUnit.Text := FormatFloat(',0.00', FProduto.PrecoVenda);
    edtQuantidade.SetFocus;
  end;
end;

procedure TframePedidoVenda.ColocarEmEstadoInclusao;
begin
  inherited;
  LimparDadosPedido;
  FContPedVenda := TControllerPedidoVenda
                    .New
                     .ColocarEmEstadoInclusao;

  if assigned(FContPedVenda) then
  begin
    edtNumeroPedido.Text := IntToStr(FContPedVenda.NumeroPedido);
    edtNumeroPedido.Enabled := False;
    edtDataEmissao.Date := Now;
    edtCliente.SetFocus;
    FDMemTableItens.Close;
    FDMemTableItens.Open;
  end;
end;

procedure TframePedidoVenda.ConfirmarInsercaoItem;
begin
  if TfrmPergunta.Pergunta('Confirma inserir o �tem ao pedido?',tmpergunta) then
  begin
    FDMemTableItens.Open;
    FDMemTableItens.Append;
    FDMemTableItens.FieldByName('NumeroPedido').AsInteger  := FContPedVenda.NumeroPedido;
    FDMemTableItens.FieldByName('CodigoProduto').AsInteger := FProduto.Codigo;
    FDMemTableItens.FieldByName('Descricao').AsString      := FProduto.Descricao;
    FDMemTableItens.FieldByName('VlrUnitario').AsFloat     := FProduto.PrecoVenda;
    FDMemTableItens.FieldByName('Quantidade').AsFloat      := StrToFloat(edtQuantidade.Text);
    FDMemTableItens.FieldByName('VlrTotal').AsFloat        := StrToFloat(edtValorTotal.Text);
    FDMemTableItens.Post;

    AtualizarTotalPedido;
    pnInserirItens.Enabled := False;
    pnInserirItens.Visible := False;
    pnInserirItens.SendToBack;
  end;
end;

procedure TframePedidoVenda.ConsultarCliente;
begin
  pnConsultaCliente.Top     := edtCliente.Top;
  pnConsultaCliente.Left    := 157;
  pnConsultaCliente.Enabled := True;
  pnConsultaCliente.Visible := True;
  pnConsultaCliente.BringToFront;

  TCliente
   .New
    .Open(dsConsultaCliente);
end;

procedure TframePedidoVenda.edtClienteInvokeSearch(Sender: TObject);
begin
  inherited;
  ConsultarCliente;
end;

procedure TframePedidoVenda.edtCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
    CarregarDadosProduto;
end;

procedure TframePedidoVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  CalcularTotarItem;
end;

procedure TframePedidoVenda.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if KEY = #13 then
    edtValorTotal.SetFocus;
end;

procedure TframePedidoVenda.edtValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if KEY = #13 then
    btn_AplicarItem.Click;
end;

procedure TframePedidoVenda.ExecutarPesquisa;
begin
  FContPedVenda := TControllerPedidoVenda
                    .New
                    .Open(dsConsulta);
end;

procedure TframePedidoVenda.FrameResize(Sender: TObject);
begin
  inherited;
  fraPesquisa.FTamMax := 197;
end;

procedure TframePedidoVenda.ChamarInserirItem;
begin
  LimparDadosItens;
  if (not FInclusao) and (not FEdicao) then
  begin
    TFrmMensagem.ExibirMensagem('Pedido n�o est� em estado de inclus�o/edi��o!  Inclus�o de �tem nao � permitida!', tmInfo);
    exit;
  end;

  pnInserirItens.Top     := edtCliente.Top;
  pnInserirItens.Left    := 157;
  pnInserirItens.Enabled := True;
  pnInserirItens.Visible := True;
  pnInserirItens.BringToFront;
  edtCodigoProduto.SetFocus;
end;

procedure TframePedidoVenda.LimparDadosItens;
begin
  edtCodigoProduto.Clear;
  edtDescricao.Clear;
  edtValorUnit.Clear;
  edtQuantidade.Clear;
  edtValorTotal.Clear;
end;

procedure TframePedidoVenda.LimparDadosPedido;
begin
  edtNumeroPedido.Clear;
  edtCliente.Clear;
  lbTotalPedido.Caption := '0,00';
  FDMemTableItens.Close;
  pnConsultaCliente.Visible := False;
  Application.ProcessMessages;
end;

procedure TframePedidoVenda.Persistir;
begin
  if TfrmPergunta.Pergunta('Confirma gravar os dados do pedido?',tmPergunta) then
  begin
    if trim(edtCliente.Text) = EmptyStr then
    begin
      TFrmMensagem.ExibirMensagem('Informe um cliente para o pedido!', tmAlerta);
      exit;
    end;

    if FDMemTableItens.IsEmpty then
    begin
      TFrmMensagem.ExibirMensagem('Pedido sem �tens!', tmAlerta);
      exit;
    end;

    AtualizarTotalPedido;
    try
      if FInclusao then
      begin
        FContPedVenda.IncluirPedidoVenda(FDMemTableItens);
      end;
      TFrmMensagem.ExibirMensagem('Pedido gravado com sucesso!', tmInfo);
      inherited;

    finally

    end;
  end;
end;

procedure TframePedidoVenda.RemoverItem;
begin
  if not FDMemTableItens.IsEmpty then
  begin
    if FInclusao OR FEdicao then
    begin
      if TFrmPergunta.Pergunta('Deseja realmente remover o �tem do pedido?', tmPergunta) then
      begin
        FDMemTableItens.Delete;
        AtualizarTotalPedido;
      end;
    end;
  end;
end;

procedure TframePedidoVenda.setConsultaCliente;
begin
  edtCliente.Text := IntToStr(dsConsultaCliente.DataSet.FieldByName('Codigo').AsInteger)+' - '+dsConsultaCliente.DataSet.FieldByName('Nome').AsString;
  FContPedVenda.CodigoCliente(dsConsultaCliente.DataSet.FieldByName('Codigo').AsInteger);
  pnConsultaCliente.Enabled := False;
  pnConsultaCliente.Visible := False;
  pnConsultaCliente.SendToBack;
  FDMemTableItens.Close;
end;

procedure TframePedidoVenda.btn_incluirItemClick(Sender: TObject);
begin
  inherited;
  ChamarInserirItem;
end;

procedure TframePedidoVenda.btn_RemoverItemClick(Sender: TObject);
begin
  inherited;
  RemoverItem;
end;

procedure TframePedidoVenda.btn_CancelItemClick(Sender: TObject);
begin
  inherited;
  CancelarInserirItem;
end;

procedure TframePedidoVenda.AtualizarTotalPedido;
var
   aTotal : Currency;
begin
  aTotal := 0;
  if not FDMemTableItens.IsEmpty then
  begin
    FDMemTableItens.First;
    while not FDMemTableItens.Eof do
    begin
      aTotal := aTotal + FDMemTableItens.FieldByName('vlrtotal').AsFloat;
      FDMemTableItens.Next;
    end;
  end;
  FContPedVenda.ValorTotalPedido(aTotal);
  lbTotalPedido.Caption := FormatFloat(',0.00', aTotal);
  Application.ProcessMessages;
end;

procedure TframePedidoVenda.btn_AplicarClienteClick(Sender: TObject);
begin
  inherited;
  setConsultaCliente;
end;

procedure TframePedidoVenda.btn_AplicarItemClick(Sender: TObject);
begin
  inherited;
  ConfirmarInsercaoItem;
end;

procedure TframePedidoVenda.btn_CancelClienteClick(Sender: TObject);
begin
  inherited;
  CancelarConsultaCliente;
end;

end.
