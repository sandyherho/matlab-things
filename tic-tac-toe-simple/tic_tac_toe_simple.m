% ============================================
% *** TIC-TAC-TOE GAME! ***
% ============================================
% Author: Sandy Herho
% Date: 11/13/2025
% This game allows two players to play Tic-Tac-Toe
% Player 1 = RED circles (O)
% Player 2 = BLUE crosses (X)
% Click on a square to place your marker
% First player to get 3 in a row wins!
% ============================================

%% STEP 1: INITIALIZE THE GAME
% ===========================================
% WHAT IS INITIALIZATION?
% Before we start our game, we need to set up our "workspace"
% Think of it like clearing your desk before starting homework!
% ===========================================

% Close any open windows and clear workspace
close all;  % Closes all figure windows that might be open
clear;      % Clears all variables from memory (fresh start!)
clc;        % Clears the command window (makes it nice and clean)

% ===========================================
% CREATE THE GAME WINDOW
% The 'figure' function creates a new window where our game will appear
% We customize this window with several properties:
% ===========================================
figure('Name', 'Tic-Tac-Toe Game', ...        % Title at top of window
       'NumberTitle', 'off', ...               % Don't show "Figure 1" text
       'Position', [100, 100, 600, 600], ...   % [left, bottom, width, height] in pixels
       'Color', [0.95 0.95 0.95]);             % Background color (light gray)
% NOTE: Position [100, 100, 600, 600] means:
%       - 100 pixels from left edge of screen
%       - 100 pixels from bottom of screen
%       - 600 pixels wide
%       - 600 pixels tall

