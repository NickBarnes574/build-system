add_library(Networking
    common/src/socket_io.c
    tcp_server/src/event_handler.c
    tcp_server/src/server_utils.c
    tcp_server/src/socket_manager.c
    tcp_server/src/tcp_server.c
)

# Specify include directories
target_include_directories(Networking PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/common/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/tcp_server/include"
)

# Link dependencies
target_link_libraries(Networking PUBLIC Common Threading)

# Set the required C standard
target_compile_features(Networking PUBLIC c_std_17)
