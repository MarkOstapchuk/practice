unit addGroup_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Main_U;

type
  TaddGroupForm = class(TForm)
	GroupEdit: TEdit;
	YearEdit: TEdit;
	CodeEdit: TMaskEdit;
	cancelBtn: TButton;
	confirmBtn: TButton;
	procedure confirmBtnClick(Sender: TObject);
	procedure cancelBtnClick(Sender: TObject);
	procedure FormShow(Sender: TObject);

  private
	{ Private declarations }
  public
	newGroup: TGroupData;
  end;

var
  addGroupForm: TaddGroupForm;

implementation

{$R *.dfm}

procedure TaddGroupForm.cancelBtnClick(Sender: TObject);
begin
  self.Close;
end;

procedure TaddGroupForm.confirmBtnClick(Sender: TObject);
var
  node: PGroup;
  flag: boolean;
begin
  flag := false;
  node := App.GroupHead;
  while (not(node.Next = nil)) and (flag = false) do
  begin
	node := node.Next;
	if node.Data.Group = GroupEdit.Text then
	  flag := true;
  end;

  with newGroup do
  begin
	Group := GroupEdit.Text;
	Year := StrToInt(YearEdit.Text);
	Code := CodeEdit.Text;
  end;
  if flag then
	ShowMessage('Данная группа уже существует.')
  else
  begin
	App.addNewGroup(newGroup);
	self.Close;
  end;
end;

procedure TaddGroupForm.FormShow(Sender: TObject);
begin
  GroupEdit.Text := '';
  CodeEdit.Text := '';
  YearEdit.Text := '';
end;

end.
