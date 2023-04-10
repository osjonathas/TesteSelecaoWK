unit uPrincipal;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Imaging.pngimage,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  unClasseSistema,
  uframeCadastroBase,
  unframePedidoVenda,
  uframeCadUsuario;

type
  TfmPrincipal = class(TForm)
    pnl_fundo: TPanel;
    pnl_menu_lateral: TPanel;
    btn_sair: TSpeedButton;
    btn_config: TSpeedButton;
    btn_pedidovenda: TSpeedButton;
    btn_empresa: TSpeedButton;
    btn_usuarios: TSpeedButton;
    pnSubmenu: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    pnTopo: TPanel;
    lbSistema: TLabel;
    lbUsuarioLogado: TLabel;
    pnBarraTopo: TPanel;
    pn_menu_barra: TPanel;
    imgLogoInt: TImage;
    btnRest: TSpeedButton;
    btnClose: TSpeedButton;
    framePedidoVenda: TframePedidoVenda;
    frameCadUsuario: TframeCadUsuario;
    btn_menu: TSpeedButton;
    procedure btn_menuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_configClick(Sender: TObject);
    procedure pnl_fundoMouseEnter(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure btcloseClick(Sender: TObject);
    procedure btminimizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_usuariosClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnRestClick(Sender: TObject);
    procedure btn_pedidovendaClick(Sender: TObject);
  private
    { Private declarations }
    procedure FecharFrames;
    procedure ChamarFrame(Objeto: TWinControl);
  public

    { Public declarations }
    Sistema : TSistema;
  end;

var
  fmPrincipal: TfmPrincipal;
  FMenuExpandido : boolean;

implementation

{$R *.dfm}

uses model.connection, ufrmLogin, KrUtil;

procedure TfmPrincipal.btcloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmPrincipal.btminimizeClick(Sender: TObject);
begin
  if Self.WindowState = TWindowState.wsMaximized then
    Self.WindowState := TWindowState.wsMinimized
  else
    Self.WindowState := TWindowState.wsMaximized;
end;

procedure TfmPrincipal.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmPrincipal.btnRestClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfmPrincipal.btn_menuClick(Sender: TObject);
begin
  if FMenuExpandido then
    pnl_menu_lateral.Width := 45
  else
    pnl_menu_lateral.Width :=  160;

  FMenuExpandido := not FMenuExpandido;
end;

procedure TfmPrincipal.btn_sairClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfmPrincipal.btn_usuariosClick(Sender: TObject);
begin
  ChamarFrame(frameCadUsuario);
end;

procedure TfmPrincipal.ChamarFrame(Objeto: TWinControl);
begin
  FecharFrames;
  if not TWinControl(Objeto).Visible then
  begin
    Objeto.Align := alClient;
    Objeto.visible := true;
  end;
end;

procedure TfmPrincipal.FecharFrames;
var I : integer;
begin
  for I := 0 to Pred(ComponentCount) do
  begin
    if Components[I].inheritsfrom(TFrame) then
    begin
      TFrame(Components[I]).Align := alNone;
      TFrame(Components[I]).Visible := False;
    end;
  end;
end;

procedure TfmPrincipal.FormCreate(Sender: TObject);
begin
  Sistema := TSistema.Create;
  try
    if connection.Conectar(Sistema.NomeServidor, Sistema.NomeBanco, Sistema.LoginBanco, Sistema.SenhaBAnco) then
    begin
      SetWindowLong(fmPrincipal.Handle, GWL_STYLE, GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
      Height := ClientHeight;
      Application.CreateForm(TfrmLogin, frmLogin);
      frmLogin.ShowModal;
      if not frmLogin.ModalResult = mrOk then
        Application.Terminate;
      FreeAndNil(frmLogin);
    end;
  except on E: Exception do
    begin
      raise Exception.Create(mProblemasNaConexaoComBanco+E.Message);
      Application.Terminate;
    end;
  end;
end;

procedure TfmPrincipal.FormShow(Sender: TObject);
begin
  pnl_menu_lateral.Width := 40;
  lbSistema.Caption := 'Sistema de Vendas - vers�o '+Sistema.CapturarVersaoExe;
  lbSistema.left := imgLogoInt.Width + 30;
  lbSistema.Top  := 21;
  lbUsuarioLogado.Top := 21;
  lbUsuarioLogado.Caption := Sistema.NomeFuncionarioLogado;
  Application.ProcessMessages;
end;

procedure TfmPrincipal.pnl_fundoMouseEnter(Sender: TObject);
begin
  pnSubmenu.Visible := False;
end;

procedure TfmPrincipal.btn_pedidovendaClick(Sender: TObject);
begin
  ChamarFrame(framePedidoVenda);
end;

procedure TfmPrincipal.btn_configClick(Sender: TObject);
begin
  if FMenuExpandido then
    pnSubmenu.Left := 40
  else
    pnSubmenu.Left := 160;
end;

end.
