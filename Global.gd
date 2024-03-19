extends Node

const MAX_TRY_COUNT = 10
var try_count = MAX_TRY_COUNT
var correct_count = 0

var is_action_allowed = true

func reset_counts():
	try_count = MAX_TRY_COUNT
	correct_count = 0
	is_action_allowed = true
