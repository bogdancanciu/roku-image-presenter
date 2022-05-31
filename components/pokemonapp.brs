function init()
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.pokeList = m.top.FindNode("PokemonRowList")
    initTextFields()
    getRequest("http://my-json-server.typicode.com/bogdanterzea/pokemon-server/photos")
end function

function initTextFields()
    m.titleLabel.translation = [0.0,20]
    m.descriptionLabel.wrap = true
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
    m.pokeList.observeField("rowItemFocused","parsePokeData")
end function

function parsePokeData(event as Object)
    data = event.GetData()
    pokemonIndex = data[1]
    selectedPokemon = m.pokeList.content.getChild(0).getChild(pokemonIndex)
    titleFromData = selectedPokemon.title
    descriptionFromData = selectedPokemon.pokemonDescription
    updateText(titleFromData, descriptionFromData)
end function

function updateText(title as String, description as String)
    m.titleLabel.text = title
    m.descriptionLabel.text = description
end function
