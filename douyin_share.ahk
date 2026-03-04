; 注意：AHK v2语法（你的AutoHotkey是v2版本，所以用v2语法）
#SingleInstance Force  ; 只允许一个脚本实例运行
#Warn  ; 保留警告，帮助排查问题

; 主逻辑：检测窗口+执行操作
F1::  ; 按F1键触发这个脚本（可以改成你喜欢的快捷键）
{
    ; 1. 判断当前最前端窗口是否是抖音
    currentWindow := WinGetTitle("A")  ; 获取当前激活窗口的标题
    if (!InStr(currentWindow, "抖音"))  ; 如果标题不含“抖音”
    {
        Send "#5"  ; 按Win+5切换到抖音
        Sleep 200  ; 等待窗口切换
    }

    ; 新增：光标归位核心逻辑（按V前执行）
    ; 方法1：按ESC退出所有输入框/弹窗（优先用，最通用）
    ; Send "{Esc}"  
    ; Sleep 100  ; 等待ESC生效
    ; 方法2：点击视频区域（兜底，确保聚焦）
    ; 获取抖音窗口句柄，定位视频区域点击（适配大多数抖音窗口尺寸）
    winHwnd := WinGetID("A")
    WinActivate(winHwnd)
    MouseClick("Left", A_ScreenWidth/2, A_ScreenHeight/2)  ; 点击屏幕中间（抖音视频核心区）
    Sleep 150  ; 等待点击生效

    ; 2. 按V复制分享链接 + 剪切板检测（修复核心）
    Send "v"
    Sleep 800  ; 延长等待时间，确保复制完成（抖音复制可能有延迟）
    
    ; 读取剪切板文本（AHK v2标准写法）
    clipText := A_Clipboard  ; 正确读取系统剪切板文本
    ; 兼容检测：同时检测"douyin"和"抖音"，提高成功率
    if (!InStr(clipText, "douyin") && !InStr(clipText, "抖音"))  
    {
        ToolTip("复制抖音链接失败，剪切板内容：`n" . clipText)  ; 去掉多余的逗号，语法更规范
        Sleep 5000  ; 显示5秒后自动清空
        ToolTip()   ; 主动清空提示，避免残留
        return      ; 直接结束本次脚本执行
    }

    ; 3. 按空格暂停播放
    Send " "
    Sleep 200

    ; 4. 按Win+6切换到QQ
    Send "#6"
    Sleep 300

    ; 5. 按Ctrl+V粘贴链接 + 按Enter发送
    Send "^v"
    Sleep 200
    Send "{Enter}"
    Sleep 300

    ; 6. 按Win+5切换回抖音
    Send "#5"
    Sleep 200

    ; 7. 按空格播放
    Send " "
    Sleep 200

}
; AHK v2中函数块{}结尾不需要return，移除多余的return