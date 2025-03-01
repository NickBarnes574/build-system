#include <errno.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h> // close()

#include "system_info.h"
#include "utilities.h"

#define BYTE             8
#define TIME_BUFFER_SIZE 80
#define BUFFER_SIZE      1024
#define SESSION_STR_LEN  13

void print_error(const char * p_message, ...)
{
    if (NULL == p_message)
    {
        goto END;
    }
#ifdef DEBUG
    va_list args;
    va_start(args, p_message);

    /* [ACTION]: Suppressing fprintf() error.
     * [JUSTIFICATION]: Result inconsequential to any further operations.
     */
    // NOLINTNEXTLINE
    fprintf(stderr, "[ERROR]: ");
    // NOLINTNEXTLINE
    vfprintf(stderr, p_message, args);
    // NOLINTNEXTLINE
    fprintf(stderr, "\n");
#endif
END:
    return;
}

void print_strerror(const char * p_message)
{
    if (NULL == p_message)
    {
        goto END;
    }
#ifdef DEBUG
    /* [ACTION]: Suppressing fprintf() error.
     * [JUSTIFICATION]: Result inconsequential to any further operations.
     */
    // NOLINTNEXTLINE
    fprintf(stderr, "%s %s\n", p_message, strerror(errno));
#endif
END:
    return;
}

void print_boxed_info(FILE *       output,
                      const char * header,
                      const char * hostname,
                      const char * operating_system,
                      const char * cpu,
                      const char * architecture,
                      const char * memory)
{
    size_t max_len = strlen(header);

    // Calculate the max length considering the full strings
    char temp[BUFFER_SIZE];
    (void)snprintf(temp, BUFFER_SIZE, "Hostname: %s", hostname);
    max_len = max_len > strlen(temp) ? max_len : strlen(temp);

    (void)snprintf(temp, BUFFER_SIZE, "Operating System: %s", operating_system);
    max_len = max_len > strlen(temp) ? max_len : strlen(temp);

    (void)snprintf(temp, BUFFER_SIZE, "CPU: %s", cpu);
    max_len = max_len > strlen(temp) ? max_len : strlen(temp);

    (void)snprintf(temp, BUFFER_SIZE, "Architecture: %s", architecture);
    max_len = max_len > strlen(temp) ? max_len : strlen(temp);

    (void)snprintf(temp, BUFFER_SIZE, "Memory: %s", memory);
    max_len = max_len > strlen(temp) ? max_len : strlen(temp);

    max_len += 2; // Padding

    (void)fprintf(output, "+");
    for (size_t i = 0; i < max_len + 2; i++)
    {
        (void)fprintf(output, "-");
    }
    (void)fprintf(output, "+\n");

    (void)fprintf(output, "| %-*s |\n", (int)max_len, header);

    (void)fprintf(output, "+");
    for (size_t i = 0; i < max_len + 2; i++)
    {
        (void)fprintf(output, "-");
    }
    (void)fprintf(output, "+\n");

    (void)snprintf(temp, BUFFER_SIZE, "Hostname: %s", hostname);
    (void)fprintf(output, "| %-*s |\n", (int)max_len, temp);

    (void)snprintf(temp, BUFFER_SIZE, "Operating System: %s", operating_system);
    (void)fprintf(output, "| %-*s |\n", (int)max_len, temp);

    (void)snprintf(temp, BUFFER_SIZE, "CPU: %s", cpu);
    (void)fprintf(output, "| %-*s |\n", (int)max_len, temp);

    (void)snprintf(temp, BUFFER_SIZE, "Architecture: %s", architecture);
    (void)fprintf(output, "| %-*s |\n", (int)max_len, temp);

    (void)snprintf(temp, BUFFER_SIZE, "Memory: %s", memory);
    (void)fprintf(output, "| %-*s |\n", (int)max_len, temp);

    (void)fprintf(output, "+");
    for (size_t i = 0; i < max_len + 2; i++)
    {
        (void)fprintf(output, "-");
    }
    (void)fprintf(output, "+\n");
}

int log_system_info()
{
    int    exit_code        = E_FAILURE;
    FILE * file             = NULL;
    char * hostname         = NULL;
    char * operating_system = NULL;
    char * cpu              = NULL;
    char * arch             = NULL;
    char * memory           = NULL;

    hostname         = get_hostname();
    operating_system = get_operating_system();
    cpu              = get_cpu_info();
    arch             = get_cpu_architecture();
    memory           = get_memory_info();

    file = fopen(LOGFILE, "ae");
    if (!file)
    {
        (void)fprintf(stderr, "log_system_info(): Unable to open log file.\n");
        goto END;
    }

    print_boxed_info(file,
                     "SYSTEM INFO",
                     hostname ? hostname : "N/A",
                     operating_system ? operating_system : "N/A",
                     cpu ? cpu : "N/A",
                     arch ? arch : "N/A",
                     memory ? memory : "N/A");
    (void)fclose(file);

    print_boxed_info(stdout,
                     "SYSTEM INFO",
                     hostname ? hostname : "N/A",
                     operating_system ? operating_system : "N/A",
                     cpu ? cpu : "N/A",
                     arch ? arch : "N/A",
                     memory ? memory : "N/A");

    exit_code = E_SUCCESS;

END:
    free(hostname);
    free(operating_system);
    free(cpu);
    free(arch);
    free(memory);
    return exit_code;
}

