program Practice;

uses
  Vcl.Forms,
  Main_U in 'Main_U.pas' {App},
  addGrades_U in 'addGrades_U.pas' {addGradesForm},
  addStudents_U in 'addStudents_U.pas' {addStudentsForm},
  addGroup_U in 'addGroup_U.pas' {addGroupForm},
  infoGroup_U in 'infoGroup_U.pas' {infoGroupForm},
  infoStudent_U in 'infoStudent_U.pas' {infoStudentForm},
  saveList_U in 'saveList_U.pas' {SaveListForm},
  infoGrades_U in 'infoGrades_U.pas' {InfoGradesForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TApp, App);
  Application.CreateForm(TaddGradesForm, addGradesForm);
  Application.CreateForm(TaddStudentsForm, addStudentsForm);
  Application.CreateForm(TaddGroupForm, addGroupForm);
  Application.CreateForm(TinfoGroupForm, infoGroupForm);
  Application.CreateForm(TinfoStudentForm, infoStudentForm);
  Application.CreateForm(TSaveListForm, SaveListForm);
  Application.CreateForm(TInfoGradesForm, InfoGradesForm);
  Application.Run;

end.
