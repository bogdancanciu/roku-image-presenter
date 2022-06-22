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
    videoData = serverContent[m.firstResult]
    content.id = videoData.id
    content.title = videoData.title
    content.url = videoData.stream.url
    content.streamformat = videoData.stream.format
    content.HDPosterUrl = videoData.poster
    m.top.getRequestContent = content
end function
