set(LIBRARY_SOURCES
    "common/src/socket_io.c"
    "tcp_server/src/event_handler.c"
    "tcp_server/src/server_utils.c"
    "tcp_server/src/socket_manager.c"
    "tcp_server/src/tcp_server.c")

set(LIBRARY_INCLUDES
    "common/include/socket_io.h"
    "tcp_server/include/event_handler.h"
    "tcp_server/include/job_handler.h"
    "tcp_server/include/server_structs.h"
    "tcp_server/include/server_utils.h"
    "tcp_server/include/socket_manager.h"
    "tcp_server/include/tcp_server.h")

add_library(${LIB_NETWORKING} STATIC ${LIBRARY_SOURCES} ${LIBRARY_INCLUDES})
target_include_directories(
    ${LIB_NETWORKING}
    PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/common/include"
           "${CMAKE_CURRENT_SOURCE_DIR}/tcp_server/include"
           "${CMAKE_BINARY_DIR}/config_files/include")

target_link_libraries(${LIB_NETWORKING} PUBLIC ${LIB_COMMON} ${LIB_THREADING})
