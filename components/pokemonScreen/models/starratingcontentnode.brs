function init()
    m.ratingStarsNumber = 5

    m.rowNode = m.top.FindNode("rowNode")
    
    appendStars()
end function

function appendStars()
    for x = 1 to m.ratingStarsNumber
        rowItem = CreateObject("roSGNode","ContentNode")
        rowItem.HDPosterUrl = "pkg:/images/rate-star.png"
        m.rowNode.appendChild(rowItem)
    end for
end function