#Requires AutoHotkey v2.0

; 添加 Ctrl+Alt+R 重启脚本功能
^!r:: Reload

CapsLock::ESC
Esc::CapsLock
SetTitleMatchMode "RegEx"  ; 启用 RegEx 模式

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
#HotIf !ProcessExist("pot.exe")
!a:: {
	Run "C:\Program Files\pot\pot.exe"
	Sleep 1000  ; 等待1秒让程序启动
	send "!a"
}
!q:: {
	Run "C:\Program Files\pot\pot.exe"
	Sleep 1000  ; 等待1秒让程序启动
	send "!q"
}

#HotIf !ProcessExist("PixPin.exe")
F1:: {
	Run "D:\软件\PixPin\PixPin.exe"
	WinWait "PixPin"  ; 等待窗口出现
	Send "{F1}"
}
F2:: {
	Run "D:\软件\PixPin\PixPin.exe"
	WinWait "PixPin"  ; 等待窗口出现
	Send "{F2}"
}

#HotIf !ProcessExist("Ztools.exe")
!Space:: {
	Run "D:\软件\ZTools\ZTools.exe"
	WinWait "Ztools"  ; 等待窗口出现
	Send "!{Space}"
}

#HotIf WinActive("terminal$")
^.::^!F7

#HotIf WinActive("neovim$")
^[::^!F10
^Space::^!F12
^h::^!F8
^.::^!F7
!w:: {
	Send "{Space}"
	Sleep 50
	Send "c"
	return
}

#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp:: Send "{Volume_Up}"
WheelDown:: Send "{Volume_Down}"

#HotIf WinExist("neovim-explorer$")
^Space::^!F12
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

MouseIsOver(WinTitle) {
	MouseGetPos , , &Win
	return WinExist(WinTitle " ahk_id " Win)
}

; Alt+W 关闭 Chrome 标签页
#HotIf WinActive("ahk_class Chrome_WidgetWin_1")
!w:: Send "^w"

HasATLWindows() {
	idList := WinGetList()

	for thisID in idList {
		class := WinGetClass("ahk_id " thisID)

		if (InStr(class, "ATL")) {
			return true
		}
	}
	; 没有找到 ATL 窗口
	return false
}

#HotIf HasATLWindows()
$^Space:: {
	if WinActive("neovim$") {
		send("^{Space}")
	} else {
		Send("{Enter}")
		send("^{Space}")
	}
}

$Shift:: {
	if WinActive("neovim$") {
		send("^{Space}")
	} else {
		Send("{Enter}")
		send("^{Space}")
	}
}

#HotIf WinActive("ahk_exe explorer.exe")
!w:: Send "^w"

#HotIf not HasATLWindows() and not WinActive("neovim$")
$Shift:: send("^{Space}")
