local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

vim
  :disableForApp('ITerm2')
  :bindHotKeys({enter = {{'ctrl'}, ';'}})
