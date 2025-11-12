function mygrid(n_rows, n_cols)
% MYGRID Creates a grid of squares
%
% Input:
%   n_rows - number of rows in the grid
%   n_cols - number of columns in the grid
%
% Output:
%   None (creates a figure window with the grid)
%
% Example:
%   mygrid(7, 5)  % Creates a 7x5 grid
%
% Author: Sandy H. S. Herho
% Date: November 2025

% Create a new figure window for our grid
figure;

% Set up the axes to display our grid properly
% - 'equal' makes sure squares look square (not stretched)
% - 'off' hides the axis lines and numbers for a cleaner look
axis equal;
axis off;

% Hold on allows us to draw multiple patches without erasing previous ones
hold on;

% MAIN LOOP: Create each square in the grid
% Outer loop goes through each row (from bottom to top)
for i = 1:n_rows
    % Inner loop goes through each column (from left to right)
    for j = 1:n_cols
        
        % Calculate the four corner points of the current square
        % Each square is 1 unit wide and 1 unit tall
        % x-coordinates: left edge at j-1, right edge at j
        % y-coordinates: bottom edge at i-1, top edge at i
        x_corners = [j-1, j, j, j-1];      % [bottom-left, bottom-right, top-right, top-left]
        y_corners = [i-1, i-1, i, i];      % [bottom-left, bottom-right, top-right, top-left]
        
        % Draw the square using the patch function
        % patch creates a filled polygon with the specified corners and color
        % Using 'white' as the fill color for all squares
        patch(x_corners, y_corners, 'white');
        
    end  % End of column loop
end  % End of row loop

% Turn hold off so future plots don't add to this figure
hold off;

% Set the axis limits to fit our grid perfectly
% This ensures we see the entire grid from (0,0) to (n_cols, n_rows)
xlim([0, n_cols]);
ylim([0, n_rows]);

% Add a title to the figure showing the grid dimensions
title(sprintf('%d x %d Grid', n_rows, n_cols));

end  % End of function