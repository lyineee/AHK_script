#DllLoad httpHelper.dll

UrlEscape("类型: 整数指定一个 0 到 255 之间的数字, 以将缓冲中的每个字节设置为该数字..在不需要先读取缓冲而直接写入的情况下, 通常应将其省略, 因为它的时间开销与字节数成正比. 如果省略, 则不初始化缓冲的内存; 每个字节的值是任意的..")
MsgBox(UrlEscape("https://wyagd001.github.io/v2/docs/objects/Buffer.htm"))
; MsgBox(HttpGet("http://bing.com"))

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

HttpGet(url){
    buffobj :=StrToByte(url)
    retBuffer := DllCall("httpHelper\HttpGet","Ptr", buffobj.Ptr, "Ptr")
    ret:= StrGet(retBuffer, "utf-8")
    return ret
}