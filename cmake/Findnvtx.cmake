include_guard()

add_library(nvtx INTERFACE IMPORTED GLOBAL)
add_library(CUDA::nvToolsExt ALIAS nvtx)
