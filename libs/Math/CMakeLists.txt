set(LIBRARY_SOURCES
    "src/number_converter.c"
    "src/number_generator.c")
    
set(LIBRARY_INCLUDES
    "include/number_converter.h"
    "include/number_generator.h")

add_library(${LIB_MATH} STATIC ${LIBRARY_SOURCES} ${LIBRARY_INCLUDES})
target_include_directories(${LIB_MATH} PUBLIC "include/" "${CMAKE_BINARY_DIR}/config_files/include")

target_link_libraries(${LIB_MATH} PUBLIC ${LIB_COMMON})