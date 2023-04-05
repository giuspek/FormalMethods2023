from pysmt.shortcuts import *

msat = Solver()
N = 8
vars = {"x{}{}".format(i,j):Symbol("x{}{}".format(i,j), BOOL) for i in range(1,N+1) for j in range(1,N+1)}

for i in range(1,N+1):
    msat.add_assertion(ExactlyOne([vars["x{}{}".format(i,j)] for j in range(1,N+1)]))

for j in range(1,N+1):
    msat.add_assertion(ExactlyOne([vars["x{}{}".format(i,j)] for i in range(1,N+1)]))

for i in range(1,N+1):
    for j in range(1,N+1):
        assertion = []
        m = i-1
        n = j+1
        # up right
        while m>0 and n<N+1:
            assertion.append(Not(vars["x{}{}".format(m,n)]))
            n=n+1
            m=m-1
        m = i-1
        n = j-1
        # up left
        while m>0 and n>0:
            assertion.append(Not(vars["x{}{}".format(m,n)]))
            m = m-1
            n = n-1
        m = i+1
        n = j+1
        # down right
        while m<N+1 and n<N+1:
            assertion.append(Not(vars["x{}{}".format(m,n)]))
            m = m+1
            n = n+1
        m = i+1
        n = j-1
        # down left
        while m<N+1 and n>0:
            assertion.append(Not(vars["x{}{}".format(m,n)]))
            m = m+1
            n = n-1        
        msat.add_assertion(Implies(vars["x{}{}".format(i,j)],(And(assertion))))

res = msat.solve()
uniqueness = list()
if res:
    solution = list()
    sat_model = {el[0].symbol_name():el[1] for el in msat.get_model()}
    for i in range (0,N):
        row = list()
        for j in range(0,N):
            if sat_model["x{}{}".format(i+1,j+1)] == Bool(True):
                row.append("Q")
                uniqueness.append(Symbol("x{}{}".format(i+1,j+1), BOOL))
            else:
                row.append(".")
        solution.append(row)
    for line in solution:
        print(line)
else:
    print("UNSAT")

# check uniqueness
msat.add_assertion(Not(And(uniqueness)))
res = msat.solve()

if res:
    print("not unique")
else:
    print("unique")
