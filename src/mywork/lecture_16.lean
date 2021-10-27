/-
Algebraic structure:
- collection of values
- collection of applicable operations
- ++ is append for a string a ++ b = ab
Examples:
- int, +
- int, +, *
- string, ++
- bool, &&, ! (and, not)
-/

-- ^ often these are called a carier sets

-- a set is a collection of objects of some kind - we do not mix types I think? 

/-
We now introduce the algebraic structure
that we call the set, by explaining what
are the objects of this type and what are
the applicable operations.
-/

/- OBJECTS 

The objects of this algebraic structure are 
values of type "set T," where T is the type
of objects "in" the set: of the "members" of 
the set. 

For example, consider the set, written in 
what's caledl display notation: { 1, 2, 3, 4 }.
The set has four members, as enumerated here.
The key distinction we want to make is between
the type of the elements, here ℕ, and the type
of the set, here, set ℕ.

Lean in fact supports this notation. A little
later in the lecture, we'll figure out what it
actually means. Then you'll see the power that
comes with the corresponding epiphany. 
-/

-- A bag is like a set but with repeats and such

-- Russel tells his friend (Fraenkel ) that the friend's life work on set theory had a fundemental logical flaw

-- Russel's paradox, consider the set of all sets that don't contain themselves. 
-- S = {s set t | S ¬∈ S}
-- excluded middle tells us S is either in it, or not.#check
-- in both of these cases a logical inconsistency occurs. 
-- if it does contain itself, it does not contain itself so contradiction 
-- if it does not contain itself, then it is a set that does not contain itself so it should be in S.

-- type theory does not allow a set to be a member of itself because there is no type for that case.

-- ∪ = union, kind of like ∨ 

-- ∩ = intersection, kind of like ∧ 

-- a single set (like a set of just 3) is still a different type from 3. set nat = (3) | 3 = nat
-- to be a subset, every element of the subset is in the parent set. If in set2, then in set1. 

-- for power set of {1,2,3} is of type set set nat. 2^size of the set 
-- each element added doubles the size of the power set

-- product of {nice, mean} x {cat, dog} = {Nice Cat, Mean Cat, Nice dog, Mean dog} So the size of the product set
-- is the size of both set multiplied together. 

-- {1,2,3,4} this is display notation
-- if we want the set of all even natural numbers we say {n:ℕ | n%2 = 0 } -> this is a predicate !!!! 
-- so the type is nat → Prop
-- so two sets with respective predicates P, Q -> union is P ∨ Q and intersect is P ∧ Q
--set is defined by a predicate

/- OPERATIONS

Assume that we've been given some type, T. The 
operations of the "set T" algebraic structure
include the following:

empty set -- containing no elements of type T
complete set -- containing all T-valued elts
membership (s : set T) (val : T) : is member? ∈ is symbol for membership 
complement (s : set T) : set T  -- not in s
union (s1 s2 : set T) : set T   -- in either
intersection (s1 s2 : set T) : set T -- in both
product (s1 : set T) (s2 : set V) : set (T × V)
power (s : set T) : set (set T) -- set of subsets
-/

/- CHANGE IN PERSPECTIVE!

You might visualize a set as being a
collection of objects (such as natural
numbers, for example). But let's make 
a fundamental shift in perspective, one
that builds on everything we've learned
so far.

We will now think of a set defined by
the property that distinguishes objects
that are in the set from those that are
not. 
-/

def s1 : set ℕ := { n : ℕ | n = 0 }

#check s1
#reduce s1
#check λ (n : ℕ), n = 0

def s1' : ℕ → Prop := { n : ℕ | n = 0 }


#check s1 0
#reduce s1' 0
#reduce s1 1
#reduce s1 2
#reduce s1' 3

/-
Let's meet up once again with our favorite
one-place predicate on the natural numbers.
-/

def ev (n : ℕ) : Prop := n % 2 = 0

/-
In a sense that we can now make precise,
this *predicate* defines a set: the set 
of all natural numbers that *satisfy* it. 
We can think of ev as being a membership
predicate that indicates whether a given
value is in a given set or not. 

It should be clear that every predicate
defines a set, and perhaps that there is
a predicate for every set. 

The next section of the course introduces
the lovely topic of set theory based exactly
on this idea: represent sets as predicates,
and operations on sets (such as intersection
and union) as corresponding to operations on 
predicates. 

Indeed we will define the type "set T" just
to be the predicate T → Prop! A set is thus
represented *exactly* as a predicate in our
logic. 
-/


-- set comprehension notation

def s0   : set ℕ    := { n : ℕ | ev n }
def s0'  : ℕ → Prop := { n : ℕ | ev n } --!
def s0''            := { n : ℕ | ev n }

-- Set predicate:  proposition for each value

#reduce s0 0  -- by rfl
#reduce s0 1  -- false
#reduce s0 2  -- by rfl
#reduce s0 3  -- false


--We can prove these two
example : s0 0 := rfl
example : s0 2 := rfl

-- But not these two
example : s0 1 := rfl
example : s0 3 := rfl

-- set membership notation

#reduce 0 ∈ s0  -- yes
#reduce 1 ∈ s0  -- no
#reduce 2 ∈ s0  -- yes
#reduce 3 ∈ s0  -- no

example : 0 ∈ s0 := rfl
example : 2 ∈ s0 := rfl

-- But not these two
example : 1 ∉ s0 := 
begin
  assume h,
  cases h,
end

example : 3 ∈ s0  := 
begin
  show s0 3,
  show ev 3,
  simp [ev],
  show 1 = 0,
  -- stuck
end

-- set display notation
def s1'' : set nat := { 1, 2, 3, 4 }
def s1''' := {1, 2, 3, 4} -- need explicit type

/- #1: 
Represent the empty set using set comprehension. 

Here's the empty set (of natural numbers) 
in display notation. Write the same set using 
set comprehension notation.
-/

def empty' : set ℕ := {}
def empty  : set ℕ := _

/- #2:
Represent the entire set of the natural 
numbers using set comprehension notation.
-/

def s2 : set ℕ := 
  _


/- #3: 
Represent the set containinly all and only
the natural numbers, 1, 2, 3, and 4.
-/

def s1'' : set nat := 
  _


/-
What we see is that we can represent a 
given set with the right predicate in a
set comprehension expression. Now let's
think about having two sets, with two 
characteristic predicates, P and Q. We
will continue to assume these operate on
natural numbers, but the argument type
could be anything.
-/

axioms (P Q : ℕ → Prop)

def pSet  : set nat := { n : ℕ | P n}
def qSet  : set nat := { n : ℕ | Q n}

#reduce pSet ∪ qSet