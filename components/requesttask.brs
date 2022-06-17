function init()
    m.top.functionName = "getcontent"
    m.registry = CreateObject("roRegistrySection","PokemonAppRegistry")
end function

function getcontent()
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    response = ParseJson(getRequest.GetToString())
    createNodes(response)
end function

function createNodes(serverContent as object)
    content = createObject("roSGNode", "ContentNode")
    for each pokemon in serverContent:
        currentPokemon = content.createChild("PokemonContentNode")
        currentPokemon.pokemonID = pokemon.id
        currentPokemon.title = pokemon.title
        currentPokemon.HDPosterUrl = pokemon.url
        currentPokemon.pokemonDescription = pokemon.description
        currentPokemon.pokemonBGImage = pokemon.image_1080_url
        registryValue = m.registry.Read(currentPokemon.pokemonID.ToStr()).ToInt()
        currentPokemon.pokemonRating = registryValue
    end for
    m.top.getRequestContent = content
end function