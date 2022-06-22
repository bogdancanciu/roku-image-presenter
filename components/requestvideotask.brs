function init()
    m.top.functionName = "execute"
    m.firstResult = 0
end function

function execute()
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    getRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    getRequest.InitClientCertificates()
    response = ParseJson(getRequest.GetToString())
    createVideoNode(response)
end function

function createVideoNode(serverContent as object)
    content = createObject("roSGNode", "ContentNode")
    content.id = serverContent[m.firstResult].id
    content.title = serverContent[m.firstResult].title
    content.url = serverContent[m.firstResult].stream.url
    content.streamformat = serverContent[m.firstResult].stream.format
    content.HDPosterUrl = serverContent[m.firstResult].poster
    m.top.getRequestContent = content
end function
