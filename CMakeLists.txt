cmake_minimum_required(VERSION 3.10)

project(Fuzzing)
#set(CMAKE_C_COMPILER "../../AFL/afl-gcc")

add_executable(stb-image main.c)
target_link_libraries(stb-image m)
