// (c) Michael Buro 1992-2002, licensed under the GNU Public License, version 2

#ifndef NNPATT_H
#define NNPATT_H

#include "nnm.h"
#include "nnentry.h"

struct PatternInfo {
  int sq[100];
  char *name;
  bool one_phase;
  int sub_list[64];
};


class Pattern {

public:

  enum { MAX_LEN = 16 };

  char  *name;
  int   sq[100];
  int   perms[8][MAX_LEN+1];
  int   perm_num;
  int   len;
  bool  one_phase;
  Entry *tab;
  int   trans_num;
  int   sq_lists[8][MAX_LEN+1];
  int   sub_list[MAX_LEN+1];
  Pattern *p_sub;

  Pattern();

  void init(PatternInfo &pinf);
  void asc_write(FILE *fp);
  void bin_write(FILE *fp);
  bool bin_read(FILE *fp);
  bool bin_write_freq(FILE *fp, int n);
  int sub_index(int ind);

  static void conf_write(FILE *fp, int l, int n);

};


class Patterns : public vector<Pattern> {};

#endif
