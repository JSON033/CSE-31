#include <stdio.h>
#define MAXSIZE 4096

/**
* You can use this recommended helper function
* Returns true if partial_line matches pattern, starting from
* the first char of partial_line.
*/
int matches_leading(char *partial_line, char *pattern) {
	// Implement if desire 

	return 0;
}

/**
* You may assume that all strings are properly null terminated
* and will not overrun the buffer set by MAXSIZE
*
* Implementation of the rgrep matcher function
*/
int rgrep_matches(char *line, char *pattern) {
	char *lpos = line;
	char *prev = 0;
	char *start = pattern;
	char *next = 0;
	char *p2 = 0;
	char *check = 0;
	char *lcheck = 0;
	//	int i = 0;
	int result;
	int loops = 0;

	while (*line != '\0') {
		loops++;
		//	printf("%s", line);
		//	printf("%d", loops);
		//	printf("\n%s\n", pattern);
		if (pattern != start && *line != *pattern && *pattern != '+' && *pattern != '?' && *pattern != '.' && *pattern != '\\') {
			//	printf("6");
			result = rgrep_matches(lpos + 1, start);
			if (result == 1) {
				return 1;
			}
			if (result == 0) {
				return 0;
			}
		}
		if (loops == 3) {
			//		printf("7");
			result = rgrep_matches(lpos + 1, start);
			if (result == 1) {
				return 1;
			}
			if (result == 0) {
				return 0;
			}
		}

		//	p2 = pattern + 2;
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}
		while (*pattern != *line && *pattern != '+' && *pattern != '?' && *pattern != '.' && *pattern != '\\' && pattern == start && *next != '?') {
			line = line + 1;
			if (*line == '\0') {
				return 0;
			}
		}
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}
		while (*pattern == *line && *next != '?' && *pattern != '\\' && *pattern != '?' && *pattern != '.' && *pattern != '+') {
			pattern = pattern + 1;
			line = line + 1;
			next = pattern + 1;
			if (*next == '?') {
				break;
			}
			if (*pattern == '\0') {
				return 1;
			}
		}
		//	p2 = pattern + 2;
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}

		/*	if (*pattern != *line && *next == '?' && *line != *p2) {
		result = rgrep_matches(line, start);
		if (result == 1) {
		return 1;
		}
		}
		*/
		//p2 = pattern + 2;
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}

		if (*next == '?' && *pattern != '\\') {
			p2 = pattern + 2;
			if (*pattern == *p2 && *line == *pattern) {
				pattern = pattern + 3;
				line = line + 1;
				loops = 0;
			}
			else	if (*line == *pattern) {
				line = line + 1;
				pattern = pattern + 2;
				loops = 0;
			}
			else if (*p2 == '\0') {
				return 1;
			}
			else	if (*line == *p2) {
				line = line + 1;
				pattern = pattern + 3;
				loops = 0;
			}


		}
		//	p2 = pattern + 2;
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}

		if (*pattern == '+') {
			if (*prev == '.') {
				check = pattern - 2;
				lcheck = line - 2;
				if (*check != '\\') {
					while (*line != '\0') {
						line++;
						if (*line == *next) {
							pattern = pattern + 1;
							loops = 0;
							break;
						}

					}
					if (*check == '\\'&& *lcheck != '\\') {
						if (*line == '.') {
							while (*line == '.') {
								line++;
							}
							pattern = pattern + 1;
							loops = 0;
						}
					}
				}
			}
			else	if (*line == *prev) {
				while (*line == *prev) {

					line = line + 1;
					if (*line == *next) {
						pattern = pattern + 1;
					}
				}
				pattern = pattern + 1;
				loops = 0;
			}

			else {
				pattern = pattern + 1;

			}
			if (*pattern == '\0') {
				return 1;
			}
		}
		//	p2 = pattern + 2;
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}
		if (*pattern == '.') {
			if (*line != '\n') {
				line = line + 1;
				pattern = pattern + 1;
				loops = 0;

				if (*pattern == '\0') {
					return 1;
				}
			}

		}
		//		p2 = pattern + 2;
		prev = pattern - 1;
		if (*pattern != '\0') {
			next = pattern + 1;
		}

		if (*pattern == '\\') {
		//	printf("\n%s\n", next);
			if (*line == *next) {
				pattern = pattern + 2;
				line = line + 1;
				loops = 0;

			}
			else if (*line == *next && *line == '\\') {
				pattern = pattern + 2;
				line = line + 1;
				loops = 0;
			}

			if (*pattern == '\0') {
				return 1;
			}

		}


		if (*pattern == '\0') {
			return 1;
		}
	}

	if (*pattern == '\0') {
		return 1;
	}

	return 0;
}

int main(int argc, char **argv) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <PATTERN>\n", argv[0]);
		return 2;
	}

	/* we're not going to worry about long lines */
	char buf[MAXSIZE];

	while (!feof(stdin) && !ferror(stdin)) {
		if (!fgets(buf, sizeof(buf), stdin)) {
			break;
		}
		if (rgrep_matches(buf, argv[1])) {
			fputs(buf, stdout);
			fflush(stdout);
		}
	}

	if (ferror(stdin)) {
		perror(argv[0]);
		return 1;
	}

	return 0;
}
