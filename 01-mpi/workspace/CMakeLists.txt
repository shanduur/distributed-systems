cmake_minimum_required(VERSION 3.22)

project(
    HPC 
    VERSION 0.1.0
    DESCRIPTION "High Performance Computing Lab"
    LANGUAGES CXX
)

# Set the C++ standard to C++20
set(CMAKE_CXX_STANDARD 20)

# set the default build type to Release
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif ()

# Set the compiler flags warning and optimization
set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

find_package(Boost COMPONENTS mpi REQUIRED)
find_package(OpenMP REQUIRED)
find_package(MPI REQUIRED)

# The executable code is here
add_subdirectory(apps)

# The library code is here
add_subdirectory(libs)
