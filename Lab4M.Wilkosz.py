def clear_all():
    gl = globals().copy()
    for var in gl:
        if var[0] == '': continue
        if 'func' in str(globals()[var]): continue
        if 'module' in str(globals()[var]): continue

        del globals()[var]

clear_all()


##1
def findPositions(*args):
    dictionary = dict()
    letters = args[1:]
    word = args[0]
    for i in letters:
        if i in word:
            dictionary[i] = [x for x, letter in enumerate(word) if letter == i]
    return dictionary


pos = findPositions("test"*2 + "xD", "a", "e", "s", "x")
pos

##2
def positionsToTupleList(d):
    tuple_list = []
    for key in d.keys():
        for value in d[key]:
            tuple_list.append((value,key))
    tuple_list.sort(key = lambda x: x[0])
    return(sorted(tuple_list))

def positionsToTupleList_comprehension(d):
    return(sorted([(value,key) for key in d.keys() for value in d[key]],key = lambda x: x[0]))


positionsToTupleList(pos)
positionsToTupleList_comprehension(pos)

##3
dict = {5:1, 1:5}

def dictSortedGenerator(d):
    keys = sorted(d.keys())
    for key in keys:
        yield key, d[key]

for a, b in dictSortedGenerator(dict):
    print(f"k={a}, v={b}")

clear_all()

##4
def drawHisto(d):
    for a, b in dictSortedGenerator(d):
        print(a, "*"*len(b))

drawHisto(pos)

##5
l = [1, 2, 1, 2, 6, 7, 6, 9, 9, 9, 10]

def convertToUnique(l):
    list = []
    for i in l:
        if i in list:
            pass
        else:
            list.append(i)
    return list

#or more pythonic way
def convertToUnique2(l):
    return list(set(l))

convertToUnique(l)
convertToUnique2(l)

##6
def jaccard_index(s1, s2):
    return len(s1.intersection(s2)) / len(s1.union(s2))

s1 = {1,2,3,4,5,6}
s2 = {3,4,5}

jaccard_index(s1, s2)

##7
def optimizeJaccardIndex(s1, s2, limit=0.9):

    lens1 = len(s1)
    lens2 = len(s2)

    if lens1 > lens2:
        diff = s1.difference(s2)

        for i in diff:
            if jaccard_index(s1,s2) < limit:
                s1.remove(i)
                limit = jaccard_index(s1,s2)
            else:
                pass

    if lens2 > lens1:
        diff = s2.difference(s1)

        for i in diff:
            if jaccard_index(s1, s2) < limit:
                s2.remove(i)
                limit = jaccard_index(s1,s2)
            else:
                pass
    else:
        for i in s1:
            if jaccard_index(s1, s2) < limit:
            s1.remove(i)
            limit = jaccard_index(s1, s2)


    print(s1,s2,limit)

s1 = {4,5}
s2 = {4,5}

optimizeJaccardIndex(s1,s2)
