set(TARGET hpc-lab)

add_executable(${TARGET})

target_compile_features(hpc-lab PRIVATE cxx_std_20)

target_include_directories(${TARGET} PUBLIC include)

target_sources(${TARGET}
    PRIVATE
    src/main.cpp
    src/application.cpp
)

target_link_libraries(hpc-lab PRIVATE
    cxxopts
    spdlog
    Boost::boost
    Boost::mpi
    MPI::MPI_CXX
    OpenMP::OpenMP_CXX
)
