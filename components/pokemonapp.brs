function init()
    m.focusedItemIndex = 1
    m.firstChild = 0
    m.focusedPokemonIndex = 0
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.ratingLabel = m.top.FindNode("ratingLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.pokeList = m.top.FindNode("PokemonRowList")
    m.pokeRatingList = m.top.FindNode("StarsList")
    m.registry = CreateObject("roRegistrySection","PokemonAppRegistry")
    getRequest("http://my-json-server.typicode.com/bogdanterzea/pokemon-server/photos")
end function

function getRequest(uri as String)
    m.requestContent = CreateObject("roSGnode","RequestTask")
    m.requestContent.observeField("getRequestContent","saveContent")
    m.requestContent.serveruri = uri
    m.requestContent.control = "RUN"
end function

function saveContent(event as Object)
    serverContent = event.getData()
    createPokeList(serverContent)
end function

function createPokeList(listRow as Object)
    newPokemonContent = CreateObject("roSGNode", "ContentNode")
    newPokemonContent.appendChild(listRow)
    m.pokeList.content = newPokemonContent
    m.pokeList.setFocus(true)
    displayPokemonRating()
    observePokeList()
end function

function observePokeList()
    m.pokeList.observeField("rowItemFocused","onPokemonFocus")
    m.pokeList.observeField("rowItemSelected", "onPokemonSelect")
end function

function observeRatingList()
    m.pokeRatingList.observeField("rowItemSelected", "onRatingSelect")
end function

function onRatingSelect(event as Object)
    data = event.getData()
    ratingScore = data[m.focusedItemIndex] + 1
    currentRow = m.pokeList.content.getChild(m.firstChild)
    selectedPokemon = currentRow.getChild(m.focusedPokemonIndex)
    selectedPokemon.pokemonRating = ratingScore
    m.registry.Write(selectedPokemon.pokemonID.ToStr(),ratingScore.ToStr())
    m.registry.Flush()
    m.pokeList.setFocus(true)
end function

function onPokemonFocus(event as Object)
    data = event.GetData()
    currentRow = m.pokeList.content.getChild(m.firstChild)
    m.focusedPokemonIndex = data[m.focusedItemIndex]
    selectedPokemon = currentRow.getChild(m.focusedPokemonIndex)

    if(selectedPokemon.pokemonRating = 0)
        m.ratingLabel.visible = false
    else
        m.ratingLabel.visible = true
        m.ratingLabel.text = substitute("Current pokemon rating is {0}", selectedPokemon.pokemonRating.ToStr())
    end if
    updateText(selectedPokemon)
end function

function onPokemonSelect(event as Object)
    data = event.GetData()
    currentRow = m.pokeList.content.getChild(m.firstChild)
    selectedPokemon = currentRow.getChild(m.focusedPokemonIndex)
    pokemonSplashArt = CreateObject("roSGNode", "PokeArtScreen")
    createPokemonSplashArt(pokemonSplashArt, selectedPokemon)
end function

function updateText(selectedPokemon as Object)
    m.titleLabel.text = selectedPokemon.title
    m.descriptionLabel.text = selectedPokemon.pokemonDescription
end function

function createPokemonSplashArt(splashArtObject as Object, selectedPokemon as dynamic)
    splashArtObject.contenturi = selectedPokemon.pokemonBGImage
    m.pokeList.setFocus(false)
    m.top.appendChild(splashArtObject)
    splashArtObject.setFocus(true)
end function

function displayPokemonRating()
    rating = CreateObject("roSGNode","StarRatingContentNode")
    m.pokeRatingList.content = rating
    observeRatingList()
end function 

function defineFocus() as integer
    currentRow = m.pokeList.content.getChild(m.firstChild)
    selectedPokemon = currentRow.getChild(m.focusedPokemonIndex)

    if(selectedPokemon.pokemonRating = 0)
        return 0
    else
        return selectedPokemon.pokemonRating - 1
    end if
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if(key = "up" AND m.pokeList.hasFocus())
            m.pokeRatingList.setFocus(true)
            m.pokeRatingList.jumpToRowItem = [0, defineFocus()]
        end if
        if(key = "down" AND m.pokeRatingList.hasFocus())
            m.pokeList.setFocus(true)
        end if
    end if
    return true
end function