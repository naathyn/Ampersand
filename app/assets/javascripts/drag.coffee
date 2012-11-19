$ (dragItem) ->
  window.dragInit = (event, id) ->
    dragItem.node = document.getElementById(id)
    x = event.clientX + window.scrollX
    y = event.clientY + window.scrollY
    dragItem.cursorStartX  = x
    dragItem.cursorStartY  = y
    dragItem.nodeStartLeft = parseInt(dragItem.node.style.left, 10)
    dragItem.nodeStartTop  = parseInt(dragItem.node.style.top , 10)

    if isNaN(dragItem.nodeStartLeft)
     dragItem.nodeStartLeft = 0
    if isNaN(dragItem.nodeStartTop)
     dragItem.nodeStartTop  = 0

    dragItem.node.style.zIndex = ++dragItem.zIndex
    document.addEventListener "mousemove", dragProc
    document.addEventListener "mouseup"  , dragHalt

    event.preventDefault()
  
  window.dragProc = (event) ->
    x = event.clientX + window.scrollX
    y = event.clientY + window.scrollY
    dragItem.node.style.left = (dragItem.nodeStartLeft + x - dragItem.cursorStartX) + "px"
    dragItem.node.style.top  = (dragItem.nodeStartTop  + y - dragItem.cursorStartY) + "px"

    event.preventDefault()

  window.dragHalt = (event) ->
    document.removeEventListener "mousemove", dragProc
    document.removeEventListener "mouseup"  , dragHalt
