#!/usr/bin/env python3
"""
===============================================================================
SCRIPT: temp_evolv.py
Evolution of Earth Surface Temperature Through Geological Time
===============================================================================
Author:       Sandy H. S. Herho
Date:         11/25/2025
Course:       GEO111 - Introduction to Numerical Modeling
Assignment:   #7 - Climate Model

DESCRIPTION:
    This script simulates how Earth's global mean surface temperature has
    evolved from the formation of the Sun (~4.57 billion years ago) to 
    approximately 5 billion years into the future.
    
    The model uses:
    1. A zero-dimensional Energy Balance Model (EBM) to calculate temperature
    2. A time-varying solar constant based on stellar evolution theory

OUTPUT:
    - Figure displayed on screen
    - Figure saved as PNG file (earth_temperature_evolution.png)

REQUIRED LIBRARIES:
    - numpy
    - matplotlib
===============================================================================
"""

# =============================================================================
# SECTION 1: IMPORT LIBRARIES
# =============================================================================

import numpy as np
import matplotlib.pyplot as plt


# =============================================================================
# SECTION 2: DEFINE THE ENERGY BALANCE MODEL FUNCTION
# =============================================================================

def fun_1(solar_constant, albedo):
    """
    Zero-Dimensional Energy Balance Model (EBM).
    
    Calculates the global mean surface temperature of Earth using
    energy balance between incoming solar radiation and outgoing
    thermal radiation.
    
    Parameters
    ----------
    solar_constant : float
        Solar flux at Earth's orbit [W/m^2]
    albedo : float
        Planetary reflectivity [dimensionless, 0-1]
    
    Returns
    -------
    temp : float
        Global mean surface temperature [degrees Celsius]
    """
    
    # Physical Constants
    sigma = 5.67e-8       # Stefan-Boltzmann constant [W/(m^2*K^4)]
    emissivity = 0.62     # Effective emissivity (accounts for greenhouse)
    
    # Calculate equilibrium temperature
    temp_fourth = ((1 - albedo) * solar_constant) / (4 * emissivity * sigma)
    temp_kelvin = temp_fourth ** 0.25
    
    # Convert Kelvin to Celsius
    temp_celsius = temp_kelvin - 273.15
    
    return temp_celsius


# =============================================================================
# SECTION 3: DEFINE THE SOLAR CONSTANT EVOLUTION FUNCTION
# =============================================================================

def fun_2(t):
    """
    Solar Constant Evolution Through Geological Time.
    
    Calculates the solar constant as a function of time since the 
    formation of the Sun using the Gough (1981) formula.
    
    Parameters
    ----------
    t : float
        Time since formation of the Sun [Gyr]
    
    Returns
    -------
    St : float
        Solar constant at time t [W/m^2]
    """
    
    # Reference values
    S_0 = 1368.0    # Present-day solar constant [W/m^2]
    t_0 = 4.57      # Age of the Sun [Gyr]
    
    # Calculate solar constant at time t
    denominator = 1 + (2/5) * (1 - t/t_0)
    St = S_0 / denominator
    
    return St


# =============================================================================
# SECTION 4: MAIN PROGRAM
# =============================================================================

