% My elements
fof(e1, axiom, ord(a,b) & ord(b,c) & ord(c,d) & ord(d,e) & ord(e,f) & ord(f,g)).
fof(e2, axiom, $distinct(a,b,c,d,e,f,g)).

% Binary search tree basic axioms
fof(b1, axiom, ![N,T1,T2]:(tree(N,T1,T2) != empty)).
fof(b2, axiom, ![N,T1,T2]:(root(N,tree(N,T1,T2)))).
fof(b3, axiom, ![T1,T2,T3,N]:(subtree(T1, tree(N,T1,T2)))).
fof(b4, axiom, ![T1,T2,T3]:((subtree(T1,T2) & subtree(T2,T3))=>subtree(T1,T3))).

% ordering of elements
fof(o1, axiom, ![X,Y] : ( (ord(X,Y) & ord(Y,X)) => X=Y)). % antisymmetry
fof(o2, axiom, ![X,Y,Z] : ((ord(X,Y) & ord(Y,Z)) => ord(X,Z))). % transitivity
% reflexivity makes a binary search tree can be infinite, for example a tree full of a same elements and never ends
fof(o3, axiom, ![X] : ~ord(X,X)). % reflexivity

% Binary tree is a binary search tree
% Each sorted() predicte models a binary search tree and can be used as a subtree in a bigger binary search tree
% A binary search can be infinite

% bst depth is 1
fof(s1, axiom, ![N,T1]:((ord(T1,N)) => (sorted(tree(N,T1,empty))))).
fof(s2, axiom, ![N,T1]:((ord(N,T1)) => (sorted(tree(N,empty,T1))))).
fof(s3, axiom, ![N,T1,T2]:((ord(T1,N) & ord(N,T2)) => (sorted(tree(N,T1,T2))))).
fof(s4, axiom, ![N]:(sorted(tree(N, empty,empty)))).

% bst depth >= 2
% full bst
fof(s5, axiom, ![N2,T1,T2,R1,R2]:((root(R1,T1) & root(R2,T2) & ord(R1, N2) & ord(N2,R2)
                                & sorted(T1) & sorted(T2)) 
                                => (sorted(tree(N2, T1, T2))))).
% unbalanced bst (only has left subtree)
fof(s6, axiom, ![N2,T1,R1]:((root(R1,T1) & ord(R1, N2) & sorted(T1)) 
                                => (sorted(tree(N2, T1, empty))))).
% unbalanced bst (only has right subtree)
fof(s7, axiom, ![N2,T1,R1]:((root(R1,T1) & ord(N2, R1) & sorted(T1)) 
                                => (sorted(tree(N2, empty, T1))))).


% Binary tree but not binart search tree (elements are not in order)
% fof(ns0,axiom,![T]:(~sorted(T)=>tree(T)));

fof(ns2, axiom, ![N,T1,T2]:((ord(T1,N) | ord(N,T2)) 
                            => (~sorted(tree(N,T2,T1))))).

% full binary tree but not sorted
fof(ns3, axiom, ![N2,T1,T2,R1,R2]:((root(R1,T1) & root(R2,T2) & (ord(N2, R1) | ord(R2,N2))) 
                                => (~sorted(tree(N2, T1, T2))))).
% only has left subtree, not sorted
fof(ns4, axiom, ![N2,T1,R1]:((root(R1,T1) & ord(N2, R1)) 
                                => (~sorted(tree(N2, T1, empty))))).
% only has right subtree, not sorted
fof(ns5, axiom, ![N2,T1,R1]:((root(R1,T1) & ord(R1, N2)) 
                                => (~sorted(tree(N2, empty, T1))))).


% Insert into a binary search tree. 
% I use equality for insertion function. insert(X,Tree1) = Tree2
fof(i1, axiom, ![T]:(insert(empty,T)=T)).

% Insert into a tree whose depth is 1
fof(i2, axiom, ![Nadd,N1]:((ord(Nadd,N1))
                <=>(insert(Nadd, tree(N1, empty, empty)) = tree(N1, tree(Nadd,empty,empty), empty)))).

fof(i3, axiom, ![Nadd,N1]:((ord(N1,Nadd))
                <=>(insert(Nadd, tree(N1, empty, empty)) = tree(N1, empty, tree(Nadd,empty,empty))))).

% Insert into a tree whose depth 2 or more
fof(i4, axiom, ![N1,T1,T2,N2]: ((ord(N1,N2) & sorted(T1) & sorted(T2))
                => (insert(N2, tree(N1,T1,T2))=tree(N1,T1,insert(N2,T2))))).

fof(i5, axiom, ![N1,T1,T2,N2]: ((ord(N2,N1) & sorted(T1) & sorted(T2))
                => (insert(N2, tree(N1,T1,T2))=tree(N1,insert(N2,T1),T2)))).


% fof(q1, conjecture, ![X1,X2,X3]:(?[T1,T2,T3,T4]:((ord(X1,X2) & ord(X2,X3) & sorted(T1) & sorted(T2) & sorted(T3) & sorted(T4))=>sorted(tree(X2,tree(X1,T1,T2), tree(X3,T3,T4)))))).
% fof(q2, conjecture, ![X1,X2,X3]:(?[T1,T2,T3,T4]:(((ord(X1,X2) | ord(X3,X1)) & sorted(T1) & sorted(T2) & sorted(T3) & sorted(T4))=> ~sorted(tree(X1,tree(X2,T1,T2), tree(X3,T3,T4)))))).
% fof(q3, conjecture, ![X1,X2,X3,R1,R2,R3,R4]:(?[T1,T2,T3,T4]:((ord(X1,X2) & ord(X2,X3) & root(R1,T1) & root(R2,T2) & root(R3,T3) & root(R4,T4) & (ord(X1,R1)|ord(R2,X1)|ord(X3,R3)|ord(R4,X3))) => ~sorted(tree(X2,tree(X1,T1,T2), tree(X3,T3,T4)))))).
% fof(q4, conjecture, ![X]: (?[T1,T2]:((insert(X,T1)=T2)=>sorted(T2)))).
% fof(q5, conjecture, ![X1,X2,X3]: (?[T1,T2]:((insert(X1,insert(X2,insert(X3,T1)))=T2) => sorted(T2)))).
% fof(q6, conjecture, ![X]: (?[T2]:((insert(X,tree(d,tree(b,tree(a,empty, empty), tree(c, empty,empty))))=T2)=>sorted(T2)))).
% fof(q7,conjecture, ![X]:(sorted(tree(X, empty,empty)))).
