    function ds = diff_gate(s, a, b)
    s_inf = a / (a+b);
    ds = (s_inf-s) * (a+b);
    end