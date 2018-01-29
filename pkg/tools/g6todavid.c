/****************************************************************************

******************************************************************************/

#include "gtools.h"

main(argc,argv)
int argc;
char **argv;
{

  graph *g;
  int m,n;
  int i,j;
  int first;

  int codetype;
  FILE *infile;

  infile = opengraphfile(NULL,&codetype,0,1);

  while ((g = readg(infile,NULL,0,&m,&n)) != NULL)
  {

    first = 1;

    for (i=0; i<n; i++)
    for (j=i+1; j<n; j++)
    if (ISELEMENT(g+m*i,j)) {
      if (!first) {
        printf(",");
      } else {
       first = 0;
      }
      printf("%d--%d",i,j);
    }

    printf("\n");

     free(g);
  }

}
