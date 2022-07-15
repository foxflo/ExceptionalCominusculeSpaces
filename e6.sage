from collections import defaultdict
from math import factorial

w_0 = '123143124354234513426542345613452431'
w_lower_p = '12314312435423451342'
w_upper_p = '6542345613452431'

"""
#dual to above, this uses E6/P1
w_0 = '625645624534254365421342543165432456'
w_lower_p = '62564562453425436542'
w_upper_p = '1342543165432456'
"""
n=6
cartan = [[2,0,-1,0,0,0],[0,2,0,-1,0,0],[-1,0,2,-1,0,0],[0,-1,-1,2,-1,0],[0,0,0,-1,2,-1],[0,0,0,0,-1,2]]
std_dual = {1:defaultdict(int,{1:2,11:13,14:16,17:18,19:20,21:23}),2:defaultdict(int,{4:5,6:7,8:10,19:21,20:23,22:24}),3:defaultdict(int,{2:3,9:11,12:14,15:17,20:22,23:24}),4:defaultdict(int,{3:4,7:9,10:12,17:19,18:20,24:25}),5:defaultdict(int,{4:6,5:7,12:15,14:17,16:18,25:26}),6:defaultdict(int,{6:8,7:10,9:12,11:14,13:16,26:27})} #1st fundamental irreducible representation
std_rep = {x:defaultdict(int, {b:a for (a,b) in y.items()}) for (x,y) in std_dual.items()} #sixth fundamental representation
matrices = [matrix(27,27,defaultdict(int,{(b-1,a-1):1 for (a,b) in simple[1].items()})) for simple in sorted(std_dual.items())] #adjoint, defined from the first fundamental rep

#Find the labels of the functions \phi(m,i), where m is in ]r_k,r]\cap e(i) U {t_k|k in I}, in terms of the D's
#Note that the last n of these correspond to the frozen variables
def func_labels():
    nonexch = [w_0.rindex(str(i))+1 for i in range(1,n+1)]
    mutable = [i for i in range(len(w_lower_p)+1,len(w_0)+1) if i not in nonexch]
    frozen = [-6]+[w_lower_p.rindex(str(i))+1 for i in range(1,n)]        
    #return mutable+frozen
    return frozen

#return the simple root alpha_i in the lie algebra as a function on the basis vectors of the 6th fundamental rep
def root_vec(i):
    return lambda x: std_rep[i][x]

def dual_vec(i):
    return lambda x: std_dual[i][x]

def commutator(a,b):
    return a*b-b*a

#act on weight vector for an irrep by the simple root alpha_i
#vect is in the form of a dictionary whose keys are tuples of strings of the form (a_1,a_2,...a_i) representing the vector e_{a_1} wedge ... wedge e_{a_i}, and values are the coefficient of that basis vector
def root_action(i,vec):
    output = defaultdict(int)
    for basis_vec in vec.keys():
        coeff = vec[basis_vec]
        if coeff != 0:
            for k in range(len(basis_vec)):
                temp = list(basis_vec)
                new = root_vec(i)(int(temp[k]))
                if str(new) in temp or new == 0:
                    pass
                else:
                    temp[k] = new
                    output[tuple(map(str,temp))] = output[tuple(map(str,temp))] + coeff
    return output

def dual_action(i,vec):
    output = defaultdict(int)
    for basis_vec in vec.keys():
        coeff = vec[basis_vec]
        if coeff != 0:
            for k in range(len(basis_vec)):
                temp = list(basis_vec)
                new = dual_vec(i)(int(temp[k]))
                if str(new) in temp or new == 0:
                    pass
                else:
                    temp[k] = new
                    output[tuple(map(str,temp))] = output[tuple(map(str,temp))] + coeff
    return output

#find all simple roots that move down, return a list of (weight,vec,root) triples corresponding to the simple roots moving down
def find_moves(vec):
    down = []
    for i in range(n):
        new_vec = root_action(i+1,vec)
        if len(new_vec.keys()) > 0:
            down.append((new_vec,i+1))
    return down

def dual_moves(vec):
    down = []
    for i in range(n):
        new_vec = dual_action(i+1,vec)
        if len(new_vec.keys()) > 0:
            down.append((new_vec,i+1))
    return down

def mat_moves(vec):
    down = []
    for i in range(n):
        new_vec = commutator(matrices[i],vec)
        if len(new_vec.dict().values())>0:
            down.append((new_vec,i+1))
    return down

def dual_mat(vec):
    down = []
    for i in range(n):
        new_vec = commutator(matrices[i].transpose(),vec)
        if len(new_vec.dict().values())>0:
            down.append((new_vec,i+1))
    return down

