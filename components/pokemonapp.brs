function init()
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.pokeList = m.top.FindNode("PokemonRowList")
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
    observePokeList()
end function

function observePokeList()
    m.pokeList.observeField("rowItemFocused","onPokemonFocus")
    m.pokeList.observeField("rowItemSelected", "onPokemonSelect")
end function

function onPokemonFocus(event as Object)
    data = event.GetData()
    pokemonIndex = data[1]
    selectedPokemon = m.pokeList.content.getChild(0).getChild(pokemonIndex)
    updateText(selectedPokemon)
end function

function onPokemonSelect(event as Object)
    data = event.GetData()
    pokemonIndex = data[1]
    selectedPokemon = m.pokeList.content.getChild(0).getChild(pokemonIndex)
    pokemonSplashArt = CreateObject("roSGNode", "PokemonSplashArt")
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
