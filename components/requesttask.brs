function init()
    m.top.functionName = "getcontent"
end function

function getcontent()
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    response = ParseJson(getRequest.GetToString())
    createNodes(response)
end function

function createNodes(serverContent as object)
    m.content = createObject("roSGNode", "ContentNode")
    for each pokemon in serverContent:
        currentPokemon = m.content.createChild("PokemonContentNode")
        currentPokemon.pokemonID = pokemon.id
        currentPokemon.pokemonTitle = pokemon.title
        currentPokemon.pokemonDescription = pokemon.description
        currentPokemon.pokemonBGImage = pokemon.image_1080_url
        currentPokemon.pokemonImage = pokemon.url
    end for
    m.top.getRequestContent = m.content
end function