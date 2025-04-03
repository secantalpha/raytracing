cmake_minimum_required(VERSION 3.20)

project(_raytracing LANGUAGES CXX CUDA)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(FetchContent)

find_package(nvtx REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(Torch REQUIRED CONFIG)
find_package(Python COMPONENTS Interpreter Development)
find_package(pybind11 REQUIRED CONFIG)

pybind11_add_module(
  ${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/src/raytracer.cu
  ${CMAKE_CURRENT_SOURCE_DIR}/src/bvh.cu
  ${CMAKE_CURRENT_SOURCE_DIR}/src/bindings.cpp)

target_include_directories(
  ${PROJECT_NAME} PRIVATE ${TORCH_INCLUDE_DIRS}
                          ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} PRIVATE ${TORCH_LIBRARIES} Eigen3::Eigen)

target_compile_definitions(${PROJECT_NAME}
                           PRIVATE -DTORCH_EXTENSION_NAME=${PROJECT_NAME})

set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 17)

install(TARGETS ${PROJECT_NAME} DESTINATION raytracing)
install(DIRECTORY raytracing/ DESTINATION raytracing)
