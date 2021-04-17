#include "book.h"
#include "chp3.h"


int main() {
    int host_value;  // "host" means the regular cpu/memory
    int *cuda_gpu_ptr; // "device" mean the CUDA code running on the GPU/MEM
    int count;
    cudaDeviceProp device_specs;
    get_device_info(count, device_specs);
    display_add_result(host_value, cuda_gpu_ptr);

    return 0;
}

/// Simple addition function
__global__ void add(int num_one, int num_b, int *sum_result_ptr) {
    *sum_result_ptr = num_one + num_b;
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

// TODO: make this a pure function
void get_device_info(int &cuda_device_count, cudaDeviceProp &device_specs) {

    HANDLE_ERROR(cudaGetDeviceCount(&cuda_device_count));

    for (int cuda_device_i = 0; cuda_device_i < cuda_device_count; cuda_device_i++) {

        // Get the device specs for a device
        HANDLE_ERROR(cudaGetDeviceProperties(&device_specs, cuda_device_i));

        printf("Device Name: %s\n", device_specs.name);
        printf("Compute capability: %d.%d\n",prop.major, prop.minor)
    }
}
