"""
temp = second_rep()
elts = list(set(temp.keys())) #+ [a for b in [[vs[0] for vs in v] for v in temp.values()] for a in b]
elts.append((0,-1,0,0,0,0,0))
covers = []
labels = {}
for (k,v) in temp.items(): 
    for val in v: 
        covers.append((elts.index(val[0]),elts.index(k))) 
        labels[covers[-1]] = val[1] 
P = Poset((range(len(elts)),covers))
#P.show(figsize=[20,20],cover_labels = labels)
H = P.hasse_diagram()
paths = H.all_paths(elts.index((0,-1,0,0,0,0,0)),elts.index((0,0,0,0,-1,0,2)))
fin_paths = []
for path in paths:
    steps = []
    for i in range(len(path)-1):
        steps.append(str(labels[(path[i],path[i+1])]))
    fin_paths.append(steps[::-1])
#now temp contains all paths betweeon the things that I want in the second rep
'765432456134257431654234567'

finished = []
unfinished = []
for path in fin_paths:
    unfinished.append((path,w_upper_p,()))
    while len(unfinished)!=0:
        curr = unfinished.pop()
        if len(curr[0])!=0:
            for pos in fuid_occurrence(curr[0][0],curr[1]):
                unfinished.append((curr[0][1:],curr[1][pos:],curr[2]+(str(-pos),)))
        else:
            finished.append(curr[2])

exponents = [([len(find_occurrence(str(i),exp_vec)) for i in range(1,28)],1) for exp_vec in finished]
exponents = [(exp[0],2^len(find_occurrence(2,exp[0]))) for exp in exponents]
to_polynomial(exponents)

def second_rep():
    start = funs()
    unfinished = [(tuple(start[0]),start[1])]
    covers = defaultdict(list)
    while len(unfinished) != 0:
        (curr_w,curr_v) = unfinished.pop()
        moves = mixed_moves(curr_v)
        for move in moves:
            next_w = tuple([x-y for (x,y) in zip(curr_w,cartan[move[1]-1])])
            next_v = move[0]
            new_v = defaultdict(int)
            for (b_vec,coeff) in next_v.items():
                b_mat_coeff = list(b_vec[1].dict().values())[0]
                temp = b_vec[1]/b_mat_coeff
                temp.set_immutable()
                new_v[(b_vec[0],temp)]=new_v[(b_vec[0],temp)]+coeff*b_mat_coeff
            if tuple(set(new_v.values())) in [(),(0,)]:
                continue
            if (next_w,move[1]) not in covers[curr_w]:
                covers[curr_w].append((next_w,move[1]))
                unfinished.append((next_w,new_v))
    return covers

"""

from collections import defaultdict
from math import factorial
from itertools import chain, combinations, product

w_0 = '123142314354231435426542314354265431765432456134257431654234567'
w_lower_p = '123142314354231435426542314354265431'
w_upper_p = '765432456134257431654234567'
cartan = [[2,0,-1,0,0,0,0],[0,2,0,-1,0,0,0],[-1,0,2,-1,0,0,0],[0,-1,-1,2,-1,0,0],[0,0,0,-1,2,-1,0],[0,0,0,0,-1,2,-1],[0,0,0,0,0,-1,2]]
n=7

#compute root actions on weight spaces of the minuscule fundamental rep associated to the 7th fundamental weight
#this is the 56-dimensional representation with highest weight omega_7.

def minus_rep():
    global cartan,n
    start = (0,0,0,0,0,0,1)
    covers = defaultdict(list)
    unfinished = [start]
    while len(unfinished) != 0:
        curr = unfinished.pop(0)
        for i in range(n):
            if curr[i] > 0:
                new = tuple([a-b*curr[i] for (a,b) in zip(curr,cartan[i])])
                if (new,i+1) not in covers[curr]:
                    covers[curr].append((new,i+1))
                    unfinished.append(new)
    elt_list = list(covers.keys())
    elt_list.append((0,0,0,0,0,0,-1))
    return elt_list
    mats = [[],[],[],[],[],[],[]]
    for rels in covers.items():
        for rel in rels[1]:
            mats[rel[1]-1].append((elt_list.index(rels[0]),elt_list.index(rel[0])))
    rep = {i+1:defaultdict(int,{a+1:b+1 for (a,b) in mats[i]}) for i in range(n)}
    return rep

