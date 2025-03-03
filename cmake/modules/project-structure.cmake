# ----------------------------------------------------------------------------
# BRIEF -- project-structure.cmake
# ----------------------------------------------------------------------------
# Configures project include directories and installation rules.
#
# Features:
# - Uses `target_include_directories()` instead of `include_directories()`
# - Ensures `EXECUTABLE_NAME` is defined before installing
# - Provides a default fallback for `CMAKE_RUNTIME_OUTPUT_DIRECTORY`
#
# Usage:
# - Call `set_project_includes(<target>)` to add include directories
# - Call `configure_executable()` to install the executable (if enabled)
# ----------------------------------------------------------------------------

# Ensure runtime output directory is defined
if(NOT DEFINED CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin" CACHE PATH "Default runtime output directory")
endif()

# Function to set include directories per target
function(set_project_includes target)
    target_include_directories(${target} PRIVATE "${CMAKE_BINARY_DIR}/cmake/config")
endfunction()

# Function to configure executable installation
function(configure_executable)
    if(COMPILE_EXECUTABLE)
        if(NOT DEFINED EXECUTABLE_NAME)
            message(FATAL_ERROR "EXECUTABLE_NAME is not defined but COMPILE_EXECUTABLE is ON.")
        endif()

        install(TARGETS ${EXECUTABLE_NAME}
                DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    endif()
endfunction()

# *** END OF FILE ***
