function init()
    m.top.observeField("contenturi","updatePoster")
    m.pokemonSplashArtPoster = m.top.findNode("pokemonPoster")
end function

function updatePoster(event as Object)
    data = event.getData()
    m.pokemonSplashArtPoster.uri = data
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if(key = "back")
            parent = m.top.getparent()
            parent.removeChildIndex(parent.getChildCount()-1)
            rowList = parent.findNode("PokemonRowList")
            rowList.setFocus(true)
        end if
    end if
    return true
end function