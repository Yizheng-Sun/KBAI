fof(q1, conjecture, ![X1,X2,X3]:(?[T1,T2,T3,T4]:((ord(X1,X2) & ord(X2,X3) & sorted(T1) & sorted(T2) & sorted(T3) & sorted(T4))=>sorted(tree(X2,tree(X1,T1,T2), tree(X3,T3,T4)))))).
fof(q2, conjecture, ![X1,X2,X3]:(?[T1,T2,T3,T4]:(((ord(X1,X2) | ord(X3,X1)) & sorted(T1) & sorted(T2) & sorted(T3) & sorted(T4))=> ~sorted(tree(X1,tree(X2,T1,T2), tree(X3,T3,T4)))))).
fof(q3, conjecture, ![X1,X2,X3,R1,R2,R3,R4]:(?[T1,T2,T3,T4]:((ord(X1,X2) & ord(X2,X3) & root(R1,T1) & root(R2,T2) & root(R3,T3) & root(R4,T4) & (ord(X1,R1)|ord(R2,X1)|ord(X3,R3)|ord(R4,X3))) => ~sorted(tree(X2,tree(X1,T1,T2), tree(X3,T3,T4)))))).
fof(q4, conjecture, ![X]: (?[T1,T2]:((insert(X,T1)=T2)=>sorted(T2)))).
fof(q5, conjecture, ![X1,X2,X3]: (?[T1,T2]:((insert(X1,insert(X2,insert(X3,T1)))=T2) => sorted(T2)))).
fof(q6, conjecture, ![X]: (?[T2]:((insert(X,tree(d,tree(b,tree(a,empty, empty), tree(c, empty,empty))))=T2)=>sorted(T2)))).
fof(q7,conjecture, ![X]:(sorted(tree(X, empty,empty)))).
