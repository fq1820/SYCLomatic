// REQUIRES: aspect-fp16
// RUN: %clangxx -fsycl -fsycl-targets=%sycl_triple %s -o %t.out
// RUN: %GPU_RUN_PLACEHOLDER %t.out
//
// Missing __spirv_SubgroupLocalInvocationId, __spirv_GroupFAdd,
// __spirv_GroupFMin, __spirv_GroupFMax on AMD
// XFAIL: hip_amd

// This test verifies the correct work of the sub-group algorithms
// exclusive_scan() and inclusive_scan().

#include "scan.hpp"
#include <iostream>
int main() {
  queue Queue;
  if (!core_sg_supported(Queue.get_device())) {
    std::cout << "Skipping test\n";
    return 0;
  }
  check<class KernelName_dlpo, sycl::half>(Queue);
  std::cout << "Test passed." << std::endl;
  return 0;
}
