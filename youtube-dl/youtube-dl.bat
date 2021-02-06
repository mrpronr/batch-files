@echo off
rem cd %~dp0
cd %USERPROFILE%\Downloads

set exe=C:\bin\_Video\youtube-dl.exe

rem URL入力待ち
set /P url="URL>"

rem ベースコマンド
set cmd=%exe% %url%

rem フォーマット一覧表示
call %cmd% -F | findstr "format webm" | findstr "code webm"

rem フォーマットコード入力待ち
rem 複数ダウンロードしたい場合は'+'で連結させる
echo;
echo Select Format Code(s)
set /P formatCodes="If you want to download multiple, concatenate format codes with '+'>"

rem ダウンロード実行
call %cmd% -f %formatCodes%

pause