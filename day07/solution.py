def main(lines: list[str]) -> None:
    workdir = ["/"]

    # dir_sizes is a dictionary that maps directory (a tuple of directory
    # names) to its total size (including sizes of subdirectories)
    # we use tuples as the keys because Python requires dictionary keys
    # to be hashable (strings would also work, but lists are not hashable)
    dir_sizes = {tuple(workdir): 0}

    for line in lines:
        words = line.split()

        # "$ ls" and "dir <whatever>" can be ignored since they don't
        # affect the sizes
        if words[0] == "$" and words[1] == "cd":
            cd_arg = words[2]
            if cd_arg == "/":  # cd back to root
                workdir = ["/"]
            elif cd_arg == "..":  # cd to parent directory
                workdir.pop()
            else:
                workdir.append(cd_arg)
        elif words[0].isdecimal():  # line represents a file
            file_size = int(words[0])

            # add current file size to current workdir *and all its parents*
            for i in range(len(workdir)):
                directory = tuple(workdir[:i+1])
                if directory not in dir_sizes:
                    dir_sizes[directory] = file_size
                else:
                    dir_sizes[directory] += file_size

    #  Part 1
    # ========
    sum_sizes = 0
    for size in dir_sizes.values():
        if size <= 100_000:
            sum_sizes += size

    # or, alternatively, with list comprehension:
    # sum_sizes = sum(size for size in dir_sizes.values() if size <= 100_000)

    print("Part 1:", sum_sizes)

    #  Part 2
    # ========
    TOTAL_DISK_SPACE = 70_000_000
    REQUIRED_UNUSED_SPACE = 30_000_000
    ROOT = ("/",)

    already_free_space = TOTAL_DISK_SPACE - dir_sizes[ROOT]
    required = REQUIRED_UNUSED_SPACE - already_free_space
    to_delete = dir_sizes[ROOT]

    for size in dir_sizes.values():
        if size >= required and size < to_delete:
            to_delete = size

    # or, alternatively, with list comprehension:
    # to_delete = min(size for size in dir_sizes.values() if size > required)

    print("Part 2:", to_delete)


if __name__ == "__main__":
    with open("input.txt") as file:
        lines = file.read().splitlines()
    main(lines)
