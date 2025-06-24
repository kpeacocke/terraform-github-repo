package test

import rego.v1

deny contains msg if {
	true
	msg := "This is always denied"
}

deny2 contains msg if {
	true
	msg := "This is also always denied"
}
