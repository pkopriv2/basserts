require 'lib/bashum/lang/fail.sh'

assert() {
	if (( $# < 2 )) 
	then
		fail "usage: assert <msg> <cmd>"
	fi

	msg=$1; shift 
	#echo -n "Running assertion: "

	if $*
	then
		:
	else
		echo "Failed: "
		fail "$msg" 
	fi

}

assert_equals() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_equals <expected> <actual> [<message>]"
	fi

	assert "${3:-"Expected value [$1] does not equal [$2]"}" \
		builtin test $1 = $2
}

assert_not_equals() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_not_equals <expected> <actual> [<message>]"
	fi

	assert "${3:-"Value [$1] equals [$2] when it should not have"}" \
		builtin test $1 != $2
}

assert_string_equals() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_string_equals <expected> <actual> [<message>]"
	fi

	string=$1; shift
	[[ "$*" == "$string" ]]

	assert_equals 0 $? \
		"${3:-"String [$*] did not equal [$string]"}"
}

assert_string_starts_with() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_string_starts_with <expected> <actual> [<message>]"
	fi

	string=$1; shift
	[[ "$*" == "$string"* ]]

	assert_equals 0 $? \
		"${3:-"String [$*] did not start with [$string]"}"
}

assert_string_ends_with() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_string_ends_with <expected> <actual> [<message>]"
	fi

	string=$1; shift
	[[ "$*" == *"$string" ]]

	assert_equals 0 $? \
		"${3:-"String [$*] did not end with [$string]"}"
}

assert_matches() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_matches <expected> <actual>"
	fi

	expression=$1; shift
	[[ $* == *$expression* ]]

	assert_equals 0 $? \
		"${3:-"Expression [$expression] did not match [$*]"}"
}

assert_failure() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_failure <message match> <cmd>"
	fi

	expected=$1; shift
	actual=$( $* 2>&1 )

	assert_not_equals $? 0 \
		"Expected command to fail" 

	assert_matches "$expected" "$actual"
}

assert_true() {
	if (( $# < 1 )) 
	then
		fail "usage: assert_true <cmd>"
	fi

	$*

	assert_equals 0 $? \
		"Expected true or success"
}

assert_false() {
	if (( $# < 1 )) 
	then
		fail "usage: assert_true <cmd>"
	fi

	$*
	
	assert_not_equals 0 $? \
		"Expected false" 
}

assert_contains() {
	if (( $# < 2 )) 
	then
		fail "usage: assert_contains <expected> <item> [<item>]*"
	fi

	local elem=$1; shift
	array_contains $elem "$@"

	assert_equals 0 $? \
		"Items did not contain: $elem"
}

assert_empty() {
	assert_equals 0 $# \
		"Input was not empty."
}

