package day1

import "core:fmt"
import "core:math"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

part1 :: proc() {
  fmt.println("Day 1 Part 1")

  data, err := os.read_entire_file_from_filename_or_err("inputs/day1.txt")
  file_str := string(data)

  left_list: [dynamic]int
  defer delete(left_list)
  right_list: [dynamic]int
  defer delete(right_list)

  for str in strings.split_lines_iterator(&file_str) {
    parts := strings.split(str, "   ")

    left, _ := strconv.parse_int(parts[0])
    append(&left_list, left)
    right, _ := strconv.parse_int(parts[1])
    append(&right_list, right)
  }

  slice.sort(left_list[:])
  slice.sort(right_list[:])

  sum := 0
  for i in 0 ..< len(left_list) {
    sum += math.abs(left_list[i] - right_list[i])
  }

  fmt.println("Sum: ", sum)
}

part2 :: proc() {
  fmt.println("Day 1 Part 2")

  data, err := os.read_entire_file_from_filename_or_err("inputs/day1.txt")
  file_str := string(data)

  left_list: [dynamic]int
  defer delete(left_list)
  right_list: [dynamic]int
  defer delete(right_list)

  for str in strings.split_lines_iterator(&file_str) {
    parts := strings.split(str, "   ")

    left, _ := strconv.parse_int(parts[0])
    append(&left_list, left)
    right, _ := strconv.parse_int(parts[1])
    append(&right_list, right)
  }

  slice.sort(left_list[:])
  slice.sort(right_list[:])
  fmt.printfln("Lengths: %d, %d", len(left_list), len(right_list))

  score := 0

  i, j := 0, 0
  for i < len(left_list) {
    if j >= len(right_list) {
      fmt.printfln("Breaking early at i=%d, j=%d", i, j)
      break
    }

    counter := 0
    for ; j < len(right_list) && right_list[j] <= left_list[i]; j += 1 {
      if (right_list[j] == left_list[i]) {
        fmt.printfln("Found %d at %d in sorted right", left_list[i], j)
        counter += 1
      }
    }

    score += counter * left_list[i]

    i += 1
  }

  fmt.println("Score: ", score)
}
