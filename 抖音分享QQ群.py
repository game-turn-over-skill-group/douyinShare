import pyautogui
import psutil
import time
import win32gui


def get_window_title(pid):
    try:
        hwnd = win32gui.FindWindowEx(0, 0, None, None)
        while hwnd:
            if win32gui.GetWindowThreadProcessId(hwnd)[1] == pid:
                return win32gui.GetWindowText(hwnd)
            hwnd = win32gui.FindWindowEx(0, hwnd, None, None)
        return ''
    except Exception:
        return ''


def is_douyin_window_active():
    for proc in psutil.process_iter(['name']):
        if proc.info['name'] == 'Douyin.exe':
            window_title = get_window_title(proc.pid)
            if window_title:
                return True
    return False


def is_video_playing():
    for proc in psutil.process_iter(['name']):
        if proc.info['name'] == 'Douyin.exe':
            window_title = get_window_title(proc.pid)
            # 这里简单判断标题不为空就认为视频在播放，实际需完善
            return bool(window_title)
    return False


def copy_share_link():
    pyautogui.press('v')
    time.sleep(0.5)


def is_copy_successful():
    try:
        clipboard_content = pyautogui.hotkey('ctrl', 'c')
        return bool(clipboard_content)
    except Exception:
        return False


def switch_to_qq():
    pyautogui.hotkey('win', '7')


def share_link():
    pyautogui.hotkey('ctrl', 'v')
    pyautogui.press('enter')


def switch_back_to_douyin():
    pyautogui.hotkey('win', '6')


print('开始执行脚本')
if not is_douyin_window_active():
    print('当前窗口不是抖音，按win+6切换出抖音')
    pyautogui.hotkey('win', '6')
else:
    print('当前窗口是抖音')

if not is_video_playing():
    print('视频未处于播放状态，按空格键激活播放状态')
    pyautogui.press('space')
print('按V复制分享链接')
copy_share_link()

if not is_copy_successful():
    print('复制未成功，等待1秒后重试')
    time.sleep(1)
    print('再次按V复制链接')
    copy_share_link()
    time.sleep(0.5)
    print('按空格暂停')
    pyautogui.press('space')
else:
    print('复制成功，按空格暂停')
    pyautogui.press('space')

print('进入分享阶段，按WIN+7切换到QQ聊天窗口')
switch_to_qq()
print('按CTRL+V粘贴分享链接并按回车分享出去')
share_link()

print('回到抖音，按WIN+6切换回抖音窗口')
switch_back_to_douyin()

if not is_video_playing():
    print('抖音未处于播放状态，按空格')
    pyautogui.press('space')
print('结束脚本')
