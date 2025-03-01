set(LIBRARY_SOURCES
    "src/threadpool.c")
    
set(LIBRARY_INCLUDES
    "include/threadpool.h")

add_library(${LIB_THREADING} STATIC ${LIBRARY_SOURCES} ${LIBRARY_INCLUDES})
target_include_directories(${LIB_THREADING} PUBLIC "include/" "${CMAKE_BINARY_DIR}/config_files/include")

target_link_libraries(${LIB_THREADING} PUBLIC ${LIB_COMMON} ${LIB_DSA} pthread)