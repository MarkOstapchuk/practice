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
	GroupEdit: TEdit;
	AddGradesBtn: TButton;
	confirmBtn: TButton;
	procedure FirstNameEditEnter(Sender: TObject);
	procedure FirstNameEditExit(Sender: TObject);
	procedure LastNameEditExit(Sender: TObject);
	procedure LastNameEditEnter(Sender: TObject);
	procedure MiddleNameEditExit(Sender: TObject);
	procedure MiddleNameEditEnter(Sender: TObject);
	procedure FormShow(Sender: TObject);
	procedure GroupEditEnter(Sender: TObject);
	procedure GroupEditExit(Sender: TObject);
	procedure CheckLetterPress(Sender: TObject; var Key: Char);
	procedure confirmBtnClick(Sender: TObject);
	procedure addGradesBtnClick(Sender: TObject);
  private
	{ Private declarations }
  public
	newStudent: TStudentData;
  end;

var
  addStudentsForm: TaddStudentsForm;

implementation

{$R *.dfm}

procedure TaddStudentsForm.FormShow(Sender: TObject);
begin
  FirstNameEdit.Text := 'Имя';
  FirstNameEdit.Font.Style := FirstNameEdit.Font.Style + [fsItalic];
  FirstNameEdit.Font.Color := clGrayText;
  LastNameEdit.Text := '';
  LastNameEdit.Font.Style := LastNameEdit.Font.Style - [fsItalic];
  LastNameEdit.Font.Color := clWindowText;
  LastNameEdit.SetFocus;
  MiddleNameEdit.Text := 'Отчество';
  MiddleNameEdit.Font.Style := MiddleNameEdit.Font.Style + [fsItalic];
  MiddleNameEdit.Font.Color := clGrayText;
  GroupEdit.Text := 'Группа';
  GroupEdit.Font.Style := GroupEdit.Font.Style + [fsItalic];
  GroupEdit.Font.Color := clGrayText;
end;

procedure TaddStudentsForm.GroupEditEnter(Sender: TObject);
begin
  if GroupEdit.Text = 'Группа' then
  begin
	GroupEdit.Text := '';
	GroupEdit.Font.Style := GroupEdit.Font.Style - [fsItalic];
	GroupEdit.Font.Color := clWindowText;
  end;
end;

procedure TaddStudentsForm.GroupEditExit(Sender: TObject);
begin
  if GroupEdit.Text = '' then
  begin
	GroupEdit.Text := 'Группа';
	GroupEdit.Font.Style := GroupEdit.Font.Style + [fsItalic];
	GroupEdit.Font.Color := clGrayText;
  end;
end;

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
	Group := GroupEdit.Text;
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

procedure TaddStudentsForm.FirstNameEditEnter(Sender: TObject);
begin
  if FirstNameEdit.Text = 'Имя' then
  begin
	FirstNameEdit.Text := '';
	FirstNameEdit.Font.Style := FirstNameEdit.Font.Style - [fsItalic];
	FirstNameEdit.Font.Color := clWindowText;
  end;
end;

procedure TaddStudentsForm.FirstNameEditExit(Sender: TObject);
begin
  if FirstNameEdit.Text = '' then
  begin
	FirstNameEdit.Text := 'Имя';
	FirstNameEdit.Font.Style := FirstNameEdit.Font.Style + [fsItalic];
	FirstNameEdit.Font.Color := clGrayText;
  end;
end;

procedure TaddStudentsForm.addGradesBtnClick(Sender: TObject);
begin
  addGradesForm.ShowModal;
end;

procedure TaddStudentsForm.CheckLetterPress(Sender: TObject; var Key: Char);
begin

  if Key in ['0' .. '9'] then // Проверяем, что введенный символ является цифрой
	Key := #0; // Отменяем обработку события KeyPress
end;

procedure TaddStudentsForm.LastNameEditEnter(Sender: TObject);
begin
  if LastNameEdit.Text = 'Фамилия' then
  begin
	LastNameEdit.Text := '';
	LastNameEdit.Font.Style := LastNameEdit.Font.Style - [fsItalic];
	LastNameEdit.Font.Color := clWindowText;
  end;
end;

procedure TaddStudentsForm.LastNameEditExit(Sender: TObject);
begin
  if LastNameEdit.Text = '' then
  begin
	LastNameEdit.Text := 'Фамилия';
	LastNameEdit.Font.Style := LastNameEdit.Font.Style + [fsItalic];
	LastNameEdit.Font.Color := clGrayText;
  end;
end;

procedure TaddStudentsForm.MiddleNameEditEnter(Sender: TObject);
begin
  if MiddleNameEdit.Text = 'Отчество' then
  begin
	MiddleNameEdit.Text := '';
	MiddleNameEdit.Font.Style := MiddleNameEdit.Font.Style - [fsItalic];
	MiddleNameEdit.Font.Color := clWindowText;
  end;
end;

procedure TaddStudentsForm.MiddleNameEditExit(Sender: TObject);
begin
  if MiddleNameEdit.Text = '' then
  begin
	MiddleNameEdit.Text := 'Отчество';
	MiddleNameEdit.Font.Style := MiddleNameEdit.Font.Style + [fsItalic];
	MiddleNameEdit.Font.Color := clGrayText;
  end;
end;

end.
