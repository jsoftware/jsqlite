#ifndef JEXT_H
#define JEXT_H

#if defined(_WIN64)||defined(__LP64__)
typedef long long I;
#define SZI 8
#else
typedef long I;
#define SZI 4
#endif

#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <vector>
#include "util.h"
#include "../c/sqlite3.h"

using namespace std;

extern bool DEBUG;
#ifndef ANDROID
#define Debug(x) if (DEBUG) x;
#else
#include <android/log.h>
#define Debug(x) if (DEBUG) __android_log_write(ANDROID_LOG_DEBUG,"libjsqlite3",(x).c_str())
#endif

extern I NullInt;
extern double NullFloat;
extern char* NullText;

extern "C" {
  int sqlite3_extopen(const char *, sqlite3 **, int, I, double, const char *, const char *);
  int sqlite3_extversion();
  int sqlite3_exec_values(sqlite3_stmt*, int, int, int*, int*, char*);
  int sqlite3_free_values(void **);
  int sqlite3_read_values(sqlite3_stmt *, void **);
  int sqlite3_select_values(sqlite3_stmt*, void **, int, int*, int*, char*);
}

#endif