#input: list of exponent vectors as tuples
#output: polynomial as a string
def to_polynomial(poly):
    terms = ['*'.join(['a_{}^{}'.format(str(i),term[0][i-1]) for i in range(1,len(w_upper_p)+1)]) for term in poly]
    coeffs = [(term[1],str(reduce(lambda x,y:x*y,[factorial(x) for x in term[0]]))) for term in poly]
    return '+'.join('({}/{})*{}'.format(coeff[0],coeff[1],term) for (coeff,term) in zip(coeffs,terms))

#find all occurrences of character a in string b
def find_occurrence(a,b):
    positions = []
    for i in range(len(b)):
        if a==b[i]:
            positions.append(i-len(b))
    return positions

def explore():
    start = (0,1,0,0,0,0)
    covers = defaultdict(list)
    unfinished = [start]
    while len(unfinished) != 0:
        curr = unfinished.pop()
        for i in range(6):
            if curr[i] > 0:
                new = tuple([a-b*curr[i] for (a,b) in zip(curr,cartan[i])])
                if (curr,i+1) not in covers[new]:
                    covers[new].append((curr,i+1))
                unfinished.append(new)
    paths = []
    for i in range(6):
        curr = tuple(cartan[i])
        path = [i+1]
        while curr != (0,1,0,0,0,0):
            path.append(covers[curr][0][1])
            curr = covers[curr][0][0]
        paths.append((i+1,path))
    return paths


def find_highest():
    steps = explore()
    mats = []
    for i in range(6):
        start = commutator(matrices[i],matrices[i].transpose())
        path = steps[i][1]
        for step in path:
            start = commutator(matrices[step-1].transpose(),start)
        mats.append(start)
    return mats[-1]

"""
#compute generalized minors for E6/P1
def funs():
    lowest_vecs = [defaultdict(int,{('27',):1}),(find_highest()*(1/2)).transpose(),defaultdict(int,{('26','27'):1}),defaultdict(int,{('1','2','3'):1}),defaultdict(int,{('1','2'):1}),defaultdict(int,{('1',):1})]
    funs = []
    nakayama = [None,6,2,5,4,3,1]
    for m in func_labels():
        vec = None
        uleqm = None
        irrep_index = None
        if m>0:
            uleqm = w_0[:m]
            irrep_index = nakayama[int(uleqm[-1])]
        else:
            uleqm = ""
            irrep_index = 6
        curr = ([-int(i==(nakayama[irrep_index])) for i in range(1,n+1)],lowest_vecs[irrep_index-1]) #highest weight
        for transp in uleqm[::-1]:
            next_weight = [x-curr[0][int(transp)-1]*y for (x,y) in zip(curr[0],cartan[int(transp)-1])]
            next_vec = curr[1]
            for i in range(-curr[0][int(transp)-1]):
                if irrep_index-1 in [0,2]:
                    next_vec = dual_action(int(transp),next_vec)
                elif irrep_index-1 in [3,4,5]:
                    next_vec = root_action(int(transp),next_vec)
                else:
                    next_vec = commutator(matrices[int(transp)-1].transpose(),next_vec)
            curr = (next_weight, next_vec)
        if irrep_index == 2:
            vec = curr[1]
        else:
            vec = defaultdict(int,{x:1 for (x,y) in curr[1].items()})
        #now current should be the starting weight/vector pair 
        #step 3: figure out expressions for these functions evaluated on the lusztig torus
        finished_paths = []
        unfinished_paths = [(vec,)+(w_upper_p,)+((),())]
        while len(unfinished_paths) != 0:
            current = unfinished_paths.pop()
            if irrep_index-1 in [0,2]:
                moves = dual_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    if len(current[0].keys())>1:
                        #print(m,current[0],"skipped")
                        continue
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
            elif irrep_index-1 in [3,4,5]:
                moves = find_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    if len(current[0].keys())>1:
                        #print(m,current[0],"skipped")
                        continue
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),),current[3]+(down[1],)))
            else: #adjoint
                moves = dual_mat(current[0])
                if len(moves) == 0:
                    #if len(current[0].keys())>1:
                        #print(current[0])
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
        funs.append((m,irrep_index,finished_paths))
    #print(funs)
    #step 4: evaluate the functions on the lusztig torus
    polys = []
    for (phi_idx,irrep_idx,fun) in funs:
        temp = []
        if not isinstance(fun[0][0],defaultdict):
            for term in fun:
                coeff = abs(list(fun[0][0].dict().values())[0])
                exponent = [0]*len(w_upper_p)
                for i in term[1]:
                    exponent[int(i)-1] = exponent[int(i)-1]+1
                temp.append((exponent,coeff))
            polys.append((phi_idx,irrep_idx,to_polynomial(temp)))
        else:
            for term in fun:
                coeff = list(term[0].values())[0]
                exponent = [0]*len(w_upper_p)
                for i in term[1]:
                    exponent[int(i)-1] = exponent[int(i)-1] + 1
                temp.append((exponent,coeff))
            polys.append((phi_idx,irrep_idx,to_polynomial(temp)))
    return polys
"""

