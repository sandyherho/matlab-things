%{
================================================================================
Author: Sandy H. S. Herho
Date: 10/29/2025
Filename: ass3_model_ans.m

Purpose: Create an animated visualization of monthly temperature data
         This script loads 12 monthly temperature files and creates a video
         showing how temperature patterns change throughout the year.
================================================================================
%}

%% STEP 1: Clean workspace and close all figures
% Remove all variables from memory
clear all
% Close any open figure windows
close all
% Clear the command window for clean output
clc

%% STEP 2: Setup coordinate grids for latitude and longitude
% These coordinates define where each temperature value is located on Earth

% Define longitude vector (East-West position)
% Covers 0° to 358.125° East with 1.875° spacing
% This gives us 192 points around the globe
lon = 0:1.875:358.125;

% Define latitude vector (North-South position)  
% Covers -90° (South Pole) to 87.63° (near North Pole) with 1.91° spacing
% This gives us 94 points from south to north
lat = -90:1.91:87.63;

% Create 2D coordinate grids using meshgrid
% This converts our 1D vectors into 2D matrices that match our temperature data
% Both LON and LAT will be 94 rows × 192 columns
[LON, LAT] = meshgrid(lon, lat);

% Display grid dimensions to verify they're correct
fprintf('LON grid size: %d rows × %d columns\n', size(LON, 1), size(LON, 2));
fprintf('LAT grid size: %d rows × %d columns\n', size(LAT, 1), size(LAT, 2));

%% STEP 3: Find global temperature range across ALL months
% We need to find the minimum and maximum temperatures across all 12 months
% This ensures all plots use the same color scale for easy comparison

fprintf('\nScanning all temperature files to find global min/max...\n');

% Initialize variables to store global extremes
global_min = inf;   % Start with infinity (will be replaced by actual min)
global_max = -inf;  % Start with negative infinity (will be replaced by actual max)

% Loop through all 12 months to find overall temperature range
for month = 1:12
    % Build filename for current month (temp1.tsv, temp2.tsv, etc.)
    filename = ['temp' num2str(month) '.tsv'];
    
    % Load temperature data from file
    temp = load(filename);
    
    % Find minimum temperature in this month's data
    month_min = min(temp(:));  % (:) converts 2D matrix to 1D for min()
    
    % Find maximum temperature in this month's data
    month_max = max(temp(:));
    
    % Update global minimum if this month has a lower temperature
    if month_min < global_min
        global_min = month_min;
    end
    
    % Update global maximum if this month has a higher temperature
    if month_max > global_max
        global_max = month_max;
    end
    
    % Display this month's temperature range
    fprintf('  Month %2d: min = %.2f K, max = %.2f K\n', ...
            month, month_min, month_max);
end

% Display the overall temperature range that will be used for all plots
fprintf('\nGlobal temperature range: %.2f K to %.2f K\n', global_min, global_max);
fprintf('This range will be used for all 12 monthly plots.\n\n');

%% STEP 4: Create video file for animation
% Initialize video writer object (saves as AVI format)
vidObj = VideoWriter('my_animation.avi');
open(vidObj);  % Open the video file for writing
fprintf('Video file opened: my_animation.avi\n');

%% STEP 5: Generate animation by looping through monthly data
fprintf('Creating animation frames...\n');

for month = 1:12
    % Load temperature data for current month
    filename = ['temp' num2str(month) '.tsv'];
    temp = load(filename);
    
    % Verify temperature data dimensions match our coordinate grids
    fprintf('  Processing Month %2d: temp size = %d × %d\n', ...
            month, size(temp, 1), size(temp, 2));
    
    % Create filled contour plot with geographic coordinates
    % contourf creates a filled contour map with 20 color levels
    % 'LineColor', 'none' removes black lines between color regions
    contourf(LON, LAT, temp, 20, 'LineColor', 'none');
    
    % *** CRITICAL: Set color axis limits to global range ***
    % This ensures all 12 plots use the same color scale
    caxis([global_min global_max]);
    
    % Add x-axis label (longitude with degree symbol)
    xlabel('Longitude ($^\circ$E)', 'Interpreter', 'latex');
    
    % Add y-axis label (latitude with degree symbol)
    ylabel('Latitude ($^\circ$N)', 'Interpreter', 'latex');
    
    % Add title showing which month this is
    title(['Month ' num2str(month)], 'FontSize', 12, 'FontWeight', 'bold');
    
    % Add colorbar (legend showing what colors mean)
    cb = colorbar;
    
    % Label the colorbar to show it represents temperature in Kelvin
    ylabel(cb, 'T [K]', 'Interpreter', 'latex');
    
    % Show grid lines to help read coordinates
    grid on;
    
    % Set axis properties:
    % 'equal' makes x and y scales the same (no distortion)
    % 'tight' removes extra white space around the plot
    axis equal tight;
    
    % Capture current figure window as an image frame
    currFrame = getframe(gcf);
    
    % Write this frame to the video file
    writeVideo(vidObj, currFrame);
end

%% STEP 6: Finalize and close video file
% Close the video file (this finalizes the writing process)
close(vidObj);

fprintf('\n================================================================================\n');
fprintf('SUCCESS! Animation saved as my_animation.avi\n');
fprintf('All 12 months use the same color scale: %.2f K to %.2f K\n', ...
        global_min, global_max);
fprintf('================================================================================\n');