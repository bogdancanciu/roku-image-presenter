function init()
    m.ratingLabel = m.top.findNode("artScreenRatingLabel")
    m.pokemonSplashArtPoster = m.top.findNode("pokemonPoster") 
    m.top.observeField("contenturi","updatePoster")
    m.top.observeField("pokemonratinglabel", "updateRatingLabel")
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
