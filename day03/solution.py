def value(letter: str) -> int:
    return (ord(letter) & 31) + 26 * letter.isupper()


def part1(lines: list[str]) -> int:
    result = 0
    for rucksack in lines:
        halfway = len(rucksack) // 2
        left = set(rucksack[:halfway])
        right = set(rucksack[halfway:])
        common_letters = set.intersection(left, right)
        assert len(common_letters) == 1
        letter = common_letters.pop()
        result += value(letter)
    return result


def part2(lines: list[str]) -> int:
    GROUP_SIZE = 3
    result = 0
    while lines:
        group = [set(lines.pop()) for i in range(GROUP_SIZE)]
        common_letters = set.intersection(*group)
        assert len(common_letters) == 1
        letter = common_letters.pop()
        result += value(letter)
    return result


def main():
    INPUT_FILE_NAME = __file__.replace("solution.py", "input.txt")

    with open(INPUT_FILE_NAME) as f:
        lines = [line.strip() for line in f.readlines()]

    answer1 = part1(lines)
    print(answer1)

    answer2 = part2(lines)
    print(answer2)


if __name__ == "__main__":
    main()
