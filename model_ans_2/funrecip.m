function [result] = funrecip(n)
    % Problem
    % result = 1/1 + 1/2 + 1/3 + 1/4 + ... + 1/n
    % example if you have n = 5
    % result = 1/1 + 1/2 + 1/3 + 1/4 + 1/5
    % to test if you do this correctly 
    % funrecip(5) --> 2.28333
    % funrecip(10) --> 2.9290

    % assign dummy number tp start
   result = 0;
   for i = 1:n
        current_reciprocal = 1/i;
        % for example if you give the function funrecip(3)
        % when i = 1 --> result_1 = 0 + 1/1 = 1
        % when i = 2 --> result_2 =  result_1 + 1/2 = 1 + 1/2 = 1.5
        % when i = 3 --> result_3 = result_2 + 1/3 = 1.5 + 1/3 = 1.8333...
        result = result + current_reciprocal;
    end
end