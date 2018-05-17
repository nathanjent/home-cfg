@Echo off

:: MSBUILD path is subject to change on Visual Studio upgrade
set msbuildpath="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin"

set vimpath="%%USERPROFILE%%\kaoriyaVim"

:: Editor command used to open unassociated filetypes
setx EDITOR %vimpath%\gvim

:: Scripts to include on path
set PYTHON3_SCRIPTS="%%PYTHON3%%\Scripts"

setx XDG_CONFIG_HOME %%HOMEDRIVE%%\

setx RUST_SRC_PATH %%USERPROFILE%%\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\src

:: My User path environment variables
:: This will store a dynamic reference to these registry values the values should be set manually depending on locations
setx PATH %%BIN%%;%%CMAKE%%;%%MVN%%;%%ANT%%;%%YARN%%;%%CARGO%%;%%ECLIPSE%%;%%NODE%%;%%PYTHON2%%;%%PYTHON3%%;%PYTHON3_SCRIPTS%;%%CLANG%%;%%GNUPLOT%%;%vimpath%;%%MINGW_BIN%%;%%MINGW_USR_BIN%%;%%VIRTUALBOX_HOME%%;%msbuildpath%