int message_log(const char * prefix_p,
                color_code_t color,
                log_dest_t   destination,
                const char * format,
                ...)
{
    int          exit_code            = E_FAILURE;
    char         buffer[MAX_MSG_SIZE] = { 0 };
    const char * color_code           = NULL;
    va_list      args;
    int          ret = 0;
    time_t       now = 0;
    struct tm *  timeinfo;
    char         time_buffer[TIME_BUFFER_SIZE] = { 0 };
    FILE *       file                          = NULL;

    // Timestamp
    now = time(NULL);
    if (now == ((time_t)-1))
    {
        (void)fprintf(stderr, "message_log(): time() failed.\n");
        goto END;
    }

    timeinfo = localtime(&now);
    if (strftime(
            time_buffer, sizeof(time_buffer), "%Y-%m-%d %H:%M:%S", timeinfo) ==
        0)
    {
        (void)fprintf(stderr,
                      "message_log(): strftime() failed to format the time.\n");
        goto END;
    }

    // Handle color code
    switch (color)
    {
        case COLOR_YELLOW:
            color_code = "\033[0;33m";
            break;
        case COLOR_RED:
            color_code = "\033[0;31m";
            break;
        case COLOR_GREEN:
            color_code = "\033[0;32m";
            break;
        case COLOR_BLUE:
            color_code = "\033[0;34m";
            break;
        default:
            color_code = "\033[0m"; // Default to no color
            break;
    }

    // Prepare the message
    va_start(args, format);
    ret = vsnprintf(buffer, sizeof(buffer), format, args);
    va_end(args);

    if (ret >= (int)sizeof(buffer))
    {
        (void)fprintf(
            stderr,
            "message_log(): Message truncated. Buffer size exceeded.\n");
        goto END;
    }

    // Handle log destination
    if (destination == LOG_FILE || destination == LOG_BOTH)
    {
        file = fopen(LOGFILE, "ae");
        if (!file)
        {
            (void)fprintf(stderr, "message_log(): Unable to open log file.\n");
            goto END;
        }
    }

    if (0 == strncmp(prefix_p, "SESSION_START", SESSION_STR_LEN))
    {
        (void)fprintf(file,
                      "\n---------------------------------SESSION "
                      "START---------------------------------\n\n");
        (void)fclose(file);
        exit_code = E_SUCCESS;
        goto END;
    }

    // Print the message with timestamp
    if (destination == LOG_CONSOLE || destination == LOG_BOTH)
    {
        printf("%s[%s][%s]: %s\033[0m\n",
               color_code,
               time_buffer,
               prefix_p,
               buffer);
    }
    if (destination == LOG_FILE || destination == LOG_BOTH)
    {
        (void)fprintf(file, "[%s][%s]: %s\n", time_buffer, prefix_p, buffer);
        (void)fclose(file);
    }

    exit_code = E_SUCCESS;

END:
    return exit_code;
}

void noop_free(void * data)
{
    // No operation
    (void)data;
}

int safe_snprintf(char * buffer, size_t buffer_size, const char * format, ...)
{
    int     exit_code = E_FAILURE;
    size_t  result    = 0;
    va_list args;

    if ((NULL == buffer) || (NULL == format))
    {
        print_error("safe_snprintf(): NULL argument passed.");
        goto END;
    }

    va_start(args, format);
    result = vsnprintf(buffer, buffer_size, format, args);
    va_end(args);

    if (result >= buffer_size)
    {
        print_error("safe_snprintf(): Output truncated.");
        goto END;
    }

    exit_code = E_SUCCESS;
END:
    return exit_code;
}

int safe_fprintf(FILE * file, const char * format, ...)
{
    int     exit_code = E_FAILURE;
    int     result    = 0;
    va_list args;

    if ((NULL == file) || (NULL == format))
    {
        print_error("safe_fprintf(): NULL argument passed.");
        goto END;
    }

    va_start(args, format);
    result = vfprintf(file, format, args);
    va_end(args);

    if (0 > result)
    {
        print_error("safe_fprintf(): Failed to write to file.");
        goto END;
    }

    exit_code = E_SUCCESS;
END:
    return exit_code;
}

int safe_fclose(FILE * file)
{
    int exit_code = E_FAILURE;
    int result    = 0;

    if (NULL == file)
    {
        print_error("safe_fclose(): NULL argument passed.");
        goto END;
    }

    result = fclose(file);
    if (EOF == result)
    {
        print_error("safe_fclose(): Failed to close file.");
        goto END;
    }

    exit_code = E_SUCCESS;
END:
    return exit_code;
}

int safe_close(int file_fd)
{
    int exit_code = E_FAILURE;
    int result    = 0;

    result = close(file_fd);
    if (-1 == result)
    {
        print_error("safe_close(): Error closing file descriptor.");
        goto END;
    }

    exit_code = E_SUCCESS;
END:
    return exit_code;
}

char * safe_fgets(char * buffer, size_t size, FILE * stream)
{
    char * result = NULL;

    if ((NULL == buffer) || (NULL == stream))
    {
        // Log an appropriate error message
        print_error("safe_fgets(): Invalid arguments passed.");
        goto END;
    }

    result = fgets(buffer, (int)size, stream);
    if (NULL == result)
    {
        if (feof(stream))
        {
            print_error("safe_fgets(): End of file reached.");
        }
        else if (ferror(stream))
        {
            perror("safe_fgets(): Read error");
        }
    }

END:
    return result;
}

/*** end of file ***/
