//
// Created by riley on 4/17/21.
//

#ifndef UNTITLED2_CHP3_H
#define UNTITLED2_CHP3_H
/// Query the cuda device(s) for their info
void get_device_info(int &count);


/// Show the results of the cuda addition
void display_add_result(int &host_value, int *&cuda_gpu_ptr);

#endif //UNTITLED2_CHP3_H
