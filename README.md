# Spine Cooling - Tissue Cooling Simulation

A Python-based simulation for analyzing thermal dynamics of tissue cooling using physical heat transfer principles.

## Overview

This project simulates the temperature changes in a 1 kg tissue sample over time, accounting for:
- **Metabolic heat generation** - internal heat production in living tissue
- **Radiative heat loss** - thermal radiation emitted by the tissue
- **Convective heat loss** - heat transfer through the surrounding medium
- **Applied cooling** - external cooling intervention

The simulation tracks temperature changes and calculates the power balance to determine how long it takes to cool tissue from its initial temperature to a target temperature.

## Features

- Numerical ODE integration using simple Euler method
- Customizable tissue parameters (mass, surface area, specific heat capacity)
- Environmental condition settings (ambient temperature, convection coefficient)
- Visualization of temperature evolution over time
- Power analysis table showing heat transfer at different time points
- Comparison against target temperature with timing information

## Requirements

- Python 3.7+
- NumPy - for numerical computations
- Matplotlib - for visualization

## Installation

1. Clone or download this repository
2. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Usage

Run the simulation:
```bash
python simple_power.py
```

## Customization

Edit the parameters at the top of `simple_power.py` to modify:
- **MASS_KG** - tissue weight in kilograms
- **SURFACE_AREA** - tissue surface area in m²
- **Q_METABOLIC** - metabolic heat rate in W/kg
- **T_INITIAL** - starting temperature in °C
- **T_TARGET** - desired target temperature in °C
- **Q_COOLING** - applied cooling power in watts
- **T_TOTAL_S** - simulation duration in seconds
- **DT_S** - integration time step in seconds

## Output

The script generates:
- A plot showing temperature vs. time with target temperature line
- A summary table of heat flow components at the end of simulation
- Console output with timing information for reaching target temperature
