from pysmt.shortcuts import *

msat = Solver()


# -- Variables --

# Number of Queens
# Chessboard is NxN tiles
N = 8

# Boolean variables
# xi_j = Queen in row i, column j
vars = {f'x{i}_{j}': Symbol(f'x{i}_{j}', BOOL) for i in range(N) for j in range(N)}


# -- Constraints --

# Exactly one Queen per row
for i in range(N):
    msat.add_assertion(ExactlyOne([
        vars[f'x{i}_{j}'] for j in range(N)
    ]))

# Exactly one Queen per column
for j in range(N):
    msat.add_assertion(ExactlyOne([
        vars[f'x{i}_{j}'] for i in range(N)
    ]))

# At most one Queen per bottom-left to top-right diagonal
for i in range(2 * N - 1):
    msat.add_assertion(AtMostOne([
        vars[f'x{i-d}_{d}'] for d in range(N) if i-d >= 0 and i-d < N
    ]))

# At most one Queen per top-left to bottom-right diagonal
for i in range(-N, N):
    msat.add_assertion(AtMostOne([
        vars[f'x{i+d}_{d}'] for d in range(N) if i+d >= 0 and i+d < N
    ]))


# -- Solve --
res = msat.solve()


# -- Display Output --
if res:
    sat_model = {el[0].symbol_name():el[1] for el in msat.get_model()}
    for i in range(N):
        for j in range(N):
            if sat_model[f'x{i}_{j}'] == Bool(True):
                print('X', end='')
            else:
                print('•', end='')
        print('')
else:
    print("UNSAT")