add_library(Threading
    src/threadpool.c
)

# Specify include directories
target_include_directories(Threading PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

# Link dependencies
target_link_libraries(Threading PUBLIC Common DSA pthread)

# Set the required C standard
target_compile_features(Threading PUBLIC c_std_17)