numbering = {1: (0, 0, 0, 0, 0, 0, 1),  2: (0, 0, 0, 0, 0, 1, -1),  3: (0, 0, 0, 0, 1, -1, 0),  4: (0, 0, 0, 1, -1, 0, 0),  5: (0, 1, 1, -1, 0, 0, 0),  6: (0, -1, 1, 0, 0, 0, 0),  7: (1, 1, -1, 0, 0, 0, 0),  8: (1, -1, -1, 1, 0, 0, 0),  9: (-1, 1, 0, 0, 0, 0, 0),  10: (-1, -1, 0, 1, 0, 0, 0),  11: (1, 0, 0, -1, 1, 0, 0),  12: (-1, 0, 1, -1, 1, 0, 0),  13: (1, 0, 0, 0, -1, 1, 0),  14: (0, 0, -1, 0, 1, 0, 0),  15: (-1, 0, 1, 0, -1, 1, 0),  16: (1, 0, 0, 0, 0, -1, 1),  17: (0, 0, -1, 1, -1, 1, 0),  18: (-1, 0, 1, 0, 0, -1, 1),  19: (1, 0, 0, 0, 0, 0, -1),  20: (0, 1, 0, -1, 0, 1, 0),  21: (0, 0, -1, 1, 0, -1, 1),  22: (-1, 0, 1, 0, 0, 0, -1),  23: (0, -1, 0, 0, 0, 1, 0),  24: (0, 1, 0, -1, 1, -1, 1),  25: (0, 0, -1, 1, 0, 0, -1),  26: (0, -1, 0, 0, 1, -1, 1),  27: (0, 1, 0, 0, -1, 0, 1),  28: (0, 1, 0, -1, 1, 0, -1),  29: (0, -1, 0, 1, -1, 0, 1),  30: (0, -1, 0, 0, 1, 0, -1),  31: (0, 1, 0, 0, -1, 1, -1),  32: (0, 0, 1, -1, 0, 0, 1),  33: (0, -1, 0, 1, -1, 1, -1),  34: (0, 1, 0, 0, 0, -1, 0),  35: (1, 0, -1, 0, 0, 0, 1),  36: (0, 0, 1, -1, 0, 1, -1),  37: (0, -1, 0, 1, 0, -1, 0),  38: (-1, 0, 0, 0, 0, 0, 1),  39: (1, 0, -1, 0, 0, 1, -1),  40: (0, 0, 1, -1, 1, -1, 0),  41: (-1, 0, 0, 0, 0, 1, -1),  42: (1, 0, -1, 0, 1, -1, 0),  43: (0, 0, 1, 0, -1, 0, 0),  44: (-1, 0, 0, 0, 1, -1, 0),  45: (1, 0, -1, 1, -1, 0, 0),  46: (-1, 0, 0, 1, -1, 0, 0),  47: (1, 1, 0, -1, 0, 0, 0),  48: (-1, 1, 1, -1, 0, 0, 0),  49: (1, -1, 0, 0, 0, 0, 0),  50: (-1, -1, 1, 0, 0, 0, 0),  51: (0, 1, -1, 0, 0, 0, 0),  52: (0, -1, -1, 1, 0, 0, 0),  53: (0, 0, 0, -1, 1, 0, 0),  54: (0, 0, 0, 0, -1, 1, 0),  55: (0, 0, 0, 0, 0, -1, 1), 56: (0, 0, 0, 0, 0, 0, -1)}

