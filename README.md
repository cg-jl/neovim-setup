# Neovim in Lua


I've taken the opportunity to rewrite my config in Lua, therefore
cleaning it up. Using this opportunity to learn a bit of fennel, a
lisp-like lua, I've written all my configuration in this language, and
all the config is under [`fnl/`](./fnl), the stuff in [`lua/`](./lua) has been compiled via the `fennel` tool
and the [`makefile`](./makefile) that you can see.

Fennel is very readable even if you don't really know how to write it, so if you want
to take inspiration of my config, you will have no problem on reading it, just don't take the
brackets into account.

Also note that the `fnl/` directory is mirrored into the `lua/` directory, except for the `lua/<dir>/init.lua` files which are generated
by the makefile automatically so I don't miss any `require`s. The only job of those files is to source everything under the directory.


# Dependencies

The only dependency here is `neovim` version `0.5+`.
