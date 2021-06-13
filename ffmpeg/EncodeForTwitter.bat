@echo off

rem ファイル定数
set VIDEO_NAME=video.mp4
set AUDIO_NAME=audio.m4a
set ENCODED_VIDEO_NAME=encoded_video.mp4

rem オプション定数
set FPS=-r 40
set VIDEO_CODEC=-vcodec libx264
set QUALITY=-crf 20
set SCALE=-s 1280x720

rem 動画と音声を分割
ffmpeg -i %1 -vcodec copy -map 0:0 %VIDEO_NAME%
ffmpeg -i %1 -acodec copy -map 0:1 %AUDIO_NAME%

rem 変換
ffmpeg -i %VIDEO_NAME% %FPS% %VIDEO_CODEC% %QUALITY% %SCALE% %ENCODED_VIDEO_NAME%

rem 動画と音声を結合
ffmpeg -i %ENCODED_VIDEO_NAME% -i %AUDIO_NAME% -vcodec copy -acodec copy -map 0:v:0 -map 1:a:0 "%~n1_for_twitter.mp4"

rem お掃除
del %VIDEO_NAME% %AUDIO_NAME% %ENCODED_VIDEO_NAME%

pause
