function init()
    m.firstResult = 0
    m.top.functionName = "execute"
end function

function execute()
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    getRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    getRequest.InitClientCertificates()
    response = ParseJson(getRequest.GetToString())
    m.top.getRequestContent = createVideoNode(response)
end function

function createVideoNode(serverContent as Object) as Object
    content = createObject("roSGNode", "ContentNode")
    videoData = serverContent[m.firstResult]
    content.id = videoData.id
    content.title = videoData.title
    content.url = videoData.stream.url
    content.streamformat = videoData.stream.format
    content.HDPosterUrl = videoData.poster
    return content
end function
