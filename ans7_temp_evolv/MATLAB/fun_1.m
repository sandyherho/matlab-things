function [temp] = fun_1(solar_constant, albedo)
%==========================================================================
% FUNCTION: fun_1 - Zero-Dimensional Energy Balance Model (EBM)
%==========================================================================
% Author:       Sandy H. S. Herho
% Date:         11/25/2025
% Course:       GEO111 - Introduction to Numerical Modeling
% Assignment:   #7 - Climate Model
%==========================================================================
%
% DESCRIPTION:
%   This function calculates the global mean surface temperature of Earth
%   using a simple zero-dimensional energy balance model. At equilibrium,
%   the incoming solar radiation equals the outgoing thermal radiation.
%
% PHYSICS:
%   Energy Balance Equation:
%       F_in = F_out
%
%   Where:
%       F_in  = (1 - albedo) * S / 4     [Incoming solar radiation]
%       F_out = emissivity * sigma * T^4  [Outgoing thermal radiation]
%
%   Solving for temperature T:
%       T = [ (1 - albedo) * S / (4 * emissivity * sigma) ]^(1/4)
%
% INPUTS:
%   solar_constant  - Solar flux at Earth's orbit [W/m^2]
%                     Modern value: 1368 W/m^2
%   albedo          - Planetary reflectivity [dimensionless, 0-1]
%                     Typical Earth value: 0.3
%
% OUTPUTS:
%   temp            - Global mean surface temperature [degrees Celsius]
%
% EXAMPLE USAGE:
%   >> temp = fun_1(1368.0, 0.3)
%   temp = 14.1851  (approximately 14 degrees C for modern conditions)
%
%==========================================================================

%--------------------------------------------------------------------------
% SECTION 1: Define Physical Constants
%--------------------------------------------------------------------------

% Stefan-Boltzmann constant [W / (m^2 * K^4)]
sigma = 5.67E-8;

% Effective emissivity of Earth's surface [dimensionless]
% Value 0.62 accounts for the greenhouse effect
emissivity = 0.62;

%--------------------------------------------------------------------------
% SECTION 2: Calculate Equilibrium Temperature
%--------------------------------------------------------------------------

% Calculate T^4 first (intermediate step)
temp_fourth = ((1 - albedo) * solar_constant) / (4 * emissivity * sigma);

% Take the fourth root to get temperature in Kelvin
temp_kelvin = temp_fourth^0.25;

%--------------------------------------------------------------------------
% SECTION 3: Convert Temperature Units (Kelvin to Celsius)
%--------------------------------------------------------------------------

temp = temp_kelvin - 273.15;

end
%==========================================================================
% END OF FUNCTION
%==========================================================================