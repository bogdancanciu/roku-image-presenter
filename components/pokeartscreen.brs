function init()
    m.playButton = m.top.findNode("playVideoButton")
    m.ratingLabel = m.top.findNode("artScreenRatingLabel")
    m.pokemonSplashArtPoster = m.top.findNode("pokemonPoster") 
    m.firstChild = 0
    m.top.observeField("contenturi","updatePoster")
    m.top.observeField("pokemonratinglabel", "updateRatingLabel")
    getRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
end function


function observePlayButton()
    print "..."
    print m.playButton
    m.playButton.observeField("buttonSelected","onPlayButtonClick")
end function

function onPlayButtonClick()
    print "clicked"
end function

function getRequest(uri as String)
    m.requestContent = CreateObject("roSGnode","RequestVideoTask")
    m.requestContent.observeField("getRequestContent","saveRequestContent")
    m.requestContent.serveruri = uri
    m.requestContent.control = "RUN"
end function

function saveRequestContent(event as Object)
    videoContent = event.getData().getChild(m.firstChild)
    updateButton(videoContent.title)
    observePlayButton()
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
        print m.top.hasFocus()
        print m.ratingLabel.hasFocus()
    end if
    return true
end function

function closeArtScreen()
    parent = m.top.getparent()
    parent.removeChildIndex(parent.getChildCount()-1)
    rowList = parent.findNode("PokemonRowList")
    rowList.setFocus(true)
end function
