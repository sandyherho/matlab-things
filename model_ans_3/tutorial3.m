%{
Name: 
Date:
Purpose:
%}

clear all; close all; clc

lon = [0:1.875:358.125];
lat = [-90:1.91:87.63];

[LON LAT] = meshgrid(lon, lat); %94 rows x 192 cols

%% Set the colorbar into the same scale
% place holder
global_min = inf;
global_max = -inf;

for month = 1:12
    filename = ['temp' num2str(month) '.tsv'];
    temp = load(filename);
    month_min = min(temp(:));
    month_max = max(temp(:));
    
    if month_max > global_max
        global_max = month_max;
    end

    if month_min < global_min
        global_min = month_min;
    end
end

% create the animation
% Prepare the new file.
vidObj = VideoWriter('my_animation.avi');
open(vidObj);

for month=1:12
    filename = ['temp' num2str(month) '.tsv'];
    temp = load(filename);
    contourf(LON, LAT, temp, 20, 'LineColor', 'none');
    caxis([global_min global_max]);
    xlabel('Longitude [deg E]')
    ylabel('Latitude [deg N]')

    cb = colorbar;
    ylabel(cb, 'Tempreature [K]')

    title(['Month: ' num2str(month)])

    axis equal tight

    grid on

    % Write each frame to the file.
    currFrame = getframe;
    writeVideo(vidObj,currFrame);
end
% Close the file.
close(vidObj);



