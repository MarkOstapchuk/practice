unit chooseSubject_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

const
  path = '..\..\assets\Subjects.txt';

type
  TSubjects = array of string;
  TchooseSubjectForm = class(TForm)
    SubjectsCmb: TComboBox;
    Label1: TLabel;
    confirmBtn: TButton;
    procedure FormShow(Sender: TObject);
    procedure confirmBtnClick(Sender: TObject);
  private
    SubjectsCount: smallInt;
	subjects: TSubjects;
  public
    { Public declarations }
  end;

var
  chooseSubjectForm: TchooseSubjectForm;

implementation
uses Main_U;
{$R *.dfm}

procedure TchooseSubjectForm.confirmBtnClick(Sender: TObject);
begin
App.makeDebtorsList(SubjectsCmb.Items[SubjectsCmb.ItemIndex]);
self.Close;
end;

procedure TchooseSubjectForm.FormShow(Sender: TObject);
var
  F: textFile;
  s: string;
  i: integer;
begin
  SubjectsCount := 0;
  SubjectsCmb.Items.Clear;
  AssignFile(F, path, CP_UTF8);
  reset(F);
  while not Eof(F) do
  begin
	SetLength(subjects, SubjectsCount + 1);
	Readln(F, s);
	subjects[SubjectsCount] := s;
    SubjectsCmb.Items.Add(s);
	Inc(SubjectsCount);
  end;
  closeFile(F);
end;

end.

