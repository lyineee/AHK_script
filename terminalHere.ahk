!t::
{
    if(WinGetProcessName("A")="explorer.exe"){
        Send "{Alt Down}d{Alt Up}"
        Send "wt -d ."
        Send "{Enter}"
        Exit
    }
}