unit Main_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, CommCtrl,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.Menus, System.Actions,
  Vcl.ActnList;

const
  studentsPath = '\students.txt';

const
  groupsPath = '\groups.txt';

type

  TGrade = record
	Subject: ShortString;
	Grade: shortInt;
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
	MainMenu: TMainMenu;
	fileOptions: TMenuItem;
	SaveFIle: TMenuItem;
	ExitApp: TMenuItem;
	ImageList: TImageList;
	ActionList1: TActionList;
	SaveAction: TAction;
	ExitAction: TAction;
	N1: TMenuItem;
	expulsionList: TMenuItem;
	debtorsList: TMenuItem;
	expulsionListAction: TAction;
	debtorsListAction: TAction;
	N2: TMenuItem;
	saveListAction: TAction;
	SaveDialog: TSaveDialog;
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
	procedure DeleteGroupStudent(Group: String);
	procedure saveGroupsToFile(path: string);
	procedure changeGroupCount(Group: ShortString; delta: Integer);
	procedure loadGroups(path: string);
	procedure showGroups;

	procedure sort(comparator: TComporator);
	procedure filterGroup(Group: ShortString);

	procedure GroupInfoBtnClick(Sender: TObject);
	procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
	procedure GroupsCmbChange(Sender: TObject);
	procedure studentInfoBtnClick(Sender: TObject);
	procedure StudentsListChange(Sender: TObject; Item: TListItem;
	  Change: TItemChange);
	procedure SearchStudentBtnClick(Sender: TObject);
	// procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure StudentsListColumnClick(Sender: TObject; Column: TListColumn);
	procedure showStudentsGroupBtnClick(Sender: TObject);
	procedure showAllStudentsBtnClick(Sender: TObject);
	procedure SaveActionExecute(Sender: TObject);
	procedure ExitActionExecute(Sender: TObject);

	procedure expulsionListActionExecute(Sender: TObject);
	procedure debtorsListActionExecute(Sender: TObject);
	procedure makeDebtorsList(Subject: string);

	procedure saveListActionExecute(Sender: TObject);

	procedure saveList(itemIndex: Byte);
	procedure LastNameEditChange(Sender: TObject);

  private
	wasSaved: boolean;

  public
	isFiltered: boolean;
	Head: PStudent;
	GroupHead: PGroup;
	displayedHead: PStudent;
	expulsionHead: PStudent;
	DebtorsHead: PStudent;

  end;

var
  App: TApp;

implementation

uses addStudents_U, addGroup_U, infoGroup_U, infoStudent_U, saveList_U,
  chooseSubject_U;
{$R *.dfm}

procedure TApp.showAllStudentsBtnClick(Sender: TObject);
begin
  isFiltered := false;
  ShowStudents(Head);
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
  if isFiltered then
  begin
	ShowStudents(Head);
	isFiltered := false;
  end;
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
  index := StudentsList.itemIndex;
  node := Head;
  for i := 0 to index do
	node := node.Next;
  changeGroupCount(node.Data.Group, -1);
  node.Data := Data;
  changeGroupCount(node.Data.Group, 1);
  ShowStudents(Head);
  wasSaved := false;
end;

procedure TApp.makeDebtorsList(Subject: string);
var
  node, newNode: PStudent;
  i: Integer;
  flag: boolean;
begin
  new(DebtorsHead);
  newNode := DebtorsHead;
  node := Head;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	flag := false;
	for i := 0 to node.Data.GradesCount - 1 do
	begin
	  if node.Data.Grades[i].Subject = Subject then
		if node.Data.Grades[i].Grade < 0 then
		  flag := true;
	end;
	if flag then
	begin
	  new(newNode.Next);
	  newNode := newNode.Next;
	  newNode.Data := node.Data;
	end;
  end;
  newNode.Next := nil;
  if DebtorsHead.Next = nil then
	ShowMessage('Студентов с задолжностями нет.')
  else
  begin
	displayedHead := DebtorsHead;
	isFiltered := true;
	ShowStudents(displayedHead);
  end;
