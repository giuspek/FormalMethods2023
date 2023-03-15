from pysmt.shortcuts import *

# Number k is in position (i,j) -> xijk
msat = Solver()

vars = {"x{}{}{}".format(i,j,k): Symbol("x{}{}{}".format(i,j,k), BOOL) for i in range(1,10) for j in range(1,10) for k in range(1,10)}
sudoku_map = [	[0,0,0,9,0,0,1,0,0], 
				[0,0,0,0,0,0,0,3,5], 
				[0,0,8,0,7,0,0,0,0], 
				[0,0,0,0,5,0,9,0,0], 
				[1,0,4,3,0,0,2,0,0], 
				[0,7,0,0,0,9,0,0,3], 
				[0,0,5,0,2,7,0,0,0], 
				[0,4,9,0,0,0,8,0,0],
				[7,0,0,1,0,0,0,2,0]]


for k in range(1, 10):
	# For each row, the digit appears once
	for i in range(1,10):
		msat.add_assertion("TODO")

	# For each column, the digit appear once
	for j in range(1,10):
		msat.add_assertion("TODO")

	# For each 3x3 subgrid, the digit appear once
	for i in range(1,10,3):
		for j in range(1,10,3):
			msat.add_assertion("TODO")

for i in range(0,9):
	for j in range(0,9):
		# If cell x[i,j] is not 0, it means it is already filled, so...
		if sudoku_map[i][j] != 0:
			msat.add_assertion("TODO")
		else:
			# For each cell, we can have a single digit
			msat.add_assertion("TODO")


res = msat.solve()
if res:
	solution = list()
	sat_model = {el[0].symbol_name():el[1] for el in msat.get_model()}
	for i in range(0,9):
		row = list()
		for j in range(0,9):
			for k in range(1,10):
				if sat_model["x{}{}{}".format(i+1,j+1,k)] == Bool(True):
					row.append(k)
		solution.append(row)
	for line in solution:
		print(line)
else:
	print("UNSAT")