# Work Log

## David Cai Liang

### 5/22/2023

I created the two classes. I added all the initial variables and constructors that we need for the classes, initially. I added all the get methods needed for both classes. I added the addPrevious and allFollowing methods to the Component class and the add method to the Circuit class. I started to test all of these methods. I also created the Processing window we will use for our final demo.

### 5/23/2023

Start working on implementing the interface we wanted to have in processing in processing. I also started thinking more about the user interface and how the user will interact with our program as well as writing a few additional methods to assist in the display and UI of our program.

### 5/24/2023

Finally figuring out what type of UI we want for the feature of connecting components together and implementing the visual part of these connections and preparing to start working on the technical side of these connections to make them actually work.

### 5/25/2023

Wrote the visual connection algorithm. Discovered multiple flaws in our code related to not knowing where loops ended and started exactly. I also did some testing leading to the discovery of these flaws.

### 5/26/2023

I worked on dealing with the flaw discovered yesterday and work on streamlining the code. This process involved replacing a lot of what we have already written to deal with this issue. This issue will likely mean it will take until at least Tuesday if not Wednesday for us to have enough functioning code to do a complete test. I also started working on the new generate connections method.

### 5/27/2023

Worked on new algorithm and redesigned the data structure.

### 5/28/2023

Continued work on new algorithm and data structure.

### 5/29/2023

Worked on mouseClicked(); and the underlying connection methods which needs debugging.

### 5/30/2023

Continued to work on the error; figured out what it is but no progress.
Update: Removed both errors from program, first error caused by variables being placed in the wrong location, second error caused by missing code protecting against null cases and a missing '!'

### 6/1/2023
Fixed the new junction issue partially, the junctions now work for where there are only a single layer of junctions and no interconnection between junction sets. I am not able to redesign the entire algorithm to fix this in 12 hours.

### 6/4/2023
Worked on undo button. Got undo button working but the UI is terrible. Didn't have time to start working on asymmetric loops yet.

### 6/5/2023
Started working on the RREF algorithm and the more advanced UI. Mainly working on logistics so far.

### 6/6/2023
Went back to original algorithm and started working on how the start junction, end junction, and resistors set interact to set their currents.

### 6/7/2023
Made additional UI improvements and asked the CS dojo for recommendations and help. Made the simulation show resistances for resistor in a clearer way.

### 6/9/2023
Worked on UI, made tweaks to make it better. Started working on two new features allowing the user to save a txt file representing the current simulation position and then pull up a new file. Also started exploring options involving audio.

### 6/10/2023 & 6/11/2023

Worked on adding fonts and sound to the UI; wrote documentation for our project

## Dylan Ma

### 5/23/2023

I completed the calculate methods which are used to provide critical information about the individual components as well as the overall stats for the circuit, such as the total current (IEQ), the total resistance (REQ) and the total voltage (VEQ). I also added the resetSolved() method, which resets the solved status of all components, as well as the calculateStat method, which calculates the statistics for individual resistors (components).

### 5/24/2023
Continued to work on a bug in the Processing window, which may have led to infinite recursion initially.

### 5/25/2023

We continued to work on our reqSub() method - made headway on the make connections method.

### 5/26/2023

We deal with the error related to not knowing where loops start and end. I work on the mousePressed method as well as the buttons for the junctions and resistor.

### 5/27/2023

Figured out a new algorithm, as our old algorithm didn't work for parallel or series circuits, so we began implementing a new algorithm using the junctions as nodes.

### 5/28/2023

Continued to work on the new algorithm, as we had to change up our components to have subclasses.

### 5/29/2023

We continued to work on the button to add a junction, but we haven't quite figured out our algorithm to generate connections yet, or our mouseClicked() function entirely.

### 5/30/2023

Continued to work on the bug; determined that the issue might be that the last components connects to itself, rather than to another component, which causes a infinite loop because there's no end point.

### 6/4/2023

Worked on an undo button so that we don't have to restart the simulation when we make a mistake. Still a few bugs

### 6/6/2023

Worked on algebraic method to manipulate the matrix which would make the RREF algorithm possible - also went to the CS Dojo

### 6/7/2023

Went to the CS Dojo for help - worked on a error we were facing.

### 6/8/2023

Worked on the UI to improve the appearance - we're still trying to improve our algorithm so it can be more efficient at calculating stats for circuits with many loops and intersections.

### 6/10/2023

Worked on adding fonts and sound to our project

### 6/11/2023

Tweaked some sound effects to make it slightly better; also added to the documentation

##Working Features
1. Ability to calculate the current, resistance, voltage, and power values for in series resistors.
2. Ability to calculate the current, resistance, voltage, and power values for in parallel resistors.
3. Ability to have 1 and 2 working at the same time such that we have in series sections inside parallel sections which are inside series sections and so.
4. Ability for a battery to have more than two paths directly connected to it.
5. Ability to place resistors, startJunctions, and endJunctions.
6. Ability to get the statistics of the resistors such as resistance, current, voltage, and power;
7. Ability to get the statistics of the resistors such as REQ, IEQ, VEQ, and PEQ which stand for current equivalence, resistance equivalence, voltage equivalence, and power equivalence.
8. Ability to save the current circuit on the screen into a text file. Data saved into the x,y position of all components, as well as their resistance, current, voltage, and power.
9. Ability to read text files to extract the data mentioned in item 8 and display the data.
10. Ability to remove the last added component and add further components.
11. Ability to access debugging information for the selected component if it is a resistor. 12. Debug information includes the resistance, current, voltage, power, x-position, y-position for the selected resistor, the component before it, and after it, in that order.
13. Ability to clear the board by pressing a key.
14. Ability to change the resistance of resistors in two different ways: typing the value / sliding the slider.
15. Ability to change the voltage of the entire curcuit in two different ways: typing the value / sliding the slider.
16. Putting 0 for voltage for the entire circuit and/or for individual resistors doesn't break anything.
17. Ability to have audio effects.

##Broken Features
1. Voltage / Current for startJunctions and endJunctions tend to be inaccuruate.
2. The debugging mode with junctions and battery will print out arrays that cover the screen, making them pretty much useless.
3. Spam clicking with the left or right mouse tends to cause freezing or crashing.
4. Very large numbers being directly inputted into the circuit voltage and individual resistor resistance tend to malfunction with the numbers not being registered accurately.
5. The system that prevents you from making bad connections such as connecting two components to a resistor sometimes fails and when you put the program in run mode, an error might occur. This system also might crash the program once in a while. ##Content Resources
https://www.falstad.com/circuit/
https://phet.colorado.edu/en/simulations/circuit-construction-kit-dc
The bottom two are just inspiration more than anything.
https://www.youtube.com/watch?v=yvlFrzIsrhY
https://electronics.stackexchange.com/questions/182022/is-sound-produced-by-varying-current-or-voltage
