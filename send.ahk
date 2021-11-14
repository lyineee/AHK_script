#DllLoad httpHelper.dll

global key := "your_private_key"
icon := "https://cdn-icons-png.flaticon.com/512/610/610021.png"
group := "来自PC"

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

    HttpGet("https://api.day.app/" key "/" UrlEscape(send_text) "?group=" group "&icon=" icon)
    return	
}

StrToByte(str){
    buffobj := Buffer(StrPut(str, "utf-8"))
    StrPut(str, buffobj, "utf-8")
    return buffobj
}

UrlEscape(url){
    buffobj :=StrToByte(url)
    retBuffer := DllCall("httpHelper\Quote","Ptr", buffobj.Ptr,"Ptr")
    escapeUrl:= StrGet(retBuffer, "utf-8")
    return escapeUrl
}

; http request function
HttpGet(url){
    buffobj :=StrToByte(url)
    retBuffer := DllCall("httpHelper\HttpGet","Ptr", buffobj.Ptr, "Ptr")
    ret:= StrGet(retBuffer, "utf-8")
    return ret
}
