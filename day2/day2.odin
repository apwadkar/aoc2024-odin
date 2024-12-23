package day2

import "core:fmt"
import "core:math"
import "core:os"
import "core:strconv"
import "core:strings"

@(private)
check_parts :: proc(parts0, parts1: string, ascending: bool) -> bool {
  num0, _ := strconv.parse_int(parts0)
  num1, _ := strconv.parse_int(parts1)
  diff := math.abs(num0 - num1)
  is_safe := true
  fmt.fprintf(os.stderr, "Numbers: (%d, %d), Ascending: %t, Diff: %d", num0, num1, num0 < num1, diff)
  if ascending && num0 > num1 {
    is_safe = false
    fmt.fprint(os.stderr, " * (Descends)")
  } else if !ascending && num0 < num1 {
    is_safe = false
    fmt.fprint(os.stderr, " * (Ascends)")
  }
  if !(diff >= 1 && diff <= 3) {
    is_safe = false
    fmt.fprint(os.stderr, " * (Diff out of range)")
  }
  fmt.fprintln(os.stderr)
  return is_safe
}

@(private)
check_line :: proc(parts: []string, skip := false) -> bool {
  if !skip {
    num0, _ := strconv.parse_int(parts[0])
    num1, _ := strconv.parse_int(parts[1])

    ascending := num0 < num1
    is_safe := check_parts(parts[0], parts[1], ascending)
    if !is_safe {
      return false
    }

    for i in 2 ..< len(parts) {
      is_safe = check_parts(parts[i - 1], parts[i], ascending)
      if !is_safe {
        return false
      }
    }
  } else {
    num0, _ := strconv.parse_int(parts[0])
    num1, _ := strconv.parse_int(parts[1])

    ascending := num0 < num1
    is_safe := check_parts(parts[0], parts[1], ascending)
    if !is_safe {
      return false
    }

    skipped := false
    for i in 2 ..< len(parts) {
      is_safe = check_parts(parts[i - 1], parts[i], ascending)
      if !is_safe {
        if skipped {
          return false
        }

        if i - 2 == 0 {
          num0, _ := strconv.parse_int(parts[i - 2])
          num1, _ := strconv.parse_int(parts[i])
          ascending = num0 < num1
        }
        is_safe = check_parts(parts[i - 2], parts[i], ascending)
        if !is_safe {
          if i == len(parts) - 1 {
            return true
          }
          return false
        }
        skipped = true
      }
    }
  }
  return true
}

part1 :: proc() {
  fmt.println("Day 2 Part 1")

  data, err := os.read_entire_file_from_filename_or_err("inputs/day2.txt")
  file_str := string(data)

  safe_count := 0
  for line in strings.split_lines_iterator(&file_str) {
    fmt.fprintfln(os.stderr, "Line: %s", line)

    parts := strings.split(line, " ")
    is_safe := check_line(parts)

    if is_safe {
      safe_count += 1
    } else {
      fmt.fprintln(os.stderr, "Unsafe line: ", line)
    }
    fmt.fprintln(os.stderr)
  }

  fmt.println("Safe: ", safe_count)
}

part2 :: proc() {
  fmt.println("Day 2 Part 2")

  data, err := os.read_entire_file_from_filename_or_err("inputs/day2.txt")
  file_str := string(data)

  safe_count := 0
  for line in strings.split_lines_iterator(&file_str) {
    fmt.fprintfln(os.stderr, "Line: %s", line)

    parts := strings.split(line, " ")
    parts_dyn := make([dynamic]string, len(parts))
    for part in parts {
      append(&parts_dyn, part)
    }

    is_safe := check_line(parts)

    if is_safe {
      safe_count += 1
      fmt.fprintln(os.stderr, "Safe line: ", line)
    } else {
      fmt.fprintln(os.stderr, "Unsafe line: ", line)

      fmt.fprint(os.stdout, "Unsafe line: ", line)
    }
    fmt.fprintln(os.stderr)
  }

  fmt.println("Safe: ", safe_count)
}
