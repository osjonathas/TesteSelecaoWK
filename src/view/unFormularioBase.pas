unit unFormularioBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Imaging.jpeg;

type
  TfrmFormularioBase = class(TForm)
    pnTitulo: TPanel;
    btnRest: TSpeedButton;
    pnCentral: TPanel;
    pnInterno: TPanel;
    lbTitulo: TLabel;
    btnClose: TSpeedButton;
    lbSubTituloForm: TLabel;
    procedure btnRestClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }




  public
    { Public declarations }
  end;

var
  frmFormularioBase: TfrmFormularioBase;

implementation

{$R *.dfm}

procedure TfrmFormularioBase.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmFormularioBase.btnRestClick(Sender: TObject);
begin
  if Self.WindowState = TWindowState.wsMaximized then
    Self.WindowState := TWindowState.wsNormal
  else
    Self.WindowState := TWindowState.wsMaximized;
end;
end.
