clear all; close all; clc
data = load("paleo_CO2_data.txt");

% 1st col --> time (Ma)
% 2nd col --> mean of CO2 (ppmv)
% 3rd col --> min of CO2 (ppmv)
% 4th col --> max of CO2 (ppmv)

sorted_data = sortrows(data);

figure(1)
hold on

% mean values of CO2
scatter(sorted_data(:,1), sorted_data(:,2), 'ok', 'filled', 'k')

% max of co2 --> dashed black line
plot(sorted_data(:,1), sorted_data(:,4), '--k', 'LineWidth', 1.5)

% min of co2 --> dotted black line
plot(sorted_data(:,1), sorted_data(:,3), ':k', 'LineWidth', 1.5)

xlim([0 500])
ylim([0 6000])

xlabel('Time [Ma]')
ylabel('Atmospheric CO_{2} [ppmv]')

legend('Mean CO_{2}', 'Max CO_{2}', 'Min CO_{2}', ...
    'Location','best')

grid on
title('Sandy Herho: Proxy Atmospheric CO_{2} over Geological time')

% gcf -> get curent fig
exportgraphics(gcf, 'geol_plot.png')
hold off

