/* util.cpp  */

#include "util.h"

// ---------------------------------------------------------------------
// fundamental datatypes:
// SQLITE_INTEGER  1
// SQLITE_FLOAT    2
// SQLITE_TEXT     3
// SQLITE_BLOB     4
// SQLITE_NULL     5
//
// The affinity of a column is determined by the declared type of the
// column, according to the following rules in the order shown:
//
// If the declared type contains the string "INT" then it is assigned
// INTEGER affinity.
//
// If the declared type of the column contains any of the strings "CHAR",
// "CLOB", or "TEXT" then that column has TEXT affinity. Notice that the
// type VARCHAR contains the string "CHAR" and is thus assigned TEXT
// affinity.
//
// If the declared type for a column contains the string "BLOB" or if no
// type is specified then the column has affinity BLOB.
//
// If the declared type for a column contains any of the strings "REAL",
// "FLOA", or "DOUB" then the column has REAL affinity.
//
// Otherwise, the affinity is NUMERIC.
// standard affinities, except that empty is null, not blob
// return 5 if not recognized
int decl2type(const char *s)
{
  if (s==0) return 5;
  int len=strlen(s);
  if (len==0) return 5;
  string t;
  for (int i=0; i<len; i++)
    t.push_back(tolower(s[i]));
  if (has(t,"int")) return 1;
  if (has(t,"char") || has(t,"clob") || has(t,"text")) return 3;
  if (has(t,"blob")) return 4;
  if (has(t,"doub") || has(t,"floa") || has(t,"real")) return 2;
  return 5;
}

// ---------------------------------------------------------------------
int error(string s)
{
  Debug(cout << ("error: " + s) << endl);
  return 1;
}

// ---------------------------------------------------------------------
bool has(string s,string t)
{
  return string::npos != s.find(t);
}

// ---------------------------------------------------------------------
bool has(vector<int> s,int t)
{
  for (int i=0; i<s.size(); i++)
    if (t==s[i]) return true;
  return false;
}

// ---------------------------------------------------------------------
// integer to string
string i2s(int i)
{
  stringstream s;
  s << i;
  return s.str();
}
