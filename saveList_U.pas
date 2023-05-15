unit saveList_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Main_U;


type


  TSaveListForm = class(TForm)
	RadioGroup: TRadioGroup;
	SaveBtn: TButton;
	procedure RadioGroupClick(Sender: TObject);
	procedure SaveBtnClick(Sender: TObject);
	procedure FormShow(Sender: TObject);
  private

  public
	{ Public declarations }
  end;

var
  SaveListForm: TSaveListForm;

implementation

{$R *.dfm}

procedure TSaveListForm.FormShow(Sender: TObject);
begin
  RadioGroup.ItemIndex := 0;
end;

procedure TSaveListForm.RadioGroupClick(Sender: TObject);
begin
  SaveBtn.Enabled := true;
end;

procedure TSaveListForm.SaveBtnClick(Sender: TObject);
begin
  case RadioGroup.ItemIndex of
	0:
	  if (App.expulsionHead = nil) or (App.expulsionHead.Next = nil) then
	  begin
		ShowMessage('Список студентов на отчисление пуст.');
		Exit
	  end;
	1:
	  if (App.DebtorsHead = nil) or (App.DebtorsHead.Next = nil) then
	  begin
		ShowMessage('Список студентов-задлжников пуст.');
		Exit
	  end;
  end;
  App.saveList(RadioGroup.ItemIndex);
  self.CLose;
end;

end.
