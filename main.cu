#include "book.h"

/// Simple Cuda addition function
__global__ void add(int numberA, int numberB, int *sum_result_ptr) {
    *sum_result_ptr = numberA + numberB;
}

int main() {
    int host_value;  // "host" means the regular cpu/memory
    int *cuda_gpu_ptr; // "device" mean the CUDA code running on the GPU/MEM
    int count;
    cudaDeviceProp device_specs;

    HANDLE_ERROR(cudaGetDeviceCount(&count));

    for (int i = 0; i < count; i++) {
        HANDLE_ERROR(cudaGetDeviceProperties(&device_specs, i));
    }



    // allocate memory on the cuda device
    HANDLE_ERROR(cudaMalloc((void **) &cuda_gpu_ptr, sizeof(int)));

    // perform calculation with CUDA on GPU
    add<<<1, 1>>>(2, 7, cuda_gpu_ptr);


    // Copy result from CUDA memory back to host memory
    HANDLE_ERROR(cudaMemcpy(&host_value, cuda_gpu_ptr, sizeof(int), cudaMemcpyDeviceToHost));
    // end utility macro

    printf("3+7 = %d\n", host_value);
    cudaFree(cuda_gpu_ptr);

    return 0;
}
