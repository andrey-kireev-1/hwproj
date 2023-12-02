#include <stdio.h>
#include <string.h>
#include <stdbool.h>


int main(int argc, char *argv[])
{
    bool need_n = false;
    bool need_fflush = true;
    bool need_out = false;
    char* file_name = "";
    for (int i = 0; i < argc; i++)
    {
        if (strcmp(argv[i], "add_n")==0)
        {
            need_n = true;
            continue;
        }
        if (strcmp(argv[i], "remove_fflush")==0)
        {
            need_fflush = false;
            continue;
        }
        if (strcmp(argv[i], "-o")==0)
        {
            need_out = true;
            continue;
        }
        if (strcmp(argv[i], argv[0])!=0)
        {
            if (need_out == false)
            {
                fputs("Output file is not needed", stderr);
                continue;
            }
            if (strcmp(argv[i-1], "-o")!=0)
            {
                fputs("Not correct positioning out name", stderr);
                continue;
            }
            file_name = argv[i];
        }
    }

    if ((need_out == true) && (strcmp(file_name, "")==0)) {
        fputs("Writing to out is requested, but out name is empty", stderr);
    }

    FILE* out;
    FILE* out_err;
    if (need_out == true) {
        out = fopen(file_name, "w");
        if (out == NULL) {
            printf("Error Occurred While creating a out !");
            return 1;
        }
        out_err = out;
    } else {
        out = stdout;
        out_err = stderr;
    }

    char* msg_out = "";
    char* msg_err = "";

    if (need_n)
    {
        msg_out = "STDOUT\n";
        msg_err = "STDERR\n";
    } else {
        msg_out = "STDOUT";
        msg_err = "STDERR";
    }

    fputs(msg_out, out);
    if (need_fflush) {
        fflush(out);
    }

    fputs(msg_err, out_err);
    if (need_fflush) {
        fflush(out_err);
    }

    if (need_out == true) {
        fclose(out);
    }

    return 0;
}