@echo off

rem 定数
set WORK_DIR=work_vfr_to_cfr
set VIDEO_NAME=video.mp4
set AUDIO_NAME=audio.m4a
set CFR_VIDEO_NAME=video_cfr.mp4
set OUT_NAME=%1_cfr.mp4

rem 作業用フォルダ
mkdir %WORK_DIR%
cd %WORK_DIR%

rem 動画と音声を分割
ffmpeg -i %1 -vcodec copy -map 0:0 %VIDEO_NAME%
ffmpeg -i %1 -acodec copy -map 0:1 %AUDIO_NAME%

rem 動画を59.94fpsのcfrに変換
ffmpeg -i %VIDEO_NAME% -r 60000/1001 -vsync cfr -vcodec libx264 -crf 17 %CFR_VIDEO_NAME%

rem cfrの動画と音声を結合
ffmpeg -i %CFR_VIDEO_NAME% -i %AUDIO_NAME% -vcodec copy -acodec copy -map 0:v:0 -map 1:a:0 %OUT_NAME%

rem お掃除
move %OUT_NAME% ..
del %VIDEO_NAME% %AUDIO_NAME% %CFR_VIDEO_NAME%
cd ..
rd %WORK_DIR%

pause