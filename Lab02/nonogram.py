from pysmt.shortcuts import *

# Number k is in position (i,j)
msat = Solver()

ancillas_index = 1
nonogram_column_hints = [2,3,4,2,2]
nonogram_row_hints = [2,3,3,(3,1),1]
nonogram_size = (len(nonogram_row_hints), len(nonogram_column_hints))
vars = {"x{}{}".format(i,j): Symbol("x{}{}".format(i,j), BOOL) for i in range(1,len(nonogram_row_hints)+1) for j in range(1,len(nonogram_column_hints)+1)}

# Row 1

msat.add_assertion(Or(
	And(vars["x11"], vars["x12"], Not(vars["x13"]), Not(vars["x14"]), Not(vars["x15"])),
	And(vars["x12"], vars["x13"], Not(vars["x11"]), Not(vars["x14"]), Not(vars["x15"])),
	And(vars["x13"], vars["x14"], Not(vars["x11"]), Not(vars["x12"]), Not(vars["x15"])),
	And(vars["x14"], vars["x15"], Not(vars["x13"]), Not(vars["x11"]), Not(vars["x12"]))
	)
)

# Row 2

msat.add_assertion(Or(
	And(vars["x21"], vars["x22"], vars["x23"], Not(vars["x24"]), Not(vars["x25"])),
	And(vars["x22"], vars["x23"], vars["x24"], Not(vars["x21"]), Not(vars["x25"])),
	And(vars["x23"], vars["x24"], vars["x25"], Not(vars["x21"]), Not(vars["x22"]))
	)
)

# Row 3

msat.add_assertion(Or(
	And(vars["x31"], vars["x32"], vars["x33"], Not(vars["x34"]), Not(vars["x35"])),
	And(vars["x32"], vars["x33"], vars["x34"], Not(vars["x31"]), Not(vars["x35"])),
	And(vars["x33"], vars["x34"], vars["x35"], Not(vars["x31"]), Not(vars["x32"]))
	)
)

# Row 4

msat.add_assertion(And(vars["x41"],vars["x42"],vars["x43"],Not(vars["x44"]),vars["x45"]))

# Row 5
msat.add_assertion(ExactlyOne([vars["x5{}".format(i)] for i in range(1,6)]))

# Column 1

msat.add_assertion(Or(
	And(vars["x11"], vars["x21"], Not(vars["x31"]), Not(vars["x41"]), Not(vars["x51"])),
	And(vars["x21"], vars["x31"], Not(vars["x11"]), Not(vars["x41"]), Not(vars["x51"])),
	And(vars["x31"], vars["x41"], Not(vars["x11"]), Not(vars["x21"]), Not(vars["x51"])),
	And(vars["x41"], vars["x51"], Not(vars["x11"]), Not(vars["x21"]), Not(vars["x31"]))
	)
)

# Column 2

msat.add_assertion(Or(
	And(vars["x12"], vars["x22"], vars["x32"], Not(vars["x42"]), Not(vars["x52"])),
	And(vars["x22"], vars["x32"], vars["x42"], Not(vars["x12"]), Not(vars["x52"])),
	And(vars["x32"], vars["x42"], vars["x52"], Not(vars["x22"]), Not(vars["x12"]))
	)
)

# Column 3

msat.add_assertion(Or(
	And(vars["x13"], vars["x23"], vars["x33"], vars["x43"], Not(vars["x53"])),
	And(vars["x23"], vars["x33"], vars["x43"], vars["x53"], Not(vars["x13"]))
	)
)

# Column 4

msat.add_assertion(Or(
	And(vars["x14"], vars["x24"], Not(vars["x34"]), Not(vars["x44"]), Not(vars["x54"])),
	And(vars["x24"], vars["x34"], Not(vars["x14"]), Not(vars["x44"]), Not(vars["x54"])),
	And(vars["x34"], vars["x44"], Not(vars["x14"]), Not(vars["x24"]), Not(vars["x54"])),
	And(vars["x44"], vars["x54"], Not(vars["x14"]), Not(vars["x24"]), Not(vars["x34"]))
	)
)

# Column 5

msat.add_assertion(Or(
	And(vars["x15"], vars["x25"], Not(vars["x35"]), Not(vars["x45"]), Not(vars["x55"])),
	And(vars["x25"], vars["x35"], Not(vars["x15"]), Not(vars["x45"]), Not(vars["x55"])),
	And(vars["x35"], vars["x45"], Not(vars["x15"]), Not(vars["x25"]), Not(vars["x55"])),
	And(vars["x45"], vars["x55"], Not(vars["x15"]), Not(vars["x25"]), Not(vars["x35"]))
	)
)

res = msat.solve()
if res:
	solution = list()
	sat_model = {el[0].symbol_name():el[1] for el in msat.get_model()}
	for i in range(1,nonogram_size[0]+1):
		row = ""
		for j in range(1,nonogram_size[1]+1):
			if sat_model["x{}{}".format(i,j)] == Bool(True):
				row += "*"
			else:
				row += " "
		solution.append(row)
	for line in solution:
		print(line)
else:
	print("UNSAT")