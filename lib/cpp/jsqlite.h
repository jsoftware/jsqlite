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

#endif
