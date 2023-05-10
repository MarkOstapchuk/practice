unit Main_U;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;
const studentsPath = 'assets\students.dat';
type
    TGrade = record
        Subject: string;
        Grade: Byte;
    end;
    TGrades = array [0 .. 9] of TGrade;

    TStudentData = record
        id: Word;
        FirstName: string[30];
        LastName: string[30];
        MiddleName: string[30];
        Group: string[6];
        Grades: TGrades;
        GradesCount: byte;
        AvgGrade: string[4];
    end;

    PStudent = ^TStudent;

    TStudent = record
        Data: TStudentData;
        Next: PStudent;
    end;

    TGroupData = record
        Group: string;
        Year: Integer;
        Code: string;
        StudentsCount: Byte;
    end;

    PGroup = ^TGroup;

    TGroup = record
        Data: TGroupData;
        Next: PGroup;
    end;

    TApp = class(TForm)
        StudentsList: TListView;
        addStudentBtn: TButton;
    GroupsCmb: TComboBox;
    addNewGroupBtn: TButton;
    editStudentBtn: TButton;
    deleteStudentBtn: TButton;
    searchStudentEdit: TEdit;
    SearchStudentBtn: TButton;
    GroupInfoBtn: TButton;
    showStudentsGroupBtn: TButton;
        procedure FormCreate(Sender: TObject);
        procedure addStudentBtnClick(Sender: TObject);
        procedure saveStudents(path: string);
        procedure addNewStudent(Data: TStudentData);
        procedure ShowNewStudent(Data: TStudentData);
    private
        { Private declarations }
    public
        Head: PStudent;
        StudentsCount: Integer;
    end;

var
    App: TApp;

implementation

uses addStudents_U;
{$R *.dfm}

procedure TApp.addNewStudent(Data: TStudentData);
var
    node: PStudent;
begin
    node := Head;
    while not(node.Next = nil) do
        node := node.Next;

    new(node.Next);
    node := node.Next;
    node.Data := Data;
    Data.id := StudentsCount;
    node.Next := nil;
    ShowNewStudent(Data);
    Inc(StudentsCount);
end;

procedure TApp.ShowNewStudent(Data: TStudentData);
var
    Item: TListItem;
begin
    Item := StudentsList.Items.Add;
    Item.Caption := IntToStr(StudentsCount + 1);
    Item.SubItems.Add(Data.LastName + ' ' + Data.FirstName + ' ' +
      Data.MiddleName);
    Item.SubItems.Add(Data.Group);
    Item.SubItems.Add(Data.AvgGrade);
end;

procedure TApp.addStudentBtnClick(Sender: TObject);
begin
    AddStudentsForm.ShowModal;
end;

procedure TApp.FormCreate(Sender: TObject);
begin
    StudentsCount := 0;
end;
procedure TApp.SaveStudents(path: string);
begin
   App.Caption := 'App';
end;
end.
