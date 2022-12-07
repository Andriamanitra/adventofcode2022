run: c_solution
	./c_solution < input.txt

debug: solution.c
	gcc -g -Wall -o c_solution solution.c
	gdb --tui --quiet ./c_solution

c_solution: solution.c
	gcc -Wall -o c_solution solution.c
