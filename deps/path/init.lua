--[[

Copyright 2014-2015 The Luvit Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

--]]

exports.name = "luvit/path"
exports.version = "1.0.0-1"
exports.dependencies = {
  "luvit/core@1.0.2",
  "luvit/los@1.0.0",
}
exports.license = "Apache 2"
exports.homepage = "https://github.com/luvit/luvit/blob/master/deps/path"
exports.description = "A port of node.js's path module for luvit."
exports.tags = {"luvit", "path"}

local los = require('los')
local path_base = require('./base')

local function setup_meta(ospath)
  local path = exports
  path._internal = ospath
  setmetatable(path, {__index = function(_, key)
    if type(path._internal[key]) == 'function' then
      return function(...)
        return path._internal[key](path._internal, ...)
      end
    else
      return path._internal:_get(key)
    end
  end
  })
  return path
end

if los.type() == "win32" then
  return setup_meta(path_base.nt)
else
  return setup_meta(path_base.posix)
end
