set(LIBRARY_SOURCES
    "src/comparisons.c"
    "src/file_io.c"
    "src/signal_handler.c"
    "src/string_operations.c"
    "src/system_info.c"
    "src/utilities.c")
    
set(LIBRARY_INCLUDES
    "include/callback_types.h"
    "include/comparisons.h"
    "include/file_io.h"
    "include/signal_handler.h"
    "include/string_operations.h"
    "include/system_info.h"
    "include/utilities.h")

add_library(${LIB_COMMON} STATIC ${LIBRARY_SOURCES} ${LIBRARY_INCLUDES})
target_include_directories(${LIB_COMMON} PUBLIC "include/" "${CMAKE_BINARY_DIR}/config_files/include")