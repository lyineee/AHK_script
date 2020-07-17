SendMode("Input")
SetWorkingDir(A_ScriptDir)

!s::{
    Run('sharex.exe -workflow  "OCR offline" -s -autoclose',,"Min")
}
