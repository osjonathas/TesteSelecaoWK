unit unFormularioCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unFormularioBase, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.WinXCtrls, System.ImageList,
  Vcl.ImgList, KrUtil, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.TitleBarCtrls, unfraPesquisa;

type
  TfrmFormularioCadastroBase = class(TfrmFormularioBase)
    pnConsulta: TPanel;
    pn_IncluirNovo: TPanel;
    gridPesquisa: TDBGrid;
    pnResultado: TPanel;
    pnCadastro: TPanel;
    pnBotoesForm: TPanel;
    pn_Confirma: TPanel;
    pn_Cancela: TPanel;
    pn_Exclui: TPanel;
    btConfirma: TSpeedButton;
    btCancela: TSpeedButton;
    btExclui: TSpeedButton;
    btIncluir: TSpeedButton;
    dsConsulta: TDataSource;
    FDConsulta: TFDQuery;
    fraPesquisa: TfraPesquisa;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure gridPesquisaDblClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fraPesquisaSpeedButton2Click(Sender: TObject);
    procedure fraPesquisabtPesqClick(Sender: TObject);
    procedure btcloseClick(Sender: TObject);
    procedure btcloseMouseEnter(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure gridPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FNomeTabela: String;
    FCampoControle: String;
    { Private declarations }
  public
    { Public declarations }

    procedure PosicionarBotoes;
    procedure DesenharTelaInicial;

    procedure MudarEstadoBotoes(opcao: TStatusBotoes);
    procedure ColocarEmEstadoInclusao; Virtual;
    procedure ColocarEmEstadoEdicao; Virtual;
    procedure CancelarEdicao; virtual;
    procedure Excluir; Virtual;
    procedure Persistir; virtual;
    procedure ExecutarPesquisa; virtual;
    procedure CarregarRegistroPesquisa(AValor: String); virtual;

    property NomeTabela: String read FNomeTabela write FNomeTabela;
    property CampoControle: String read FCampoControle write FCampoControle;

    procedure TratamentoDeTecla(aKey : Char);
  end;

var
  frmFormularioCadastroBase: TfrmFormularioCadastroBase;
  FInclusao, FEdicao : boolean;

implementation

{$R *.dfm}

uses UnMensagem, UnitPergunta;

{ TfrmFormularioCadastroBase }

procedure Arredondarcantos(componente: TWinControl; Y:String);
var
   BX: TRect;
   mdo: HRGN;
begin
  with componente do
  begin
    BX := ClientRect;
    mdo := CreateRoundRectRgn(BX.Left, BX.Top, BX.Right,
    BX.Bottom, StrToInt(Y), StrToInt(Y)) ;
    Perform(EM_GETRECT, 0, lParam(@BX)) ;
    InflateRect(BX, - 4, - 4) ;
    Perform(EM_SETRECTNP, 0, lParam(@BX)) ;
    SetWindowRgn(Handle, mdo, True) ;
    Invalidate;
  end;
end;

procedure TfrmFormularioCadastroBase.btCancelaClick(Sender: TObject);
begin
  inherited;
  CancelarEdicao;
end;

procedure TfrmFormularioCadastroBase.btcloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmFormularioCadastroBase.btcloseMouseEnter(Sender: TObject);
begin
  inherited;
//btclose.font.Color := clRed;
//Application.Processmessages;
end;

procedure TfrmFormularioCadastroBase.btConfirmaClick(Sender: TObject);
begin
  inherited;
  Persistir;
end;

procedure TfrmFormularioCadastroBase.btIncluirClick(Sender: TObject);
begin
  inherited;
  ColocarEmEstadoInclusao;
end;

procedure TfrmFormularioCadastroBase.CancelarEdicao;
begin
  MudarEstadoBotoes(sbInicialSemDados);
  FInclusao := False;
  FEdicao   := False;
  pnConsulta.Visible := True;
  pnCadastro.Visible := False;
  pnConsulta.BringToFront;
  //edtValor.SetFocus;
end;

procedure TfrmFormularioCadastroBase.CarregarRegistroPesquisa(AValor: String);
begin

end;

procedure TfrmFormularioCadastroBase.ColocarEmEstadoEdicao;
begin
  pnConsulta.Visible := False;
  pnCadastro.Visible := True;
  pnCadastro.BringToFront;
  MudarEstadoBotoes(sbInsercaoEdicao);
  FEdicao := True;
end;

procedure TfrmFormularioCadastroBase.ColocarEmEstadoInclusao;
begin
  pnConsulta.Visible := False;
  pnCadastro.Visible := True;
  pnCadastro.BringToFront;
  MudarEstadoBotoes(sbInsercaoEdicao);
  FInclusao := True;
end;

procedure TfrmFormularioCadastroBase.DesenharTelaInicial;
begin
 { pnConsulta.Align := alClient;
  pnCadastro.Align := alClient;
  pnCadastro.Visible := False;
  pnConsulta.BringToFront;
  pnConsulta.Visible := true;}
end;

procedure TfrmFormularioCadastroBase.Excluir;
begin

end;

procedure TfrmFormularioCadastroBase.ExecutarPesquisa;
begin
  inherited;

end;

procedure TfrmFormularioCadastroBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if FInclusao or FEdicao then
  begin
    TfrmMensagem.Exibirmensagem(mCanceleOuGrave, tmAlerta);
    Action := caNone;
  end
  else
  Action := caFree;
end;

procedure TfrmFormularioCadastroBase.FormCreate(Sender: TObject);
begin
  inherited;
  DesenharTelaInicial;
 // FModoPesquisaAtivo   := False;
 end;

procedure TfrmFormularioCadastroBase.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TratamentoDeTecla(Key);
 { if Key = #13 then
  begin
    if (Sender is TEdit) or (Sender is TLabeledEdit) or (Sender is TSearchbox) or (Sender is TSearchBoxStyleHook) then
    begin
      Key := #0;
      SelectNext(ActiveControl as TWinControl, true, true);
    end;
   end;}
end;

procedure TfrmFormularioCadastroBase.FormShow(Sender: TObject);
begin
  inherited;
  PosicionarBotoes;
  MudarEstadoBotoes(sbInicialSemDados);
  lbSubTituloForm.Top := 5;
  lbSubTituloForm.Left := 10;
  lbTitulo.Top := 5;
  lbTitulo.Left := lbSubTituloForm.Left + lbSubTituloForm.Width + 5;
  FInclusao := False;
  FEdicao   := false;
  pnConsulta.BringToFront;
  ExecutarPesquisa;
end;

procedure TfrmFormularioCadastroBase.fraPesquisabtPesqClick(Sender: TObject);
begin
  inherited;
  ExecutarPesquisa;
end;

procedure TfrmFormularioCadastroBase.fraPesquisaSpeedButton2Click(
  Sender: TObject);
begin
  inherited;
  ExecutarPesquisa;
end;

procedure TfrmFormularioCadastroBase.gridPesquisaDblClick(Sender: TObject);
begin
  inherited;
//  CarregarRegistroPesquisa(dsConsulta.DataSet.FieldByName(FCampoControle).AsString);
end;

procedure TfrmFormularioCadastroBase.gridPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if State = [] then
  begin
    if gridPesquisa.DataSource.DataSet.RecNo mod 2 = 1 then
      gridPesquisa.Canvas.Brush.Color := clAqua
    else
      gridPesquisa.Canvas.Brush.Color := clWhite;
  end;
  gridPesquisa.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFormularioCadastroBase.MudarEstadoBotoes(opcao: TStatusBotoes);
begin
  if opcao = sbInicialSemDados then
  begin
    {* Estado inicial da tela *}
    pn_Confirma.Visible  := False;
    pn_Cancela.Visible   := False;
    pn_Exclui.Visible    := False;
  end;

  if opcao = sbInsercaoEdicao then
  begin
    {* Estado de edição *}
    pn_Confirma.Visible  := True;
    pn_Cancela.Visible   := True;
    pn_Exclui.Visible    := False;
  end;
end;

procedure TfrmFormularioCadastroBase.Persistir;
begin
  pnConsulta.Visible := True;
  pnCadastro.Visible := False;
  pnConsulta.BringToFront;
  MudarEstadoBotoes(sbInicialSemDados);
  FInclusao := False;
  FEdicao := False;
end;

procedure TfrmFormularioCadastroBase.PosicionarBotoes;
begin
{  btIncluir.left  := 8;
  btEditar.Left   := 130;
  btGravar.left   := 8;
  btCancelar.Left := 130;
  btSair.Left     := 256;}
end;

procedure TfrmFormularioCadastroBase.TratamentoDeTecla(aKey: Char);
begin
  if aKey = #13 then
  begin
    SelectNext(ActiveControl as TWinControl,True,True);
    aKey:= #0;
  end;

  if aKey = #27 then
  begin
    btnClose.Click;
  end;
end;

end.
