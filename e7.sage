from collections import defaultdict
from math import factorial
from itertools import chain, combinations
w_0 = '123142314354231435426542314354265431765432456134752431654234567'
w_lower_p = '123142314354231435426542314354265431'
w_upper_p = '765432456134752431654234567'
cartan = [[2,0,-1,0,0,0,0],[0,2,0,-1,0,0,0],[-1,0,2,-1,0,0,0],[0,-1,-1,2,-1,0,0],[0,0,0,-1,2,-1,0],[0,0,0,0,-1,2,-1],[0,0,0,0,0,-1,2]]
n=7

std_rep = {1: defaultdict(int, {7: 9, 8: 10, 11: 12, 13: 15, 16: 18, 19: 22, 35: 38, 39: 41, 42: 44, 45: 46, 47: 48, 49: 50}), 2: defaultdict(int, {5: 6, 7: 8, 9: 10, 20: 23, 24: 26, 27: 29, 28: 30, 31: 33, 34: 37, 47: 49, 48: 50, 51: 52}), 3: defaultdict(int, {5: 7, 6: 8, 12: 14, 15: 17, 18: 21, 22: 25, 32: 35, 36: 39, 40: 42, 43: 45, 48: 51, 50: 52}), 4: defaultdict(int, {4: 5, 8: 11, 10: 12, 17: 20, 21: 24, 25: 28, 29: 32, 33: 36, 37: 40, 45: 47, 46: 48, 52: 53}), 5: defaultdict(int, {3: 4, 11: 13, 12: 15, 14: 17, 24: 27, 26: 29, 28: 31, 30: 33, 40: 43, 42: 45, 44: 46, 53: 54}), 6: defaultdict(int, {2: 3, 13: 16, 15: 18, 17: 21, 20: 24, 23: 26, 31: 34, 33: 37, 36: 40, 39: 42, 41: 44, 54: 55}), 7: defaultdict(int, {1: 2, 16: 19, 18: 22, 21: 25, 24: 28, 26: 30, 27: 31, 29: 33, 32: 36, 35: 39, 38: 41, 55: 56})}

std_dual = {x:defaultdict(int, {b:a for (a,b) in y.items()}) for (x,y) in std_rep.items()}
matrices = [matrix(56,56,{(b-1,a-1):1 for (a,b) in simple[1].items()}) for simple in sorted(std_rep.items())]

highest_1 = matrix(56,56,{(0, 37): 1,(1, 40): 1, (2, 43): 1, (3, 45): 1, (4, 47): 1, (5, 49): 1, (6, 50): 1, (7, 51): 1, (10, 52): 1, (12, 53): 1, (15, 54): 1, (18, 55): 1})
highest_1.set_immutable()

highest_1_2 = matrix(56,56,{(0, 34): -1, (1, 38): -1, (2, 41): -1, (3, 44): -1, (4, 46): -1, (5, 48): -1, (8, 50): 1, (9, 51): 1, (11, 52): 1, (14, 53): 1, (17, 54): 1, (21, 55): 1})
highest_1_2.set_immutable()

m1=matrix(56,56,{(1, 22): 1, (2, 25): 1, (3, 28): 1, (4, 31): 1, (6, 34): 1, (8, 37): 1, (18, 48): 1, (21, 49): 1, (24, 51): 1, (27, 52): 1, (30, 53): 1, (33, 54): 1})
m1.set_immutable()
m2=matrix(56,56,{(0, 22): 1, (2, 29): -1, (3, 32): -1, (4, 35): -1, (6, 38): -1, (8, 40): -1, (15, 48): 1, (17, 49): 1, (20, 51): 1, (23, 52): 1, (26, 53): 1, (33, 55): -1})
m2.set_immutable()
m3=matrix(56,56,{(0, 25): -1, (1, 29): -1, (3, 36): 1, (4, 39): 1, (6, 41): 1, (8, 43): 1, (12, 48): 1, (14, 49): 1, (16, 51): 1, (19, 52): 1, (26, 54): -1, (30, 55): -1})
m3.set_immutable()
m4=matrix(56,56,{(0, 28): 1, (1, 32): 1, (2, 36): 1, (4, 42): -1, (6, 44): -1, (8, 45): -1, (10, 48): 1, (11, 49): 1, (13, 51): 1, (19, 53): -1, (23, 54): -1, (27, 55): -1})
m4.set_immutable()
m5=matrix(56,56,{(0, 31): -1, (1, 35): -1, (2, 39): -1, (3, 42): -1, (6, 46): 1, (7, 48): 1, (8, 47): 1, (9, 49): 1, (13, 52): -1, (16, 53): -1, (20, 54): -1, (24, 55): -1})
m5.set_immutable()
m7=matrix(56,56,{(0, 34): 1, (1, 38): 1, (2, 41): 1, (3, 44): 1, (4, 46): 1, (5, 48): 1, (8, 50): -1, (9, 51): -1, (11, 52): -1, (14, 53): -1, (17, 54): -1, (21, 55): -1})
m7.set_immutable()
m9=matrix(56,56,{(0, 37): -1, (1, 40): -1, (2, 43): -1, (3, 45): -1, (4, 47): -1, (5, 49): -1, (6, 50): -1, (7, 51): -1, (10, 52): -1, (12, 53): -1, (15, 54): -1, (18, 55): -1})
m9.set_immutable()

