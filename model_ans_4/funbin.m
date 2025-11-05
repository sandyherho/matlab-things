function decimal_value = funbin(binary_vector)
% FUNBIN Convert binary number (as vector) to decimal
%   Takes a vector of 0s and 1s representing a binary number
%   Returns the equivalent decimal (base 10) number
%
%   Example: funbin([1 0 1]) returns 5
%            because: 1*2^2 + 0*2^1 + 1*2^0 = 4 + 0 + 1 = 5
%
% Author: Sandy Herho

% ========================================================================
% STEP 1: Initialize the result variable to zero
% ========================================================================
% This will store our running sum as we process each binary digit
decimal_value = 0;

% ========================================================================
% STEP 2: Reverse the vector so the units digit comes first
% ========================================================================
% In binary: rightmost digit = 2^0 (units)
%            next digit left = 2^1 (twos)
%            next digit left = 2^2 (fours), etc.
%
% Example: [1 0 1 1] represents 1*2^3 + 0*2^2 + 1*2^1 + 1*2^0
%
% By reversing to [1 1 0 1], we make:
%   - Element 1 (first position) = 2^0 power
%   - Element 2 (second position) = 2^1 power
%   - Element 3 (third position) = 2^2 power
%   This makes the loop indexing much easier!

binary_reversed = fliplr(binary_vector);

% ========================================================================
% STEP 3: Loop through each binary digit
% ========================================================================
% We'll check each digit one by one and add its contribution

for n = 1:length(binary_reversed)
    
    % Check if this digit is a 1 or a 0
    if binary_reversed(n) == 1
        
        % If it's a 1, we need to add 2^(n-1) to our sum
        % Why (n-1)? Because:
        %   - When n=1 (first element), we want 2^0 = 1
        %   - When n=2 (second element), we want 2^1 = 2
        %   - When n=3 (third element), we want 2^2 = 4
        %   - And so on...
        
        power_of_two = 2^(n-1);
        
        % Add this value to our running total
        decimal_value = decimal_value + power_of_two;
        
    end
    % If the digit is 0, we don't add anything (so no 'else' needed)
    
end

% ========================================================================
% STEP 4: Return the result
% ========================================================================
% The function automatically returns 'decimal_value' at the end

end
