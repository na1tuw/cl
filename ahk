; AutoHotkey v2 鼠标持续上滑脚本
; 热键说明：F1 = 启动/暂停 | F2 = 退出脚本

; 全局变量：控制滚动启停状态
global isRunning := false

; 滚动参数配置（可根据需要调整）
ScrollStep := 1    ; 每次滚轮上滑的步长（1=常规，数值越大滚动越快）
SleepTime := 10    ; 每次滚动后的间隔时间（毫秒），数值越小滚动越频繁

; 注册F1热键：切换滚动启停状态
F1::
{
    global isRunning
    isRunning := !isRunning  ; 取反状态（启动↔暂停）
    
    if (isRunning)
    {
        ToolTip("鼠标上滑已启动（F1暂停 | F2退出）",, 1)  ; 显示提示框
        SetTimer(ScrollMouseUp, SleepTime)  ; 启动定时器，按间隔执行滚动
    }
    else
    {
        ToolTip("鼠标上滑已暂停（F1启动 | F2退出）",, 1)
        SetTimer(ScrollMouseUp, 0)  ; 停止定时器
    }
    SetTimer(ToolTip, -2000)  ; 2秒后自动关闭提示框
}

; 注册F2热键：退出脚本
F2::
{
    global isRunning
    isRunning := false
    SetTimer(ScrollMouseUp, 0)  ; 确保定时器停止
    ToolTip("脚本已退出",, 1)
    SetTimer(ToolTip, -1000)
    ExitApp()  ; 退出程序
}

; 核心函数：发送鼠标滚轮上滑指令
ScrollMouseUp()
{
    global isRunning
    if (!isRunning)
        return  ; 如果已暂停，直接返回
    
    ; 发送鼠标滚轮上滑事件（第二个参数是步长）
    SendEvent("{WheelUp " ScrollStep "}")
}

; 脚本启动提示
ToolTip("鼠标上滑脚本已加载（F1启动 | F2退出）",, 1)
SetTimer(ToolTip, -2000)
