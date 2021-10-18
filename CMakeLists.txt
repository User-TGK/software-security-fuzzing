cmake_minimum_required(VERSION 3.10)

project(Fuzzing)

set(CMAKE_C_COMPILER "/home/azureuser/honggfuzz/hfuzz_cc/hfuzz-clang")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=address")

add_executable(stb-image main.c)
target_link_libraries(stb-image m)
