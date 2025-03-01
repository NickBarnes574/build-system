set(LIBRARY_SOURCES
    "adjacency_list/src/adjacency_list.c"
    "adjacency_matrix/src/adjacency_matrix.c"
    "hash_table/src/hash_table.c"
    "linked_list/src/linked_list.c"
    "queue/src/queue.c"
    "stack/src/stack.c"
    "vector/src/vector.c"
)

set(LIBRARY_HEADERS
    "adjacency_list/include/adjacency_list.h"
    "adjacency_matrix/include/adjacency_matrix.h"
    "hash_table/include/hash_table.h"
    "linked_list/include/linked_list.h"
    "queue/include/queue.h"
    "stack/include/stack.h"
    "vector/include/vector.h"
)

add_library(${LIB_DSA} STATIC ${LIBRARY_SOURCES} ${LIBRARY_HEADERS})

target_include_directories(${LIB_DSA} PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/adjacency_list/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/adjacency_matrix/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/hash_table/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/linked_list/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/queue/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/stack/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/vector/include"
    "${CMAKE_BINARY_DIR}/config_files/include"
)

target_link_libraries(${LIB_DSA} PUBLIC ${LIB_COMMON} ${LIB_MATH})