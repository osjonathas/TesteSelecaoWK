unit UnitPergunta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Vcl.Imaging.pngimage, Vcl.ImgList, System.ImageList, KrUtil;

type
  TfrmPergunta = class(TForm)
    pnCentro: TPanel;
    pnImg: TPanel;
    imgPergunta: TImage;
    pnMensagem: TPanel;
    LbMensagem: TLabel;
    pn_Cancela: TPanel;
    btCancela: TSpeedButton;
    pn_Confirma: TPanel;
    btConfirma: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConfirmaClick(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FTipoMensagem : TipoMensagem;
    FOpcaoPergunta: String;
    class function Pergunta(aTexto : String; aTipoMensagem: TipoMensagem): boolean;
  end;

var
  frmPergunta: TfrmPergunta;


implementation

{$R *.dfm}




procedure TfrmPergunta.btCancelaClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPergunta.btConfirmaClick(Sender: TObject);
begin
  FOpcaoPergunta := '1';
  ModalResult := mrOk;
end;

procedure TfrmPergunta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPergunta.FormShow(Sender: TObject);
begin
  imgPergunta.Top := 54;
  imgPergunta.Left := 50;
  lbMensagem.Top := 15;
end;

class function TfrmPergunta.Pergunta(aTexto: String; aTipoMensagem: TipoMensagem): boolean;
begin
  Application.CreateForm(TFrmPergunta, frmPergunta);
  frmPergunta.LbMensagem.Caption := aTexto;
  frmPergunta.FTipoMensagem      := aTipoMensagem;
  frmPergunta.ShowModal;

  if Trim(frmPergunta.FOpcaoPergunta) = '1' then
  begin
    Result := True;
  end
  else Result := False;
  frmPergunta.Free;
end;

end.
