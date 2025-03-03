add_library(DSA
    adjacency_list/src/adjacency_list.c
    adjacency_matrix/src/adjacency_matrix.c
    hash_table/src/hash_table.c
    linked_list/src/linked_list.c
    queue/src/queue.c
    stack/src/stack.c
    vector/src/vector.c
)

# Include directories for headers
target_include_directories(DSA PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/adjacency_list/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/adjacency_matrix/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/hash_table/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/linked_list/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/queue/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/stack/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/vector/include"
)

# Link dependencies (Common and Math libraries)
target_link_libraries(DSA PUBLIC Common Math)

# Set the required C standard
target_compile_features(DSA PUBLIC c_std_17)