def main():
    """
    Main program: Calculate and plot the evolution of Earth's surface
    temperature through geological time.
    """
    
    print("=" * 60)
    print("   CLIMATE MODEL: Earth Temperature Through Geological Time")
    print("=" * 60)
    print()
    
    # -------------------------------------------------------------------------
    # 4.1: Set Model Parameters
    # -------------------------------------------------------------------------
    
    albedo = 0.3            # Planetary albedo
    
    t_start = 0.0           # Start: Formation of the Sun [Gyr]
    t_end = 10.0            # End: ~5.4 Gyr in the future [Gyr]
    t_step = 0.1            # Time step: 100 million years [Gyr]
    
    t_present = 4.57        # Present day [Gyr since Sun formation]
    
    print("Model Parameters:")
    print("  Albedo: " + str(albedo))
    print("  Time range: " + str(t_start) + " to " + str(t_end) + " Gyr")
    print("  Time step: " + str(t_step) + " Gyr")
    print()
    
    # -------------------------------------------------------------------------
    # 4.2: Create Time Array and Initialize Storage
    # -------------------------------------------------------------------------
    
    time_array = np.arange(t_start, t_end + t_step, t_step)
    n_steps = len(time_array)
    
    temp_array = np.zeros(n_steps)
    solar_array = np.zeros(n_steps)
    
    # -------------------------------------------------------------------------
    # 4.3: Main Time Loop
    # -------------------------------------------------------------------------
    
    print("Running simulation...")
    
    for i, t in enumerate(time_array):
        St = fun_2(t)
        temp = fun_1(St, albedo)
        solar_array[i] = St
        temp_array[i] = temp
    
    print("Simulation complete!")
    print()
    
    # -------------------------------------------------------------------------
    # 4.4: Transform Time to "Relative to Present"
    # -------------------------------------------------------------------------
    
    time_relative = time_array - t_present
    
    # -------------------------------------------------------------------------
    # 4.5: Create the Figure with Dual Y-Axes (BONUS)
    # -------------------------------------------------------------------------
    
    fig, ax1 = plt.subplots(figsize=(10, 6))
    
    # LEFT Y-AXIS: Temperature
    color_temp = 'blue'
    ax1.set_xlabel('Time Relative to Present (Gyr)', fontsize=12, fontweight='bold')
    ax1.set_ylabel('Global Mean Temperature (degrees C)', fontsize=12, 
                   fontweight='bold', color=color_temp)
    
    line1, = ax1.plot(time_relative, temp_array, color=color_temp, 
                      linewidth=2, label='Temperature (degrees C)')
    
    ax1.tick_params(axis='y', labelcolor=color_temp)
    ax1.set_ylim(-20, 60)
    ax1.set_xlim(-5, 5)
    ax1.grid(True, alpha=0.3)
    
    # RIGHT Y-AXIS: Solar Constant (BONUS)
    ax2 = ax1.twinx()
    
    color_solar = 'red'
    ax2.set_ylabel('Solar Constant (W/m^2)', fontsize=12, 
                   fontweight='bold', color=color_solar)
    
    line2, = ax2.plot(time_relative, solar_array, color=color_solar, 
                      linewidth=1.5, linestyle='--', label='Solar Constant (W/m^2)')
    
    ax2.tick_params(axis='y', labelcolor=color_solar)
    ax2.set_ylim(900, 1800)
    
    # ADD PRESENT-DAY MARKER LINE
    present_line = ax1.axvline(x=0, color='black', linestyle=':', linewidth=2, 
                               label='Present Day')
    
    # ADD TITLE
    plt.title('Evolution of Earth Surface Temperature Through Geological Time',
              fontsize=14, fontweight='bold', pad=20)
    
    # ADD LEGEND
    lines = [line1, line2, present_line]
    labels = [l.get_label() for l in lines]
    ax1.legend(lines, labels, loc='upper left', fontsize=10)
    
    plt.tight_layout()
    
    # -------------------------------------------------------------------------
    # 4.6: Save Figure as PNG
    # -------------------------------------------------------------------------
    
    output_filename = 'earth_temperature_evolution.png'
    
    # Save figure as PNG with high resolution (150 dpi)
    plt.savefig(output_filename, dpi=150, bbox_inches='tight')
    
    print("Figure saved as: " + output_filename)
    
    # Display the figure
    plt.show()
    
    # -------------------------------------------------------------------------
    # 4.7: Print Summary Statistics
    # -------------------------------------------------------------------------
    
    print()
    print("=" * 60)
    print("                    RESULTS SUMMARY")
    print("=" * 60)
    
    # Find index for present day
    idx_present = np.argmin(np.abs(time_array - t_present))
    print()
    print("Present Day (t = " + str(t_present) + " Gyr):")
    print("  Temperature: " + str(round(temp_array[idx_present], 2)) + " degrees C")
    print("  Solar constant: " + str(round(solar_array[idx_present], 2)) + " W/m^2")
    
    # Find index for early Earth (~4 Gyr ago)
    t_early = 0.57
    idx_early = np.argmin(np.abs(time_array - t_early))
    print()
    print("Early Earth (t = " + str(t_early) + " Gyr, ~4 Gyr ago):")
    print("  Temperature: " + str(round(temp_array[idx_early], 2)) + " degrees C")
    print("  Solar constant: " + str(round(solar_array[idx_early], 2)) + " W/m^2")
    
    print()
    print("=" * 60)


# =============================================================================
# SECTION 5: RUN THE PROGRAM
# =============================================================================

if __name__ == "__main__":
    main()

# =============================================================================
# END OF SCRIPT
# =============================================================================
