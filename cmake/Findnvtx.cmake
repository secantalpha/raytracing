FetchContent_Declare(
  nvtx
  GIT_REPOSITORY https://github.com/NVIDIA/NVTX.git
  GIT_TAG tags/v3.1.1
  GIT_SHALLOW TRUE)
FetchContent_Populate(nvtx)

set(USE_SYSTEM_NVTX ON)
list(APPEND CMAKE_PREFIX_PATH ${nvtx_SOURCE_DIR}/c/include)
add_library(nvtx INTERFACE IMPORTED GLOBAL)

target_include_directories(nvtx INTERFACE ${nvtx_SOURCE_DIR}/c/include)

add_library(CUDA::nvToolsExt ALIAS nvtx)
