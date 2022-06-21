function init()
    m.playButton = m.top.findNode("playVideoButton")
    m.ratingLabel = m.top.findNode("artScreenRatingLabel")
    m.pokemonSplashArtPoster = m.top.findNode("pokemonPoster") 
    m.firstChild = 0
    m.top.observeField("contenturi","updatePoster")
    m.top.observeField("pokemonratinglabel", "updateRatingLabel")
    getRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
    observePlayButton()
end function


function observePlayButton()
    m.playButton.observeField("buttonSelected","onPlayButtonClick")
end function

function onPlayButtonClick()
    m.videoComponent = CreateObject("roSGNode","VideoComponent")
    m.videoComponent.videoContent = m.videoContent
    m.top.appendChild(m.videoComponent)
    m.videoComponent.setFocus(true)
end function

function onVideoComponentUpdate(event as Object)
    print event.getData()
end function

function getRequest(uri as String)
    requestContent = CreateObject("roSGnode","RequestVideoTask")
    requestContent.observeField("getRequestContent","saveRequestContent")
    requestContent.serveruri = uri
    requestContent.control = "RUN"
end function

function saveRequestContent(event as Object)
    m.videoContent = event.getData().getChild(m.firstChild)
    updateButton(m.videoContent.title)
end function

function updateButton(buttonText as string)
    m.playButton.text = buttonText
end function

function updatePoster(event as Object)
    data = event.getData()
    m.pokemonSplashArtPoster.uri = data
end function

function updateRatingLabel(event as Object)
    data = event.getData()
    m.ratingLabel.text = data.text
    m.ratingLabel.visible = data.visible
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if(key = "back")
            closeArtScreen()
        end if
    end if
    return true
end function

function closeArtScreen()
    parent = m.top.getparent()
    parent.removeChildIndex(parent.getChildCount()-1)
    rowList = parent.findNode("PokemonRowList")
    rowList.setFocus(true)
end function
