set(EXE_SOURCES "src/main.c" "src/option_handler.c")
set(EXE_INCLUDES "include/option_handler.h")

add_executable(${EXECUTABLE_NAME} ${EXE_SOURCES} ${EXE_INCLUDES})

target_include_directories(${EXECUTABLE_NAME}
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(
  ${EXECUTABLE_NAME} PUBLIC Common DSA Math Networking Threading)

# ---SHARED LIBRARY CODE BELOW---
# Tell the linker:
# 1. To look in the artifacts directory while running in the build directory
# 2. To set the install RPATH to /lib for installed libraries
set_target_properties(${EXECUTABLE_NAME} PROPERTIES
  BUILD_RPATH "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/../libs"
  INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/../libs"
  INSTALL_RPATH_USE_LINK_PATH TRUE
)