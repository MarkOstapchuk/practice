unit Main_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

const
  studentsPath = '..\..\assets\students.txt';

const
  groupsPath = '..\..\assets\groups.txt';

type
  TGrade = record
	Subject: string;
	Grade: Byte;
  end;

  TGrades = array [0 .. 9] of TGrade;

  TStudentData = record
	id: Word;
	FirstName: string;
	LastName: string;
	MiddleName: string;
	Group: string;
	Grades: TGrades;
	GradesCount: Byte;
	AvgGrade: string;
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
	procedure addStudentBtnClick(Sender: TObject);
	procedure saveStudents(path: string);
	procedure addNewStudent(Data: TStudentData);
	procedure ShowNewStudent(Data: TStudentData);
	procedure ShowNewGroup(Group: string);
	procedure FormCreate(Sender: TObject);
	procedure addNewGroupBtnClick(Sender: TObject);
	procedure addNewGroup(GroupData: TGroupData);
	procedure ChangeGroupInfo(Data: TGroupData);
	procedure DeleteGroup;
	procedure saveGroupsToFile(path: string);
	procedure loadGroups(path: string);
	procedure showGroups;
	procedure GroupInfoBtnClick(Sender: TObject);
	procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
	procedure GroupsCmbChange(Sender: TObject);
  private
	{ Private declarations }
  public
	Head: PStudent;
	GroupHead: PGroup;
  end;

var
  App: TApp;

implementation

uses addStudents_U, addGroup_U, infoGroup_U;
{$R *.dfm}

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

procedure TApp.loadGroups(path: string);
var
  node: PGroup;
  F: file of TGroupData;
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
  ShowNewStudent(node.Data);
end;

procedure TApp.ShowNewStudent(Data: TStudentData);
var
  Item: TListItem;
begin
  Item := StudentsList.Items.Add;
  Item.Caption := IntToStr(Data.id + 1);
  Item.SubItems.Add(Data.LastName + ' ' + Data.FirstName + ' ' +
	Data.MiddleName);
  Item.SubItems.Add(Data.Group);
  Item.SubItems.Add(Data.AvgGrade);
end;

procedure TApp.addStudentBtnClick(Sender: TObject);
begin
  AddStudentsForm.ShowModal;
end;

procedure TApp.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  case MessageDlg('Вы хотите сохранить изменения перед выходом?',
	mtConfirmation, [mbOK, mbCancel, mbNo], 0) of
	mrCancel:
	  begin
		CanClose := False;
	  end;
	mrOK:
	  begin
		saveGroupsToFile(groupsPath);
	  end;
  end;
end;

procedure TApp.FormCreate(Sender: TObject);
begin
  new(Head);
  new(GroupHead);
  loadGroups(groupsPath);
end;

procedure TApp.GroupInfoBtnClick(Sender: TObject);
begin
  infoGroupForm.show;
end;

procedure TApp.GroupsCmbChange(Sender: TObject);
begin
  GroupInfoBtn.Enabled := GroupsCmb.ItemIndex >= 0;
end;

procedure TApp.saveStudents(path: string);
begin
  App.Caption := 'App';
end;

procedure TApp.ShowNewGroup(Group: string);
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
  // saveGroupsToFile(groupsPath)
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
end;

procedure TApp.saveGroupsToFile(path: string);
var
  node: PGroup;
  F: file of TGroupData;
begin
  AssignFile(F, path);
  reWrite(F);
  node := GroupHead;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	write(F, node.Data);
  end;
  closeFile(F);
end;

end.
