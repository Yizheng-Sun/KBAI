# Knowledge-based-AI-bst-with-FOL
### This program uses TPTP, a declarative language for writing first order logic formulas. It's runned by vampire. It models binary search tree (knowledge base) and reasons with it.
=============================================

N.B: a) My knowledge base is infinite so we cannot check it's self-consistent and query invalid conjectures. (it never stops running).
     b) It can perfectly answer valid conjectures. Run "./check_conjectures.sh exercise6 -ep off" to check. (-ep off is necessary).

<br/>---------------------
<br/>1 - the Domain
<br/>---------------------
<br/>My knowledge models binary search tree. There are 12 constants. letters a~k and empty. letters a~k are ordered in
alphabet order. Note: My knowledge base is infinite, because a binary search tree can be infinite (such as tree full of a same element). 
When I check my knowledge is self-consistent (all the axioms), it will try to construct all the possible binary search trees such that 
it's never going to saturate. So it's impossible to check it's self-consistent. However, when adding a valid conjecture,
it can greatly cut off the search space and I can quickly derive an answer (false), which means my knowledge base works.

<br/>A tree has three parts: one root and two nodes. The root must be a letter. A node must be a tree or empty constant.

<br/>A letter cannot be an ending node. It must be of the form tree(x, empty, empty) where x is a letter constant. (ending node must be empty constant)

<br/>A sorted tree is a binary search tree, which means for each subtree in this tree, the root of left subtree is ordered before root, 
the root of right subtree is ordered after root.

<br/>Inserting a letter into a binary search tree will insert a subtree whose root is this letter. Insert function will insert the element to
a proper position. Thus the derived tree is still a binary search tree.

<br/>---------------------
<br/>2 - Modelline 
<br/>---------------------
<br/>predicate tree(N,T1,T2) takes three entities, N is the root of this tree, T1 and T2 are nodes of this tree.

<br/>predicate root(N,T) takes two entities, T is a tree and N is the root of T.

<br/>predicate ord(X,Y) takes two entities, it means X<Y and X,Y are letter constants. as mentioned above, letter 
constants are in alphabet order. And ord() is antisymmetry and transitive. It's not reflective.

<br/>predicate sorted(T) takes one entity, which is a tree. It means T is a binary search tree.
The root of T >= the root of its left subtree, the root of T =< the root of right subtree.

<br/>predicate ~sorted(T) also takes one entity, which is a tree. it will check the root and two nodes of T,
to see whether it's not a binary search tree.

<br/>sorted(T) and ~sorted(T) together achieve sth like a domain closure. Because my knowledge base is infinite,
when adding a invalid conjecture about sorted(A_Tree), there is no Refutation, it never stops running. But adding a
a ~sorted(A_Tree) can give an answer. Thus these two can answer any queries about sorted().

<br/>predicate insert(X,T) takes two entities, X is letter constant, T is binary search tree. I use equality indicating that 
insert(X,T) = T2, where T2 is the inserted binary search tree.
<br/>---------------------
<br/>3 - Checking 
<br/>---------------------
<br/>Minimal means there are no unused clauses in my knowledge base. To achieve this,
I need to use --unused_predicate_definition_removal on. This can remove the unnecessary clauses from my knowledge base.
<br/>To check my knowledge base is consistent. I run it without adding any conjecture.
In short, run: ./vampire -updr on exercise6.p 
But as mentioned about, I cannot derive a satisfiable because it never stops, even with --mode portfolio 

<br/>---------------------
<br/>4 - Queries and Conjectures 
<br/>---------------------
<br/>To run the queries, option "-ep off" is required, because I use equality for insert. Otherwise the search sapce is to large to finish in limited time.
Inshort, run   ./check_conjectures.sh exercise6 -ep off

<br/>fof(q1, conjecture, ![X1,X2,X3]:(?[T1,T2,T3,T4]:((ord(X1,X2) & ord(X2,X3) & sorted(T1) & sorted(T2) & sorted(T3) & sorted(T4))
=>sorted(tree(X2,tree(X1,T1,T2), tree(X3,T3,T4)))))).
<br/>% q1 means for any elements X1,X2,X3, if X1<=X2<=X3, there exists binary search trees T1,T2,T3,T4, makes tree(X2,tree(X1,T1,T2), tree(X3,T3,T4))
a binary search tree.

<br/>fof(q2, conjecture, ![X1,X2,X3]:(?[T1,T2,T3,T4]:(((ord(X1,X2) | ord(X3,X1)) & sorted(T1) & sorted(T2) & sorted(T3) & sorted(T4))
=> ~sorted(tree(X1,tree(X2,T1,T2), tree(X3,T3,T4)))))).
<br/>% q2 means for all elements X1,X2,X3, if X3<=X1 or X1<=X2, Then tree(X1, tree(X2,T1,T2), tree(X3,T3,T4)) is not a binary serach tree

<br/>fof(q3, conjecture, ![X1,X2,X3,R1,R2,R3,R4]:(?[T1,T2,T3,T4]:((ord(X1,X2) & ord(X2,X3) & root(R1,T1) & root(R2,T2) & root(R3,T3) & root(R4,T4)
 & (ord(X1,R1)|ord(R2,X1)|ord(X3,R3)|ord(R4,X3)))
  => ~sorted(tree(X2,tree(X1,T1,T2), tree(X3,T3,T4)))))).
<br/>% q3 basically means if any subtree in a binary tree is not sorted, then the whole tree is not a binary search tree.

<br/>fof(q4, conjecture, ![X]: (?[T1,T2]:((insert(X,T1)=T2)=>sorted(T2)))).
<br/>% q4 means for all elements X, there exists Tree1 and Tree2, inserting X into Tree1 gives Tree2. Then Tree2 is a binary search tree.

<br/>fof(q5, conjecture, ![X1,X2,X3]: (?[T1,T2]:((insert(X1,insert(X2,insert(X3,T1)))=T2) => sorted(T2)))).
<br/>% q5 means for all elements X1, X2, X3, inserting X3 into the tree, then inserting X2, then 
% inserting X1, I can still get a binary search tree. It means insert() can be used on a tree for multiple times. And for any element,
% There is always a proper position for it.  

<br/>fof(q6, conjecture, ![X]: (?[T2]:((insert(X,tree(d,tree(b,tree(a,empty, empty), tree(c, empty,empty))))=T2)=>sorted(T2)))).
<br/>% In q6 I use a specific tree, it basically checks whether insert() works on this specific tree.

<br/>fof(q7,conjecture, ![X]:(sorted(tree(X, empty,empty)))).
<br/>% q7 just check the base case of a binary search tree.
