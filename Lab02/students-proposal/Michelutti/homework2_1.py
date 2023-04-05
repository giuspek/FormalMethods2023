from pysmt.shortcuts import *

# Number k is in position (i,j) -> xijk
msat = Solver()

vars = {"x{}{}{}".format(i,j,k): Symbol("x{}{}{}".format(i,j,k), BOOL) for i in range(1,10) for j in range(1,10) for k in range(1,10)}
sudoku_map = [	[0,0,5,0,0,0,1,0,0],
                [0,0,0,4,9,2,0,0,0],
                [9,0,0,0,0,0,0,0,3],
                [0,3,0,0,0,0,0,6,0],
                [0,9,0,0,0,0,0,1,0],
                [0,2,0,0,0,0,0,7,0],
                [1,0,0,0,0,0,0,0,8],
                [0,0,0,6,8,7,0,0,0],
                [0,0,3,0,0,0,4,0,0]]

for k in range(1, 10):
	# For each row, the digit appears once
	for i in range(1,10):
		msat.add_assertion(ExactlyOne([vars[f"x{i}{col}{k}"] for col in range(1,10) ]))

	# For each column, the digit appear once
	for j in range(1,10):
		msat.add_assertion(ExactlyOne([vars[f"x{row}{j}{k}"] for row in range(1,10) ]))

	# For each 3x3 subgrid, the digit appear once
	for i in range(1,10,3):
		for j in range(1,10,3):
			msat.add_assertion(ExactlyOne([vars[f"x{x}{y}{k}"] for x in range(i,i+3) for y in range(j,j+3)]))

for i in range(0,9):
	for j in range(0,9):
		# If cell x[i,j] is not 0, it means it is already filled, so...
		if sudoku_map[i][j] != 0:
			msat.add_assertion(vars[f"x{i+1}{j+1}{sudoku_map[i][j]}"])
		else:
			# For each cell, we can have a single digit
			msat.add_assertion(ExactlyOne([vars[f"x{i+1}{j+1}{v}"] for v in range(1,10)]))


# diagonal constraint
# left to right
for k in range(1,10):{
	msat.add_assertion(ExactlyOne([vars[f"x{pos}{pos}{k}"] for pos in range(1,10) ]))
}
# right to left
for k in range(1,10):{
	msat.add_assertion(ExactlyOne([vars[f"x{pos}{10-pos}{k}"] for pos in range(1,10) ]))
}

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


# UNIQUENESS

sol_found=[ [2, 6, 5, 8, 7, 3, 1, 4, 9],
            [3, 1, 7, 4, 9, 2, 5, 8, 6],
            [9, 4, 8, 1, 5, 6, 7, 2, 3],
            [7, 3, 4, 9, 2, 1, 8, 6, 5],
            [5, 9, 6, 7, 4, 8, 3, 1, 2],
            [8, 2, 1, 3, 6, 5, 9, 7, 4],
            [1, 7, 2, 5, 3, 4, 6, 9, 8],
            [4, 5, 9, 6, 8, 7, 2, 3, 1],
            [6, 8, 3, 2, 1, 9, 4, 5, 7]]
for i in range(0,9):
	for j in range(0,9):
		msat.add_assertion(Not(vars[f"x{i+1}{j+1}{sol_found[i][j]}"]))
res = msat.solve()
if res:
	print("Solution is not unique:\n For example another solution is:\n\n")
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
	print("Solution is unique!")