package odinfmt_test

// Consecutive constant declarations
USER_ID                  :: 1          // user id
USER_NAME                :: "Barney"   // user name
LIST_ID                  :: 1          // list id
PREFERRED_TITLE_LANGUAGE :: "English"  // language
PREFERRED_TITLE_SOURCE   :: "Toshokan" // source

// Separate group after blank line
foo           := 1
bar_long_name := 2
x             := 3

// Procedure with local declarations
alignment_proc :: proc() {
	a          := 1
	longer_var := 2
	x          := 3

	// Separate group
	y     := 10
	short := 20
}

// Non-simple decls should break alignment groups
complex_proc :: proc() {}

simple_after :: 123
