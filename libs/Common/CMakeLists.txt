add_library(Common
    src/comparisons.c
    src/file_io.c
    src/signal_handler.c
    src/string_operations.c
    src/system_info.c
    src/utilities.c
)

# Specify include directories
target_include_directories(Common PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")

# Link any dependencies if needed (e.g., Threads, Math)
# target_link_libraries(Common PUBLIC Threads::Threads m)

# Add optional compile flags for this library
target_compile_features(Common PUBLIC c_std_17)
