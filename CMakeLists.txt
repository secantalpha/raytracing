cmake_minimum_required(VERSION 3.20)

project(raytracing LANGUAGES CXX CUDA)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(FetchContent)

find_package(nvtx REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(Torch REQUIRED CONFIG)
find_package(Python COMPONENTS Interpreter Development)

add_library(
  ${PROJECT_NAME} SHARED
  ${CMAKE_CURRENT_SOURCE_DIR}/src/raytracer.cu
  ${CMAKE_CURRENT_SOURCE_DIR}/src/bvh.cu
  ${CMAKE_CURRENT_SOURCE_DIR}/src/bindings.cpp)

target_include_directories(
  ${PROJECT_NAME} PRIVATE ${TORCH_INCLUDE_DIRS}
                          ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} PRIVATE ${TORCH_LIBRARIES} Eigen3::Eigen
                                              Python::Python)

set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 17)
