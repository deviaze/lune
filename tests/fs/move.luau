local fs = require("@lune/fs")
local utils = require("./utils")

-- Make sure our bin dir exists

fs.writeDir("bin")

-- Write both of our files

fs.writeFile("bin/move_test_binary", utils.binaryBlob)
fs.writeFile("bin/move_test_json.json", utils.jsonBlob)

-- Move / rename them to something else, to test we
-- change the prefix in the names from "move" to "moved"

fs.move("bin/move_test_binary", "bin/moved_test_binary")
fs.move("bin/move_test_json.json", "bin/moved_test_json.json")

-- Make sure reading the files we just
-- wrote gets us back the original strings

assert(
	fs.readFile("bin/moved_test_binary") == buffer.tostring(utils.binaryBlob),
	"Binary file round-trip resulted in different strings"
)

assert(
	fs.readFile("bin/moved_test_json.json") == utils.jsonBlob,
	"JSON file round-trip resulted in different strings"
)

-- Remove the files and make sure
-- the APIs say they no longer exist

fs.removeFile("bin/moved_test_binary")
fs.removeFile("bin/moved_test_json.json")

assert(not fs.isDir("bin/moved_test_binary"), "Binary after removal isDir check failed")
assert(not fs.isFile("bin/moved_test_binary"), "Binary after removal isFile check failed")

assert(not fs.isDir("bin/moved_test_json.json"), "JSON after removal isDir check failed")
assert(not fs.isFile("bin/moved_test_json.json"), "JSON after removal isFile check failed")

-- Also make sure files and dirs at the paths before moving do not exist

assert(not fs.isDir("bin/moved_test_binary"), "Binary file path still existed after moving")
assert(not fs.isFile("bin/moved_test_binary"), "Binary file path still existed after moving")

assert(not fs.isDir("bin/moved_test_json.json"), "JSON file path still existed after moving")
assert(not fs.isFile("bin/moved_test_json.json"), "JSON file path still existed after moving")
