@echo off
chcp 65001 > nul  # 永久解决中文乱码问题
title 抖音分享到QQ群助手
python "%~dp0抖音分享QQ群.py"
pause > nul  # 执行完不自动关闭窗口，方便看结果
