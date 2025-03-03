# ----------------------------------------------------------------------------
# BRIEF -- build-options.cmake
# ----------------------------------------------------------------------------
# Configures common compiler options and build settings.
# This file is included in the main CMakeLists.txt.
# ----------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/color-options.cmake)

function(set_build_preferences)
    # Default to Release mode if not set
    if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE Release)
    endif()

    # Ensure flags are treated as proper lists (users define them without quotes)
    set(CMAKE_C_FLAGS_COMMON ${FLAGS_COMMON})
    set(CMAKE_C_FLAGS_DEBUG ${FLAGS_DEBUG})
    set(CMAKE_C_FLAGS_RELEASE ${FLAGS_RELEASE})
    set(CMAKE_C_FLAGS_TEST ${FLAGS_TEST})

    foreach(flag ${CMAKE_C_FLAGS_COMMON})
        add_compile_options(${flag})
    endforeach()
    
    add_compile_options()

    # Apply flags per configuration (Properly expanded)
    foreach(flag ${CMAKE_C_FLAGS_DEBUG})
        add_compile_options($<$<CONFIG:Debug>:${flag}>)
    endforeach()

    foreach(flag ${CMAKE_C_FLAGS_RELEASE})
        add_compile_options($<$<CONFIG:Release>:${flag}>)
    endforeach()

    foreach(flag ${CMAKE_C_FLAGS_TEST})
        add_compile_options($<$<CONFIG:Test>:${flag}>)
    endforeach()

    # Display build type
    message_color(STATUS "*** Building in ${CMAKE_BUILD_TYPE} mode ***")
    message_color(STATUS "*** Common FLAGS: ${CMAKE_C_FLAGS_COMMON} ***")
    message_color(STATUS "*** Debug FLAGS: ${CMAKE_C_FLAGS_DEBUG} ***")
    message_color(STATUS "*** Release FLAGS: ${CMAKE_C_FLAGS_RELEASE} ***")
    message_color(STATUS "*** Test FLAGS: ${CMAKE_C_FLAGS_TEST} ***")
endfunction()
