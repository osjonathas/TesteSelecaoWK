unit uframeCadUsuario;

interface

uses
  Data.DB,
  unfraPesquisa,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.WinXCtrls,
  Vcl.Mask,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Controls,
  System.Classes,
  System.SysUtils,
  uframeCadastroBase;

type
  TframeCadUsuario = class(TframeCadastroBase)
    edtCodigo: TMaskEdit;
    edtNome: TSearchBox;
    FDConsultacodigo: TFDAutoIncField;
    FDConsultalogin: TStringField;
    FDConsultasenha: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure ColocarEmEstadoInclusao; override;
    procedure ColocarEmEstadoEdicao; override;
    procedure CancelarEdicao; override;
    procedure Excluir; override;
    procedure Persistir; override;
    procedure ExecutarPesquisa; override;
    procedure CarregarRegistroPesquisa(AValor: String); override;
  end;

var
  frameCadUsuario: TframeCadUsuario;

implementation

{$R *.dfm}

uses model.connection, model.usuario;

procedure TframeCadUsuario.CancelarEdicao;
begin
  inherited;

end;

procedure TframeCadUsuario.CarregarRegistroPesquisa(AValor: String);
begin
  inherited;

end;

procedure TframeCadUsuario.ColocarEmEstadoEdicao;
begin
  inherited;

end;

procedure TframeCadUsuario.ColocarEmEstadoInclusao;
begin
  inherited;

end;

procedure TframeCadUsuario.Excluir;
begin
  inherited;

end;

procedure TframeCadUsuario.ExecutarPesquisa;
begin
  TUsuario
   .New
   .Login(trim(fraPesquisa.edtvalor.Text))
    .Open(dsConsulta);
  inherited;
end;

procedure TframeCadUsuario.Persistir;
begin
  inherited;

end;

end.