#return the functions phi(m,i) in the form of polynomials in the parameters of the lusztig torus
def funs():
    highest_vecs = [defaultdict(int,{('1',):1}),find_highest()*(1/2),defaultdict(int,{('1','2'):1}),defaultdict(int,{('1','2','3'):1}),defaultdict(int,{('26','27'):1}),defaultdict(int,{('27',):1})]
    funs = []
    for m in func_labels():
        vec = None
        uleqm = None
        irrep_index = None
        if m>0:
            uleqm = w_0[:m]
            irrep_index = int(uleqm[-1])
        else:
            uleqm = ""
            irrep_index = 6
        curr = ([int(i==(irrep_index)) for i in range(1,n+1)],highest_vecs[irrep_index-1]) #highest weight
        for transp in uleqm[::-1]:
            next_weight = [x-curr[0][int(transp)-1]*y for (x,y) in zip(curr[0],cartan[int(transp)-1])]
            next_vec = curr[1]
            for i in range(curr[0][int(transp)-1]):
                if irrep_index-1 in [0,2,3]:
                    next_vec = dual_action(int(transp),next_vec)
                elif irrep_index-1 in [4,5]:
                    next_vec = root_action(int(transp),next_vec)
                else:
                    next_vec = commutator(matrices[int(transp)-1],next_vec)
            curr = (next_weight, next_vec)
        if irrep_index == 2:
            vec = curr[1]
        else:
            vec = defaultdict(int,{x:1 for (x,y) in curr[1].items()})
        #now current should be the starting weight/vector pair 
        #step 3: figure out expressions for these functions evaluated on the lusztig torus
        finished_paths = []
        unfinished_paths = [(vec,)+(w_upper_p,)+((),())]
        while len(unfinished_paths) != 0:
            current = unfinished_paths.pop()
            if irrep_index-1 in [0,2,3]:
                moves = dual_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    if len(current[0].keys())>1:
                        #print(m,current[0],"skipped")
                        continue
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
            elif irrep_index-1 in [4,5]:
                moves = find_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    if len(current[0].keys())>1:
                        #print(m,current[0],"skipped")
                        continue
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),),current[3]+(down[1],)))
            else: #adjoint
                moves = mat_moves(current[0])
                if len(moves) == 0:
                    #if len(current[0].keys())>1:
                        #print(current[0])
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
        funs.append((m,irrep_index,finished_paths))
    #step 4: evaluate the functions on the lusztig torus
    polys = []
    for (phi_idx,irrep_idx,fun) in funs:
        temp = []
        if not isinstance(fun[0][0],defaultdict):
            for term in fun:
                coeff = abs(list(fun[0][0].dict().values())[0])
                exponent = [0]*len(w_upper_p)
                for i in term[1]:
                    exponent[int(i)-1] = exponent[int(i)-1]+1
                temp.append((exponent,coeff))
            polys.append((phi_idx,irrep_idx,to_polynomial(temp)))
        else:
            for term in fun:
                coeff = list(term[0].values())[0]
                exponent = [0]*len(w_upper_p)
                for i in term[1]:
                    exponent[int(i)-1] = exponent[int(i)-1] + 1
                temp.append((exponent,coeff))
            polys.append((phi_idx,irrep_idx,to_polynomial(temp)))
    return polys


def plucker():
    funs = []
    for i in range(1,28):
        vec = defaultdict(int,{(str(i),):1}) 
        #step 3: figure out expressions for these functions evaluated on the lusztig torus
        finished_paths = []
        unfinished_paths = [(vec,)+(w_upper_p,)+((),)]
        while len(unfinished_paths) != 0:
            current = unfinished_paths.pop()
            moves = find_moves(current[0])
            if len(moves) == 0: #this should be a lowest weight
                finished_paths.append((current[0],current[2]))
            for down in moves:
                positions = find_occurrence(str(down[1]),current[1])
                for pos in positions:
                    unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
        funs.append((i,finished_paths))
    #step 4: evaluate the functions on the lusztig torus
    polys = []
    for (label,fun) in funs:
        temp = []
        for term in fun:
            coeff = list(term[0].values())[0]
            exponent = [0]*len(w_upper_p)
            for i in term[1]:
                exponent[15-int(i)+1] = exponent[15-int(i)+1] + 1
            temp.append((exponent,coeff))
        polys.append((label,to_polynomial(temp)))
    return polys

print("R=QQ[reverse(a_1..a_16)]")
for poly in plucker():
    print("p_{}={}".format(poly[0], poly[1]))
    
for f in funs():
    print("f_{}={}".format(f[0],f[2]))