steps = {1: (0, 0, 0, 0, 0, 0, 0),  2: (0, 0, 0, 0, 0, 0, 1),  3: (0, 0, 0, 0, 0, 1, 1),  4: (0, 0, 0, 0, 1, 1, 1),  5: (0, 0, 0, 1, 1, 1, 1),  6: (0, 1, 0, 1, 1, 1, 1),  7: (0, 0, 1, 1, 1, 1, 1),  8: (0, 1, 1, 1, 1, 1, 1),  9: (1, 0, 1, 1, 1, 1, 1),  10: (1, 1, 1, 1, 1, 1, 1),  11: (0, 1, 1, 2, 1, 1, 1),  12: (1, 1, 1, 2, 1, 1, 1),  13: (0, 1, 1, 2, 2, 1, 1),  14: (1, 1, 2, 2, 1, 1, 1),  15: (1, 1, 1, 2, 2, 1, 1),  16: (0, 1, 1, 2, 2, 2, 1),  17: (1, 1, 2, 2, 2, 1, 1),  18: (1, 1, 1, 2, 2, 2, 1),  19: (0, 1, 1, 2, 2, 2, 2),  20: (1, 1, 2, 3, 2, 1, 1),  21: (1, 1, 2, 2, 2, 2, 1),  22: (1, 1, 1, 2, 2, 2, 2),  23: (1, 2, 2, 3, 2, 1, 1),  24: (1, 1, 2, 3, 2, 2, 1),  25: (1, 1, 2, 2, 2, 2, 2),  26: (1, 2, 2, 3, 2, 2, 1),  27: (1, 1, 2, 3, 3, 2, 1),  28: (1, 1, 2, 3, 2, 2, 2),  29: (1, 2, 2, 3, 3, 2, 1),  30: (1, 2, 2, 3, 2, 2, 2),  31: (1, 1, 2, 3, 3, 2, 2),  32: (1, 2, 2, 4, 3, 2, 1),  33: (1, 2, 2, 3, 3, 2, 2),  34: (1, 1, 2, 3, 3, 3, 2),  35: (1, 2, 3, 4, 3, 2, 1),  36: (1, 2, 2, 4, 3, 2, 2),  37: (1, 2, 2, 3, 3, 3, 2),  38: (2, 2, 3, 4, 3, 2, 1),  39: (1, 2, 3, 4, 3, 2, 2),  40: (1, 2, 2, 4, 3, 3, 2),  41: (2, 2, 3, 4, 3, 2, 2),  42: (1, 2, 3, 4, 3, 3, 2),  43: (1, 2, 2, 4, 4, 3, 2),  44: (2, 2, 3, 4, 3, 3, 2),  45: (1, 2, 3, 4, 4, 3, 2),  46: (2, 2, 3, 4, 4, 3, 2),  47: (1, 2, 3, 5, 4, 3, 2),  48: (2, 2, 3, 5, 4, 3, 2),  49: (1, 3, 3, 5, 4, 3, 2),  50: (2, 3, 3, 5, 4, 3, 2),  51: (2, 2, 4, 5, 4, 3, 2),  52: (2, 3, 4, 5, 4, 3, 2),  53: (2, 3, 4, 6, 4, 3, 2),  54: (2, 3, 4, 6, 5, 3, 2),  55: (2, 3, 4, 6, 5, 4, 2),  56: (2, 3, 4, 6, 5, 4, 3)}

pluckers=defaultdict(list)

for i in range(1,57):
    for j,k in product(steps.items(),steps.items()):
        if [a+b for (a,b) in zip(j[1],k[1])]==list(steps[i]) and j[0]<=k[0]:
            pluckers[i].append('p_%s*p_%s' % (j[0],k[0]))
    if len(pluckers[i])==1:
        pluckers.pop(i)

for i in pluckers.items():
    temp = ""
    for j in range(len(i[1])):
        sign=None
        if j%2==0:
            sign='-'
        else:
            sign='+'
        temp = temp + i[1][j]+sign
    print(temp[:-1])
input("done")

for i in range(1,57):
    highest = (0,0,0,0,0,0,1)
    target = [a-b for (a,b) in zip(highest,numbering[i])] 
    steps = [a for a in ((matrix(cartan).inverse()*matrix(target).transpose()).transpose())[0]] 
    temp.append((i,steps))
    
std_rep = minus_rep()
matrices = [matrix(56,56,{(b-1,a-1):1 for (a,b) in simple[1].items()}) for simple in sorted(std_rep.items())]

