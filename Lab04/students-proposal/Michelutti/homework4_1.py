# KAKURO

from pysmt.shortcuts import *

# Variables for cells where xCR means cell at col C row R
var={}
var["x11"]=Symbol("x11", INT)
var["x12"]=Symbol("x12", INT)
var["x13"]=Symbol("x13", INT)
var["x21"]=Symbol("x21", INT)
var["x22"]=Symbol("x22", INT)
var["x23"]=Symbol("x23", INT)
var["x24"]=Symbol("x24", INT)
var["x25"]=Symbol("x25", INT)
var["x31"]=Symbol("x31", INT)
var["x32"]=Symbol("x32", INT)
var["x34"]=Symbol("x34", INT)
var["x35"]=Symbol("x35", INT)
var["x44"]=Symbol("x44", INT)
var["x45"]=Symbol("x45", INT)


# constant for rows and columns
row1=Int(9)
row2=Int(13)
row3=Int(13)
row4=Int(7)
row5=Int(19)

col1=Int(9)
col2=Int(34)
col3_a=Int(4)
col3_b=Int(11)
col4=Int(3)

solver = Solver()


# All digits must be between 1 and 9
for key in var.keys():
    solver.add_assertion(And(GE(var[key],Int(1)), LE(var[key],Int(9))))

# Row Sums (and diversity)
# row 1
solver.add_assertion(Equals(row1,Plus([var["x11"],var["x21"],var["x31"]])))
solver.add_assertion(AllDifferent(var["x11"],var["x21"],var["x31"]))
# row 2
solver.add_assertion(Equals(row2,Plus([var["x12"],var["x22"],var["x32"]])))
solver.add_assertion(AllDifferent(var["x12"],var["x22"],var["x32"]))
# row 3
solver.add_assertion(Equals(row3,Plus([var["x13"],var["x23"]])))
solver.add_assertion(Not(Equals(var["x13"],var["x23"])))
# row 4
solver.add_assertion(Equals(row4,Plus([var["x44"],var["x24"],var["x34"]])))
solver.add_assertion(AllDifferent(var["x44"],var["x24"],var["x34"]))
# row 5
solver.add_assertion(Equals(row5,Plus([var["x45"],var["x25"],var["x35"]])))
solver.add_assertion(AllDifferent(var["x45"],var["x25"],var["x35"]))

# Column Sums (and diversity)
# col 1
solver.add_assertion(Equals(col1,Plus([var["x11"],var["x12"],var["x13"]])))
solver.add_assertion(AllDifferent(var["x11"],var["x12"],var["x13"]))
# col 2
solver.add_assertion(Equals(col2,Plus([var["x21"],var["x22"],var["x23"],var["x24"],var["x25"]])))
solver.add_assertion(AllDifferent(var["x21"],var["x22"],var["x23"],var["x24"],var["x25"]))
# col 3 
solver.add_assertion(Equals(col3_a,Plus([var["x31"],var["x32"]])))
solver.add_assertion(Not(Equals(var["x31"],var["x32"])))
solver.add_assertion(Equals(col3_b,Plus([var["x34"],var["x35"]])))
solver.add_assertion(Not(Equals(var["x34"],var["x35"])))
# col 4
solver.add_assertion(Equals(col4,Plus([var["x44"],var["x45"]])))
solver.add_assertion(Not(Equals(var["x44"],var["x45"])))

res = solver.solve()
if res:
	solution = list()
	sat_model = {el[0].symbol_name():el[1] for el in solver.get_model()}
	display=[[sat_model["x11"],sat_model["x21"],sat_model["x31"],None],
	    [sat_model["x12"],sat_model["x22"],sat_model["x32"],None],
	    [sat_model["x13"],sat_model["x23"],None,None],
	    [None,sat_model["x24"],sat_model["x34"],sat_model["x44"]],
	    [None,sat_model["x25"],sat_model["x35"],sat_model["x45"]]]
	for row  in display:
		string=""
		for el in row:
			if el==None:
				string+="- "
			else:
				string+=str(el)+" "
		print(string)
else:
	print("UNSAT")