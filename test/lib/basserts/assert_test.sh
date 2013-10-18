require 'lib/fail.sh'
require 'lib/basserts/assert.sh'

test_assert_fail() {
	declare local out

	out=$( assert "msg" false 2>&1 )
	[[ $? != 0 ]] || exit 1
	[[ $out == *msg* ]] || exit 1
}

test_assert() {
	declare local out

	out=$( assert "msg" true 2>&1 )
	[[ $? == 0 ]] || exit 1
	[[ -z $out ]] || exit 1
}

test_assert_equals_fail_no_message() {
	declare local out

	out=$( assert_equals "1" "2"  2>&1 )

	[[ $? != 0 ]] || exit 1

	local expected_msg="Expected value \[1\] does not equal \[2\]"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_equals_fail_with_message() {
	declare local out

	out=$( assert_equals "1" "2" "msg" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="msg"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_equals() {
	declare local out

	assert_equals "1" "1"  
	[[ $? = 0 ]] || exit 1

	assert_equals 1 1  
	[[ $? = 0 ]] || exit 1
}

test_assert_not_equals_fail_no_message() {
	declare local out

	out=$( assert_not_equals "1" "1"  2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="Value \[1\] equals \[1\] when it should not have"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_not_equals_fail_with_message() {
	declare local out

	out=$( assert_not_equals "1" "1" "msg" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="msg"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_not_equals() {
	declare local out

	assert_not_equals "1" "2"  
	[[ $? = 0 ]] || exit 1

	assert_not_equals 3 4  
	[[ $? = 0 ]] || exit 1
}

test_assert_string_equals_fail_no_message() {
	declare local out

	out=$( assert_string_equals "1*" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "*1" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "*1*" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "1*" "1 is only the first part" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "*123*" "1 is not a match.  but 123 is" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals " 1 " "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "1" " 1 " 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "" " " 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_equals "abc" "def" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="String \[def\] did not equal \[abc\]"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_string_equals_fail_with_message() {
	declare local out

	out=$( assert_string_equals "abc" "def" "msg" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="msg"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_string_equals() {
	assert_string_equals "" ""
	[[ $? = 0 ]] || exit 1

	assert_string_equals " " " "
	[[ $? = 0 ]] || exit 1

	assert_string_equals "1" "1"
	[[ $? = 0 ]] || exit 1

	assert_string_equals "1*" "1*"
	[[ $? = 0 ]] || exit 1

	assert_string_equals "*1" "*1"
	[[ $? = 0 ]] || exit 1

	assert_string_equals "*1*" "*1*"
	[[ $? = 0 ]] || exit 1
}

test_assert_string_starts_with_fail_no_message() {
	declare local out

	out=$( assert_string_starts_with "1*" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with "*1" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with "*1*" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with "1*" "1 is only the first part" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with "*123*" "1 is not a match.  but 123 is" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with " 1 " "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with "1" " 1 " 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_starts_with "abc" "def" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="String \[def\] did not start with \[abc\]"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_string_starts_with_fail_with_message() {
	declare local out

	out=$( assert_string_starts_with "abc" "def" "msg" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="msg"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_string_starts_with() {
	assert_string_starts_with "" ""
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with "" "123"
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with " " " "
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with "1" "123"
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with "1*" "1*23"
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with "*1" "*123"
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with "*1*" "*1*23"
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with "1" "123"  
	[[ $? = 0 ]] || exit 1

	assert_string_starts_with " " " 123"  
	[[ $? = 0 ]] || exit 1
}

test_assert_string_ends_with_fail_no_message() {
	declare local out

	out=$( assert_string_ends_with "1*" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with "*1" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with "*1*" "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with "*part" "1 is only the first part" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with "*123*" "1 is not a match.  but 123 is" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with " 1 " "1" 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with "1" " 1 " 2>&1 )
	[[ $? != 0 ]] || exit 1

	out=$( assert_string_ends_with "abc" "def" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="String \[def\] did not end with \[abc\]"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_string_ends_with_fail_with_message() {
	declare local out

	out=$( assert_string_ends_with "abc" "def" "msg" 2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="msg"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_string_ends_with() {
	assert_string_ends_with "" ""
	[[ $? = 0 ]] || exit 1

	assert_string_ends_with "" "123"
	[[ $? = 0 ]] || exit 1

	assert_string_ends_with " " "123 "
	[[ $? = 0 ]] || exit 1

	assert_string_ends_with "3" "123"
	[[ $? = 0 ]] || exit 1

	assert_string_ends_with "3*" "123*"
	[[ $? = 0 ]] || exit 1

	assert_string_ends_with "*3" "12*3"
	[[ $? = 0 ]] || exit 1

	assert_string_ends_with "*3*" "12*3*"
	[[ $? = 0 ]] || exit 1
}

test_assert_matches_fail() {
	declare local out

	out=$( assert_matches "5" "There is no 4 here"  2>&1 )
	[[ $? != 0 ]] || exit 1

	local expected_msg="Expression \[5\] did not match \[There is no 4 here\]"
	[[ $out == *$expected_msg*  ]] || exit 1
}

test_assert_matches() {
	assert_matches "1" "1"  
	[[ $? = 0 ]] || exit 1

	assert_matches "1*" "1"  
	[[ $? = 0 ]] || exit 1

	assert_matches "*1" "1"  
	[[ $? = 0 ]] || exit 1

	assert_matches "*1*" "1"  
	[[ $? = 0 ]] || exit 1

	assert_matches "1*" "1 is only the first part"  
	[[ $? = 0 ]] || exit 1

	assert_matches "*123*" "1 is not a match.  but 123 is"  
	[[ $? = 0 ]] || exit 1
}

