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
% Close any open windows and clear workspace
close all;
clear;
clc;

% Create a new figure window for the game
figure('Name', 'Tic-Tac-Toe Game', 'NumberTitle', 'off', ...
       'Position', [100, 100, 600, 600], 'Color', [0.95 0.95 0.95]);

% Create axes that fill the entire window
fh = axes('Position', [0.05 0.05 0.9 0.9], 'Visible', 'off');
axis([0 3 0 3]);
axis square;  % Make the board perfectly square!
hold on;

%% STEP 2: DRAW THE CHECKERBOARD BACKGROUND
% Create a nice alternating background pattern
colors = [0.9 0.9 1.0; 0.8 0.8 0.95];  % Light blue alternating colors
for i = 1:3
    for j = 1:3
        % Alternate colors like a checkerboard
        if mod(i+j, 2) == 0
            color = colors(1,:);
        else
            color = colors(2,:);
        end
        % Draw filled rectangle for each square
        rectangle('Position', [i-1, j-1, 1, 1], ...
                  'FaceColor', color, 'EdgeColor', 'none');
    end
end

%% STEP 3: DRAW THE GRID LINES
% Draw thick black lines to separate the squares
for i = 0:3
    line([i i], [0 3], 'LineWidth', 4, 'Color', [0.2 0.2 0.2]);
    line([0 3], [i i], 'LineWidth', 4, 'Color', [0.2 0.2 0.2]);
end

%% STEP 4: SET UP GAME VARIABLES
% Game control variable
go = true;  % Keep playing while this is true

% Player tracking
player1 = true;  % true = Player 1's turn, false = Player 2's turn

% Game board array
% 0 = empty square
% 1 = Player 1 (RED O)
% 2 = Player 2 (BLUE X)
grid = zeros(3, 3);

% Move counter
move_count = 0;

% Display starting message
title('TIC-TAC-TOE: Player 1 (RED O) - Click to start!', ...
      'FontSize', 16, 'FontWeight', 'bold', 'Color', 'r');

%% STEP 5: MAIN GAME LOOP
while (go)
    % Get mouse click position
    [x, y, button] = ginput(1);
    
    % Convert click position to grid coordinates (1, 2, or 3)
    if (x < 1)
        xi = 1;
    elseif (x < 2)
        xi = 2;
    else
        xi = 3;
    end
    
    if (y < 1)
        yi = 1;
    elseif (y < 2)
        yi = 2;
    else
        yi = 3;
    end
    
    % Check if the clicked square is empty
    if (grid(xi, yi) == 0)
        % VALID MOVE - Place the marker
        
        % Draw Player 1's marker (RED circle)
        if (player1)
            scatter(xi-0.5, yi-0.5, 5000, 'o', ...
                   'LineWidth', 4, 'MarkerEdgeColor', [1 0 0]);
            grid(xi, yi) = 1;
            current_player = 1;
        % Draw Player 2's marker (BLUE cross)
        else
            scatter(xi-0.5, yi-0.5, 5000, 'x', ...
                   'LineWidth', 4, 'MarkerEdgeColor', [0 0 1]);
            grid(xi, yi) = 2;
            current_player = 2;
        end
        
        % Increment move counter
        move_count = move_count + 1;
        
        %% STEP 6: CHECK FOR A WINNER
        winner = check_winner(grid);
        
        if (winner > 0)
            % Someone won!
            go = false;  % End the game
            
            if (winner == 1)
                % Player 1 wins
                title('PLAYER 1 (RED O) WINS!', ...
                      'FontSize', 18, 'FontWeight', 'bold', 'Color', 'r');
                disp('========================================');
                disp('GAME OVER: Player 1 (RED O) WINS!');
                disp('========================================');
            else
                % Player 2 wins
                title('PLAYER 2 (BLUE X) WINS!', ...
                      'FontSize', 18, 'FontWeight', 'bold', 'Color', 'b');
                disp('========================================');
                disp('GAME OVER: Player 2 (BLUE X) WINS!');
                disp('========================================');
            end
            
            % Pause to show the result, then close
            pause(3);
            close;
            
        elseif (move_count == 9)
            % Board is full and no winner - it's a draw!
            go = false;
            title('DRAW! Nobody wins!', ...
                  'FontSize', 18, 'FontWeight', 'bold', 'Color', [0.5 0.5 0.5]);
            disp('========================================');
            disp('GAME OVER: DRAW! Nobody wins!');
            disp('========================================');
            
            % Pause to show the result, then close
            pause(3);
            close;
            
        else
            % Game continues - switch to next player
            player1 = ~player1;
            
            % Update title to show whose turn it is
            if (player1)
                title('TIC-TAC-TOE: Player 1 (RED O) - Your turn!', ...
                      'FontSize', 16, 'FontWeight', 'bold', 'Color', 'r');
            else
                title('TIC-TAC-TOE: Player 2 (BLUE X) - Your turn!', ...
                      'FontSize', 16, 'FontWeight', 'bold', 'Color', 'b');
            end
        end
        
    else
        % INVALID MOVE - Square already taken
        disp('That square is already taken! Choose another square.');
        % Flash a warning (optional)
        if (player1)
            title('Square taken! Player 1, try again!', ...
                  'FontSize', 16, 'FontWeight', 'bold', 'Color', 'r');
        else
            title('Square taken! Player 2, try again!', ...
                  'FontSize', 16, 'FontWeight', 'bold', 'Color', 'b');
        end
    end
end

%% FUNCTION: CHECK FOR WINNER
% This function checks if anyone has won the game
% Returns: 0 = no winner yet, 1 = Player 1 wins, 2 = Player 2 wins
function winner = check_winner(grid)
    winner = 0;  % Default: no winner
    
    % Check all rows (horizontal)
    for i = 1:3
        if (grid(i,1) ~= 0 && grid(i,1) == grid(i,2) && grid(i,2) == grid(i,3))
            winner = grid(i,1);
            return;
        end
    end
    
    % Check all columns (vertical)
    for j = 1:3
        if (grid(1,j) ~= 0 && grid(1,j) == grid(2,j) && grid(2,j) == grid(3,j))
            winner = grid(1,j);
            return;
        end
    end
    
    % Check diagonal (top-left to bottom-right)
    if (grid(1,1) ~= 0 && grid(1,1) == grid(2,2) && grid(2,2) == grid(3,3))
        winner = grid(1,1);
        return;
    end
    
    % Check diagonal (top-right to bottom-left)
    if (grid(3,1) ~= 0 && grid(3,1) == grid(2,2) && grid(2,2) == grid(1,3))
        winner = grid(3,1);
        return;
    end
end

% ============================================
% *** END OF GAME ***
% ============================================