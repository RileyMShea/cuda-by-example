cmake_minimum_required(VERSION 3.19)
project(untitled2 CUDA)

set(CMAKE_CUDA_STANDARD 14)

add_executable(untitled2 main.cu chp3.h)

set_target_properties(
        untitled2
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)