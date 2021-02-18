cmake_minimum_required(VERSION 3.17)

project(mkl-sample LANGUAGES CXX)

set(BLA_VENDOR Intel10_64_dyn)
find_package(LAPACK REQUIRED)

add_executable(dgemm dgemm.cpp)

target_link_libraries(dgemm
  PRIVATE
    ${LAPACK_LIBRARIES}
  )
