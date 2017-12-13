@Echo off

:: MSBUILD path is subject to change on Visual Studio upgrade
set msbuildpath="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin"

:: Editor command used to open unassociated filetypes
setx EDITOR %%VIM_APP%%\gvim

:: Scripts to include on path
set PYTHON3_SCRIPTS="%%PYTHON3%%\Scripts"

setx XDG_CONFIG_HOME %%HOMEDRIVE%%\

setx RUST_SRC_PATH %%USERPROFILE%%.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\src

:: My User path environment variables
:: This will store a dynamic reference to these registry values the values should be set manually depending on locations
setx PATH %%BIN%%;%%CMAKE%%;%%CARGO%%;%%ECLIPSE%%;%%NODE%%;%%PYTHON3%%;%PYTHON3_SCRIPTS%;%%CLANG%%;%%VIM_APP%%;%%GNUPLOT%%;%%MINGW_BIN%%;%%MINGW_USR_BIN%%;%%VIRTUALBOX_HOME%%;%msbuildpath%
