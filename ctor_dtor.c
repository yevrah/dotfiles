#if 0
set -x

SOURCE=
OUT="${SOURCE/\.c/}"

echo "source: $SOURCE, out $OUT"

cc "$SOURCE" -std=c89 -Wall -o "$OUT" && "$OUT" $*
exit
#endif

include <stdlib.h> /* need malloc and friends */

/* this is the type of object we have, with a single int member */
typedef struct WIDGET_T {
  int member;
} WIDGET_T;

/* functions that deal with WIDGET_T */


/* constructor function */
void
WIDGETctor (WIDGET_T *this, int x)
{
  this->member = x;
}

/* destructor function */
void
WIDGETdtor (WIDGET_T *this)
{
  /* In this case, I really don't have to do anything, but
     if WIDGET_T had internal pointers, the objects they point to
     would be destroyed here.  */
  this->member = 0;
}

/* create function - this function returns a new WIDGET_T */
WIDGET_T *
WIDGETcreate (int m)
{
  WIDGET_T *x = 0;

  x = malloc (sizeof (WIDGET_T));
  if (x == 0) abort (); /* no memory */

  WIDGETctor (x, m);
  return x;
}

/* destroy function - calls the destructor, then frees the object */
void
WIDGETdestroy (WIDGET_T *this)
{
  WIDGETdtor (this);
  free (this);
}

/* END OF CODE */
