// png support
#include <png.h> // system

#include "png.hpp" // lua module

static const struct luaL_Reg lua_png_m[] = { // metatable {{{
  // {"__call", call    }, // setting/manual
  // {"load"  , load    }, // read
  // {"drop"  , drop    }, // write
  {NULL, NULL}
}; // }}}

LUA_API int luaopen_cetcore ( lua_State *L ) { // {{{
  lua_createtable(L, 0, 8);

  luaL_newlib(L, lua_png_m); // cet metatable
  lua_pushvalue(L, -1); lua_setfield(L, -2, "__index");
  lua_pushstring(L, "PNG (" MD5 ") " OPT); lua_setfield(L, -2, "__metatable");
  lua_pushstring(L, "LUA " LUA_VDIR " / MIT (c) " __DATE__); lua_setfield(L, -2, "lic");
  lua_setmetatable(L, -2);

  return 1;
} // }}}
