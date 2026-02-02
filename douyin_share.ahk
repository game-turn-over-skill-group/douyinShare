; 注意：AHK v2语法（你的AutoHotkey是v2版本，所以用v2语法）
#SingleInstance Force  ; 只允许一个脚本实例运行

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

    ; 2. 按V复制分享链接
    Send "v"
    Sleep 300  ; 等待复制完成

    ; 3. 按空格暂停播放
    Send " "
    Sleep 200

    ; 4. 按Win+6切换到QQ
    Send "#6"
    Sleep 300

    ; 5. 按Ctrl+V粘贴链接 + 按Enter发送（你之前说“按Enter发送”，但实际需要先粘贴，所以补充Ctrl+V）
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
return