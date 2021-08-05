% Name: diff_gate
% Purpose: Simple helper function for gate variable calculation
function ds = diff_gate(s, a, b)
    s_inf = a / (a+b);
    ds = (s_inf-s) * (a+b);
end