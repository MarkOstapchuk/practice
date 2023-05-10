unit addGrades_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.NumberBox,
  Vcl.ComCtrls, Main_U;

const
  path = '..\..\assets\Subjects.txt';

type
  TSubjects = array of string;

  TaddGradesForm = class(TForm)
	SubjectsCmb: TComboBox;
	gradeEdit: TNumberBox;
	GradesList: TListView;
	confirmBtn: TButton;
	addSubjectEdit: TEdit;
	saveBtn: TButton;
	procedure FormShow(Sender: TObject);

	procedure loadSubjects(var Subjects: TSubjects; path: string);
	procedure confirmBtnClick(Sender: TObject);
	procedure ShowGrades(Grades: TGrades);
	procedure FormClose(Sender: TObject; var Action: TCloseAction);
	procedure SubjectsCmbChange(Sender: TObject);
	function isSubjectUsed(subject: string): boolean;
	function isSubjectExist(subject: string): boolean;
	procedure saveBtnClick(Sender: TObject);
	procedure addSubjectEditChange(Sender: TObject);
  private
	{ Private declarations }
  public
	SubjectsCount: Byte;
	Subjects: TSubjects;
	Grades: TGrades;
	GradesCount: Byte;
  end;

var
  addGradesForm: TaddGradesForm;

implementation

uses addStudents_U;
{$R *.dfm}

function TaddGradesForm.isSubjectUsed(subject: string): boolean;
var
  I: Integer;
begin
  result := false;
  I := 0;
  while (I < GradesCount) and (not result) do
  begin
	if LowerCase(subject) = LowerCase(Grades[I].subject) then
	  result := true;
	Inc(I);
  end;

end;

function TaddGradesForm.isSubjectExist(subject: string): boolean;
var
  I: Integer;
begin
  result := false;
  I := 0;
  while (I < SubjectsCount) and (not result) do
  begin
	if LowerCase(subject) = LowerCase(Subjects[I]) then
	  result := true;
	Inc(I);
  end;

end;

procedure TaddGradesForm.loadSubjects(var Subjects: TSubjects; path: string);
var
  I: Integer;
  F: textFile;
  s: string;
begin
  SubjectsCount := 0;
  AssignFile(F, path, CP_UTF8);
  reset(F);
  while not Eof(F) do
  begin
	SetLength(Subjects, SubjectsCount + 1);
	Readln(F, s);
	Subjects[SubjectsCount] := s;
	Inc(SubjectsCount);
  end;
  closeFile(F);
  SubjectsCmb.Items.Clear;
  SubjectsCmb.Items.Add('Добавить...');
  SubjectsCmb.ItemIndex := 0;
  for I := 0 to SubjectsCount - 1 do
  begin
	if not isSubjectUsed(Subjects[I]) then
	  SubjectsCmb.Items.Add(Subjects[I]);
  end;
end;

procedure TaddGradesForm.saveBtnClick(Sender: TObject);
begin
  self.Close;
end;

procedure addSubjectToFile(subject: string);
var
  F: textFile;
  I: Integer;
begin
  AssignFile(F, path, CP_UTF8);
  Rewrite(F);
  SetLength(addGradesForm.Subjects, addGradesForm.SubjectsCount + 1);
  addGradesForm.Subjects[addGradesForm.SubjectsCount] := subject;
  Inc(addGradesForm.SubjectsCount);
  for I := 0 to addGradesForm.SubjectsCount - 1 do
  begin
	Writeln(F, addGradesForm.Subjects[I]);
  end;
  closeFile(F);
end;

procedure TaddGradesForm.addSubjectEditChange(Sender: TObject);
begin
  confirmBtn.Enabled := Length(Trim(addSubjectEdit.Text)) > 0;

end;

procedure TaddGradesForm.confirmBtnClick(Sender: TObject);
var
  Item: TListItem;
  newGrade: TGrade;
begin
  if SubjectsCmb.ItemIndex = 0 then
	if isSubjectExist(addSubjectEdit.Text) then
	  ShowMessage('Данная дисциплина уже добавлена.')
	else if (StrToInt(gradeEdit.Text) > 10) or (StrToInt(gradeEdit.Text) < 0)
	then
	  ShowMessage('Отметка должна быть в пределах от 0 до 10.')
	else
	begin
	  newGrade.Grade := StrToInt(gradeEdit.Text);
	  if SubjectsCmb.ItemIndex = 0 then
	  begin
		newGrade.subject := addSubjectEdit.Text;
		addSubjectToFile(addSubjectEdit.Text);
	  end
	  else
		newGrade.subject := SubjectsCmb.Items[SubjectsCmb.ItemIndex];
	  Item := GradesList.Items.Add;
	  Item.Caption := newGrade.subject;
	  Item.SubItems.Add(IntToStr(newGrade.Grade));
	  if not(SubjectsCmb.ItemIndex = 0) then
	  begin
		SubjectsCmb.Items.Delete(SubjectsCmb.ItemIndex);
		SubjectsCmb.ItemIndex := SubjectsCmb.ItemIndex - 1;
	  end;
	  Grades[GradesCount] := newGrade;
	  Inc(GradesCount);
	end;
end;

procedure TaddGradesForm.ShowGrades(Grades: TGrades);
var
  I: Integer;
  Item: TListItem;
begin
  for I := 0 to GradesCount - 1 do
  begin
	Item := GradesList.Items.Add;
	Item.Caption := Grades[I].subject;
	Item.SubItems.Add(IntToStr(Grades[I].Grade));
  end;
end;

procedure TaddGradesForm.SubjectsCmbChange(Sender: TObject);
begin
  addSubjectEdit.Visible := SubjectsCmb.ItemIndex = 0;
  confirmBtn.Enabled := not(SubjectsCmb.ItemIndex = 0);
end;

procedure TaddGradesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  addStudentsForm.newStudent.Grades := Grades;
  addStudentsForm.newStudent.GradesCount := GradesCount;
end;

procedure TaddGradesForm.FormShow(Sender: TObject);
begin
  GradesList.Items.Clear;
  loadSubjects(Subjects, path);
  Grades := addStudentsForm.newStudent.Grades;
  GradesCount := addStudentsForm.newStudent.GradesCount;
  ShowGrades(Grades);
end;

end.
