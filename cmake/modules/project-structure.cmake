include_directories("${CMAKE_BINARY_DIR}/cmake/config")

include(${CMAKE_CURRENT_LIST_DIR}/options/build-options.cmake)

function(configure_executable)
  if(COMPILE_EXECUTABLE)
    install(TARGETS ${EXECUTABLE_NAME}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()
