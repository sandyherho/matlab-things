%{
assignment1_shshs.m
Sandy H 
10/08/2025
%}

clear all; close all; clc

data = load('paleo_CO2_data.txt');

% 1st col. --> time [Ma]
% 2nd col. --> mean CO2 [ppmv]
% 3rd col. --> min. CO2 [ppmv]
% 4th col. --> max. CO2 [ppmv]

sorted_data = sortrows(data);

figure(1)
hold on

% mean value of co2
scatter(sorted_data(:,1), sorted_data(:,2), 'ok', 'filled', 'k')

% max value of co2 dashed black line
plot(sorted_data(:, 1), sorted_data(:,4), '--k', 'LineWidth',1.5)

% min value of co2 dotted black line
plot(sorted_data(:,1), sorted_data(:, 3), ':k', 'LineWidth',1.5)

% label x-axis
xlabel('Time [Ma]')
% label y-axis
ylabel('Atmospheric pCO_{2} [ppmv]')

% x limit 0 to 500 Ma
xlim([0 500])

% y limit 0 to 6000 ppmv
ylim([0 6000])

% put legend
legend('Mean of CO_{2}', 'Max. of CO_{2}', 'Min. of CO_{2}', 'Location','best')

% set the title
title('Sandy Herho: Atmospheric CO_{2} Evolution in Geological Timescale')

% saving using the command line
% exportgraphics(gcf, 'geolas1.png') % gcf --> get current figure
