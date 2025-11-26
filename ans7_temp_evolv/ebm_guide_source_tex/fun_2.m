function [St] = fun_2(t)
%==========================================================================
% FUNCTION: fun_2 - Solar Constant Evolution Through Geological Time
%==========================================================================
% Author:       Sandy H. S. Herho
% Date:         11/25/2025
% Course:       GEO111 - Introduction to Numerical Modeling
% Assignment:   #7 - Climate Model
%==========================================================================
%
% DESCRIPTION:
%   This function calculates the solar constant (solar flux at Earth's
%   orbit) as a function of time since the formation of the Sun.
%
% PHYSICS:
%   The solar luminosity evolution follows the approximation by
%   Gough (1981) and Feulner (2012):
%
%       S(t) = S_0 / [1 + (2/5) * (1 - t/t_0)]
%
%   Where:
%       S(t) = Solar constant at time t
%       S_0  = Present-day solar constant (1368 W/m^2)
%       t    = Time since formation of the Sun [Gyr]
%       t_0  = Age of the Sun (4.57 Gyr)
%
% INPUT:
%   t   - Time since the formation of the Sun [Gyr]
%         t = 0    --> Formation of the Sun (4.57 billion years ago)
%         t = 4.57 --> Present day
%         t > 4.57 --> Future
%
% OUTPUT:
%   St  - Solar constant at time t [W/m^2]
%
% EXAMPLE USAGE:
%   >> St = fun_2(4.57)    % Present day
%   St = 1368              % Modern solar constant
%
%   >> St = fun_2(0.0)     % At Sun's formation
%   St = 977.14            % About 71% of modern value
%
%==========================================================================

%--------------------------------------------------------------------------
% SECTION 1: Define Reference Values (Constants)
%--------------------------------------------------------------------------

% Present-day solar constant [W/m^2]
S_0 = 1368.0;

% Age of the Sun [Gyr]
t_0 = 4.57;

%--------------------------------------------------------------------------
% SECTION 2: Calculate Solar Constant at Time t
%--------------------------------------------------------------------------

% Apply the Gough (1981) / Feulner (2012) formula:
% S(t) = S_0 / [1 + (2/5) * (1 - t/t_0)]

denominator = 1 + (2/5) * (1 - t/t_0);

St = S_0 / denominator;

end
%==========================================================================
% END OF FUNCTION
%==========================================================================
