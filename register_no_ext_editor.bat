:: set file association for files without an extension for current user
REG ADD "HKCU\software\classes\." /d "No Extension" /f
REG ADD "HKCU\software\classes\No Extension\Shell\Open\Command" /t REG_EXPAND_SZ /d "\"%%EDITOR%%\" \"%%1\"" /f

:: This requires admin
:: assoc .="No Extension"
:: ftype "No Extension"="%EDITOR%" "%1"
