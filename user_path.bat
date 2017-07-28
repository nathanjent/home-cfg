@Echo off

:: MSBUILD path is subject to change on Visual Studio upgrade
set msbuildpath="%ProgramFiles(x86)%\MSBuild\14.0\bin\amd64\"

:: Editor command used to open unassociated filetypes
setx EDITOR %%VIM%%\vim

:: Scripts to include on path
set PYTHON_SCRIPTS="%%PYTHON3%%\Scripts"

setx XDG_CONFIG_HOME %%LOCALAPPDATA%%

setx RUST_SRC_PATH %%USERPROFILE%%.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\src

:: My User path environment variables
:: This will store a dynamic reference to these registry values the values should be set manually depending on locations
setx PATH %%BIN%%;%%CMAKE%%;%%CARGO%%;%%EMSDK%%;%%ECLIPSE%%;%%NODE%%;%%PYTHON3%%;%%PYTHON2%%;%PYTHON_SCRIPTS%;%%CLANG%%;%%VIM%%;%%GNUPLOT%%;%%MINGW_BIN%%;%%MINGW_USR_BIN%%;%msbuildpath%
