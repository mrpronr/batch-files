@echo off

rem ファイル定数
set WORK_DIR=work_vfr_to_cfr
set VIDEO_NAME=video.mp4
set AUDIO_NAME=audio.m4a
set CFR_VIDEO_NAME=video_cfr.mp4
set OUT_SUFFIX=_cfr.mp4

rem オプション定数
set FPS=-r 60000/1001
set SCAN_TYPE=-vsync cfr
set VIDEO_CODEC=-vcodec libx264
set QUALITY=-crf 17

rem 遅延環境変数を設定
setlocal ENABLEDELAYEDEXPANSION

rem 作業用フォルダ
mkdir %WORK_DIR%
cd %WORK_DIR%

for %%a in (%*) do (

	rem 動画と音声を分割
	ffmpeg -i %%a -vcodec copy -map 0:0 %VIDEO_NAME%
	ffmpeg -i %%a -acodec copy -map 0:1 %AUDIO_NAME%

	rem 変換
	ffmpeg -i %VIDEO_NAME% %FPS% %SCAN_TYPE% %VIDEO_CODEC% %QUALITY% %CFR_VIDEO_NAME%

	set OUT_NAME="%%~a%OUT_SUFFIX%"

	rem cfrの動画と音声を結合
	ffmpeg -i %CFR_VIDEO_NAME% -i %AUDIO_NAME% -vcodec copy -acodec copy -map 0:v:0 -map 1:a:0 !OUT_NAME!

	rem お掃除
	move !OUT_NAME! ..
	del %VIDEO_NAME% %AUDIO_NAME% %CFR_VIDEO_NAME%
)

cd ..
rmdir %WORK_DIR%

pause
