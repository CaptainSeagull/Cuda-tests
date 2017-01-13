// This is the REAL "hello world" for CUDA!
// It takes the string "Hello ", prints it, then passes it to CUDA with an array
// of offsets. Then the offsets are added in parallel to produce the string "World!"
// By Ingemar Ragnemalm 2010

#include <stdio.h>
#include <assert.h>

const int N = 16;
const int blocksize = 16;

__global__
void hello(char *a, int *b) {
    a[threadIdx.x] += b[threadIdx.x];
}

void *my_malloc(size_t size) {
    void *p;
    cudaMalloc(&p, size);

    // TODO(Jonny): Check error here! If there is an error, free the memory and return null.

    return(p);
}

void my_free(void *p) {
    if(!p) { assert(0); }
    else {
        cudaFree(p);
        // TODO(Jonny): Check error here!
    }
}

// TODO(Jonny): Do cudaMemcpy!

int main() {
    char a[N] = "Hello \0\0\0\0\0\0";
    int b[N] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    char *ad;
    int *bd;
    const int csize = N*sizeof(char);
    const int isize = N*sizeof(int);

    printf("%s", a);

    ad = (char *)my_malloc(csize);
    bd = (int *)my_malloc(isize);
    cudaMemcpy( ad, a, csize, cudaMemcpyHostToDevice );
    cudaMemcpy( bd, b, isize, cudaMemcpyHostToDevice );

    dim3 dimBlock( blocksize, 1 );
    dim3 dimGrid( 1, 1 );
    hello <<<dimGrid, dimBlock>>>(ad, bd);
    cudaMemcpy( a, ad, csize, cudaMemcpyDeviceToHost );
    my_free(ad);
    my_free(bd);


    printf("%s\n", a);
    return EXIT_SUCCESS;
}