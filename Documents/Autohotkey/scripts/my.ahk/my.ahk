; 添加 Ctrl+Alt+R 重启脚本功能
^!r:: Reload

CapsLock::ESC
Esc::CapsLock

#HotIf WinGetTitle("A") == "neovim"
^[::^!F10
^Space::^!F12
^h::^!F8
^.::^!F7
#HotIf

#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp:: Send "{Volume_Up}"
WheelDown:: Send "{Volume_Down}"
#HotIf

#HotIf WinExist("neovim-explorer")
$Space::
{
	; 创建一个输入钩子，L1=长度1，T0.1=超时0.1秒
	ih := InputHook("L1 T0.15")
	ih.Start()
	ih.Wait()

	; 判断结果
	if (ih.Input = "e") {
		Send "q"
	} else if (ih.EndReason = "Timeout") {
		Send "{Space}"
	} else {
		; 如果按了其他键，发送 空格 + 该键
		Send "{Space}" . ih.Input
	}
}
#HotIf
MouseIsOver(WinTitle) {
	MouseGetPos , , &Win
	return WinExist(WinTitle " ahk_id " Win)
}

; Ctrl+Alt+K 切换 KeePassXC
^!k:: {
	; 检查是否存在KeePassXC程序
	If ProcessExist("KeePassXC.exe") {
		if WinExist("KeePassXC") {
			WinMinimize
		} else {
			Run "keepassxc.exe"
		}
	} Else {
		; 如果程序不存在，运行KeePassXC
		Run "keepassxc.exe"
	}
	Return
}

; Alt+W 关闭 Chrome 标签页
#HotIf WinActive("ahk_class Chrome_WidgetWin_1")
!w:: Send "^w"
#HotIf
