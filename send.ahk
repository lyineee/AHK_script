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
    A_Clipboard := prevClipboard
    ;Msgbox clipboard
	
    reg_result := RegExMatch(clipboard, "^((https?:\/\/)?(([a-zA-Z0-9]+-?)+[a-zA-Z0-9]+\.)+[a-zA-Z]+)(:\d+)?(\/.*)?(\?.*)?(#.*)?$") ; url?
	send_text := UriEncode(clipboard) ;encode for transmition 

    if !(reg_result = 0){
        http("get","https://api.day.app/" key "/" send_text "?url=" clipboard)
		return
    }

    http("get","https://api.day.app/" key "/" send_text "?automaticallyCopy=1")
	return	
}

; http request function
http(method, url, oData := "", oHeaders := "") {
    static whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open(method, url, true)
    
    if !(IsSpace(oHeaders)){
        for k, v in oHeaders {
            whr.SetRequestHeader(k, v)
        }
    }
    if (method ~= "i)POST|PUT") && !oHeaders["Content-Type"] {
        whr.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    }
    sData := ""
    if IsObject(oData) {
        for k, v in oData {
            sData .= "&" k "=" v
        }
        sData := SubStr(sData, 2)
    }
    
    whr.Send(sData)
    whr.WaitForResponse()
return whr.ResponseText
}

; url encode function
UriEncode(Uri, RE:="[0-9A-Za-z]"){
    Var:=BufferAlloc(StrPut(Uri,"UTF-8"),0)
    StrPut(Uri,Var,,"UTF-8")
    Res:=""
    While Code:=NumGet(Var,A_Index-1,"UChar")
    Res.=(Chr:=Chr(Code))~=RE?Chr:Format("%{:02X}",Code)
    Return Res
}
