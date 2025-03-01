# ----------------------------------------------------------------------------
# BRIEF -- adsan-options.cmake
# ----------------------------------------------------------------------------
# Configures Address Sanitizer, warnings as errors, and other debugging tools.
# ----------------------------------------------------------------------------

# Enable AddressSanitizer if requested
if(ENABLE_ADSAN)
    message(STATUS "Address Sanitizer [ENABLED]")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address" CACHE STRING "" FORCE)
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -fsanitize=address" CACHE STRING "" FORCE)
endif()

# Treat warnings as errors if ENABLE_WARN_AS_ERR is set
if(ENABLE_WARN_AS_ERR)
    message(STATUS "Treating warnings as errors (ENABLE_WARN_AS_ERR is ON)")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror" CACHE STRING "" FORCE)
endif()
