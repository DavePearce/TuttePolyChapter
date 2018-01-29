/****************************************************************************
	
	Writes out graphs in a variety of different package based
	formats - either the adjacency matrix or the Laplacian..

******************************************************************************/

#include "gtools.h"

main(argc,argv)
int argc;
char **argv;
{

  graph *g;
  int m,n;

  int codetype;
  FILE *infile;

  int count = 0;

  infile = opengraphfile(NULL,&codetype,0,1);

  if (argc != 3) {
    fprintf(stderr,"Usage: %s -[al] -[mg|ms|mp|pr|nt|gp|jg|pl] < (graphs)\n",argv[0]);
    fprintf(stderr,"Flag 1: a=adjacency matrix, l=laplacian matrix, s=seidel\n");
    fprintf(stderr,"Flag 2: mg=Magma,ms=MagmaSparse,mp=Maple,pr=Pari,nt=NTL\n");
    fprintf(stderr,"Flag 2: jg=JGD's SMS format, pl=plain\n");
  }
  
  while ((g = readg(infile,NULL,0,&m,&n)) != NULL) 
  {

    count++;

    switch(argv[1][1]) {
      case 'a':
        if (argv[2][1] == 'm' && argv[2][2] == 'g') 
          magma_print_adj(g,m,n,count);
        if (argv[2][1] == 'm' && argv[2][2] == 't') 
          mathematica_print_adj(g,m,n,count);
        if (argv[2][1] == 'm' && argv[2][2] == 's') 
          magmasparse_print_adj(g,m,n,count);
        if (argv[2][1] == 'm' && argv[2][2] == 'p') 
          maple_print_adj(g,m,n,count);
        if (argv[2][1] == 'p' && argv[2][2] == 'r') 
          pari_print_adj(g,m,n,count);
        if (argv[2][1] == 'n' && argv[2][2] == 't') 
          ntl_print_adj(g,m,n,count);
        if (argv[2][1] == 'g' && argv[2][2] == 'p') 
          gap_print_adj(g,m,n,count);
        if (argv[2][1] == 'j' && argv[2][2] == 'g') 
          jgd_print_adj(g,m,n,count);
        if (argv[2][1] == 'p' && argv[2][2] == 'l') 
          plain_print_adj(g,m,n,count);
        break;
      case 'l':
        if (argv[2][1] == 'm' && argv[2][2] == 'g') 
          magma_print_lap(g,m,n,count);
        if (argv[2][1] == 'm' && argv[2][2] == 's') 
          magmasparse_print_lap(g,m,n,count);
        if (argv[2][1] == 'm' && argv[2][2] == 'p') 
          maple_print_lap(g,m,n,count);
        if (argv[2][1] == 'p' && argv[2][2] == 'r') 
          pari_print_lap(g,m,n,count);
        if (argv[2][1] == 'n' && argv[2][2] == 't') 
          ntl_print_lap(g,m,n,count);
        if (argv[2][1] == 'g' && argv[2][2] == 'p') 
          gap_print_lap(g,m,n,count);
        if (argv[2][1] == 'j' && argv[2][2] == 'g') 
          jgd_print_lap(g,m,n,count);
        break;
	case 's': ntl_print_seid(g,m,n,count);
    }
    free(g);
  }
}

template_print_adj(graph *g, int m, int n, int count) {
}

template_print_lap(graph *g, int m, int n, int count) {
}

plain_print_adj(graph *g, int m, int n, int count) {
  int i,j;
  printf("%d\n",n);
  for (i=0;i<n;i++) {
  for (j=0;j<n;j++)
    printf("%d ",ISELEMENT(g+m*i,j)?1:0);
  printf("\n");
  }
}

jgd_print_adj(graph *g, int m, int n, int count) {

  int i,j;

  printf("%d %d M\n",n,n);
  for (i=0;i<n;i++) 
  for (j=0;j<n;j++) 
  if (ISELEMENT(g+m*i,j)) 
    printf("%d %d 1\n",i+1,j+1);

  printf("0 0 0\n");

}