highest_2 = defaultdict(int,{(1,m1):1,(2,m2):-1,(3,m3):1,(4,m4):-1,(5,m5):1,(7,m7):-1,(9,m9):1})

def commutator(a,b):
    return a*b-b*a

#return the simple root alpha_i in the lie algebra as a function on the basis vectors of the minuscule fundamental rep
def root_vec(i):
    return lambda x: std_rep[i][x]

#return the simple root alpha_i in the lie algebra as a function on the basis vectors of the adjoint rep
def root_mat(i):
    return lambda x: commutator(matrices[i],x)

def dual_vec(i):
    return lambda x: std_dual[i][x]

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
                    temp[k] = str(new)
                    temp_sorted = sorted(temp)
                    temp_sign= Permutation([temp.index(i)+1 for i in temp_sorted]).sign()
                    output[tuple(temp_sorted)] = output[tuple(temp_sorted)] + temp_sign*coeff
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

def mat_action(i,vec):
    output = defaultdict(int)
    for basis_vec in vec.keys():
        coeff = vec[basis_vec]
        if coeff != 0:
            for k in range(len(basis_vec)):
                temp = list(basis_vec)
                new = root_mat(i-1)(temp[k])
                if new in temp or len(new.dict().values()) == 0:
                    pass
                else:
                    temp_coeff = list(new.dict().values())[0]
                    new = new/temp_coeff
                    new.set_immutable()
                    temp[k] = new
                    output[tuple(temp)] = output[tuple(temp)] + coeff*temp_coeff
    return output

#act on the second fundamental rep contained in the tensor power of the first and seventh
def mixed_action(i,vec):
    output = defaultdict(int)
    for basis_vec in vec.keys():
        coeff = vec[basis_vec]
        if coeff != 0:
            std_vec = basis_vec[0]
            mat = basis_vec[1]
            new_std = std_rep[i][std_vec]
            new_matrix = commutator(matrices[i-1],mat)
            if new_std != 0:
                output[(new_std,mat)] = output[(new_std,mat)] + coeff
            if len(new_matrix.dict().values()) != 0:
                temp_coeff = list(new_matrix.dict().values())[0]
                new_matrix = new_matrix / temp_coeff
                new_matrix.set_immutable()
                output[(std_vec,new_matrix)] = output[(std_vec,new_matrix)] + coeff*temp_coeff
    return output

def dual_mixed_action(i,vec):
    output = defaultdict(int)
    for basis_vec in vec.keys():
        coeff = vec[basis_vec]
        if coeff != 0:
            std_vec = basis_vec[0]
            mat = basis_vec[1]
            new_std = std_dual[i][std_vec]
            new_matrix = commutator(matrices[i-1].transpose(),mat)
            if new_std != 0:
                output[(new_std,mat)] = output[(new_std,mat)] + coeff
            if len(new_matrix.dict().values()) != 0:
                new_matrix.set_immutable()
                output[(std_vec,new_matrix)] = output[(std_vec,new_matrix)] + coeff
    return output

#find all simple roots that move down, return a list of (weight,vec,root) triples corresponding to the simple roots moving down
def find_moves(vec):
    down = []
    for i in range(1,n+1):
        new_vec = root_action(i,vec)
        temp = set(new_vec.values())
        if not(temp == set([0]) or len(temp) == 0):
            down.append((new_vec,i))
    return down

def dual_moves(vec):
    down = []
    for i in range(1,n+1):
        new_vec = dual_action(i,vec)
        temp = set(new_vec.values())
        if not(temp == set([0]) or len(temp) == 0):
            down.append((new_vec,i))
    return down

def mat_moves(vec):
    down = []
    for i in range(1,n+1):
        new_vec = mat_action(i,vec)
        temp = set(new_vec.values())
        if not(temp == set([0]) or len(temp) == 0):
            down.append((new_vec,i))
    return down

def mixed_moves(vec):
    down = []
    for i in range(1,n+1):
        new_vec = mixed_action(i,vec)
        temp = set(new_vec.values())
        if not(temp == set([0]) or len(temp) == 0):
            down.append((new_vec,i))
    return down

def dual_mixed_moves(vec):
    down = []
    for i in range(1,n+1):
        new_vec = dual_mixed_action(i,vec)
        temp = set(new_vec.values())
        if not(temp == set([0]) or len(temp) == 0):
            down.append((new_vec,i))
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

