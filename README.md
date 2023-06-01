# APCS Final Project
THIS DOCUMENT IS REQUIRED
## Group Info
Group Members: Dylan Ma and David Cai Liang
## Overview
We've created a circuit simulator that returns the total charge of the circuit as well as that of individual components; you are allowed to add and remove components.
## Instructions
4 Buttons Along Top From Left to Right
- 4 part circle
  - Allows you to move between run mode and edit mode.
  - You can only edit current components and their connections in edit mode.
  - You can only see data about the circuit in run mode
- pill shape
  - allows you to select resistors as the objects you put down
    - resistors have one input and one output component
- right facing y
  - allows you to select start junctions as the objects you put down
    - start junctions have one input and two outputs component
- left facing y
  - allows you to select end junctions as the objects you put down
    - end junctions have two input and one output components

2 Slider
Top - Right of Screen Slider
  - Allows you to adjust the total amount of voltage through the curcuit, pull right to increase voltage
  - Goes from 0 volts to 28.5 volts.
Bottom Slider
  - Only appears when you have selected a resistor by right clicking it.
  - This allows you adjust the resistance of a resistor.
  - Goes from 0 ohms to 28.5 ohms.
4 Hotkeys
- 'd'
  - opens up debug mode
- 'e'
  - does same thing as 4 part circle
- 'c'
  - allows you to switch the objects you place down from resistor to start junction to end junction and back
- 'r'
  - allows you to restart the simulation
  - will automatically return you to edit mode.

2 Mouse Inputs
- 'left click'
  - Edit mode
    - You can place down objects
    - Will sometimes fail when you do not follow the rules provided above about resistors and junctions.
    - If fails, your selected circle will go to center and no new component will be made.
  - Run mode
    - You can also interact with objects and get their statistics
- 'right click'
  - Edit mode
    - choose the component for the next component you place down connect to
    - choose the component for a previously placed component to connect to
    - the selected component will the component from which charge flows in these connections.
 - Run mode
  - You can also interact with objects and get their statistics

Note: You would right click on an element to set it as the prior element to connect to and any spot you left click where there isn't already a component will create a component such that component is tied to the one you previously right clicked. If there is already an element, the simulator will attempt to connect it using the same logic as there isn't a component already there.

Note: There is no undo button in this simulator so you must be careful how you interact with it.

Note: If a connection fails, please do not transition to run mode as it will likely crash the program but rather please restart the simulation with r and re-input all the components and their relationships while avoiding the same error.
