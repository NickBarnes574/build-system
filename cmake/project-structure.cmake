include_directories("${CMAKE_BINARY_DIR}/cmake/config")
add_subdirectory(cmake/config)
add_subdirectory(libs)

function(configure_admin_executable)
  if(COMPILE_EXECUTABLE)
    add_subdirectory(apps/admin_server)
    install(TARGETS ${EXECUTABLE_ADMIN}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()

function(configure_downstream_executable)
  if(COMPILE_EXECUTABLE)
    add_subdirectory(apps/downstream_server)
    install(TARGETS ${EXECUTABLE_DOWNSTREAM}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()

function(configure_pretreatment_executable)
  if(COMPILE_EXECUTABLE)
    add_subdirectory(apps/pretreatment_server)
    install(TARGETS ${EXECUTABLE_PRETREATMENT}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()

function(configure_residential_executable)
  if(COMPILE_EXECUTABLE)
    add_subdirectory(apps/residential_server)
    install(TARGETS ${EXECUTABLE_RESIDENTIAL}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()

function(configure_stormdrain_executable)
  if(COMPILE_EXECUTABLE)
    add_subdirectory(apps/stormdrain_server)
    install(TARGETS ${EXECUTABLE_STORMDRAIN}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()

function(configure_treatment_executable)
  if(COMPILE_EXECUTABLE)
    add_subdirectory(apps/treatment_server)
    install(TARGETS ${EXECUTABLE_TREATMENT}
            DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  endif()
endfunction()
