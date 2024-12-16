#Requires AutoHotkey v2.0+

; Hotkey support
Alt & M::MoveWindowToPrimary()  ; Alt + M to move window to primary screen
Alt & N::MoveWindowToSecondary()  ; Alt + N to move window to secondary screen

; Create tray menu
; A_TrayMenu.Delete  ; Clear default menu items
; A_TrayMenu.Add("Move to Primary", MoveWindowToPrimary)
; A_TrayMenu.Add("Move to Secondary", MoveWindowToSecondary)
A_TrayMenu.Add()  ; Add separator
A_TrayMenu.Add("Exit", (*) => ExitApp())

; Get monitor information
GetMonitorInfo() {
    monitorCount := SysGet(80)  ; 80 is the system metric value for MonitorCount
    monitors := []
    Loop monitorCount {
        workArea := []
        MonitorGetWorkArea(A_Index, &left, &top, &right, &bottom)
        monitor := {}
        monitor.Left := left
        monitor.Top := top
        monitor.Right := right
        monitor.Bottom := bottom
        monitors.Push(monitor)
    }
    return monitors
}

; Move window to primary screen
MoveWindowToPrimary(*) {
    monitors := GetMonitorInfo()
    if (monitors.Length < 2) {
        MsgBox("Only one monitor detected. Cannot move window.")
        return
    }

    ; Get handle of active window
    activeWin := WinExist("A")
    if !activeWin {
        MsgBox("No active window found.")
        return
    }

    ; Get primary screen position
    mainMonitor := monitors[1]
    x := mainMonitor.Left
    y := mainMonitor.Top

    ; Move window to primary screen
    WinMove(x, y,,, activeWin)
}

; Move window to secondary screen
MoveWindowToSecondary(*) {
    monitors := GetMonitorInfo()
    if (monitors.Length < 2) {
        MsgBox("Only one monitor detected. Cannot move window.")
        return
    }

    ; Get handle of active window
    activeWin := WinExist("A")
    if !activeWin {
        MsgBox("No active window found.")
        return
    }

    ; Get secondary screen position
    secondaryMonitor := monitors[2]
    x := secondaryMonitor.Left
    y := secondaryMonitor.Top

    ; Move window to secondary screen
    WinMove(x, y,,, activeWin)
}
