; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MySetupDir "C:\Users\JC\repos\flame_installer_windows\setup_miniconda\"
#define MyAppName "Flame"
#define MyAppVersion "1.0.0-rc1"
#define MyAppPublisher "PhI laboratory (UPF)"
#define MyAppURL "http://phi.upf.edu"
#define MyAppExeName "flame_exec.bat"
#define MyAppIcoName "flame.ico"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{ACA161A2-E732-49E2-87C3-C7DCA3D2FD6C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={userdocs}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile={#MySetupDir}\license.txt
InfoBeforeFile={#MySetupDir}\previous.rtf
OutputBaseFilename=FlameSetup
SetupIconFile={#MySetupDir}\flame.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "{#MySetupDir}miniconda3.exe"; DestDir: "{app}"; AfterInstall: RunOtherInstaller; Flags: ignoreversion
Source: "{#MySetupDir}flame_exec.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MySetupDir}flame.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MySetupDir}flame_install.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MySetupDir}flame\*"; Excludes: ".git\*"; DestDir: "{app}\flame"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MySetupDir}flame_api\*"; DestDir: "{app}\flame_api"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; IconFilename: "{app}\{#MyAppIcoName}";  Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppIcoName}"; Tasks: desktopicon

[Run]
Filename: "{app}\flame_install.bat";
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: shellexec postinstall skipifsilent

[Code]
procedure RunOtherInstaller;
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\miniconda3.exe'), '', '', SW_SHOWNORMAL,
    ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Other installer failed to run!' + #13#10 +
      SysErrorMessage(ResultCode), mbError, MB_OK);
end;
