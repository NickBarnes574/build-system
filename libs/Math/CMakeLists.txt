add_library(Math
    src/number_converter.c
    src/number_generator.c
)

# Specify include directories
target_include_directories(Math PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

# Link dependencies
target_link_libraries(Math PUBLIC Common)

# Set the required C standard
target_compile_features(Math PUBLIC c_std_17)
