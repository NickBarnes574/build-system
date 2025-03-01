set(EXE_SOURCES "src/main.c")
set(EXE_INCLUDES)

add_executable(${EXECUTABLE_TREATMENT} ${EXE_SOURCES} ${EXE_INCLUDES})

target_include_directories(${EXECUTABLE_TREATMENT}
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(
  ${EXECUTABLE_TREATMENT} PUBLIC ${LIB_COMMON} ${LIB_DSA} ${LIB_MATH}
                                 ${LIB_NETWORKING} ${LIB_THREADING})
