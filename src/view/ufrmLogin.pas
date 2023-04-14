unit ufrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Mask, model.usuario, einterface.usuario,
  Vcl.Imaging.pngimage;

type
  TOpcaoValida = (ovLogin, ovSenha);

  TfrmLogin = class(TForm)
    imgFundoTela: TImage;
    pnLogin: TPanel;
    imgLogo: TImage;
    pnDadosLogin: TPanel;
    Label1: TLabel;
    shUsuario: TShape;
    edtLogin: TEdit;
    Label2: TLabel;
    shSenha: TShape;
    edtSenha: TEdit;
    pn_IncluirNovo: TPanel;
    btConfirmar: TSpeedButton;
    Panel1: TPanel;
    btFechar: TSpeedButton;
    pnInformativo: TPanel;
    lbTitulo: TLabel;
    lbVersao: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FUsuario : iUsuario;
    procedure CentralizarPainelLogin(aForm: TForm; aPanel: TPanel);
    function validalogin(aOpcaoValida: TOpcaoValida):boolean;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UnMensagem, KrUtil, uPrincipal;

{ TfrmLogin }

procedure TfrmLogin.btConfirmarClick(Sender: TObject);
begin
  inherited;
  validalogin(ovSenha);
end;

procedure TfrmLogin.CentralizarPainelLogin(aForm: TForm; aPanel: TPanel);
begin
  aPanel.Left := (aForm.ClientWidth div 2) - (aPanel.Width div 2);
  imgLogo.Top  := 10;
  imgLogo.Left := 0;
  aPanel.Update;
  aForm.Update;
end;

procedure TfrmLogin.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if validalogin(ovLogin) then
      edtSenha.SetFocus;
end;

procedure TfrmLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btConfirmar.Click;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  ModalResult := mrNone;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    btFechar.Click;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  CentralizarPainelLogin(frmLogin, pnLogin);
  lbVersao.Caption := 'versão 2023.4.2';
end;

procedure TfrmLogin.btFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

function TfrmLogin.validalogin(aOpcaoValida: TOpcaoValida): boolean;
begin
  Result := false;
  if aOpcaoValida = ovLogin then
  begin
    if (Trim(edtLogin.Text) = EmptyStr) then
    begin
      TfrmMensagem.ExibirMensagem('Informe o usuário para efetuar o login.', tmInformacao);
      Exit;
    end;

    FUsuario := TUsuario
                .New
                .Login(trim(edtLogin.Text))
                  .getUsuario();

    if not Assigned(FUsuario) then
    begin
      TfrmMensagem.ExibirMensagem('Usuário não localizado na base de dados.', tmInformacao);
      Exit;
    end;
  end;

  if aOpcaoValida = ovSenha then
  begin
    if not Assigned(FUsuario) then
    begin
      TFrmMensagem.ExibirMensagem('Usuário inválido.', tmPare);
      Exit;
    end;

    if (UpperCase(edtSenha.Text) <> UpperCase(FUsuario.Senha)) then
    begin
      TFrmMensagem.ExibirMensagem('Senha inválida.', tmPare);
      Exit;
    end;

    fmPrincipal.Sistema.SetFuncionarioLogado(IntToStr(FUsuario.Codigo), FUsuario.Login,'' );
    ModalResult:= mrOk;
  end;
  Result := True;
end;

end.
