#include "book.h"

/// Simple Cuda addition function
__global__ void add(int num_one, int num_b, int *sum_result_ptr) {
    *sum_result_ptr = num_one + num_b;
}



/// Query the cuda device(s) for their info
void get_device_info(int &count);


/// Show the results of the cuda addition
void display_add_result(int &host_value, int *&cuda_gpu_ptr);

int main() {
    int host_value;  // "host" means the regular cpu/memory
    int *cuda_gpu_ptr; // "device" mean the CUDA code running on the GPU/MEM
    int count;
    get_device_info(count);
    display_add_result(host_value, cuda_gpu_ptr);


    return 0;
}

void display_add_result(int &host_value, int *&cuda_gpu_ptr) {// allocate memory on the cuda device
    HANDLE_ERROR(cudaMalloc((void **) &cuda_gpu_ptr, sizeof(int)));

    // perform calculation with CUDA on GPU
    add<<<1, 1>>>(2, 7, cuda_gpu_ptr);


    // Copy result from CUDA memory back to host memory
    HANDLE_ERROR(cudaMemcpy(&host_value, cuda_gpu_ptr, sizeof(int), cudaMemcpyDeviceToHost));
    // end utility macro

    printf("3+7 = %d\n", host_value);
    cudaFree(cuda_gpu_ptr);
}

void get_device_info(int &count) {
    cudaDeviceProp device_specs;

    HANDLE_ERROR(cudaGetDeviceCount(&count));

    for (int i = 0; i < count; i++) {
        HANDLE_ERROR(cudaGetDeviceProperties(&device_specs, i));
    }
}
