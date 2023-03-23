import mathsat
from pysmt.shortcuts import *

def callback(model, converter, result):
    """Callback for msat_all_sat.

    This function is called by the MathSAT API everytime a new model
    is found. If the function returns 1, the search continues,
    otherwise it stops.
    """
    # Elements in model are msat_term .
    # Converter.back() provides the pySMT representation of a solver term.
    py_model = [converter.back(v) for v in model]
    result.append(And(py_model))
    return 1 # go on

# Number k is in position (i,j)
msat = Solver()
converter = msat.converter # .converter is a property implemented by all solvers

# At time i we are in position j
vars = {"x{}{}".format(i,j): Symbol("x{}{}".format(i,j), BOOL) for i in range(1,5) for j in range(1,5)}

for i in range(1,5):
	msat.add_assertion(ExactlyOne([vars["x{}{}".format(i,j)] for j in range(1,5)]))

for j in range(1,5):
	msat.add_assertion(ExactlyOne([vars["x{}{}".format(i,j)] for i in range(1,5)]))

msat.add_assertion(Implies(vars["x11"], Not(vars["x24"])))
msat.add_assertion(Implies(vars["x21"], Not(vars["x34"])))
msat.add_assertion(Implies(vars["x31"], Not(vars["x44"])))

msat.add_assertion(Implies(vars["x14"], Not(vars["x21"])))
msat.add_assertion(Implies(vars["x24"], Not(vars["x31"])))
msat.add_assertion(Implies(vars["x34"], Not(vars["x41"])))

msat.add_assertion(Implies(vars["x12"], Not(vars["x23"])))
msat.add_assertion(Implies(vars["x22"], Not(vars["x33"])))
msat.add_assertion(Implies(vars["x32"], Not(vars["x43"])))

msat.add_assertion(Implies(vars["x13"], Not(vars["x22"])))
msat.add_assertion(Implies(vars["x23"], Not(vars["x32"])))
msat.add_assertion(Implies(vars["x33"], Not(vars["x42"])))

result = []
print([converter.convert(vars["x13"]), converter.convert(vars["x23"])])

# Directly invoke the mathsat API !!!
# The second term is a list of "important variables"
mathsat.msat_all_sat(msat.msat_env(),
      [converter.convert(vars["x13"]), converter.convert(vars["x23"])],      # Convert the pySMT term into a MathSAT term
      lambda model : callback(model, converter, result))

count = 0
for el in result:
	count += 1
	print("Model", count, ":",el)
	print("**************************************")