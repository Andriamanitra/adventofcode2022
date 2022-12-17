from collections import namedtuple

Position = namedtuple("Position", ("x", "y"))


def move(direction: str, pos: Position) -> Position:
    if direction == "U":
        return pos._replace(y=pos.y + 1)
    if direction == "D":
        return pos._replace(y=pos.y - 1)
    if direction == "L":
        return pos._replace(x=pos.x - 1)
    if direction == "R":
        return pos._replace(x=pos.x + 1)
    raise ValueError(f"Unknown direction '{direction}'")


def follow(head: Position, tail: Position) -> Position:
    dx = head.x - tail.x
    dy = head.y - tail.y
    if dx > 2 or dy > 2:
        raise ValueError(f"Tail is too far away from the head ({tail},{head})")
    if abs(dx) == 2 and abs(dy) == 2:
        return Position((head.x + tail.x) // 2, (head.y + tail.y) // 2)
    if dx == 2:
        return Position(tail.x + 1, tail.y + dy)
    if dx == -2:
        return Position(tail.x - 1, tail.y + dy)
    if dy == 2:
        return Position(tail.x + dx, tail.y + 1)
    if dy == -2:
        return Position(tail.x + dx, tail.y - 1)
    return tail


def part1(instructions: list[str]) -> int:
    head = Position(x=0, y=0)
    tail = Position(x=0, y=0)
    visited = set()
    for instruction in instructions:
        direction, num_steps = instruction.split()
        for i in range(int(num_steps)):
            head = move(direction, head)
            tail = follow(head, tail)
            visited.add(tail)
    return len(visited)


def part2(instructions: list[str]) -> int:
    rope = [Position(x=0, y=0) for _ in range(10)]
    visited = set()
    for instruction in instructions:
        direction, num_steps = instruction.split()
        for i in range(int(num_steps)):
            rope[0] = move(direction, rope[0])
            for i in range(1, len(rope)):
                rope[i] = follow(rope[i-1], rope[i])
            visited.add(rope[-1])
    return len(visited)


def main() -> None:
    with open("input.txt") as f:
        instructions = f.read().splitlines()
    print("Part 1:", part1(instructions))
    print("Part 2:", part2(instructions))


if __name__ == "__main__":
    main()
