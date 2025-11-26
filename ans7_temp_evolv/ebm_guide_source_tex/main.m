%==========================================================================
% SCRIPT: main.m - Evolution of Earth Surface Temperature Through Time
%==========================================================================
% Author:       Sandy H. S. Herho
% Date:         11/25/2025
% Course:       GEO111 - Introduction to Numerical Modeling
% Assignment:   #7 - Climate Model
%==========================================================================
%
% DESCRIPTION:
%   This script simulates how Earth's global mean surface temperature has
%   evolved from the formation of the Sun to approximately 5 billion years
%   into the future.
%
% REQUIRED FUNCTIONS:
%   fun_1.m - Energy Balance Model (calculates temperature from S, albedo)
%   fun_2.m - Solar constant as a function of time
%
% OUTPUT:
%   Figure showing temperature evolution with time (similar to Figure 2.6)
%   BONUS: Second y-axis showing solar constant evolution
%   Saves figure as PNG file
%
%==========================================================================

%--------------------------------------------------------------------------
% SECTION 1: Initialize - Clear Workspace and Set Parameters
%--------------------------------------------------------------------------

% Clear workspace and figures
clear all;
close all;
clc;

% MODEL PARAMETERS
albedo = 0.3;           % Planetary albedo (reflectivity)

% TIME SETTINGS [Gyr since Sun's formation]
t_start = 0.0;          % Start: Formation of the Sun
t_end   = 10.0;         % End: ~5.4 Gyr in the future
t_step  = 0.1;          % Time step: 100 million years

% Present day in this time system
t_present = 4.57;       % The Sun is 4.57 billion years old

%--------------------------------------------------------------------------
% SECTION 2: Initialize Storage Vectors
%--------------------------------------------------------------------------

% Initialize as empty vectors - we will append values in the loop
vt = [];                % Time values [Gyr]
vtemp = [];             % Temperature values [degrees C]
vS = [];                % Solar constant values [W/m^2]

%--------------------------------------------------------------------------
% SECTION 3: Main Time Loop - Calculate Temperature Evolution
%--------------------------------------------------------------------------

for t = t_start:t_step:t_end
    
    % Step 1: Get solar constant at current time
    St = fun_2(t);
    
    % Step 2: Calculate temperature from solar constant and albedo
    temp = fun_1(St, albedo);
    
    % Step 3: Store results by appending to vectors
    vt = [vt t];
    vtemp = [vtemp temp];
    vS = [vS St];
    
end

%--------------------------------------------------------------------------
% SECTION 4: Transform Time Axis to "Relative to Present"
%--------------------------------------------------------------------------

% Negative = past, Zero = present, Positive = future
vt_relative = vt - t_present;

%--------------------------------------------------------------------------
% SECTION 5: Create the Figure with Dual Y-Axes (BONUS)
%--------------------------------------------------------------------------

% Create figure
fig = figure('Position', [100, 100, 900, 600]);

% LEFT Y-AXIS: Temperature
yyaxis left;

% Plot temperature vs. time relative to present
plot(vt_relative, vtemp, 'b-', 'LineWidth', 2);

% Set y-axis properties for temperature
ylabel('Global Mean Temperature (degrees C)', 'FontSize', 12, 'FontWeight', 'bold');
ylim([-20 60]);

% Set the color of the left y-axis to blue
ax = gca;
ax.YColor = 'b';

% RIGHT Y-AXIS: Solar Constant (BONUS)
yyaxis right;

% Plot solar constant vs. time relative to present
plot(vt_relative, vS, 'r--', 'LineWidth', 1.5);

% Set y-axis properties for solar constant
ylabel('Solar Constant (W/m^2)', 'FontSize', 12, 'FontWeight', 'bold');
ylim([900 1800]);

% Set the color of the right y-axis to red
ax.YColor = 'r';

%--------------------------------------------------------------------------
% SECTION 6: Add Present-Day Marker Line
%--------------------------------------------------------------------------

% Hold the plot to add more elements
hold on;

% Add vertical line at present day (t_relative = 0)
xline(0, 'k:', 'LineWidth', 2);

%--------------------------------------------------------------------------
% SECTION 7: Add Labels, Title, and Legend
%--------------------------------------------------------------------------

% Add title
title('Evolution of Earth Surface Temperature Through Geological Time', ...
      'FontSize', 14, 'FontWeight', 'bold');

% Add x-axis label
xlabel('Time Relative to Present (Gyr)', 'FontSize', 12, 'FontWeight', 'bold');

% Set x-axis limits
xlim([-5 5]);

% Add grid
grid on;

% Add legend
legend('Temperature (degrees C)', 'Solar Constant (W/m^2)', 'Present Day', ...
       'Location', 'northwest');

% Release hold
hold off;

%--------------------------------------------------------------------------
% SECTION 8: Save Figure as PNG
%--------------------------------------------------------------------------

% Define output filename
output_filename = 'earth_temperature_evolution.png';

% Save figure as PNG with high resolution (150 dpi)
print(fig, output_filename, '-dpng', '-r150');

% Display confirmation message
disp(' ');
disp(['Figure saved as: ', output_filename]);

%--------------------------------------------------------------------------
% SECTION 9: Display Summary Statistics
%--------------------------------------------------------------------------

disp(' ');
disp('==========================================================');
disp('        CLIMATE MODEL RESULTS SUMMARY');
disp('==========================================================');
disp(' ');
disp('Model Parameters:');
disp(['  Albedo: ', num2str(albedo)]);
disp(['  Time range: ', num2str(t_start), ' to ', num2str(t_end), ' Gyr']);
disp(['  Time step: ', num2str(t_step), ' Gyr']);
disp(' ');
disp('Key Results:');

% Find index for present day
idx_present = find(abs(vt - t_present) < t_step/2, 1);
disp(['  Present-day temperature: ', num2str(vtemp(idx_present), '%.2f'), ' degrees C']);
disp(['  Present-day solar constant: ', num2str(vS(idx_present), '%.2f'), ' W/m^2']);

% Find index for early Earth (~4 Gyr ago, t = 0.57)
idx_early = find(abs(vt - 0.57) < t_step/2, 1);
if ~isempty(idx_early)
    disp(['  Temperature 4 Gyr ago: ', num2str(vtemp(idx_early), '%.2f'), ' degrees C']);
    disp(['  Solar constant 4 Gyr ago: ', num2str(vS(idx_early), '%.2f'), ' W/m^2']);
end

disp(' ');
disp('==========================================================');

%==========================================================================
% END OF SCRIPT
%==========================================================================
