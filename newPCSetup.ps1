$pthSetupDir = "C:\tmp\newPCSetup"
$pthUtilities = "C:\utilities"

$installedApps = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName

if (-not (Test-Path $pthSetupDir)){
    mkdir $pthSetupDir
}
if (-not (Test-Path $pthUtilities)){
    mkdir $pthUtilities
}

cd $pthSetupDir

if (-not ($installedApps.DisplayName -contains "Notepad++")){
    wget https://notepad-plus-plus.org/repository/6.x/6.8.3/npp.6.8.3.Installer.exe -OutFile npp.6.8.3.Installer.exe
    .\npp.6.8.3.Installer.exe /S
}

if (-not (Test-Path (Join-Path -Path $pthUtilities -ChildPath "Putty.exe"))){
    wget http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe -OutFile (Join-Path -Path $pthUtilities -ChildPath "Putty.exe")
}

if (($installedApps.DisplayName -match "Git version" | measure).count -lt 1){
    wget https://github.com/git-for-windows/git/releases/download/v2.5.3.windows.1/Git-2.5.3-64-bit.exe -OutFile Git-2.5.3-64-bit.exe
    .\Git-2.5.3-64-bit.exe /VERYSILENT /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"
}