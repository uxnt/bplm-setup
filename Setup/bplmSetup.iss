; 由Inno安装脚本向导生成的脚本。
; 有关创建INNO安装脚本文件的详细信息，请参阅文档！
; Inno Setup Compiler 6.2.0


#define MyAppName "bplm"
#define MyAppVersion "0.0.1"
#define MyAppPublisher "uxnt"
#define MyAppURL "https://github.com/uxnt/"
#define MyAppExeName "MyProg.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".myp"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt


[Setup]
; 注意：AppId的值唯一标识此应用程序。不要在其他应用程序的安装程序中使用相同的AppId值。
;（要生成新的GUID，请单击工具|在IDE中生成GUID。）
AppId={{EF5709FC-F186-422A-8805-183586BAC832}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
; AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
ChangesEnvironment=yes
ChangesAssociations=yes
DisableProgramGroupPage=yes
; 取消注释以下行以非管理安装模式运行（仅限当前用户安装）
; PrivilegesRequired=lowest
OutputBaseFilename=bplmSetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern



[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "simplifiedChinese"; MessagesFile: "i18n\Default.zh-cn.isl"



[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Program Files (x86)\Inno Setup 6\Examples\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
; 注意：不要在任何共享系统文件上使用 "Flags: ignoreversion"

[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
