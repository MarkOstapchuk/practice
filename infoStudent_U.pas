unit infoStudent_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Main_U,
  infoGrades_U;

type
  TinfoStudentForm = class(TForm)
	LastNameLabel: TLabel;
	FirstNameLabel: TLabel;
	MiddleNameLabel: TLabel;
	DeleteBtn: TButton;
	EditBtn: TButton;
	SaveBtn: TButton;
	CancelBtn: TButton;
	FirstNameEdit: TEdit;
	LastNameEdit: TEdit;
	MiddleNameEdit: TEdit;
	GroupLabel: TLabel;
	GroupsCmb: TComboBox;
	GroupEdit: TEdit;
    addGradesBtn: TButton;
    saveBtn2: TButton;
	procedure FormShow(Sender: TObject);
	procedure ShowInfo;
	procedure EditBtnClick(Sender: TObject);
	procedure CancelBtnClick(Sender: TObject);
	procedure SaveBtnClick(Sender: TObject);
	procedure FirstNameEditChange(Sender: TObject);
	procedure CheckLetterPress(Sender: TObject; var Key: Char);
	procedure EditChange(Sender: TObject);
	procedure DeleteBtnClick(Sender: TObject);
    procedure addGradesBtnClick(Sender: TObject);
    procedure countAvg;
  private
	{ Private declarations }
  public
	chosenStudent: TStudentData;
  end;

var
  infoStudentForm: TinfoStudentForm;

implementation
{$R *.dfm}

procedure TinfoStudentForm.SaveBtnClick(Sender: TObject);
begin
  chosenStudent.LastName := Trim(LastNameEdit.Text);
  chosenStudent.FirstName := Trim(FirstNameEdit.Text);
  chosenStudent.MiddleName := Trim(MiddleNameEdit.Text);
  chosenStudent.Group := GroupsCmb.Items[GroupsCmb.ItemIndex];
  FirstNameEdit.Enabled := false;
  LastNameEdit.Enabled := false;
  MiddleNameEdit.Enabled := false;
  SaveBtn.Visible := false;
  CancelBtn.Visible := false;
  DeleteBtn.Visible := true;
  EditBtn.Visible := true;
  GroupsCmb.Visible := false;
  GroupEdit.Visible := true;
  SaveBtn2.Visible := true;
  App.changeStudentInfo(chosenStudent);
  self.Close;
end;

procedure TinfoStudentForm.ShowInfo;
begin
  FirstNameEdit.Text := chosenStudent.FirstName;
  LastNameEdit.Text := chosenStudent.LastName;
  MiddleNameEdit.Text := chosenStudent.MiddleName;
  GroupEdit.Text := chosenStudent.Group;
end;

procedure TinfoStudentForm.addGradesBtnClick(Sender: TObject);
begin
infoGradesForm.ShowModal;
end;

procedure TinfoStudentForm.CancelBtnClick(Sender: TObject);
begin
  FirstNameEdit.Enabled := false;
  LastNameEdit.Enabled := false;
  MiddleNameEdit.Enabled := false;
  SaveBtn.Visible := false;
  CancelBtn.Visible := false;
  DeleteBtn.Visible := true;
  EditBtn.Visible := true;
  GroupsCmb.Visible := false;
  GroupEdit.Visible := true;
  SaveBtn2.Visible := true;
end;

procedure TinfoStudentForm.EditBtnClick(Sender: TObject);
begin
  FirstNameEdit.Enabled := true;
  LastNameEdit.Enabled := true;
  MiddleNameEdit.Enabled := true;
  SaveBtn.Visible := true;
  CancelBtn.Visible := true;
  CancelBtn.Enabled := false;
  DeleteBtn.Visible := false;
  EditBtn.Visible := false;
  GroupsCmb.Visible := true;
  GroupEdit.Visible := false;
  SaveBtn2.Visible := false;
end;

procedure TinfoStudentForm.FirstNameEditChange(Sender: TObject);
begin
  SaveBtn.Enabled := Length(Trim(FirstNameEdit.Text)) > 0;
end;

procedure TinfoStudentForm.FormShow(Sender: TObject);
var
  i, index: Integer;
  node: PStudent;
  nodeGr: PGroup;
begin
FirstNameEdit.Enabled := false;
  LastNameEdit.Enabled := false;
  MiddleNameEdit.Enabled := false;
  SaveBtn.Visible := false;
  CancelBtn.Visible := false;
  DeleteBtn.Visible := true;
  EditBtn.Visible := true;
  GroupsCmb.Visible := false;
  GroupEdit.Visible := true;
  GroupsCmb.Items.Clear;
  SaveBtn2.Visible := true;
  Index := App.StudentsList.ItemIndex;
  if App.isFiltered then
  node := App.displayedHead else
  node := App.Head;
  for i := 0 to index do
	node := node.Next;
  chosenStudent := node.Data;
  nodeGr := App.GroupHead;
  if nodeGr.Next = nil then
  GroupsCmb.Items.Add('Добавьте сначала группу');
  while not(nodeGr.Next = nil) do
  begin
	nodeGr := nodeGr.Next;
	GroupsCmb.Items.Add(nodeGr.Data.Group);
  end;
  GroupsCmb.ItemIndex := 0;
  ShowInfo;
end;

procedure TinfoStudentForm.EditChange(Sender: TObject);
begin
  SaveBtn.Enabled := (Length(Trim(FirstNameEdit.Text)) > 0) and
	(Length(Trim(LastNameEdit.Text)) > 0) and (GroupsCmb.ItemIndex >= 0);
end;

procedure TinfoStudentForm.CheckLetterPress(Sender: TObject; var Key: Char);
begin

  if Key in ['0' .. '9'] then // Проверяем, что введенный символ является цифрой
	Key := #0; // Отменяем обработку события KeyPress
end;

procedure TinfoStudentForm.countAvg;
var
  i, count: byte;
  sum: word;
  avg: single;
begin
    Count := chosenStudent.GradesCount;
	sum := 0;
	for i := 0 to chosenStudent.GradesCount - 1 do
	begin
        if chosenStudent.Grades[i].Grade = -1 then
        Dec(Count) else
	  sum := sum + chosenStudent.Grades[i].Grade;
	end;
    if Count = 0 then
	chosenStudent.AvgGrade := '-' else
	chosenStudent.AvgGrade := Copy(FloatToStr(sum / Count), 1, 4);
    //App.changeStudentInfo(chosenStudent);
end;

procedure TinfoStudentForm.DeleteBtnClick(Sender: TObject);
var
  buttonSelected: Integer;
begin
  buttonSelected := MessageDlg('Вы действительно хотите удалить?',
	mtConfirmation, mbOKCancel, 0);
  if buttonSelected = mrOK then
  begin
	App.deleteStudent;
	self.Close;
  end;

end;

end.
