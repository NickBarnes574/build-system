include_directories("${CMAKE_BINARY_DIR}/cmake/config")

function(configure_executable)
  if(COMPILE_EXECUTABLE)
    install(TARGETS ${EXECUTABLE_NAME}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()
