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

1 Slider (Top - Right of Screen)
  - Allows you to adjust the total amount of voltage through the curcuit, pull right to increase voltage

4 Hotkeys
- 'd'
  - opens up debug mode
- 'e'
  - does same thing as 4 part circle
- 'c'
  - allows you to switch the objects you place down from resistor to start junction to end junction and back
- 'r'
  - allows you to restart the simulation

2 Mouse Inputs
- 'left click'
  - You can place down objects in edit mode
  - You can also interact with objects and get their statistics in run mode
- 'right click'
  - choose the previous object to connect to in edit mode
  - You can also interact with objects and get their statistics in run mode

Note: You would right click on an element to set it as the prior element to connect to and any spot you right click where there isn't already a component will create a component such that component is tieing to the one you previously choose by right click. If there is already an element, the simulator will attempt to connect it using the same logic as there isn't a component already there.

Note: There is no undo button in this simulator so you must be careful how you interact with it.

Note: If a connection fails, please do not transition to run mode as it will likely crash but rather please restart the simulation with r and re-input all the components and their relationships with causing the same error to occur again.