std_rep = {1: defaultdict(int, {7: 9, 8: 10, 11: 12, 13: 15, 16: 18, 19: 22, 35: 38, 39: 41, 42: 44, 45: 46, 47: 48, 49: 50}), 2: defaultdict(int, {5: 6, 7: 8, 9: 10, 20: 23, 24: 26, 27: 29, 28: 30, 31: 33, 34: 37, 47: 49, 48: 50, 51: 52}), 3: defaultdict(int, {5: 7, 6: 8, 12: 14, 15: 17, 18: 21, 22: 25, 32: 35, 36: 39, 40: 42, 43: 45, 48: 51, 50: 52}), 4: defaultdict(int, {4: 5, 8: 11, 10: 12, 17: 20, 21: 24, 25: 28, 29: 32, 33: 36, 37: 40, 45: 47, 46: 48, 52: 53}), 5: defaultdict(int, {3: 4, 11: 13, 12: 15, 14: 17, 24: 27, 26: 29, 28: 31, 30: 33, 40: 43, 42: 45, 44: 46, 53: 54}), 6: defaultdict(int, {2: 3, 13: 16, 15: 18, 17: 21, 20: 24, 23: 26, 31: 34, 33: 37, 36: 40, 39: 42, 41: 44, 54: 55}), 7: defaultdict(int, {1: 2, 16: 19, 18: 22, 21: 25, 24: 28, 26: 30, 27: 31, 29: 33, 32: 36, 35: 39, 38: 41, 55: 56})}

"""
covers = [a[::-1] for b in [i.items() for i in list(std_rep.values())] for a in b]
labels = {i:[i[::-1] in std_rep[j].items() for j in range(1,8)].index(True)+1 for i in covers}
P = Poset((range(1,57),covers))
P.show(figsize=[15,15],cover_labels = labels)
"""

#find a path UPWARD using simple reflections from each row of the Cartan matrix to the highest weight (1,0,0,0,0,0,0) of the adjoint representation. Recall that rows of the Cartan matrix correspond to simple roots in the fundamental weight basis, and these are roots for the adjoint action.

#output of explore is a path upward from each simple root 1 through 7 to the highest weight (1,0,0,0,0,0,0)
def explore():
    global cartan, n
    start = (1,0,0,0,0,0,0)
    covers = defaultdict(list)
    unfinished = [start]
    while len(unfinished) != 0:
        curr = unfinished.pop()
        for i in range(n):
            if curr[i] > 0:
                #note that we only use simple reflections here, rather than simple roots
                #this is okay in this case because the only missing weights are the zero weight spaces, which we do not need to find paths up from the positive simple roots. Otherwise, every action of the simple reflections takes one step.
                new = tuple([a-b*curr[i] for (a,b) in zip(curr,cartan[i])])
                if (curr,i+1) not in covers[new]:
                    covers[new].append((curr,i+1))
                    unfinished.append(new)
    paths = []
    for i in range(n):
        curr = tuple(cartan[i])
        path = [i+1]
        while curr != (1,0,0,0,0,0,0):
            path.append(covers[curr][0][1])
            curr = covers[curr][0][0]
        paths.append((i+1,path))
    return paths

paths_adj = explore()

#output of find_highest is seven scalings of highest weight vector of adjoint, either by 2 or -2 depending on arbitrary choices made before to find a path in the weight space from simple roots to highest
#the only reason I output all seven is for testing purposes, any one will suffice
#highest weight vector for adjoint action, i.e. first fundamental representation

def commutator(a,b):
    return a*b-b*a

def find_highest():
    global matrices, n
    steps = paths_adj
    mats = []
    for i in range(n):
        start = commutator(matrices[i],matrices[i].transpose())
        path = steps[i][1]
        for step in path:
            start = commutator(matrices[step-1].transpose(),start)
        mats.append(start)
    return [i/2 for i in mats]

