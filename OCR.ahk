SendMode("Input")
SetWorkingDir(A_ScriptDir)

!s::{
    Run('sharex -workflow  "OCR offline" -s -autoclose',,"Min")
}
