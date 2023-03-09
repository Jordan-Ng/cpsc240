#include <stdlib.h>

int compare(const void * a, const void *b){
    if (*(double *) a  == *(double *) b) return 0;

    return *(double *) a  > *(double *) b ? 1 : -1;
}

extern "C" void quickSort(double data[], int size){
    qsort(data, size, 8, compare);
}