% ===========================================
% CREATE THE DRAWING AREA (AXES)
% 'axes' is where we'll actually draw our game board
% Think of it as the canvas where we paint!
% ===========================================
fh = axes('Position', [0.05 0.05 0.9 0.9], ... % Takes up 90% of the window
          'Visible', 'off');                    % Hide the axis lines (we'll draw our own grid)
% NOTE: Position [0.05 0.05 0.9 0.9] uses NORMALIZED coordinates (0 to 1)
%       This means 0.05 = 5% from edge, 0.9 = 90% of size

axis([0 3 0 3]);  % Set the coordinate system from 0 to 3 in both directions
                   % This creates a 3x3 grid (perfect for tic-tac-toe!)
axis square;       % Make the board perfectly square (not stretched)
hold on;           % Keep all drawings on the board (don't erase when we draw new things)

%% STEP 2: DRAW THE CHECKERBOARD BACKGROUND
% ===========================================
% WHY A CHECKERBOARD?
% The alternating colors help players see the 9 squares clearly
% It looks nice and makes the game easier to play!
% ===========================================

% Define two shades of blue for our checkerboard pattern
colors = [0.9 0.9 1.0;      % Light blue (row 1)
          0.8 0.8 0.95];     % Slightly darker blue (row 2)
% NOTE: Colors in MATLAB are [Red Green Blue] with values from 0 to 1
%       [0.9 0.9 1.0] means: a lot of red, a lot of green, full blue = light blue!

% NESTED LOOPS: We use TWO loops to visit every square
% Outer loop (i) goes through columns (left to right)
% Inner loop (j) goes through rows (bottom to top)
for i = 1:3          % Column loop: i = 1, then 2, then 3
    for j = 1:3      % Row loop: j = 1, then 2, then 3
        
        % CHECKERBOARD LOGIC:
        % We want alternating colors like a checkerboard
        % If (i+j) is EVEN, use first color
        % If (i+j) is ODD, use second color
        if mod(i+j, 2) == 0         % mod(i+j, 2) finds remainder when dividing by 2
            color = colors(1,:);     % Use first color (lighter blue)
        else
            color = colors(2,:);     % Use second color (darker blue)
        end
        % EXAMPLE: When i=1, j=1: (1+1)=2, mod(2,2)=0 → EVEN → light blue
        %          When i=1, j=2: (1+2)=3, mod(3,2)=1 → ODD → dark blue
        
        % Draw a filled rectangle for this square
        rectangle('Position', [i-1, j-1, 1, 1], ...  % [x, y, width, height]
                  'FaceColor', color, ...            % Fill color
                  'EdgeColor', 'none');              % No border (we'll add grid lines later)
        % NOTE: Position is [i-1, j-1, 1, 1] because:
        %       - MATLAB coordinates start at 0
        %       - Each square is 1 unit wide and 1 unit tall
        %       - i=1 means x=0 (i-1), i=2 means x=1, etc.
    end
end

%% STEP 3: DRAW THE GRID LINES
% ===========================================
% These black lines separate the 9 squares
% They make the tic-tac-toe board look clear and professional
% ===========================================

% We need 4 vertical lines and 4 horizontal lines (at positions 0, 1, 2, 3)
for i = 0:3
    % Draw VERTICAL line (goes up and down)
    line([i i], [0 3], ...             % From point (i,0) to point (i,3)
         'LineWidth', 4, ...            % Make it thick (4 pixels)
         'Color', [0.2 0.2 0.2]);       % Dark gray color
    % EXPLANATION: [i i] means x-coordinate stays at i
    %              [0 3] means y-coordinate goes from 0 to 3
    %              So this draws a vertical line!
    
    % Draw HORIZONTAL line (goes left and right)
    line([0 3], [i i], ...             % From point (0,i) to point (3,i)
         'LineWidth', 4, ...            % Make it thick (4 pixels)
         'Color', [0.2 0.2 0.2]);       % Dark gray color
    % EXPLANATION: [0 3] means x-coordinate goes from 0 to 3
    %              [i i] means y-coordinate stays at i
    %              So this draws a horizontal line!
end

%% STEP 4: SET UP GAME VARIABLES
% ===========================================
% VARIABLES: These are like boxes that store information
% We use variables to remember the game state as we play
% ===========================================

% GAME CONTROL VARIABLE
go = true;  % Boolean (true/false) variable
            % true = keep playing the game
            % false = game is over, stop the loop
            % We'll change this to false when someone wins or it's a draw

% PLAYER TRACKING VARIABLE
player1 = true;  % Boolean variable to track whose turn it is
                 % true = Player 1's turn (RED O)
                 % false = Player 2's turn (BLUE X)
                 % We'll flip this back and forth using: player1 = ~player1

% GAME BOARD ARRAY
% This is a 3x3 matrix (like a table with 3 rows and 3 columns)
% Each number represents what's in that square:
grid = zeros(3, 3);  % Creates a 3x3 matrix filled with zeros
% 0 = empty square (nobody has played here yet)
% 1 = Player 1 marker (RED O)
% 2 = Player 2 marker (BLUE X)
% EXAMPLE: If grid(2,3) = 1, that means Player 1 marked the square at column 2, row 3

% MOVE COUNTER
move_count = 0;  % Keeps track of how many moves have been made
                 % We'll add 1 each time someone plays
                 % When move_count = 9, the board is full!

% Display starting message at top of game window
title('TIC-TAC-TOE: Player 1 (RED O) - Click to start!', ...
      'FontSize', 16, ...         % Make text bigger (16 points)
      'FontWeight', 'bold', ...   % Make text bold
      'Color', 'r');              % Make text red ('r' is shorthand for red)

%% STEP 5: MAIN GAME LOOP
% ===========================================
% THE GAME LOOP: This is the heart of our game!
% A loop repeats code over and over until a condition is met
% Our loop keeps running while (go == true)
% Each time through the loop = one player's turn
% ===========================================

while (go)  % Keep looping as long as go is true
    
    % ===========================================
    % GET MOUSE CLICK FROM PLAYER
    % ginput(1) waits for the player to click once
    % It returns the x and y coordinates of where they clicked
    % ===========================================
    [x, y, button] = ginput(1);
    % x = horizontal position (left to right, from 0 to 3)
    % y = vertical position (bottom to top, from 0 to 3)
    % button = which mouse button was clicked (we don't use this)
    
    % ===========================================
    % CONVERT CLICK POSITION TO GRID COORDINATES
    % The player clicks somewhere between 0 and 3 (like x=1.7)
    % We need to figure out which of the 3 squares they meant
    % Square 1: 0 to 1, Square 2: 1 to 2, Square 3: 2 to 3
    % ===========================================
    
    % Determine which COLUMN (xi) was clicked
    if (x < 1)           % If x is less than 1...
        xi = 1;          % ...they clicked column 1 (leftmost)
    elseif (x < 2)       % If x is between 1 and 2...
        xi = 2;          % ...they clicked column 2 (middle)
    else                 % If x is 2 or greater...
        xi = 3;          % ...they clicked column 3 (rightmost)
    end
    % EXAMPLE: If player clicks at x=1.7, we have:
    %          1.7 < 1? NO. 1.7 < 2? YES. So xi=2 (middle column)
    
    % Determine which ROW (yi) was clicked
    if (y < 1)           % If y is less than 1...
        yi = 1;          % ...they clicked row 1 (bottom)
    elseif (y < 2)       % If y is between 1 and 2...
        yi = 2;          % ...they clicked row 2 (middle)
    else                 % If y is 2 or greater...
        yi = 3;          % ...they clicked row 3 (top)
    end
    
    % ===========================================
    % CHECK IF THE SQUARE IS EMPTY
    % Players can only mark an empty square (where grid = 0)
    % If someone already played there, we tell them to try again
    % ===========================================
    
    if (grid(xi, yi) == 0)  % Is this square empty?
        % YES! The square is empty, so this is a VALID MOVE
        
        % ===========================================
        % DRAW THE PLAYER'S MARKER
        % Player 1 gets a RED circle (O)
        % Player 2 gets a BLUE cross (X)
        % ===========================================
        
        if (player1)  % Is it Player 1's turn?
            % YES - Draw a RED circle
            scatter(xi-0.5, yi-0.5, ...          % Position at center of square
                   5000, ...                      % Size of marker (5000 is big!)
                   'o', ...                       % Shape: 'o' = circle
                   'LineWidth', 4, ...            % Thickness of circle outline
                   'MarkerEdgeColor', [1 0 0]);   % Color: [1 0 0] = pure red
            % NOTE: xi-0.5 centers the marker because:
            %       - xi is 1, 2, or 3 (left edge of square)
            %       - Subtracting 0.5 moves to the middle of the square
            
            grid(xi, yi) = 1;      % Mark this square as belonging to Player 1
            current_player = 1;    % Remember who just played (for messages)
            
        else  % It's Player 2's turn
            % Draw a BLUE cross
            scatter(xi-0.5, yi-0.5, ...          % Position at center of square
                   5000, ...                      % Size of marker
                   'x', ...                       % Shape: 'x' = cross
                   'LineWidth', 4, ...            % Thickness of cross lines
                   'MarkerEdgeColor', [0 0 1]);   % Color: [0 0 1] = pure blue
            
            grid(xi, yi) = 2;      % Mark this square as belonging to Player 2
            current_player = 2;    % Remember who just played
        end
        
        % ===========================================
        % INCREMENT THE MOVE COUNTER
        % We just made a valid move, so count it!
        % ===========================================
        move_count = move_count + 1;  % Add 1 to move_count
        % EXAMPLE: If move_count was 3, now it's 4
        
        %% STEP 6: CHECK FOR A WINNER
        % ===========================================
        % After each move, we need to check if someone won
        % A player wins by getting 3 in a row (horizontal, vertical, or diagonal)
        % We call our custom function check_winner() to do this
        % ===========================================
        winner = check_winner(grid);  % Call the function at the bottom of the code
        % winner will be: 0 (no winner), 1 (Player 1 wins), or 2 (Player 2 wins)
        
        if (winner > 0)  % Did someone win? (winner is 1 or 2)
            % YES! Someone won the game!
            go = false;  % Set go to false to END the game loop
            
            if (winner == 1)  % Did Player 1 win?
                % Player 1 wins - show RED victory message
                title('PLAYER 1 (RED O) WINS!', ...
                      'FontSize', 18, ...
                      'FontWeight', 'bold', ...
                      'Color', 'r');  % Red text
                
                % Also print message to command window
                disp('========================================');
                disp('GAME OVER: Player 1 (RED O) WINS!');
                disp('========================================');
                
            else  % Player 2 wins
                % Player 2 wins - show BLUE victory message
                title('PLAYER 2 (BLUE X) WINS!', ...
                      'FontSize', 18, ...
                      'FontWeight', 'bold', ...
                      'Color', 'b');  % Blue text
                
                % Also print message to command window
                disp('========================================');
                disp('GAME OVER: Player 2 (BLUE X) WINS!');
                disp('========================================');
            end
            
            % Pause to let players see the result, then close window
            pause(3);  % Wait 3 seconds
            close;     % Close the game window
            
        elseif (move_count == 9)  % Is the board full?
            % YES! All 9 squares are filled and nobody won - it's a DRAW!
            go = false;  % End the game loop
            
            % Show draw message in gray
            title('DRAW! Nobody wins!', ...
                  'FontSize', 18, ...
                  'FontWeight', 'bold', ...
                  'Color', [0.5 0.5 0.5]);  % Gray color
            
            % Print message to command window
            disp('========================================');
            disp('GAME OVER: DRAW! Nobody wins!');
            disp('========================================');
            
            % Pause to show result, then close window
            pause(3);
            close;
            
        else  % Game is not over yet
            % ===========================================
            % GAME CONTINUES - SWITCH TO NEXT PLAYER
            % We use the NOT operator (~) to flip the boolean
            % ===========================================
            player1 = ~player1;  % Flip the value
            % EXPLANATION: If player1 was true, now it's false
            %              If player1 was false, now it's true
            %              ~ is the "NOT" operator (it flips true/false)
            
            % Update the title to show whose turn it is now
            if (player1)  % Is it now Player 1's turn?
                title('TIC-TAC-TOE: Player 1 (RED O) - Your turn!', ...
                      'FontSize', 16, ...
                      'FontWeight', 'bold', ...
                      'Color', 'r');
            else  % It's Player 2's turn
                title('TIC-TAC-TOE: Player 2 (BLUE X) - Your turn!', ...
                      'FontSize', 16, ...
                      'FontWeight', 'bold', ...
                      'Color', 'b');
            end
        end
        
    else  % grid(xi, yi) is NOT 0
        % ===========================================
        % INVALID MOVE - Square is already taken!
        % The player clicked on a square that's already marked
        % We tell them to try again (don't switch players)
        % ===========================================
        disp('That square is already taken! Choose another square.');
        
        % Show a warning message in the title
        if (player1)  % Is it Player 1's turn?
            title('Square taken! Player 1, try again!', ...
                  'FontSize', 16, ...
                  'FontWeight', 'bold', ...
                  'Color', 'r');
        else  % It's Player 2's turn
            title('Square taken! Player 2, try again!', ...
                  'FontSize', 16, ...
                  'FontWeight', 'bold', ...
                  'Color', 'b');
        end
        % NOTE: We don't flip player1, so the same player tries again
    end
end  % End of while loop - game is over!

%% FUNCTION: CHECK FOR WINNER
% ===========================================
% WHAT IS A FUNCTION?
% A function is a reusable piece of code that does a specific job
% This function checks if anyone has won the game
% 
% INPUT: grid (the 3x3 game board)
% OUTPUT: winner (0=no winner, 1=Player 1 wins, 2=Player 2 wins)
% 
% HOW TO WIN TIC-TAC-TOE:
% - 3 in a row horizontally (any row)
% - 3 in a row vertically (any column)
% - 3 in a row diagonally (two ways)
% ===========================================

function winner = check_winner(grid)
    winner = 0;  % Start by assuming nobody has won yet
    
    % ===========================================
    % CHECK ALL ROWS (HORIZONTAL)
    % We need to check if any row has 3 matching markers
    % Row 1: grid(1,1), grid(1,2), grid(1,3)
    % Row 2: grid(2,1), grid(2,2), grid(2,3)
    % Row 3: grid(3,1), grid(3,2), grid(3,3)
    % ===========================================
    for i = 1:3  % Check each of the 3 rows
        % Three conditions must ALL be true to win:
        % 1. First square is not empty (grid(i,1) ~= 0)
        % 2. First square = second square (grid(i,1) == grid(i,2))
        % 3. Second square = third square (grid(i,2) == grid(i,3))
        if (grid(i,1) ~= 0 && grid(i,1) == grid(i,2) && grid(i,2) == grid(i,3))
            winner = grid(i,1);  % Set winner to whoever marked this row (1 or 2)
            return;  % Exit the function immediately (we found a winner!)
        end
        % NOTE: && means "AND" - all conditions must be true
        %       ~= means "not equal to"
    end
    
    % ===========================================
    % CHECK ALL COLUMNS (VERTICAL)
    % We need to check if any column has 3 matching markers
    % Column 1: grid(1,1), grid(2,1), grid(3,1)
    % Column 2: grid(1,2), grid(2,2), grid(3,2)
    % Column 3: grid(1,3), grid(2,3), grid(3,3)
    % ===========================================
    for j = 1:3  % Check each of the 3 columns
        % Three conditions must ALL be true:
        % 1. Top square is not empty
        % 2. Top = middle
        % 3. Middle = bottom
        if (grid(1,j) ~= 0 && grid(1,j) == grid(2,j) && grid(2,j) == grid(3,j))
            winner = grid(1,j);  % Set winner
            return;  % Exit immediately
        end
    end
    
    % ===========================================
    % CHECK DIAGONAL (TOP-LEFT TO BOTTOM-RIGHT)
    % This diagonal goes through: grid(1,1), grid(2,2), grid(3,3)
    % In screen coordinates:
    %     grid(1,3)  grid(2,3)  grid(3,3)
    %     grid(1,2)  grid(2,2)  grid(3,2)
    %     grid(1,1)  grid(2,1)  grid(3,1)
    % ===========================================
    if (grid(1,1) ~= 0 && grid(1,1) == grid(2,2) && grid(2,2) == grid(3,3))
        winner = grid(1,1);  % Set winner
        return;  % Exit immediately
    end
    
    % ===========================================
    % CHECK DIAGONAL (TOP-RIGHT TO BOTTOM-LEFT)
    % This diagonal goes through: grid(3,1), grid(2,2), grid(1,3)
    % This is the "other" diagonal
    % ===========================================
    if (grid(3,1) ~= 0 && grid(3,1) == grid(2,2) && grid(2,2) == grid(1,3))
        winner = grid(3,1);  % Set winner
        return;  % Exit immediately
    end
    
    % ===========================================
    % NO WINNER FOUND
    % If we get here, nobody has won yet
    % winner is still 0 (its initial value)
    % ===========================================
end  % End of check_winner function

% ============================================
% *** END OF GAME ***
% ============================================
% 
% CONGRATULATIONS! You've read through a complete game program!
% 
% KEY CONCEPTS YOU LEARNED:
% 1. Variables: Storing information (grid, player1, move_count)
% 2. Loops: Repeating code (while loop for game, for loops for drawing)
% 3. Conditionals: Making decisions (if/else statements)
% 4. Functions: Reusable code (check_winner)
% 5. Arrays: Storing multiple values (grid is a 3x3 array)
% 6. Graphics: Drawing shapes (scatter, rectangle, line)
% 7. User Input: Getting mouse clicks (ginput)