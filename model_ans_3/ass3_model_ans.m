%{
Author: Sandy H. S. Herho
Date:10/29/2025
ass3_model_ans.m
Script for creating monthly temperature animation
%}


%% Clean workspace and close all figures
clear all
close all
clc

%% Setup coordinate grids for latitude and longitude
% Define longitude vector: 0° to 358.125° E with 1.875° spacing (192 points)
lon = 0:1.875:358.125;

% Define latitude vector: -90° to 87.63° N with 1.91° spacing (94 points)
lat = -90:1.91:87.63;

% Create 2D coordinate grids using meshgrid
% LON and LAT will both be 94 rows × 192 columns to match temperature data
[LON, LAT] = meshgrid(lon, lat);

% Verify dimensions match temperature data (94 × 192)
fprintf('LON grid size: %d rows × %d columns\n', size(LON, 1), size(LON, 2));
fprintf('LAT grid size: %d rows × %d columns\n', size(LAT, 1), size(LAT, 2));

%% Create video file for animation
% Initialize video writer object (saves as AVI format)
vidObj = VideoWriter('my_animation.avi');
open(vidObj);  % Open the video file for writing

%% Generate animation by looping through monthly data
for month = 1:12
    % Load temperature data for current month
    filename = ['temp' num2str(month) '.tsv'];
    temp = load(filename);
    
    % Verify temperature data dimensions
    fprintf('Month %d: temp size = %d × %d\n', month, size(temp, 1), size(temp, 2));
    
    % Create filled contour plot with geographic coordinates
    contourf(LON, LAT, temp, 20, 'LineColor', 'none');  % 20 contour levels, no lines
    
    % Add labels and formatting with LaTeX degree symbols
    xlabel('Longitude ($^\circ$E)', 'Interpreter', 'latex');
    ylabel('Latitude ($^\circ$N)', 'Interpreter', 'latex');
    title(['Month ' num2str(month)]);
    
    % Add colorbar with label
    cb = colorbar;  % Show color scale
    ylabel(cb, 'T [K]', 'Interpreter', 'latex');  % Label colorbar as Temperature in Kelvin
    
    % Show grid lines
    grid on;
    
    axis equal tight;  % Equal aspect ratio and tight axes
    
    % Capture current figure as a frame
    currFrame = getframe(gcf);
    
    % Write frame to video file
    writeVideo(vidObj, currFrame);
end

%% Finalize and close video file
close(vidObj);

fprintf('Animation saved as my_animation.avi\n');