def second_rep():
    global n, matrices, cartan, std_rep, std_dual
    vec = find_highest()[0] #highest of adjoint rep
    weight = (1,0,0,0,0,0,0)
    #lowest = (-1,0,0,0,0,0,0)
    adj_weights = {weight:vec} #record which weight vectors go with which weights
    adj = defaultdict(list)
    unfinished = [weight]
    while len(unfinished) != 0:
        curr = unfinished.pop()
        for i in range(n):
            new_vec = commutator(matrices[i],adj_weights[curr])
            if len(new_vec.dict().values()) > 0:
                new_weight = tuple([a-b for (a,b) in zip(curr,cartan[i])])
                if (new_weight,i+1) not in adj[curr]:
                    adj[curr].append((new_weight,i+1))
                if new_weight not in adj_weights.keys():
                    adj_weights[new_weight] = new_vec
                    unfinished.append(new_weight)

    vec = find_highest()[0].transpose() #lowest of adjoint rep
    weight = (-1,0,0,0,0,0,0)
    #lowest = (-1,0,0,0,0,0,0)
    adj2_weights = {weight:vec} #record which weight vectors go with which weights
    adj2 = defaultdict(list)
    unfinished = [weight]
    while len(unfinished) != 0:
        curr = unfinished.pop()
        for i in range(n):
            new_vec = commutator(matrices[i].transpose(),adj2_weights[curr])
            if len(new_vec.dict().values()) > 0:
                new_weight = tuple([a+b for (a,b) in zip(curr,cartan[i])])
                if (new_weight,i+1) not in adj2[curr]:
                    adj2[curr].append((new_weight,i+1))
                if new_weight not in adj2_weights.keys():
                    adj2_weights[new_weight] = new_vec
                    unfinished.append(new_weight)
    vec = 1
    weight = (0,0,0,0,0,0,1)
    #lowest = (0,0,0,0,0,0,-1)
    std_weights = {weight:vec}
    std = defaultdict(list)
    unfinished = [weight]
    while len(unfinished) != 0:
        curr = unfinished.pop()
        for i in range(n):
            new_vec = std_rep[i+1][std_weights[curr]]
            if new_vec != 0:
                new_weight = tuple([a-b for (a,b) in zip(curr,cartan[i])])
                if (new_weight,i+1) not in std[curr]:
                    std[curr].append((new_weight,i+1))
                    unfinished.append(new_weight)
                if new_weight not in std_weights.keys():
                    std_weights[new_weight] = new_vec

    target = (0,1,0,0,0,0,0)
    candidates = {}
    for weight in std_weights.keys():
        adj_pair = tuple([a-b for (a,b) in zip(target,weight)])
        if adj_pair in adj_weights.keys():
            adj_weights[adj_pair].set_immutable()
            candidates[std_weights[weight]] = adj_weights[adj_pair]
        elif adj_pair in adj2_weights.keys():
            adj_weights[adj_pair].set_immutable()
            candidates[std_weights[weight]] = adj_weights[adj_pair]
    return candidates

pairs = [(i[0],matrix(56,56,i[1].dict())) for i in list(second_rep().items())]
for (i,j) in pairs:
    j.set_immutable()
highest_2 = defaultdict(int,{pairs[i]:(-1)**i for i in range(n)})

#vect is a dict whose keys are 'std' and 'adj' and whose values are pairs of (vector,weight)
#return up to n(=7) dicts of the same form as input
def testing(vect):
    global n, matrices, cartan, std_rep, std_dual
    adj = vect['adj'][0]
    adj_weight = vect['adj'][1]
    std = vect['std'][0]
    std_weight = vect['std'][1]
    outputs = []
    for i in range(n):
        std_temp = std_rep[i+1][std]
        adj_temp = commutator(matrices[i],adj)
        adj_data = len(adj_temp.dict().values())
        new_weight = None
        if std_temp != 0:
            new_std = tuple([b-a for (a,b) in zip(cartan[i],std_weight)])
            new_weight = tuple([a+b for (a,b) in zip(new_std, adj_weight)])
            outputs.append({'std':(std_temp,new_std),'adj':vect['adj']})
        elif adj_temp != 0:
            new_adj = tuple([b-a for (a,b) in zip(cartan[i],adj_weight)])
            new_weight = tuple([a+b for (a,b) in zip(std_weight,new_adj)])
            outputs.append({'std':vect['std'],'adj':(adj_temp,new_adj)})
        print(i+1,std_temp, adj_data, new_weight)
    return outputs

#Find the labels of the functions \phi(m,i), where m is in ]r_k,r]\cap e(i) U {t_k|k in I}, in terms of the D's
#Note that the last n of these correspond to the frozen variables
def func_labels():
    global w_0, w_lower_p,n
    nonexch = [w_0.rindex(str(i))+1 for i in range(1,n+1)]
    mutable = [i for i in range(len(w_lower_p)+1,len(w_0)+1) if i not in nonexch]
    frozen = [-n]+[w_lower_p.rindex(str(i))+1 for i in range(1,n)]        
    return mutable+frozen
