unit unRelatorioBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, RLReport;

type
  TfrmRelatorioBase = class(TForm)
    RLReport1: TRLReport;
    DataSource1: TDataSource;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioBase: TfrmRelatorioBase;

implementation

{$R *.dfm}

end.
