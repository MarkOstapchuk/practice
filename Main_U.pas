unit Main_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,CommCtrl,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls;

const
  studentsPath = '..\..\assets\students.txt';

const
  groupsPath = '..\..\assets\groups.txt';

type

  TGrade = record
	Subject: ShortString;
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
	GradesCount: Byte;
	AvgGrade: string[4];
  end;

  PStudent = ^TStudent;

  TStudent = record
	Data: TStudentData;
	Next: PStudent;
  end;

  TGroupData = record
	Group: string[6];
	Year: Integer;
	Code: string[10];
	StudentsCount: Byte;
  end;

  PGroup = ^TGroup;

  TGroup = record
	Data: TGroupData;
	Next: PGroup;
  end;

  TComporator = function(a, b: TStudentData): boolean;

  TApp = class(TForm)
	StudentsList: TListView;
	addStudentBtn: TButton;
	GroupsCmb: TComboBox;
	addNewGroupBtn: TButton;
	studentInfoBtn: TButton;
	SearchStudentBtn: TButton;
	GroupInfoBtn: TButton;
	showStudentsGroupBtn: TButton;
	FirstNameEdit: TEdit;
	LastNameEdit: TEdit;
	MiddleNameEdit: TEdit;
    showAllStudentsBtn: TButton;
	procedure FormCreate(Sender: TObject);

	procedure addStudentBtnClick(Sender: TObject);

	procedure addNewStudent(Data: TStudentData);
	procedure ShowNewStudent(Data: TStudentData);
	procedure changeStudentInfo(Data: TStudentData);
	procedure deleteStudent;
	procedure saveStudentsToFile(path: string);
	procedure loadStudents(path: string);
	procedure ShowStudents(Head: PStudent);


	procedure addNewGroupBtnClick(Sender: TObject);

	procedure addNewGroup(GroupData: TGroupData);
	procedure ShowNewGroup(Group: ShortString);
	procedure ChangeGroupInfo(Data: TGroupData);
	procedure DeleteGroup;
	procedure saveGroupsToFile(path: string);
    procedure changeGroupCount(group: shortString; delta: integer);
	procedure loadGroups(path: string);
	procedure showGroups;

	procedure sort(comparator: TComporator);
    procedure filterGroup(group: shortString);

	procedure GroupInfoBtnClick(Sender: TObject);
	procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
	procedure GroupsCmbChange(Sender: TObject);
	procedure studentInfoBtnClick(Sender: TObject);
	procedure StudentsListChange(Sender: TObject; Item: TListItem;
	  Change: TItemChange);
	procedure SearchStudentBtnClick(Sender: TObject);
	procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure StudentsListColumnClick(Sender: TObject; Column: TListColumn);
    procedure showStudentsGroupBtnClick(Sender: TObject);
    procedure showAllStudentsBtnClick(Sender: TObject);

  private
	{ Private declarations }
  public
	wasSaved: boolean;
	Head: PStudent;
	GroupHead: PGroup;
    displayedHead: PStudent;
    isFiltered: boolean;
  end;

var
  App: TApp;

implementation

uses addStudents_U, addGroup_U, infoGroup_U, infoStudent_U;
{$R *.dfm}

procedure TApp.showAllStudentsBtnClick(Sender: TObject);
begin
 isFiltered := false;
 showStudents(Head);
end;

procedure TApp.showGroups;
var
  node: PGroup;
begin
  GroupsCmb.Items.Clear;
  node := GroupHead;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	GroupsCmb.Items.Add(node.Data.Group);
  end;

end;

procedure TApp.ShowStudents(Head: PStudent);
var
  node: PStudent;
  i: Integer;
  Item: TListItem;
begin
  StudentsList.Items.Clear;
  node := Head;
  i := 1;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	Item := StudentsList.Items.Add;
	Item.Caption := IntToStr(i);
	Item.SubItems.Add(node.Data.LastName + ' ' + node.Data.FirstName + ' ' +
	  node.Data.MiddleName);
	Item.SubItems.Add(node.Data.Group);
	Item.SubItems.Add(node.Data.AvgGrade);
	Inc(i);
  end;
end;

