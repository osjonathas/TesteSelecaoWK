unit ufrmAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBase, JvExControls, JvNavigationPane, ExtCtrls,
  StdCtrls, JvXPCore, JvXPButtons, uDialogs, uRotinas, uDMDados, ufrmSQL, Vcl.Imaging.pngimage;

type
  TfrmAcesso = class(TfrmBase)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnConfirmar: TJvXPButton;
    btnCancelar: TJvXPButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    class function Inicializa(var pUsuario: String; var pFilial: String): Boolean;
  end;

var
  frmAcesso: TfrmAcesso;

implementation

{$R *.dfm}

{ TfrmAcesso }

procedure TfrmAcesso.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmAcesso.btnConfirmarClick(Sender: TObject);
var
  wl_Sql: String;
begin
  inherited;
  ModalResult := mrNone;
  if (Trim(edtUsuario.Text) = '') or (Trim(edtSenha.Text) = '') then
  begin
    MostraAviso('Informe o Usuário e a Senha para efetuar o login.');
    Exit;
  end;
  wl_Sql:= 'Select * from USUARIO' +
           ' where LOGIN = '+QuotedStr(edtUsuario.Text)+
           '   and SENHA = '+QuotedStr(Encrypt(edtSenha.Text));
  with RetornaDadosCDS(wl_Sql) do
  begin
    try
      if IsEmpty then
      begin
        MostraErro('Usuário e/ou Senha inválidos.');
        Exit;
      end;
      VR_USU_LOGIN := FieldByName('Login').AsString;
      VR_USU_NOME  := FieldByName('NomUsuario').AsString;
      VR_USU_CODIGO:= FieldByName('CodUsuario').AsInteger;
      VR_USU_ADMIN := FieldByName('AdminUsuario').AsInteger = 1;
      DMDados.cdsConfig.Open;
      ModalResult:= mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmAcesso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_F5 then
  begin
    frmSQL:= TfrmSQL.Create(Self);
    try
      frmSQL.ShowModal;
    finally
      frmSQL.Free;
    end;
  end;
end;

procedure TfrmAcesso.FormShow(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  edtUsuario.SetFocus;
end;

class function TfrmAcesso.Inicializa(var pUsuario: String; var pFilial: String): Boolean;
begin
  with Self.Create(Application) do
  begin
    try
      Result:= False;
      if ShowModal = mrOk then
      begin
        //pUsuario := edtUsuario.Text;
        //pFilial  := 'G2 Prime';
        Result:= True;
      end;
    finally
      Free;
    end;
  end;
end;

end.
