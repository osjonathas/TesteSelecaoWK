unit unfraPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.ComCtrls, Vcl.Mask;

type
  TfraPesquisa = class(TFrame)
    edtValor: TEdit;
    Shape1: TShape;
    btConf: TSpeedButton;
    btPesq: TSpeedButton;
    pnFiltros: TPanel;
    lbPeríodo1: TLabel;
    dtPeriodoIni: TDateTimePicker;
    dtPeriodoFim: TDateTimePicker;
    pn_PesqFiltro: TPanel;
    brPesqFiltro: TSpeedButton;
    edtValor1: TLabeledEdit;
    edtValor2: TLabeledEdit;
    edtValor3: TLabeledEdit;
    rgFiltro: TRadioGroup;
    procedure DesenharPesquisa;
    procedure btConfClick(Sender: TObject);
    procedure brPesqFiltroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FTamMax : integer;
  end;

implementation

{$R *.dfm}

//uses unFiltro;

procedure TfraPesquisa.brPesqFiltroClick(Sender: TObject);
begin
  DesenharPesquisa;
end;

procedure TfraPesquisa.btConfClick(Sender: TObject);
begin
  DesenharPesquisa;
end;

procedure TfraPesquisa.DesenharPesquisa;
begin
  if FTamMax = 0 then
    FTamMax := 267;

  if Self.height > 100 then
  begin
    Self.height := 31;
    edtValor.Enabled := True;
    btPesq.Enabled   := True;
  end
  else
  begin
    Self.height := FTamMax;
    edtValor.Enabled := False;
    btPesq.Enabled   := False;
    if edtValor1.Visible then
      edtValor1.SetFocus;

  end;
  self.Update;
end;

end.
