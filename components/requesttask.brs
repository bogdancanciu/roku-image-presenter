function init()
    m.top.functionName = "getcontent"
end function

function getcontent()
    content = createObject("roSGNode", "ContentNode")
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    response = ParseJson(getRequest.GetToString())
    for each pokemon in response:
        currentPokemon = content.createChild("PokemonContentNode")
        currentPokemon.pokemonID = pokemon.id
        currentPokemon.pokemonTitle = pokemon.title
        currentPokemon.pokemonDescription = pokemon.description
        currentPokemon.pokemonBGImage = pokemon.image_1080_url
        currentPokemon.pokemonImage = pokemon.url
    end for
    m.top.getRequestContent = content
end function