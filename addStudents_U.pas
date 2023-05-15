unit addStudents_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.Math,
  Main_U, addGrades_U;

type
  TaddStudentsForm = class(TForm)
	FirstNameEdit: TEdit;
	LastNameEdit: TEdit;
	MiddleNameEdit: TEdit;
	AddGradesBtn: TButton;
	confirmBtn: TButton;
	GroupsCmb: TComboBox;
    CancelBtn: TButton;
	procedure CheckLetterPress(Sender: TObject; var Key: Char);
	procedure confirmBtnClick(Sender: TObject);
	procedure addGradesBtnClick(Sender: TObject);
	procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure EditChange(Sender: TObject);

    procedure clearStudentData(var student: TStudentData);
  private
	{ Private declarations }
  public
	newStudent: TStudentData;
  end;

var
  addStudentsForm: TaddStudentsForm;

implementation

{$R *.dfm}

procedure TaddStudentsForm.confirmBtnClick(Sender: TObject);
var
  i, count: byte;
  sum: word;
begin
  with newStudent do
  begin
	FirstName := Trim(FirstNameEdit.Text);
	LastName := Trim(LastNameEdit.Text);
	MiddleName := Trim(MiddleNameEdit.Text);
	Group := GroupsCmb.Items[GroupsCmb.ItemIndex];
  end;
    Count := newStudent.GradesCount;
	sum := 0;
	for i := 0 to newStudent.GradesCount - 1 do
	begin
        if newStudent.Grades[i].Grade = -1 then
        Dec(Count) else
	  sum := sum + newStudent.Grades[i].Grade;
	end;
    if Count = 0 then
	newStudent.AvgGrade := '-' else
	newStudent.AvgGrade := Copy(FloatToStr(sum / Count), 1, 4);

  App.addNewStudent(newStudent);
  Self.Close;
end;

procedure TaddStudentsForm.EditChange(Sender: TObject);
begin
confirmBtn.Enabled := (Length(Trim(FirstNameEdit.Text)) > 0) and (Length(Trim(LastNameEdit.Text)) > 0) and
(GroupsCmb.ItemIndex >= 0);
end;
procedure TaddStudentsForm.clearStudentData(var student: TStudentData);
var i: integer;
begin
   student.FirstName := '';
   student.LastName := '';
   student.MiddleName := '';
   for i := 0 to student.GradesCount - 1 do
   begin
        student.Grades[i].Subject := '';
        student.Grades[i].Grade := 0;
   end;
   student.GradesCount := 0;
   student.AvgGrade := '';

end;
procedure TaddStudentsForm.FormShow(Sender: TObject);
var
  node: PGroup;
begin
  GroupsCmb.Items.Clear;
  clearStudentData(newStudent);
  node := App.GroupHead;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	GroupsCmb.Items.Add(node.Data.Group);
  end;
  if GroupsCmb.Items.Count > 0 then
  GroupsCmb.ItemIndex := 0;
  if node = App.GroupHead then
  begin
	GroupsCmb.Items.Add('Нет добавленных групп');
	confirmBtn.Enabled := false;
  end;
  confirmBtn.Enabled := false;
  FirstNameEdit.Text := '';
  LastNameEdit.Text := '';
  MiddleNameEdit.Text := '';
end;

procedure TaddStudentsForm.addGradesBtnClick(Sender: TObject);
begin
  addGradesForm.ShowModal;
end;

procedure TaddStudentsForm.CancelBtnClick(Sender: TObject);
begin
self.Close;
end;

procedure TaddStudentsForm.CheckLetterPress(Sender: TObject; var Key: Char);
begin

  if Key in ['0' .. '9'] then // Проверяем, что введенный символ является цифрой
	Key := #0; // Отменяем обработку события KeyPress
end;

end.
