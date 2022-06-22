sub restoreTo(componentToFocus as String)
    parent = m.top.getparent()
    lastChild = parent.getChildCount()-1
    parent.removeChildIndex(lastChild)
    itemToFocus = parent.findNode(componentToFocus)
    itemToFocus.setFocus(true)
end sub
