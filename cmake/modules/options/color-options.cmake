# ----------------------------------------------------------------------------
# BRIEF -- color-options.cmake
# ----------------------------------------------------------------------------
# Provides colorized output for CMake messages.
#
# Features:
# - Defines ANSI color escape sequences for various colors and styles
# - Implements `message_color` function to display messages with color
#   based on message type (e.g., STATUS, WARNING, FATAL_ERROR)
# - Supports optional custom colors for STATUS messages
#
# Usage:
# - Use `message_color` instead of `message` for colorized console output
# ----------------------------------------------------------------------------

# SOURCE:
# https://stackoverflow.com/questions/18968979/how-to-make-colorized-message-with-cmake

if(NOT WIN32)
    string(ASCII 27 Esc)
    set(ColourReset "${Esc}[m")
    set(ColourBold "${Esc}[1m")
    set(Red "${Esc}[31m")
    set(Green "${Esc}[32m")
    set(Yellow "${Esc}[33m")
    set(Blue "${Esc}[34m")
    set(Magenta "${Esc}[35m")
    set(Cyan "${Esc}[36m")
    set(White "${Esc}[37m")
    set(BoldRed "${Esc}[1;31m")
    set(BoldGreen "${Esc}[1;32m")
    set(BoldYellow "${Esc}[1;33m")
    set(BoldBlue "${Esc}[1;34m")
    set(BoldMagenta "${Esc}[1;35m")
    set(BoldCyan "${Esc}[1;36m")
    set(BoldWhite "${Esc}[1;37m")
endif()

# Custom message function with optional color for STATUS messages
function(message_color)
    set(options
        FATAL_ERROR
        SEND_ERROR
        WARNING
        STATUS
        AUTHOR_WARNING)
    set(MessageType STATUS) # Default message type
    set(colored_text "${ARGV}")

    # Check if the first argument matches a message type
    list(
        FIND
        options
        "${ARGV0}"
        index)
    if(index GREATER -1)
        set(MessageType "${ARGV0}")
        list(REMOVE_AT ARGV 0)
        set(colored_text "${ARGV}")
    endif()

    # Handle custom color for STATUS messages
    set(Color "${Green}") # Default color for STATUS messages
    if(MessageType STREQUAL STATUS)
        # Check if a color argument was passed
        if(ARGC GREATER 1)
            list(
                GET
                ARGV
                0
                CustomColor)
            if(DEFINED ${CustomColor})
                set(Color "${${CustomColor}}")
                list(REMOVE_AT ARGV 0)
                set(colored_text "${ARGV}")
            endif()
        endif()
    endif()

    # Determine color based on message type
    if(MessageType STREQUAL FATAL_ERROR OR MessageType STREQUAL SEND_ERROR)
        message(${MessageType} "${BoldRed}${colored_text}${ColourReset}")
    elseif(MessageType STREQUAL WARNING)
        message(${MessageType} "${BoldYellow}${colored_text}${ColourReset}")
    elseif(MessageType STREQUAL AUTHOR_WARNING)
        message(${MessageType} "${BoldCyan}${colored_text}${ColourReset}")
    elseif(MessageType STREQUAL STATUS)
        message(${MessageType} "${Color}${colored_text}${ColourReset}")
    else()
        # Default behavior for other messages
        message("${colored_text}")
    endif()
endfunction()
