cmake_minimum_required(VERSION 3.12)
project(TestWebGPUDist)

set(CMAKE_CXX_STANDARD 17)

add_executable(TestWebGPUDist src/main.cpp)

include(FetchContent)
FetchContent_Declare(
        webgpu
        GIT_REPOSITORY https://github.com/eliemichel/WebGPU-distribution
        GIT_TAG        main
)
FetchContent_MakeAvailable(webgpu)
target_copy_webgpu_binaries(TestWebGPUDist)
target_link_libraries(TestWebGPUDist PRIVATE webgpu)
