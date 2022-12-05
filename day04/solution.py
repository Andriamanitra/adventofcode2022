Range = tuple[int, int]


def part1(pairs: list[tuple[Range, Range]]) -> int:
    return sum(
        1 for (a0, a1), (b0, b1) in pairs
        if a0 <= b0 <= b1 <= a1 or b0 <= a0 <= a1 <= b1
    )


def part2(pairs: list[tuple[Range, Range]]) -> int:
    return sum(
        1 for (a0, a1), (b0, b1) in pairs
        if not (a1 < b0 or b1 < a0)
    )


def main(input_file_name) -> None:
    pairs = []
    with open(input_file_name) as f:
        for line in f:
            leftstr, rightstr = line.split(",")
            a0, _, a1 = leftstr.partition("-")
            b0, _, b1 = rightstr.partition("-")
            left = int(a0), int(a1)
            right = int(b0), int(b1)
            pairs.append((left, right))

    print(part1(pairs))
    print(part2(pairs))


if __name__ == "__main__":
    main("input.txt")
