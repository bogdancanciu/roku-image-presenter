function init()
    m.top.functionName = "getcontent"
end function

function getcontent()
    content = createObject("roSGNode", "ContentNode")
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    response = getRequest.GetToString()
    m.top.getRequestContent = response
end function