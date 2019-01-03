@ECHO OFF

SET TEMPCMD1=temp1.cmd
SET TEMPCMD2=temp2.cmd

call ssh-agent> %TEMPCMD1%
FINDSTR -r -c:"SSH_AUTH_SOCK" %TEMPCMD1% > %TEMPCMD2%
SET /P SSH_AUTH_SOCK=<%TEMPCMD2%
SET "%SSH_AUTH_SOCK:;=" & set rest=%"

FINDSTR -r -c:"SSH_AGENT_PID" %TEMPCMD1% > %TEMPCMD2%
SET /P SSH_AGENT_PID=<%TEMPCMD2%
SET "%SSH_AGENT_PID:;=" & set rest=%"

rm %TEMPCMD1%
rm %TEMPCMD2%

echo SSH_AGENT_PID=%SSH_AGENT_PID%
echo SSH_AUTH_SOCK=%SSH_AUTH_SOCK%

ssh-add "C:\Users\USER\.ssh\id_rsa_phabricator.key"

cd C:\src\blender\blender
git pull

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"

cd C:\src\blender\release\master
devenv Blender.sln /Build Release /Project INSTALL

pause
