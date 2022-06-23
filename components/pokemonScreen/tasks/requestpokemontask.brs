function init()
    m.top.functionName = "execute"
    m.registry = CreateObject("roRegistrySection","PokemonAppRegistry")
end function

function execute()
    getRequest = createObject("roUrlTransfer")
    getRequest.setUrl(m.top.serveruri)
    response = ParseJson(getRequest.GetToString())
    m.top.getRequestContent = createNodes(response)
end function

function createNodes(serverContent as Object) as Object
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

    return content
end function
