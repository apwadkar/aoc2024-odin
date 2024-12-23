package day2

import "core:testing"

@(test)
test_check_parts :: proc(t: ^testing.T) {
  parts0 := "1"
  parts1 := "2"
  ascending := true
  is_safe := check_parts(parts0, parts1, ascending)
  testing.expect(t, is_safe)
}

@(test)
test_check_line_with_skip :: proc(t: ^testing.T) {
  parts := []string{"1", "2", "3"}
  is_safe := check_line(parts, true)
  testing.expect(t, is_safe)
}

@(test)
test_check_line_with_skip_end :: proc(t: ^testing.T) {
  parts := []string{"1", "2", "3", "5", "6", "9", "15"}
  is_safe := check_line(parts, true)
  testing.expect(t, is_safe)
}

@(test)
test_check_line_with_skip_long_mid :: proc(t: ^testing.T) {
  parts := []string{"1", "2", "3", "7", "6", "9", "11"}
  is_safe := check_line(parts, true)
  testing.expect(t, is_safe)
}

@(test)
test_check_line_with_skip_fail :: proc(t: ^testing.T) {
  parts := []string{"1", "2", "3", "7", "8", "13"}
  is_safe := check_line(parts, true)
  testing.expect(t, !is_safe)
}

@(test)
test_check_line_with_change_order :: proc(t: ^testing.T) {
  parts := []string{"6", "4", "7", "10", "12", "13", "15", "17"}
  is_safe := check_line(parts, true)
  testing.expect(t, is_safe)
}