#[37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,55,56,57,-7,36,31,35,34,33,32]
#return the functions phi(m,i) in the form of polynomials in the parameters of the lusztig torus
def funs():
    highest_vecs = [defaultdict(int,{(highest_1,):1}),highest_2,defaultdict(int,{(highest_1,highest_1_2):1}),defaultdict(int,{('1','2','3','4'):1}),defaultdict(int,{('1','2','3'):1}),defaultdict(int,{('1','2'):1}),defaultdict(int,{('1',):1})]
    funs = []
    for m in [37]:
        uleqm = None
        irrep_index = None
        if m>0:
            uleqm = w_0[:m]
            irrep_index = int(uleqm[-1])
        else:
            uleqm = ""
            irrep_index = n
        curr = ([int(i==(irrep_index)) for i in range(1,n+1)],highest_vecs[irrep_index-1]) #highest weight
        for transp in uleqm[::-1]:
            next_weight = [x-curr[0][int(transp)-1]*y for (x,y) in zip(curr[0],cartan[int(transp)-1])]
            next_vec = curr[1]
            for i in range(curr[0][int(transp)-1]):
                if irrep_index-1 in [0,2]:
                    next_vec = mat_action(int(transp),next_vec)
                elif irrep_index-1 in [3,4,5,6]:
                    next_vec = root_action(int(transp),next_vec)
                else:
                    next_vec = mixed_action(int(transp),next_vec)
            curr = (next_weight, next_vec)
        #now current should be the starting weight/vector pair 
        #step 3: figure out expressions for these functions evaluated on the lusztig torus
        finished_paths = []
        print(curr[0])
        unfinished_paths = [(curr[1],w_upper_p,(),())]
        #unfinished_paths = [(curr[1],())]
        while len(unfinished_paths) != 0:
            current = unfinished_paths.pop()
            if irrep_index-1 in [0,2]:
                moves = mat_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    if len(current[0].keys())>1:
                        print([(t1.dict(),t2.dict()) for (t1,t2) in current[0].keys()])
                        #temp = list(current[0].keys())
                        #print(temp[0][0]==temp[1][1] and temp[0][1]==temp[1][0])
                        continue
                    print(current[3])
                    finished_paths.append((current[0],current[2])) #change this back later
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),),current[3]+(str(down[1]),)))
            elif irrep_index-1 in [3,4,5,6]:
                moves = find_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    if len(current[0].keys())>1:
                        print(m,current[0],"skipped")
                        continue
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
            elif irrep_index-1 in [1]:
                moves = mixed_moves(current[0])
                if len(moves) == 0: #this should be a lowest weight
                    finished_paths.append((current[0],current[2]))
                for down in moves:
                    positions = find_occurrence(str(down[1]),current[1])
                    for pos in positions:
                        unfinished_paths.append((down[0],current[1][pos:],current[2]+(str(-pos),)))
            else:
                print(irrep_index, m)
        funs.append((m,irrep_index,finished_paths))
    #step 4: evaluate the functions on the lusztig torus
    polys = []
    for (phi_idx,irrep_idx,fun) in funs:
        temp = []
        if not isinstance(fun[0][0],defaultdict):
            for term in fun:
                coeff = abs(fun[0][0].dict().values()[0])
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
def plucker():
    funs = []
    for i in range(1,57):
        vec = defaultdict(int,{(str(i),):1}) 
        #step 3: figure out expressions for these functions evaluated on the lusztig torus
        finished_paths = []
        unfinished_paths = [(vec,)+(w_upper_p[::-1],)+((),)]
        while len(unfinished_paths) != 0:
            current = unfinished_paths.pop()
            moves = dual_moves(current[0])
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
                exponent[26-int(i)+1] = exponent[26-int(i)+1] + 1
            temp.append((exponent,coeff))
        polys.append((label,to_polynomial(temp)))
    return polys
"""
def plucker():
    funs = []
    for i in range(1,57):
        vec = defaultdict(int,{(str(i),):1}) 
        #step 3: figure out expressions for these functions evaluated on the lusztig torus
        finished_paths = []
        unfinished_paths = [(vec,)+(w_upper_p[::-1],)+((),)]
        while len(unfinished_paths) != 0:
            current = unfinished_paths.pop()
            moves = dual_moves(current[0])
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
                exponent[26-int(i)+1] = exponent[26-int(i)+1] + 1
            temp.append((exponent,coeff))
        polys.append((label,to_polynomial(temp)))
    return polys

#print(funs())
#myfile = open("plucker",'w')
#myfile.write("R=QQ[a_1..a_27]\n")

print("R=QQ[a_1..a_27]")
for (label,func) in plucker():
    print('p_'+str(label)+'=',func)
    #myfile.write('p_'+str(label)+'=')
    #myfile.write(func+'\n')
#myfile.close()
#print(funs())
