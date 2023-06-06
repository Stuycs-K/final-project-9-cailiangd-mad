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

Continued work on new algorithm and data stucture.

### 5/29/2023

Worked on mouseClicked(); and the underlieing connection methods which needs debugging.

### 5/30/2023

Continued to work on the error; figured out what it is but no progress.
Update: Removed both errors from program, first error caused by variables being placed in the wrong location, second error caused by missing code protecting against null cases and a missing '!'

### 6/1/2023
Fixed the new junction issue partially, the junctions now work for where there are only a single layer of junctions and no interconnection between junction sets. I am not able to redesign the entire algorithm to fix this in 12 hours.

### 6/4/2023
Worked on undo button. Got undo button working but the UI is terrible. Didn't have time to start working on asymmetric loops yet.

### 6/5/2023
Started working on the RREF algorithm and the more advanced UI. Mainly working on logistics so far.
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