procedure TApp.loadGroups(path: string);
var
  node: PGroup;
  F: file of TGroupData;
begin
  if FileExists(path) then
  begin
	AssignFile(F, path);
	reset(F);
	node := GroupHead;
	while not Eof(F) do
	begin
	  new(node.Next);
	  node := node.Next;
	  read(F, node.Data);
	end;
	node.Next := nil;
	closeFile(F);
	showGroups;
  end;
end;

procedure TApp.addNewGroupBtnClick(Sender: TObject);
begin
  addGroupForm.ShowModal;
end;
procedure TApp.addNewStudent(Data: TStudentData);
var
  id: Integer;
var
  node: PStudent;
begin
  node := Head;
  while not(node.Next = nil) do
	node := node.Next;
  if (node = Head) then
	id := 0
  else
	id := node.Data.id + 1;
  new(node.Next);
  node := node.Next;
  node.Data := Data;
  node.Data.id := id;
  node.Next := nil;
  changeGroupCount(node.Data.Group, 1);
  ShowNewStudent(node.Data);
  wasSaved := false;
end;

procedure TApp.changeStudentInfo(Data: TStudentData);
var
  i, index: Integer;
  node: PStudent;
begin
  index := StudentsList.ItemIndex;
  node := Head;
  for i := 0 to index do
	node := node.Next;
  node.Data := Data;
  ShowStudents(Head);
  wasSaved := false;
end;

procedure TApp.deleteStudent;
var
  node: PStudent;
  i, index: Integer;
begin
  node := Head;
  if StudentsList.ItemIndex = 0 then
  begin
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end
  else
  begin
	index := StudentsList.ItemIndex - 1;
	for i := 0 to index do
	  node := node.Next;
    changeGroupCount(node.Next.Data.Group, -1);
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end;
  ShowStudents(Head);
  wasSaved := false;
end;

procedure TApp.ShowNewStudent(Data: TStudentData);
var
  Item: TListItem;
begin
  Item := StudentsList.Items.Add;
  Item.Caption := IntToStr(StudentsList.Items.Count);
  Item.SubItems.Add(Data.LastName + ' ' + Data.FirstName + ' ' +
	Data.MiddleName);
  Item.SubItems.Add(Data.Group);
  Item.SubItems.Add(Data.AvgGrade);
end;

procedure TApp.studentInfoBtnClick(Sender: TObject);
begin
  infoStudentForm.Show;
end;

procedure TApp.StudentsListChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  studentInfoBtn.Enabled := StudentsList.ItemIndex >= 0;
end;

procedure TApp.addStudentBtnClick(Sender: TObject);
begin
  AddStudentsForm.ShowModal;
end;

procedure TApp.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if not wasSaved then

	case MessageDlg('Вы хотите сохранить изменения перед выходом?',
	  mtConfirmation, [mbOK, mbCancel, mbNo], 0) of
	  mrCancel:
		begin
		  CanClose := false;
		end;
	  mrOK:
		begin
		  saveGroupsToFile(groupsPath);
		  saveStudentsToFile(studentsPath);
		end;
	end;
end;

procedure TApp.FormCreate(Sender: TObject);
begin
  new(Head);
  Head.Next := nil;
  new(GroupHead);
  GroupHead.Next := nil;
  loadGroups(groupsPath);
  loadStudents(studentsPath);
  wasSaved := true;
  isFiltered := false;
end;

function compareByNameUp(a, b: TStudentData): boolean;
begin
  result := a.LastName + ' ' + a.FirstName + ' ' + a.MiddleName > b.LastName + ' ' + b.FirstName + ' ' + b.MiddleName
end;
function compareByNameDown(a, b: TStudentData): boolean;
begin
  result := a.LastName + ' ' + a.FirstName + ' ' + a.MiddleName < b.LastName + ' ' + b.FirstName + ' ' + b.MiddleName
end;
function compareByGradeUp(a, b: TStudentData): boolean;
begin
	if a.avgGrade = '-' then result:=true else
    if b.AvgGrade = '-' then result:=false else
  result := a.avgGrade > b.avgGrade
