unit ufrmDlgMensagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, pngimage;


type
  TProgressThread = class(TThread)
  private
    { Private declarations }
    FProgressBar: TProgressBar;
    procedure update;
  public
    constructor CreateEx(p_ProgressBar: TProgressBar);
  protected
    procedure Execute; override;
  end;

  TfSC_FormMensagem = class(TForm)
    Timer: TTimer;
    pnCentro: TPanel;
    Image2: TImage;
    Label1: TLabel;
    pgbMsg: TProgressBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setText(p_Text: String);
    procedure setTamanhoBarra(pTamanho: Integer);
    procedure Incrementa(pTamanho: Integer);
    procedure setErro(pErro: String);
  end;

var
  fSC_FormMensagem: TfSC_FormMensagem;

implementation

//uses uDialogs;


{$R *.dfm}

{ TProgressThread }

constructor TProgressThread.CreateEx(p_ProgressBar: TProgressBar);
begin
  Create(True);
  Priority:= tpIdle;
  FreeOnTerminate:= True;
  FProgressBar := p_ProgressBar;

  FProgressBar.Max:= 1000;
  FProgressBar.Position:= 0;
end;

procedure TProgressThread.Execute;
begin
  while (not Self.Terminated) and
        (FProgressBar.Position < FProgressBar.Max) do
    begin
      Self.Synchronize(update);
      if FProgressBar.Position = FProgressBar.Max then
        FProgressBar.Position:= 0;
      Application.ProcessMessages;
    end;
end;

procedure TfSC_FormMensagem.FormDestroy(Sender: TObject);
begin
  //wp_Thread.Terminate;
  inherited;
end;

procedure TfSC_FormMensagem.FormCreate(Sender: TObject);
begin
  inherited;
  //wp_Thread:= TProgressThread.CreateEx(JvXPProgressBar);
end;

procedure TProgressThread.update;
begin
  while FProgressBar.Position < FProgressBar.Max do
    begin
      FProgressBar.Position:= FProgressBar.Position + 5;
      //if FProgressBar.Position = FProgressBar.Max then
      //  FProgressBar.Position:= 0;
      Application.ProcessMessages;
    end;
end;

procedure TfSC_FormMensagem.FormShow(Sender: TObject);
begin
  inherited;
  //if wp_Thread.Suspended then
  //  wp_Thread.Resume;
end;

procedure TfSC_FormMensagem.Incrementa(pTamanho: Integer);
begin
  pgbMsg.Position := pgbMsg.Position + pTamanho;
  Application.ProcessMessages;
end;

procedure TfSC_FormMensagem.setErro(pErro: String);
begin
  //pgbMsg.State := pbsError;
//  MostraErro(pErro);
end;

procedure TfSC_FormMensagem.setTamanhoBarra(pTamanho: Integer);
begin
{TODO -oJonathas -cBacbkup : Revisar mudança de componente treeview}
//  pgbMsg.Style := cxbsSolid;
//  pgbMsg.Marquee  := False;
  pgbMsg.Max  := pTamanho;
  pgbMsg.Position := 0;
end;

procedure TfSC_FormMensagem.setText(p_Text: String);
begin
  Self.Label1.Caption:= p_Text;
  Application.ProcessMessages;
end;

end.
