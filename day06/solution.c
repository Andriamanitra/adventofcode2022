#include <stdio.h>

#define ALPHABET_SIZE 26
#define BUFSIZE 8192

/// turns letters a..z to numbers 0..25
int charidx(char letter) {
    return (letter & 31) - 1;
}

/// datastream should be a string consisting of lowercase letters
/// delimited by either a newline or a null byte
/// markersize must be shorter than the length of the datastream
int solve(char* datastream, int markersize) {
    int counts[ALPHABET_SIZE] = {0};
    int dups = 0;

    for (int i = 0; i < markersize; i++) {
        if (++counts[charidx(datastream[i])] == 2) dups++;
    }

    for (int i = markersize; datastream[i] >= '\n'; i++) {
        if (dups == 0) return i;

        int head_char_idx = charidx(datastream[i]);
        int tail_char_idx = charidx(datastream[i - markersize]);
        if (--counts[tail_char_idx] == 1) dups--;
        if (++counts[head_char_idx] == 2) dups++;
    }

    return -1;
}

int main() {
    char buf[BUFSIZE];
    fgets(buf, BUFSIZE, stdin);
    printf("Part 1: %d\n", solve(buf, 4));
    printf("Part 2: %d\n", solve(buf, 14));
    return 0;
}
