// (c) Michael Buro 1992-2002, licensed under the GNU Public License, version 2

#include "regfeat.h"

Feature::Feature() { f = 0; bucket_num = 0; entries = 0; }

void Feature::init(FeatureInfo &finf)
{
  name = finf.name;
  f = finf.f;
  bucket_num = finf.bucket_num;
  one_phase = finf.one_phase;
  
  cout << "Feature(" << bucket_num << ") " << name << endl << endl;
  
  if (bucket_num <= 0) Error("Feature::init: bucket_num <= 0");
  entries = new Entry[bucket_num](one_phase);
  if (!entries) Error("Feature::init: no mem");

  int i;

  FOR (i, bucket_num) entries[i].alloc_esti();
}


void Feature::asc_write(FILE *fp)
{
  int i, k;
  
  FOR (k, bucket_num) {
    
    fprintf(fp, "%2d ", k);
    FOR (i, Entry::INTERVAL_NUM) fprintf(fp, " %+6.3f", entries[k].get_y(i));
    fprintf(fp, "\n");
  }
}


void Feature::bin_write(FILE *fp)
{
  int i, l;
  
  if (one_phase) Error("one phased features not supported yet");
  
  fputc(bucket_num, fp);
  fputc(Entry::INTERVAL_NUM, fp);
  fputc(Entry::DISC_MIN, fp);
  fputc(Entry::INTERVAL_LEN, fp);
  
  FOR (l, Entry::INTERVAL_NUM)
    FOR (i, bucket_num)
      entries[i].bin_write(fp, l);
}

bool Feature::bin_read(FILE *fp)
{
  int k, l;
  
  if (fgetc(fp) != bucket_num) return true;
  if (fgetc(fp) != Entry::INTERVAL_NUM) return true;
  if (fgetc(fp) != Entry::DISC_MIN)     return true;
  if (fgetc(fp) != Entry::INTERVAL_LEN) return true;
  
  FOR (l, Entry::INTERVAL_NUM)
    FOR (k, bucket_num) 
      entries[k].bin_read(fp, l);

  return false;
}

bool Feature::bin_write_freq(FILE *fp, int n)
{
  int k, l;
  
  if (n <= 0) Error("n <= 0");
  if (one_phase) Error("one phased features not supported yet");
  
  fputc(bucket_num, fp);
  fputc(Entry::INTERVAL_NUM, fp);
  fputc(Entry::DISC_MIN, fp);
  fputc(Entry::INTERVAL_LEN, fp);
  
  FOR (l, Entry::INTERVAL_NUM) {
    FOR (k, bucket_num) {
      int val = (entries[k].get_y(l) < n) * 512;
      fputc(val & 255, fp);
      fputc(val >> 8,  fp);
    }
  }
  
  return false;
}
