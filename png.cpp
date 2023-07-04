// png support
#include <lua.h>
#include <lauxlib.h>

#include <png.h> // system

#include "png.hpp" // lua module

static int png_load ( lua_State *L ) { // load PNG {{{
  return 1;
} // }}}

static int png_drop ( lua_State *L ) { // drop PNG {{{
  return 1;
} // }}}

static int png_gauge ( lua_State *L ) { // PNG measurement {{{
  // mearure from the center (h/v)
  return 1;
} // }}}

static const struct luaL_Reg lua_png_m[] = { // metatable {{{
  // {"__call", call    }, // setting/manual
  {"gauge", png_gauge}, // measurement
  {"load",  png_load }, // read
  {"drop",  png_drop }, // write
  {"ver", NULL},
  {"lic", NULL},
  {NULL, NULL}
}; // }}}

LUA_API int luaopen_png ( lua_State *L ) { // {{{
  luaL_newlib(L, lua_png_m); // cet metatable
  lua_pushstring(L, "PNG (" MD5 ") " OPT);
  lua_setfield(L, -2, "ver");
  lua_pushstring(L, "LUA " LUA_VDIR " / MIT (c) " __DATE__);
  lua_setfield(L, -2, "lic");
  return 1;
} // }}}
