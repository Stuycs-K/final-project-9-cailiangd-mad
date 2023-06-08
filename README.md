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
  - Allows you to adjust the total amount of voltage through the circuit, pull right to increase voltage
  - Goes from 0 volts to 28.5 volts.
Bottom Slider
  - Only appears when you have selected a resistor by right clicking it.
  - This allows you adjust the resistance of a resistor.
  - Goes from 0 ohms to 28.5 ohms.

5 Hotkeys
- 'd'
  - opens up debug mode
- 'e'
  - does same thing as 4 part circle
- 'c'
  - allows you to switch the objects you place down from resistor to start junction to end junction and back
- 'r'
  - allows you to restart the simulation
  - will automatically return you to edit mode.
- ' '
  - will remove the last component that was placed down.
  - will automatically return your cursor

2 Mouse Inputs
- 'left click'
  - Edit mode
    - You can place down components.
    - Will sometimes fail when you do not follow the rules provided above about resistors, startJunctions, and endJunctions in the buttons documentation.
    - If attempt to place down components fails, your selection circle will go to center and no new component will be made.
    - If you want to return selection circle to the center for any reason, you can double left click on any component.
  - Run mode
    - Click on component to see its statistics.
    - Click on a component that is already selected as in the selection circle to see the statistics for the whole circuit.
- 'right click' or 'TAB' + 'left click'
  - Edit mode
    - chooses the component for the next component you place down connect to
    - chooses the component for a previously placed component to connect to
    - The selected component will the component from which charge flows in these connections.
 - Run mode
  - Click on component to see its statistics.
  - Click on a component that is already selected as in the selection circle to see the statistics for the whole circuit.

Note: You would right click on an element to set it as the prior element to connect to and any spot you left click where there isn't already a component will create a component such that component is tied to the one you previously right clicked. If there is already an element, the simulator will attempt to connect it using the same logic as when there isn't a component already there.

Note: There is a undo button in this simulator as mentioned above but it is highly unreliable.

Note: If a connection fails, there is a non-insignificant chance that when you transition to run mode it will fail.

Note: If the program crashes, please restart the simulation with r, if possible, and re-input all the components and their relationships while avoiding the same error.
