# Set your custom application paths before running this script

# My bin path for miscellaneous local apps
$binPath = "$ENV:USERPROFILE\bin"

# My Scoop app path
$scoopPath = "$ENV:USERPROFILE\scoop\apps"

# The path to MSBuild is subject to change when upgrading Visual Studio
# Replace year, version (BuildTools, Professional, Community, etc.), and release in the command below
# $msbuildPath = "${ENV:ProgramFiles(x86)}\Microsoft Visual Studio\<year>\<version>\MSBuild\<release>\Bin"
$msbuildPath = "${ENV:ProgramFiles(x86)}\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"

# Editor command used to open unassociated filetypes which is set by running the register_no_ext_editor.bat
if (Get-Command gvim) {
    $vimPath = (Get-Command gvim).Path
    [System.Environment]::SetEnvironmentVariable("EDITOR", $vimPath, [System.EnvironmentVariableTarget]::User)
}
else {
    Write-Output "Add gvim to the Path environment variable."
}


# Set file association for files without an extension for current user
$classesPath = "Registry::HKEY_CURRENT_USER\Software\Classes"
$noExt = "No Extension"

# Set the value for files with no extension
New-ItemProperty -Path $classesPath -Force -Name "." -Value $noExt

# Set the "No Extension" file association
New-ItemProperty -Path "$classesPath\$noExt\Shell\Open\Command\" -Name "(Default)" -Force -PropertyType String -Value "`"%EDITOR%`" `"%1`""


# Set the RUST_SRC_PATH environment variable 
# Ussually installed into the rustup configuration using rustup component add rust-src which install src for the default toolchain
$rustSrcPath = "$scoopPath\rustup\current\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\src"
[System.Environment]::SetEnvironmentVariable("RUST_SRC_PATH", $rustSrcPath, [System.EnvironmentVariableTarget]::User)

# Get the previous value of the user's Path environment variable
$oldPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

$newPath = "$oldPath;$binPath;$msbuildPath"

# Append the dynamic paths to the user's Path
[System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
