function init()
    observeContentField()
    m.video = m.top.findNode("serverVideo")
end function

function observeContentField()
    m.top.observeField("videoContent","updateVideoContent")
end function

function updateVideoContent(event as Object)
    m.video.content = event.getData()
    m.video.control = "play"
    observeVideoState()
end function

function closeVideoScreen()
    parent = m.top.getparent()
    lastChild = parent.getChildCount()-1
    parent.removeChildIndex(lastChild)
    playButton = parent.findNode("playVideoButton")
    playButton.setFocus(true)
end function

function observeVideoState()
    m.video.observeField("state","onVideoFinish")
end function

function onVideoFinish(event as Object)
    data = event.getData()
    if(data = "finished")
        closeVideoScreen()
    end if
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if(key = "back")
            closeVideoScreen()
        end if
    end if
    return true
end function