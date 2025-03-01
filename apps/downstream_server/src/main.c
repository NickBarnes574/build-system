#include <stdio.h>
#include <stdlib.h>

#include "utilities.h"

int main()
{
    int exit_code = E_FAILURE;

    exit_code = E_SUCCESS;

    goto END;
END:
    return exit_code;
}

/*** end of file ***/
