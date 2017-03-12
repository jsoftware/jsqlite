#ifndef UTIL_H
#define UTIL_H

#include <jsqlite.h>
#include <sstream>

using namespace std;

bool has(string s,string t);
bool has(vector<int> s,int t);
int decl2type(const char *s);
int error(string);
string i2s(int);

#endif
