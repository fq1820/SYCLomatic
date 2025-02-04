// RUN: dpct --format-range=none --out-root %T %s --cuda-include-path="%cuda-path/include" --in-root %S --extra-arg="-I %S/../header2 ,-I %S/../header "
// RUN: FileCheck --input-file %T/test.dp.cpp --match-full-lines %s

#include "../header/in_header.h"
#include "../header2/out_header.h"
int main() {
  // CHECK: dpct::device_ext &dev_ct1 = dpct::get_current_device();
  // CHECK-NEXT: sycl::queue &q_ct1 = dev_ct1.default_queue();

  // CHECK: q_ct1.parallel_for(
  // CHECK-NEXT: sycl::nd_range<3>(sycl::range<3>(1, 1, 1), sycl::range<3>(1, 1, 1)),
  // CHECK-NEXT: [=](sycl::nd_item<3> item_ct1) {
  // CHECK-NEXT:   helloFromGPU();
  // CHECK-NEXT: });
  helloFromGPU<<<1, 1>>>();
  // CHECK: q_ct1.parallel_for(
  // CHECK-NEXT: sycl::nd_range<3>(sycl::range<3>(1, 1, 1), sycl::range<3>(1, 1, 1)),
  // CHECK-NEXT: [=](sycl::nd_item<3> item_ct1) {
  // CHECK-NEXT:   helloFromGPU2();
  // CHECK-NEXT: });
  helloFromGPU2<<<1, 1>>>();

  return 0;
}
