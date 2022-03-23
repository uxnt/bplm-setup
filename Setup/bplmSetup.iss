// 由 Inno 安装脚本向导生成的脚本。
// 有关创建 INNO 安装脚本文件的详细信息，请参阅文档！
// Inno Setup Compiler 6.2.0


#define MyAppName "bplm"
#define MyAppVersion "0.0.1"
#define MyAppPublisher "uxnt"
#define MyAppURL "https://github.com/uxnt/"
#define MyAppExeName "MyProg.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".myp"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt



// user
#define InstallTarget ""             



[Setup]
// 注意：AppId 的值唯一标识此应用程序。不要在其他应用程序的安装程序中使用相同的 AppId 值。
// (要生成新的 GUID, 请单击工具|在 IDE 中生成 GUID 。)
AppId={{EF5709FC-F186-422A-8805-183586BAC832}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
// AppVerName={#MyAppName} {#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}


ChangesEnvironment=yes
ChangesAssociations=yes
DisableProgramGroupPage=yes
// 取消注释以下行以非管理安装模式运行（仅限当前用户安装）
// PrivilegesRequired=lowest
OutputBaseFilename=bplmSetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ShowLanguageDialog=auto




//WizardImageFile="resources\inno-big-100.bmp,resources\inno-big-125.bmp,resources\inno-big-150.bmp,resources\inno-big-175.bmp,resources\inno-big-200.bmp,resources\inno-big-225.bmp,resources\inno-big-250.bmp"
//WizardSmallImageFile="resources\inno-small-100.bmp,resources\inno-small-125.bmp,resources\inno-small-150.bmp,resources\inno-small-175.bmp,resources\inno-small-200.bmp,resources\inno-small-225.bmp,resources\inno-small-250.bmp"
//SetupIconFile=resources\code.ico

// bplm
// UninstallDisplayIcon={app}\{#ExeBasename}.exe
// WizardImageFile=resources\bplmSetup-inno-small.bmp






[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl,i18n\messages.en.isl"
Name: "simplifiedChinese"; MessagesFile: "i18n\Default.zh-cn.isl,i18n\messages.zh-cn.isl"


[UninstallDelete]
Type: filesandordirs; Name: "{app}\_"


[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "addtopath"; Description: "{cm:AddToPath}"; GroupDescription: "{cm:Other}"



[Files]
// ok
// Source: "C:\Program Files (x86)\Inno Setup 6\Examples\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
// 注意：不要在任何共享系统文件上使用 "Flags: ignoreversion"
Source: "bplm\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs




[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent







[Registry]
// ok
#if "user" == InstallTarget
#define SoftwareClassesRootKey "HKCU"
#else
#define SoftwareClassesRootKey "HKLM"
#endif

Root: {#SoftwareClassesRootKey}; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: {#SoftwareClassesRootKey}; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: {#SoftwareClassesRootKey}; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: {#SoftwareClassesRootKey}; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: {#SoftwareClassesRootKey}; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""


  





// Environment
#if "user" == InstallTarget
#define EnvironmentRootKey "HKCU"
#define EnvironmentKey "Environment"
#define Uninstall64RootKey "HKCU64"
#define Uninstall32RootKey "HKCU32"
#else
#define EnvironmentRootKey "HKLM"
#define EnvironmentKey "System\CurrentControlSet\Control\Session Manager\Environment"
#define Uninstall64RootKey "HKLM64"
#define Uninstall32RootKey "HKLM32"
#endif

Root: {#EnvironmentRootKey}; Subkey: "{#EnvironmentKey}"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\bin"; Tasks: addtopath; Check: NeedsAddPath(ExpandConstant('{app}\bin'))










[Code]

// https://stackoverflow.com/a/23838239/261019
procedure Explode(var Dest: TArrayOfString; Text: String; Separator: String);
var
  i, p: Integer;
begin
  i := 0;
  repeat
    SetArrayLength(Dest, i+1);
    p := Pos(Separator,Text);
    if p > 0 then begin
      Dest[i] := Copy(Text, 1, p-1);
      Text := Copy(Text, p + Length(Separator), Length(Text));
      i := i + 1;
    end else begin
      Dest[i] := Text;
      Text := '';
    end;
  until Length(Text)=0;
end;





// 设置添加Path的bin
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue({#EnvironmentRootKey}, '{#EnvironmentKey}', 'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;

// 设置删除Path的bin
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Path: string;
  AppPath: string;
  Parts: TArrayOfString;
  NewPath: string;
  i: Integer;
begin
  if not CurUninstallStep = usUninstall then begin
    exit;
  end;
  if not RegQueryStringValue({#EnvironmentRootKey}, '{#EnvironmentKey}', 'Path', Path)
  then begin
    exit;
  end;
  NewPath := '';
  AppPath := ExpandConstant('{app}\bin')
  Explode(Parts, Path, ';');
  for i:=0 to GetArrayLength(Parts)-1 do begin
    if CompareText(Parts[i], AppPath) <> 0 then begin
      NewPath := NewPath + Parts[i];

      if i < GetArrayLength(Parts) - 1 then begin
        NewPath := NewPath + ';';
      end;
    end;
  end;
  RegWriteExpandStringValue({#EnvironmentRootKey}, '{#EnvironmentKey}', 'Path', NewPath);
end;







