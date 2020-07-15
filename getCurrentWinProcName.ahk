#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

!q:: ;alt + q
{
    uniId:=WinExist("a")
    title:=WinGetTitle("A")
    procName:=WinGetProcessName("A")
    MsgBox(procName)
    Clipboard:=procName
}