set(EXE_SOURCES "src/main.c" "src/option_handler.c")
set(EXE_INCLUDES "include/option_handler.h")

add_executable(${EXECUTABLE_ADMIN} ${EXE_SOURCES} ${EXE_INCLUDES})

target_include_directories(${EXECUTABLE_ADMIN}
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(
  ${EXECUTABLE_ADMIN} PUBLIC ${LIB_COMMON} ${LIB_DSA} ${LIB_MATH}
                             ${LIB_NETWORKING} ${LIB_THREADING})