end;

procedure TApp.debtorsListActionExecute(Sender: TObject);
begin
  chooseSubjectForm.ShowModal;
end;

procedure TApp.deleteStudent;
var
  node: PStudent;
  i, id, index: Integer;
begin
  if isFiltered then
	node := displayedHead
  else
	node := Head;
  if StudentsList.itemIndex = 0 then
  begin
	id := node.Next.Data.id;
	changeGroupCount(node.Next.Data.Group, -1);
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end
  else
  begin
	index := StudentsList.itemIndex - 1;
	for i := 0 to index do
	  node := node.Next;
	id := node.Next.Data.id;
	changeGroupCount(node.Next.Data.Group, -1);
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end;
  if isFiltered then
  begin
	node := Head;
	while not(node.Next.Data.id = id) do
	begin
	  node := node.Next;
	end;
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end;
  if isFiltered then
	ShowStudents(displayedHead)
  else
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
  studentInfoBtn.Enabled := StudentsList.itemIndex >= 0;
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
  result := AnsiLowerCase(a.LastName + ' ' + a.FirstName + ' ' + a.MiddleName) >
	AnsiLowerCase(b.LastName + ' ' + b.FirstName + ' ' + b.MiddleName)
end;

function compareByNameDown(a, b: TStudentData): boolean;
begin
  result := a.LastName + ' ' + a.FirstName + ' ' + a.MiddleName < b.LastName +
	' ' + b.FirstName + ' ' + b.MiddleName
end;

function compareByGradeUp(a, b: TStudentData): boolean;
begin
  if a.AvgGrade = '-' then
	result := true
  else if b.AvgGrade = '-' then
	result := false
  else
	result := a.AvgGrade > b.AvgGrade
end;

function compareByGradeDown(a, b: TStudentData): boolean;
begin
  if a.AvgGrade = '-' then
	result := true
  else if b.AvgGrade = '-' then
	result := false
  else
	result := a.AvgGrade < b.AvgGrade
end;

function compareByGroupUp(a, b: TStudentData): boolean;
begin
  result := a.Group > b.Group;
end;

function compareByGroupDown(a, b: TStudentData): boolean;
begin
  result := a.Group < b.Group;
end;

procedure TApp.showStudentsGroupBtnClick(Sender: TObject);
begin
  filterGroup(GroupsCmb.Items[GroupsCmb.itemIndex]);
  isFiltered := true;
end;

procedure TApp.sort(comparator: TComporator);
var
  Tempfirst, j, LAst, start, currHead: PStudent;
  temp1, temp2: PStudent;
begin
  LAst := nil;
  if isFiltered then
	currHead := displayedHead
  else
	currHead := Head;
  if not(currHead.Next = nil) then
  begin
	start := currHead;
	while currHead^.Next^.Next <> LAst do
	begin
	  j := currHead^.Next;
	  while j^.Next <> LAst do
	  begin
		if comparator(j.Data, j^.Next.Data) then
		begin
		  temp1 := j;
		  temp2 := j^.Next^.Next;
		  j := j^.Next;
		  j^.Next := temp1;
		  j^.Next^.Next := temp2;
		end;
		currHead^.Next := j;
		j := j^.Next;
		currHead := currHead^.Next;
	  end;
	  LAst := j;
	  currHead := start;
	end;
  end;
end;

procedure TApp.filterGroup(Group: ShortString);
var
  node, displayedNode: PStudent;
begin
  node := Head;
  new(displayedHead);
  displayedNode := displayedHead;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	if node.Data.Group = Group then
	begin
	  new(displayedNode.Next);
	  displayedNode := displayedNode.Next;
	  displayedNode.Data := node.Data;
	end;
  end;
  displayedNode.Next := nil;
  ShowStudents(displayedHead);
end;

