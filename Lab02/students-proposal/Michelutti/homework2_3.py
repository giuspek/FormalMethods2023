# n-queen with 8 queeens
from pysmt.shortcuts import *

msat = Solver()


# xXY means there is a queen at coordinate (X,Y)
vars = {f"x{x}{y}": Symbol(f"x{x}{y}", BOOL) for x in range(0,8) for y in range(0,8)}

# each row must contain exactly one queen
for row in range(0,8):
    msat.add_assertion(ExactlyOne(
        [vars[f"x{row}{col}"] for col in range(0,8)]
    ))

# each column must contain exactly one queen
for col in range(0,8):
    msat.add_assertion(ExactlyOne(
        [vars[f"x{row}{col}"] for row in range(0,8)]
    ))

# no 2 queens can stand in the same diagonal
#left to right
for row in range(0,7):
    msat.add_assertion(
        AtMostOne(
            [vars[f"x{x}{x+row}"] for x in range(0,8-row)] 
        )
    )
for col in range(1,7):
    msat.add_assertion(
        AtMostOne(
            [vars[f"x{x+col}{x}"] for x in range(0,8-col)] 
        )
    )

#right to left
for row in range(1,8):
    msat.add_assertion(
        AtMostOne(
            [vars[f"x{x}{row-x}"] for x in range(0,row+1)] 
        )
    )
for col in range(1,7):
    msat.add_assertion(
        AtMostOne(
            [vars[f"x{x}{9-col-x}"] for x in range(1,9-col)] 
        )
    )

res = msat.solve()
if res:
	solution = list()
	sat_model = {el[0].symbol_name():el[1] for el in msat.get_model()}
	for i in range(0,8):
		row = list()
		for j in range(0,8):
			if sat_model["x{}{}".format(i,j)] == Bool(True):
				row.append(1)
			else:
				row.append(0)
		solution.append(row)
	for line in solution:
		print(line)
else:
	print("UNSAT")


# UNIQUENESS
solution=[
	[0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 1, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 1, 0, 0, 0],
    [0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0]]

sol_list=[]
for x in range(0,8):
	for y in range(0,8):
		if solution[x][y]==1:
			sol_list.append((x,y))

msat.add_assertion(Not(And([vars[f"x{a}{b}"] for (a,b) in sol_list])))
			
res = msat.solve()
if res:
	print("Solution is not unique! \nAlso found:")
	solution = list()
	sat_model = {el[0].symbol_name():el[1] for el in msat.get_model()}
	for i in range(0,8):
		row = list()
		for j in range(0,8):
			if sat_model["x{}{}".format(i,j)] == Bool(True):
				row.append(1)
			else:
				row.append(0)
		solution.append(row)
	for line in solution:
		print(line)
else:
	print("Solution is unique!")