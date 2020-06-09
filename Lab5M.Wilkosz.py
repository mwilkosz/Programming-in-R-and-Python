def clear_all():
    gl = globals().copy()
    for var in gl:
        if var[0] == '': continue
        if 'func' in str(globals()[var]): continue
        if 'module' in str(globals()[var]): continue

        del globals()[var]

clear_all()

import numpy as np
import numpy.linalg as la

##1
def getDistanceMatrix(arr):
    n, d = arr.shape
    ed = np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            ed[i,j] = la.norm(arr[i]- arr[j])
    return ed

arr = np.array([[1,2,3],[2,3,4],[4,5,6],[5,6,7]])

getDistanceMatrix(arr)

##2
def eliminateDistances(f,Q):
    m,n = Q.shape
    A = Q.copy()
    randoms = np.random.rand(m,n)
    A = A.astype(np.float32)
    A[f > randoms] = np.inf
    return A

eliminateDistances(0.5,arr)
##3
def calculateFloydWarshall(Q):
    N = len(Q)
    A = Q.copy()
    for k in range(N):
        for i in range(N):
            for j in range(N):
                if Q[i, j] > Q[i, k] + Q[k, j]:
                    A[i, j] = Q[i, k] + Q[k, j]
    return A

##4
n = 100
d = 3

set_of_points = np.random.normal(10,2,(n,d))

Q = getDistanceMatrix(set_of_points)
E = eliminateDistances(0.5,Q)
F = calculateFloydWarshall(E)

E1 = eliminateDistances(0.9,Q)
F1 = calculateFloydWarshall(E1)

E2 = eliminateDistances(0.99,Q)
F2 = calculateFloydWarshall(E2)

np.sum(Q)
F1[np.isinf(F1)] = 0
F2[np.isinf(F2)] = 0

np.sum(F)
np.sum(F1)
np.sum(F2)

print("Result obtained for orginal matrix: {}, for 50%: {}, for 90%: {}, for 99%: {}."
      .format(np.sum(Q),np.sum(F),np.sum(F1),np.sum(F2)))

##5

def generateSystem(X):
    m,n = X.shape
    A = np.random.normal(0,100,(m,n))
    sum_i = A.sum(axis = 0)
    sum_i_abs = abs(sum_i)
    sum_i_abs = list(sum_i_abs)
    A = np.fill_diagonal(A,float(sum_i_abs))
    return A,B


