
The jsqlite addon is an extension of Sqlite that enables much faster read/write
than the earlier ddsqlite addon. The better speed is because looping is done in
the extension, rather than in J.

To recompile, first build the Sqlite engine in sqlite/lib/c, then build
the extension in sqlite/lib/cpp.

To cross-compile 32-bit binaries, pass M32=-m32 to make.
$ make M32=-m32
