hs.loadSpoon("MiroWindowsManager")

local hyper = {"ctrl", "alt", "cmd"}

hs.window.animationDuration = 0.2
spoon.MiroWindowsManager:bindHotkeys({
    up = {hyper, "k"},
    right = {hyper, "l"},
    down = {hyper, "j"},
    left = {hyper, "h"},
    fullscreen = {hyper, "m"},
    nextscreen = {hyper, "n"}
  })
spoon.MiroWindowsManager.fullScreenSizes = { 1, 2 }
spoon.MiroWindowsManager.sizes = { 2, 3, 4, 3/2, 4/3 }

-- Hold mouse 4 button and scroll with pointer, good with trackball mouse 
-- https://github.com/pqrs-org/Karabiner-archived/issues/814#issuecomment-290100483

-- positive multiplier (== natural scrolling) makes mouse work like traditional scrollwheel
local scrollmult = 6 

local mouseScrollCircle = nil

-- circle config
local mouseScrollCircleRad = 18

-- The were all events logged, when using `{"all"}`
mousetap = hs.eventtap.new({0,3,5,14,25,26,27}, function(e)
  local mods = hs.eventtap.checkKeyboardModifiers()
  local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])

  -- If OSX button 4 is pressed, allow scrolling
  if 4 == pressedMouseButton then
    if mouseScrollCircle == nil then
      -- save mouse coordinates
      local mouseScrollStartPos = hs.mouse.absolutePosition()

      mouseScrollCircle = hs.drawing.circle(hs.geometry.rect(mouseScrollStartPos.x - mouseScrollCircleRad, mouseScrollStartPos.y - mouseScrollCircleRad, mouseScrollCircleRad * 2, mouseScrollCircleRad * 2))
      mouseScrollCircle:setStrokeColor({["red"]=0.3, ["green"]=0.3, ["blue"]=0.3, ["alpha"]=1})
      mouseScrollCircle:setFill(false)
      mouseScrollCircle:setStrokeWidth(1)
      mouseScrollCircle:show()
    end

    local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
    local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
    local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
    scroll:post()
    
    return true, {scroll}
  else
    -- remove circle if exists
    if mouseScrollCircle then
      mouseScrollCircle:delete()
      mouseScrollCircle = nil
    end
    return false, {}
  end
end)
mousetap:start()
