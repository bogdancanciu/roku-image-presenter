function init()
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    initText()
end function

function initText()
    m.titleLabel.text = "Title of the current scene"
    m.titleLabel.translation = [0.0,20]
    m.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque in metus gravida, vulputate justo id, vulputate ligula. Donec nec nisl et dolor mollis malesuada sed ac diam. Vivamus purus est, tempus sit amet porttitor id, ornare fringilla nibh. Phasellus mauris sapien, lobortis eu augue eu, auctor cursus odio. Maecenas in ornare diam. Suspendisse eu lacus viverra, porta sapien eget, semper diam. Cras at blandit erat. Praesent at aliquet leo, sit amet posuere ante. Sed vehicula, tortor at congue bibendum, diam lectus aliquam neque, a sollicitudin nisl dui id risus. Praesent malesuada commodo feugiat. Donec libero velit, dapibus in tortor non, sodales lacinia arcu. Sed nec hendrerit dui. "
    m.descriptionLabel.wrap = true
end function
