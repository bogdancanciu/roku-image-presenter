function init()
    m.top.functionName = "getcontent"
    m.firstResult = 0
end function

function getcontent()
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    print getRequest.getUrl()
    getRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    getRequest.InitClientCertificates()
    response = ParseJson(getRequest.GetToString())
    createVideoNode(response)
end function

function createVideoNode(serverContent as object)
    content = createObject("roSGNode", "ContentNode")
    firstVideoResult = content.createChild("ContentNode")
    firstVideoResult.id = serverContent[m.firstResult].id
    firstVideoResult.title = serverContent[m.firstResult].title
    firstVideoResult.url = serverContent[m.firstResult].stream.url
    firstVideoResult.streamformat = serverContent[m.firstResult].stream.format
    firstVideoResult.HDPosterUrl = serverContent[m.firstResult].poster
    m.top.getRequestContent = content
end function
