function init()
    m.video = m.top.findNode("serverVideo")

    observeContentField()
end function

function observeContentField()
    m.top.observeField("videoContent","updateVideoContent")
end function

function updateVideoContent(event as Object)
    m.video.content = event.getData()
    m.video.control = "play"
    observeVideoState()
end function

function observeVideoState()
    m.video.observeField("state","onVideoStateChange")
end function

function onVideoStateChange(event as Object)
    data = event.getData()

    if data = "finished"
        closeVideoScreen()
    end if
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if key = "back"
            m.video.control = "stop"
            restoreTo("playVideoButton")
        end if
    end if
    return true
end function