end;
function compareByGradeDown(a, b: TStudentData): boolean;
begin
  if a.avgGrade = '-' then result:=true else
    if b.AvgGrade = '-' then result:=false else
  result := a.avgGrade < b.avgGrade
end;
function compareByGroupUp(a, b: TStudentData): boolean;
begin
  result := a.group > b.group;
end;
function compareByGroupDown(a, b: TStudentData): boolean;
begin
  result := a.group < b.group;
end;


procedure TApp.showStudentsGroupBtnClick(Sender: TObject);
begin
filterGroup(GroupsCmb.Items[GroupsCmb.ItemIndex]);
isFiltered := true;
end;

procedure TApp.sort(comparator: TComporator);
var
  Tempfirst, j, LAst, start, currHead: pSTudent;
  temp1, temp2: pSTudent;
begin
  LAst := nil;
  if isFiltered then currHead := DisplayedHead else currHead := Head;
  start := currHead;
  while currHead^.NExt^.NExt <> LAst do
  begin
    j := currHead^.NExt;
    while j^.NExt <> LAst do
    begin
      if comparator(j.Data, j^.Next.Data) then
      begin
        temp1 := j;
        temp2 := j^.NExt^.NExt;
        j := j^.NExt;
        j^.NExt := temp1;
        j^.NExt^.NExt := temp2;
      end;
      currHead^.NExt := j;
      j := j^.NExt;
      currHead := currHead^.NExt;
    end;
    LAst := j;
    currHead := start;
  end;
end;

procedure TApp.filterGroup(group: shortString);
var node,displayedNode: PStudent;
begin
   node := Head;
   new(displayedHead);
   displayedNode := displayedHead;
   while not (node.Next = nil) do
   begin
     node := node.Next;
     if node.Data.Group = group then
     begin
       new(displayedNode.Next);
       displayedNode := displayedNode.Next;
       displayedNode.Data := node.Data;
     end;
   end;
   displayedNode.Next := nil;
   showStudents(displayedHead);
end;


procedure TApp.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = Ord('S')) and (wasSaved = false) then
  begin
	wasSaved := true;
	saveGroupsToFile(groupsPath);
	saveStudentsToFile(studentsPath);
	Key := 0;
  end;
end;

procedure TApp.GroupInfoBtnClick(Sender: TObject);
begin
  infoGroupForm.Show;
end;

procedure TApp.GroupsCmbChange(Sender: TObject);
begin
  GroupInfoBtn.Enabled := GroupsCmb.ItemIndex >= 0;
end;

procedure TApp.saveStudentsToFile(path: string);
var
  F: file of TStudentData;
  node: PStudent;
begin
  AssignFile(F, path);
  Rewrite(F);
  node := Head;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	write(F, node.Data);
  end;
  closeFile(F);
end;

procedure TApp.SearchStudentBtnClick(Sender: TObject);
type
  Pres = ^Tres;

  Tres = record
	index: Integer;
	Next: Pres;
  end;
var
  node: PStudent;
  Item: TListItem;
  resIndexHead, resIndex: Pres;
  i: Integer;
begin
  node := Head;
  new(resIndexHead);
  resIndexHead.Next := nil;
  resIndex := resIndexHead;
  i := 0;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	if (AnsiLowerCase(node.Data.FirstName) = AnsiLowerCase(Trim(FirstNameEdit.Text)))
	  and (AnsiLowerCase(node.Data.LastName) = AnsiLowerCase(Trim(LastNameEdit.Text)))
	  and (AnsiLowerCase(node.Data.MiddleName)
	  = AnsiLowerCase(Trim(MiddleNameEdit.Text))) then
	begin
	  new(resIndex.Next);
	  resIndex := resIndex.Next;
	  resIndex.index := i;
	end;
	Inc(i);
  end;
  resIndex.Next := nil;
  if (resIndexHead.Next = nil) then
	ShowMessage('Совпадения не найдены.')
  else if resIndexHead.Next.Next = nil then
  begin
	Item := StudentsList.Items[resIndexHead.Next.index];
	Item.MakeVisible(false);
	StudentsList.ItemIndex := resIndexHead.Next.index;
  end
  else
	ShowMessage('Найдено несколько совпадений.');

