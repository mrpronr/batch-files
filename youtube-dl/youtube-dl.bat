@echo off
rem cd %~dp0
cd %USERPROFILE%\Downloads

set exe=C:\bin\_Video\youtube-dl.exe

rem URL���͑҂�
set /P url="URL>"

rem �x�[�X�R�}���h
set cmd=%exe% %url%

rem �t�H�[�}�b�g�ꗗ�\��
call %cmd% -F | findstr "format webm" | findstr "code webm"

rem �t�H�[�}�b�g�R�[�h���͑҂�
rem �����_�E�����[�h�������ꍇ��'+'�ŘA��������
echo;
echo Select Format Code(s)
set /P formatCodes="If you want to download multiple, concatenate format codes with '+'>"

rem �_�E�����[�h���s
call %cmd% -f %formatCodes%

pause