//
// procedure TApp.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
// begin
// if (ssCtrl in Shift) and (Key = Ord('S')) and (wasSaved = false) then
// begin
// wasSaved := true;
// saveGroupsToFile(groupsPath);
// saveStudentsToFile(studentsPath);
// Key := 0;
// end;
// end;

procedure TApp.GroupInfoBtnClick(Sender: TObject);
begin
  infoGroupForm.Show;
end;

procedure TApp.GroupsCmbChange(Sender: TObject);
begin
  GroupInfoBtn.Enabled := GroupsCmb.itemIndex >= 0;
  showStudentsGroupBtn.Enabled := GroupsCmb.itemIndex >= 0;
end;

procedure TApp.LastNameEditChange(Sender: TObject);
begin
  SearchStudentBtn.Enabled := (Length(Trim(LastNameEdit.Text)) > 0) and
	(Length(Trim(FirstNameEdit.Text)) > 0)
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
	if (AnsiLowerCase(node.Data.FirstName)
	  = AnsiLowerCase(Trim(FirstNameEdit.Text))) and
	  (AnsiLowerCase(node.Data.LastName) = AnsiLowerCase(Trim(LastNameEdit.Text)
	  )) and (AnsiLowerCase(node.Data.MiddleName)
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
	StudentsList.itemIndex := resIndexHead.Next.index;
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

procedure TApp.SaveActionExecute(Sender: TObject);
begin
  if wasSaved = false then
  begin
	wasSaved := true;
	saveGroupsToFile(groupsPath);
	saveStudentsToFile(studentsPath);
  end;
end;

procedure TApp.ExitActionExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TApp.expulsionListActionExecute(Sender: TObject);
var
  node, newNode: PStudent;
  i: Integer;
  Count: Byte;
begin
  new(expulsionHead);
  newNode := expulsionHead;
  node := Head;
  while not(node.Next = nil) do
  begin
	node := node.Next;
	Count := 0;
	for i := 0 to node.Data.GradesCount - 1 do
	begin
	  if node.Data.Grades[i].Grade < 5 then
		Inc(Count);
	end;
	if Count = 3 then
	begin
	  new(newNode.Next);
	  newNode := newNode.Next;
	  newNode.Data := node.Data;
	end;
  end;
  newNode.Next := nil;
  if expulsionHead.Next = nil then
	ShowMessage('Студентов для отчисления нет.')
  else
  begin
	displayedHead := expulsionHead;
	isFiltered := true;
	ShowStudents(displayedHead);
  end;

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
  index := GroupsCmb.itemIndex;
  node := GroupHead;
  for i := 0 to index do
	node := node.Next;
  node.Data := Data;
  showGroups;
  wasSaved := false;
  GroupInfoBtn.Enabled := false;
end;

procedure TApp.DeleteGroupStudent(Group: string);
var
  node: PStudent;
begin
  node := Head;
  if not(node.Next = nil) then
  begin
	repeat
	  if node.Next.Data.Group = Group then
		node.Next := node.Next.Next
      else
      node := node.Next;
	until node.Next = nil;
  end;
end;

procedure TApp.DeleteGroup;
var
  node: PGroup;
  i, index: Integer;
begin
  node := GroupHead;
  if GroupsCmb.itemIndex = 0 then
  begin
    DeleteGroupStudent(node.Next.Data.Group);
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end
  else
  begin
	index := GroupsCmb.itemIndex - 1;
	for i := 0 to index do
	  node := node.Next;
      DeleteGroupStudent(node.Next.Data.Group);
	if node.Next.Next = nil then
	  node.Next := nil
	else
	  node.Next := node.Next.Next;
  end;
  showStudents(Head);
  showGroups;
  wasSaved := false;
  GroupInfoBtn.Enabled := GroupsCmb.Items.Count > 0;
  showStudentsGroupBtn.Enabled := GroupsCmb.Items.Count > 0;
end;

procedure TApp.StudentsListColumnClick(Sender: TObject; Column: TListColumn);
var
  initCaption: TCaption;
begin

  case Column.index of
	1:
	  begin
		initCaption := 'ФИО';
		StudentsList.Columns[2].Caption := 'Группа';
		StudentsList.Columns[3].Caption := 'Средний балл';
		if (Column.Caption = initCaption) or
		  (Column.Caption = initCaption + ' ' + Chr(9660)) then
		begin
		  Column.Caption := initCaption + ' ' + Chr(9650);
		  sort(compareByNameUp);
		end
		else
		begin
		  Column.Caption := initCaption + ' ' + Chr(9660);
		  sort(compareByNameDown);
		end;
	  end;
	2:
	  begin
		initCaption := 'Группа';
		StudentsList.Columns[1].Caption := 'ФИО';
		StudentsList.Columns[3].Caption := 'Средний балл';
		if (Column.Caption = initCaption) or
		  (Column.Caption = initCaption + ' ' + Chr(9660)) then
		begin
		  Column.Caption := initCaption + ' ' + Chr(9650);
		  sort(compareByGroupUp);
		end
		else
		begin
		  Column.Caption := initCaption + ' ' + Chr(9660);
		  sort(compareByGroupDown);
		end;
	  end;
	3:
	  begin
		initCaption := 'Средний балл';
		StudentsList.Columns[2].Caption := 'Группа';
		StudentsList.Columns[1].Caption := 'ФИО';
		if (Column.Caption = initCaption) or
		  (Column.Caption = initCaption + ' ' + Chr(9660)) then
		begin
		  Column.Caption := initCaption + ' ' + Chr(9650);
		  sort(compareByGradeUp);
		end
		else
		begin
		  Column.Caption := initCaption + ' ' + Chr(9660);
		  sort(compareByGradeDown);
		end;
	  end;
  end;
  if isFiltered then
	ShowStudents(displayedHead)
  else
	ShowStudents(Head);
end;

procedure TApp.changeGroupCount(Group: ShortString; delta: Integer);
var
  node: PGroup;
  flag: boolean;
begin
  node := GroupHead;
  flag := false;
  while (not(node.Next = nil)) and (not flag) do
  begin
	node := node.Next;
	if node.Data.Group = Group then
	begin
	  node.Data.StudentsCount := node.Data.StudentsCount + delta;
	  flag := true;
	end;
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

procedure TApp.saveList(itemIndex: Byte);
var
  F: textFile;
  path, newStr: string;
  node: PStudent;
begin
  try
	// Настройка параметров диалогового окна
	SaveDialog.Title := 'Выберите путь для сохранения файла';
	SaveDialog.Filter := 'Текстовые файлы (*.txt)|*.txt'; // Фильтр файлов
	SaveDialog.DefaultExt := 'txt'; // Расширение файла по умолчанию

	// Показать диалоговое окно и обработка результатов
	if SaveDialog.Execute then
	begin
	  // Получить выбранный путь
	  ShowMessage('Файл сохранен по адресу: ' + SaveDialog.FileName);
	  path := SaveDialog.FileName;
	  AssignFile(F, path, CP_UTF8);
	  Rewrite(F);
	  case itemIndex of
		0:
		  begin
			node := expulsionHead;
		  end;
		1:
		  begin
			node := DebtorsHead;
		  end;
	  end;
	  while not(node.Next = nil) do
	  begin
		node := node.Next;
		newStr := node.Data.LastName + ' ' + node.Data.FirstName + ' ' +
		  node.Data.MiddleName + '       Группа: ' + node.Data.Group;
		Writeln(F, newStr);
	  end;
	  closeFile(F);
	end
	else
	begin
	  // Действие при отмене выбора файла
	  ShowMessage('Сохранение отменено');
	end;
  finally
	SaveDialog.Free;
  end;
end;

procedure TApp.saveListActionExecute(Sender: TObject);
begin
  saveListForm.ShowModal;
end;

end.
