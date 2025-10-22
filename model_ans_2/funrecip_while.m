function [result] = funrecip_while(n)
    result = 0;
    i = 1;
    while i <= n
        current_reciprocal = 1/i;
        result = result + current_reciprocal;
        i = i + 1;
    end
end