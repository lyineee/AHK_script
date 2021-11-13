global key := "your_private_key"

!c::{
    ; get send text
    prevClipboard := A_Clipboard
    A_Clipboard := ""
    Send ("^c")
    if(ClipWait(0.5)){
        clipboard := A_Clipboard
    }else if (IsSpace(prevClipboard)){
        A_Clipboard := ""
        TrayTip("didnt select any text","AHK error")
        return
    }else{
        clipboard:=prevClipboard
    }
    send_text := clipboard
    A_Clipboard := prevClipboard
    ;Msgbox clipboard

    barkhttp(key, send_text)
    return	
}

; http request function
barkhttp(token, title) {
    exitCode := RunWait("cmd.exe /c barkHelper.exe" " " token " " title ,,"Hide")
    Return exitCode
}