jgd_print_lap(graph *g, int m, int n, int count) {

  int i,j;

  printf("%d %d M\n",n,n);

  for (i=0;i<n;i++)
  for (j=0;j<n;j++) {
    if (i == j) printf("%d %d %d\n",i,j,degree(g,m,n,i));
    if (ISELEMENT(g+m*i,j)) printf("%d %d %d\n",i,j,-1);
  }

  printf("0 0 0\n");

}


gap_print_adj(graph *g, int m, int n, int count) {
}

gap_print_lap(graph *g, int m, int n, int count) {
}

magma_print_adj(graph *g, int m, int n, int count) {
  int i,j;

  printf("a[%d]:= Matrix([\n",count);
  for (i=0;i<n;i++) {
    printf("[");
    for (j=0;j<n;j++) {
      printf("%d",ISELEMENT(g+m*i,j)?1:0);
      if (j < n-1)
        printf(",");
      else
        printf("]");
    }
    if (i < n-1)
      printf(",\n");
    else
      printf("]);\n");
  }
}

mathematica_print_adj(graph *g, int m, int n, int count) {
  int i,j;

  printf("a = {\n",count);
  for (i=0;i<n;i++) {
    printf("{");
    for (j=0;j<n;j++) {
      printf("%d",ISELEMENT(g+m*i,j)?1:0);
      if (j < n-1)
        printf(",");
      else
        printf("}");
    }
    if (i < n-1)
      printf(",\n");
    else
      printf("};\n");
  }

  //printf("Apply[Plus, Map[Abs, x /. N[Solve[CharacteristicPolynomial[a, x] == 0]]]]\n");
  printf("Det[a]\n");
}

magmasparse_print_adj(graph *g, int m, int n, int count) {

  int i,j,first;

  printf("a%d := SparseMatrix(%d,%d,\n",count,n,n);

  first = 1;

  for (i=0;i<n;i++)
  for (j=0;j<n;j++)
  if (ISELEMENT(g+m*i,j)) {
   if (first) {
      printf("[<%d,%d,1>\n",i+1,j+1);
      first = 0;
   } else {
      printf(",<%d,%d,1>\n",i+1,j+1);
   }
  }

  printf("]);\n");

}

maple_print_adj(graph *g, int m, int n, int count) {
  magma_print_adj(g,m,n,count); // currently Maple and Magma are same
}

pari_print_adj(graph *g, int m, int n, int count) {

  int i,j;

  printf("a%d=[",count);
  for (i=0;i<n;i++) {
    for (j=0;j<n;j++) {
      printf("%d",ISELEMENT(g+m*i,j)?1:0);
      if (j<n-1) 
        printf(",");
      if (j==n-1 && i<n-1) 
        printf(";");
    }
    if (i==n-1) printf("]\n");
  }

}

ntl_print_seid(graph *g, int m, int n, int count) {
}

ntl_print_adj(graph *g, int m, int n, int count) {
}

magma_print_lap(graph *g, int m, int n, int count) {
}

magmasparse_print_lap(graph *g, int m, int n, int count) {

  int i,j,first;

  printf("a%d := SparseMatrix(%d,%d,\n",count,n,n);

  first = 1;

  for (i=0;i<n;i++)
  for (j=0;j<n;j++)
  if (ISELEMENT(g+m*i,j)) {
   if (first) {
      printf("[<%d,%d,-1>\n",i+1,j+1);
      first = 0;
   } else {
      printf(",<%d,%d,-1>\n",i+1,j+1);
   }
  }

  for (i=0;i<n;i++)
  printf(",<%d,%d,%d>\n",i+1,i+1,degree(g,m,n,i));

  printf("]);\n");
}

maple_print_lap(graph *g, int m, int n, int count) {
}

pari_print_lap(graph *g, int m, int n, int count) {
}

ntl_print_lap(graph *g, int m, int n, int count) {
}


degree(graph *g, int m, int n, int vx) {

  int i;
  int deg = 0;

  for (i=0;i<m;i++) 
  deg += POPCOUNT((g+m*vx)[i]);
 
  return deg;

}

