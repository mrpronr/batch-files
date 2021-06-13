@echo off

rem 動画と音声を分割
ffmpeg -i %1 -vcodec copy -map 0:0 "%~n1_video.mp4"
ffmpeg -i %1 -acodec copy -map 0:1 "%~n1_audio.m4a"
