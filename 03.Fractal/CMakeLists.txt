cmake_minimum_required(VERSION 3.5)
project(03_A_Fractal C)

set(CMAKE_C_STANDARD 11)

file(GLOB_RECURSE SOURCE_FILES src/*.c)

add_executable(03_A_Fractal src/main.c ${SOURCE_FILES})
target_link_libraries(03_A_Fractal PRIVATE m)
target_include_directories(03_A_Fractal PRIVATE include)