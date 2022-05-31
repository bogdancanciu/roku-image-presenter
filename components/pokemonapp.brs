function init()
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.pokeList = m.top.FindNode("PokemonRowList")
    initText()
    getRequest("http://my-json-server.typicode.com/bogdanterzea/pokemon-server/photos")
end function

function initText()
    m.titleLabel.text = "Title of the current scene"
    m.titleLabel.translation = [0.0,20]
    m.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque in metus gravida, vulputate justo id, vulputate ligula. Donec nec nisl et dolor mollis malesuada sed ac diam. Vivamus purus est, tempus sit amet porttitor id, ornare fringilla nibh. Phasellus mauris sapien, lobortis eu augue eu, auctor cursus odio. Maecenas in ornare diam. Suspendisse eu lacus viverra, porta sapien eget, semper diam. Cras at blandit erat. Praesent at aliquet leo, sit amet posuere ante. Sed vehicula, tortor at congue bibendum, diam lectus aliquam neque, a sollicitudin nisl dui id risus. Praesent malesuada commodo feugiat. Donec libero velit, dapibus in tortor non, sodales lacinia arcu. Sed nec hendrerit dui. "
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
    titleFromData = m.pokeList.content.getChild(0).getChild(data[1]).title
    descriptionFromData = m.pokeList.content.getChild(0).getChild(data[1]).pokemonDescription
    updateTitle(titleFromData)
    updateDescription(descriptionFromData)
end function

function updateTitle(title as String)
    m.titleLabel.text = title
end function

function updateDescription(description as String)
    m.descriptionLabel.text = description
end function