end;

procedure TApp.loadStudents(path: string);
var
  node: PStudent;
  F: file of TStudentData;
begin
  if FileExists(path) then
  begin
	AssignFile(F, path);
	reset(F);
	node := Head;
	while not Eof(F) do
	begin
	  new(node.Next);
	  node := node.Next;
	  read(F, node.Data);
	end;
	node.Next := nil;
	closeFile(F);
	ShowStudents(Head);
  end;
end;

procedure TApp.ShowNewGroup(Group: ShortString);
begin
  GroupsCmb.Items.Add(Group);
end;

procedure TApp.addNewGroup(GroupData: TGroupData);
var
  node: PGroup;
begin
  node := GroupHead;
  while not(node.Next = nil) do
	node := node.Next;
  new(node.Next);
  node := node.Next;
  node.Data := GroupData;
  node.Next := nil;
  ShowNewGroup(node.Data.Group);
  wasSaved := false;
end;

procedure TApp.ChangeGroupInfo(Data: TGroupData);
var
  i, index: Integer;
  node: PGroup;
begin
  index := GroupsCmb.ItemIndex;
  node := GroupHead;
  for i := 0 to index do
	node := node.Next;
  node.Data := Data;
  showGroups;
  wasSaved := false;
end;

procedure TApp.DeleteGroup;
var
  node: PGroup;
  i, index: Integer;
begin
  node := GroupHead;
  if GroupsCmb.ItemIndex = 0 then
  begin
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end
  else
  begin
	index := GroupsCmb.ItemIndex - 1;
	for i := 0 to index do
	  node := node.Next;
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end;
  showGroups;
  wasSaved := false;
end;



procedure TApp.StudentsListColumnClick(Sender: TObject; Column: TListColumn);
var initCaption: TCaption;
begin

  case Column.index of
	1:
	  begin
        initCaption := 'ФИО';
        StudentsList.Columns[2].Caption := 'Группа';
        StudentsList.Columns[3].Caption := 'Средний балл';
        if (column.Caption = initCaption) or (column.Caption = initCaption + ' ' + Chr(9660)) then
        begin
        column.Caption := initCaption + ' ' + Chr(9650);
        sort(compareByNameUp);
        end else
        begin
        column.Caption := initCaption + ' ' + Chr(9660);
        sort(compareByNameDown);
        end;
	  end;
    2:
      begin
      initCaption := 'Группа';
      StudentsList.Columns[1].Caption := 'ФИО';
        StudentsList.Columns[3].Caption := 'Средний балл';
      if (column.Caption = initCaption) or (column.Caption = initCaption + ' ' + Chr(9660)) then
        begin
        column.Caption := initCaption + ' ' + Chr(9650);
        sort(compareByGroupUp);
        end else
        begin
        column.Caption := initCaption + ' ' + Chr(9660);
        sort(compareByGroupDown);
        end;
      end;
    3:
      begin
      initCaption := 'Средний балл';
      StudentsList.Columns[2].Caption := 'Группа';
        StudentsList.Columns[1].Caption := 'ФИО';
      if (column.Caption = initCaption) or (column.Caption = initCaption + ' ' + Chr(9660)) then
        begin
        column.Caption := initCaption + ' ' + Chr(9650);
        sort(compareByGradeUp);
        end else
        begin
        column.Caption := initCaption + ' ' + Chr(9660);
        sort(compareByGradeDown);
        end;
      end;
  end;
  if isFiltered then ShowStudents(DisplayedHead) else ShowStudents(Head);
end;
procedure Tapp.changeGroupCount(group: shortString; delta: integer);
var node: PGroup;
begin
   node := groupHead;
   while not (node.Next = nil) do
   begin
     node := node.Next;
     if node.Data.Group = Group then
     node.Data.StudentsCount := node.Data.StudentsCount + delta;
   end;
end;

procedure TApp.saveGroupsToFile(path: string);
var
  node: PGroup;
  F: file of TGroupData;
begin
  AssignFile(F, path);
  Rewrite(F);
  node := GroupHead;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	write(F, node.Data);
  end;
  closeFile(F);
end;

end.
