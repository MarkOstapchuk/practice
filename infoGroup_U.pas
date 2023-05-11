unit infoGroup_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Main_U;

type
  TinfoGroupForm = class(TForm)
	GroupLabel: TLabel;
	YearLabel: TLabel;
	codeLabel: TLabel;
	studentsCountLabel: TLabel;
	GroupEdit: TEdit;
	YearEdit: TEdit;
	StudentsCount: TLabel;
	CodeEdit: TMaskEdit;
	DeleteBtn: TButton;
	EditBtn: TButton;
	SaveBtn: TButton;
	CancelBtn: TButton;
	procedure FormShow(Sender: TObject);
	procedure showInfo;
	procedure EditBtnClick(Sender: TObject);
	procedure CancelBtnClick(Sender: TObject);
	procedure SaveBtnClick(Sender: TObject);
	procedure DeleteBtnClick(Sender: TObject);
  private
	{ Private declarations }
  public
	chosenGroup: TGroupData;
  end;

var
  infoGroupForm: TinfoGroupForm;

implementation

{$R *.dfm}

procedure TinfoGroupForm.showInfo;
begin
  GroupEdit.Text := chosenGroup.Group;
  YearEdit.Text := IntToStr(chosenGroup.Year);
  CodeEdit.Text := chosenGroup.Code;
  StudentsCount.Caption := IntToStr(chosenGroup.StudentsCount);
  GroupEdit.Enabled := false;
  YearEdit.Enabled := false;
  CodeEdit.Enabled := false;
  SaveBtn.Visible := false;
  CancelBtn.Visible := false;
  DeleteBtn.Visible := true;
  EditBtn.Visible := true;
end;

procedure TinfoGroupForm.CancelBtnClick(Sender: TObject);
begin
  GroupEdit.Enabled := false;
  YearEdit.Enabled := false;
  CodeEdit.Enabled := false;
  SaveBtn.Visible := false;
  CancelBtn.Visible := false;
  DeleteBtn.Visible := true;
  EditBtn.Visible := true;
end;

procedure TinfoGroupForm.DeleteBtnClick(Sender: TObject);
var
  buttonSelected: Integer;
begin
  buttonSelected := MessageDlg('Вы действительно хотите удалить?', mtConfirmation,
	mbOKCancel, 0);
  if buttonSelected = mrOK then
  begin
	App.DeleteGroup;
	self.Close;
  end;

end;

procedure TinfoGroupForm.EditBtnClick(Sender: TObject);
begin
  GroupEdit.Enabled := true;
  YearEdit.Enabled := true;
  CodeEdit.Enabled := true;
  SaveBtn.Visible := true;
  CancelBtn.Visible := true;
  DeleteBtn.Visible := false;
  EditBtn.Visible := false;
end;

procedure TinfoGroupForm.FormShow(Sender: TObject);
var
  i, index: Integer;
  node: PGroup;
begin
  index := App.GroupsCmb.ItemIndex;
  node := App.GroupHead;
  for i := 0 to index do
	node := node.Next;
  chosenGroup := node.Data;
  showInfo;
end;

procedure TinfoGroupForm.SaveBtnClick(Sender: TObject);
begin
  with chosenGroup do
  begin
	Group := GroupEdit.Text;
	Year := StrToInt(YearEdit.Text);
	Code := CodeEdit.Text;
  end;
  App.ChangeGroupInfo(chosenGroup);
  self.Close;
end;

end.
