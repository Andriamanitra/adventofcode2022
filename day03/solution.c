#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define BUFSIZE 512
#define GROUPSIZE 3

int letter_value(char letter) {
    return (letter & 31) + 26 * (((letter & 32) >> 5) ^ 1);
}

int main() {
    char elves[GROUPSIZE][BUFSIZE];
    int lineno = 0;
    int part1result = 0;
    int part2result = 0;
    while (fgets(elves[lineno], BUFSIZE, stdin)) {
        // Part 1
        int half = strlen(elves[lineno]) / 2;
        for (int i = 0; i < half; i++) {
            char common = elves[lineno][i];
            for (int j = 0; j < half; j++) {
                if (elves[lineno][half+j] == common) {
                    part1result += letter_value(common);
                    goto found;
                }
            }
        }
found:

        lineno += 1;

        // Part 2
        if (lineno == GROUPSIZE) {
            for (int i = 0; elves[0][i] != '\0'; i++) {
                char common = elves[0][i];
                int found_count = 1;
                for (int other_idx = 1; other_idx < GROUPSIZE; other_idx++) {
                    for (int j = 0; elves[other_idx][j] != '\0'; j++) {
                        if (elves[other_idx][j] == common) {
                            found_count++;
                            break;
                        }
                    }
                }
                if (found_count == GROUPSIZE) {
                    part2result += letter_value(common);
                    break;
                }
            }
            lineno = 0;
        }
    }
    printf("Part 1: %d\n", part1result);
    printf("Part 2: %d\n", part2result);
}
