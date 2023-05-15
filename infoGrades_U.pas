unit infoGrades_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.NumberBox, Main_U;
const
  path = 'Subjects.txt';

type
  TSubjects = array of string;

  TinfoGradesForm = class(TForm)
	SubjectsCmb: TComboBox;
	gradeEdit: TNumberBox;
	GradesList: TListView;
	confirmBtn: TButton;
	addSubjectEdit: TEdit;
	saveBtn: TButton;
    retakeCB: TCheckBox;
    removeGradeBtn: TButton;
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
    procedure retakeCBClick(Sender: TObject);
    procedure GradesListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure removeGradeBtnClick(Sender: TObject);
  private
	{ Private declarations }
  public
	SubjectsCount: Byte;
	Subjects: TSubjects;
	Grades: TGrades;
	GradesCount: Byte;
  end;

var
  InfoGradesForm: TInfoGradesForm;

implementation
uses infoStudent_U;
{$R *.dfm}

function TInfoGradesForm.isSubjectUsed(subject: string): boolean;
var
  I: Integer;
begin
  result := false;
  I := 0;
  while (I < GradesCount) and (not result) do
  begin
	if AnsiLowerCase(Trim(subject)) = AnsiLowerCase(Trim(Grades[I].subject)) then
	  result := true;
	Inc(I);
  end;

end;

function TInfoGradesForm.isSubjectExist(subject: string): boolean;
var
  I: Integer;
begin
  result := false;
  I := 0;
  while (I < SubjectsCount) and (not result) do
  begin
	if AnsiLowerCase(Trim(subject)) = AnsiLowerCase(Trim(Subjects[I])) then
	  result := true;
	Inc(I);
  end;

end;

procedure TInfoGradesForm.loadSubjects(var Subjects: TSubjects; path: string);
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

procedure TinfoGradesForm.removeGradeBtnClick(Sender: TObject);
var i: integer;
begin
	SubjectsCmb.Items.Add(Grades[GradesList.ItemIndex].Subject) ;

    if GradesCount - 1 = GradesList.ItemIndex then
    begin
    Grades[GradesCount - 1].Subject := '';
    Grades[GradesCount - 1].Grade := 0;
    end else
    for i :=GradesList.ItemIndex to GradesCount - 1 do
    Grades[i] := Grades[i+1];
    GradesList.Items.Delete(GradesList.ItemIndex);
    Dec(GradesCount);

end;

procedure TInfoGradesForm.retakeCBClick(Sender: TObject);
begin
gradeEdit.Enabled := not retakeCB.Checked;
end;

procedure TInfoGradesForm.saveBtnClick(Sender: TObject);
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
  SetLength(infoGradesForm.Subjects, infoGradesForm.SubjectsCount + 1);
  infoGradesForm.Subjects[infoGradesForm.SubjectsCount] := subject;
  Inc(infoGradesForm.SubjectsCount);
  for I := 0 to infoGradesForm.SubjectsCount - 1 do
  begin
	Writeln(F, infoGradesForm.Subjects[I]);
  end;
  closeFile(F);
end;

procedure TInfoGradesForm.addSubjectEditChange(Sender: TObject);
begin
  confirmBtn.Enabled := Length(Trim(addSubjectEdit.Text)) > 0;

end;

procedure TInfoGradesForm.confirmBtnClick(Sender: TObject);
var
  Item: TListItem;
  newGrade: TGrade;
begin
	if (SubjectsCmb.ItemIndex = 0) and (isSubjectExist(addSubjectEdit.Text)) then
	  ShowMessage('Данная дисциплина уже добавлена.')
	else if (not retakeCB.Checked) and ((StrToInt(gradeEdit.Text) > 10) or (StrToInt(gradeEdit.Text) < 0))
	then
	  ShowMessage('Отметка должна быть в пределах от 0 до 10.')
	else
	begin
      if retakeCB.Checked then newGrade.Grade := -1 else
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
      if newGrade.Grade < 0 then
       Item.SubItems.Add('Не сдано') else
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

procedure TInfoGradesForm.ShowGrades(Grades: TGrades);
var
  I: Integer;
  Item: TListItem;
begin
  for I := 0 to GradesCount - 1 do
  begin
	Item := GradesList.Items.Add;
	Item.Caption := Grades[I].subject;
    if Grades[i].Grade < 0 then
    	Item.SubItems.Add('Не сдано') else
	Item.SubItems.Add(IntToStr(Grades[I].Grade));
  end;
end;

procedure TInfoGradesForm.SubjectsCmbChange(Sender: TObject);
begin
  addSubjectEdit.Visible := SubjectsCmb.ItemIndex = 0;
  confirmBtn.Enabled := not(SubjectsCmb.ItemIndex = 0);
end;

procedure TInfoGradesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  infoStudentForm.chosenStudent.Grades := Grades;
  infoStudentForm.chosenStudent.GradesCount := GradesCount;
  infoStudentForm.countAvg;
end;

procedure TInfoGradesForm.FormShow(Sender: TObject);
begin
  GradesList.Items.Clear;
  gradeEdit.Text := '';
  removeGradeBtn.Enabled := false;
  Grades := infoStudentForm.chosenStudent.Grades;
  GradesCount := infoStudentForm.chosenStudent.GradesCount;

  loadSubjects(Subjects, path);
  ShowGrades(Grades);
end;

procedure TinfoGradesForm.GradesListChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  removeGradeBtn.Enabled := GradesList.itemIndex >= 0;
end;

end.
