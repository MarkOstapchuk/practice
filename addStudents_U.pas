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
  i: byte;
  sum: word;
  avg: single;
begin
  with newStudent do
  begin
	FirstName := FirstNameEdit.Text;
	LastName := LastNameEdit.Text;
	MiddleName := MiddleNameEdit.Text;
	Group := GroupsCmb.Items[GroupsCmb.ItemIndex];
  end;
  if newStudent.GradesCount = 0 then
	newStudent.AvgGrade := '-'
  else
  begin
	sum := 0;
	for i := 0 to newStudent.GradesCount - 1 do
	begin
	  sum := sum + newStudent.Grades[i].Grade;
	end;
	newStudent.AvgGrade := Copy(FloatToStr(sum / newStudent.GradesCount), 1, 4);
  end;
  App.addNewStudent(newStudent);
  Self.Close;
end;

procedure TaddStudentsForm.FormShow(Sender: TObject);
var
  node: PGroup;
begin
  node := App.GroupHead;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	GroupsCmb.Items.Add(node.Data.Group);
  end;
  if node = App.GroupHead then
  begin
	GroupsCmb.Items.Add('Нет добавленных групп');
	confirmBtn.Enabled := false;
  end;
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
