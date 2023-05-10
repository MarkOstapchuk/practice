program Practice;

uses
  Vcl.Forms,
  Main_U in 'Main_U.pas' {App},
  addGrades_U in 'addGrades_U.pas' {addGradesForm},
  addStudents_U in 'addStudents_U.pas' {addStudentsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TApp, App);
  Application.CreateForm(TaddGradesForm, addGradesForm);
  Application.CreateForm(TaddStudentsForm, addStudentsForm);
  Application.Run;

end.
