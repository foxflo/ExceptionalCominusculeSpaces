-- input deg an integer, and t a monomial in the a's 
-- first, get the part of t with exponents >= deg
-- then get the corresponding monomial 
-- and check which plucker coordinate has it as leading term in order to run reduction

f = (deg,t) -> (
    temp = apply(flatten exponents t, i-> if i>=deg then 1 else 0);
    monom = product toList apply(0..26,i->a_(27-i)^(temp_i));
    for i in 1..56 do if monom==leadTerm(p_i) then return i
)
