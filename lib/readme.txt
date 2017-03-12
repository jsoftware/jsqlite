
The jsqlite addon is an extension of Sqlite that enables much faster reads
than the earlier ddsqlite addon. The better speed is because looping over
the records read is done in the extension, rather than in J.

To recompile, first build the Sqlite engine in sqlite/lib/c, then build
the extension in sqlite/lib/cpp.
