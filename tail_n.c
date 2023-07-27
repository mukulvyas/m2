#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LENGTH 1000

int main() {
    int n;

    printf("Enter the number of lines:");

    if (scanf("%d", &n) != 1 || n <= 0) {
        fprintf(stderr, "Invalid value of n\n");
        return EXIT_FAILURE;
    }
        printf("Now Start entering into the files and once you have done entering into the file press (ctrl+d)\n");

    char buffer[MAX_LINE_LENGTH];
    char** lines = (char**)malloc(n * sizeof(char*));

    if (lines == NULL) {
        fprintf(stderr, "Memory allocation error\n");
        return EXIT_FAILURE;
    }

    int count = 0;
    int index = 0;

    while (fgets(buffer, MAX_LINE_LENGTH, stdin) != NULL) {
        // Allocate memory for the current line and copy it into the circular buffer
        lines[index] = strdup(buffer);

        // Move to the next position in the circular buffer
        index = (index + 1) % n;

        // Increment the line count if not yet filled to 'n'
        if (count < n) {
            count++;
        }
    }

     printf("The Last %d lines present in the given line are: \n",n);
    // Print the last 'n' lines in the circular buffer
    for (int i = 0; i < count; i++) {
        printf("%s", lines[index]);
        free(lines[index]);

        // Move to the next position in the circular buffer
        index = (index + 1) % n;
    }

    free(lines);

    return EXIT_SUCCESS;
}
