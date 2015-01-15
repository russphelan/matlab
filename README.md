Physics Simulations in MatLab
======

These programs solve a few elementary problems in Physics, and showcase numerical methods for finding their solutions. 

How to Run
======

The folders contain MatLab scripts, .m files. These files can be opened with any command-line, or GUI version of MatLab. Some of the scripts require input from the user; others will run to completion automatically. 

Baseball Simulation
=======
This script simulates the pitching of a baseball in 3D with [drag](http://en.wikipedia.org/wiki/Drag_(physics)), and [Magnus](http://en.wikipedia.org/wiki/Magnus_effect) forces. The user will be prompted for initial velocities in the x, y, and z directions in mph, the [angular velocity](http://en.wikipedia.org/wiki/Angular_velocity) vector as a [unit vector](http://en.wikipedia.org/wiki/Unit_vector), and the magnitude of the angular velocity vector, or rate of spin, in Hz. 

The vector is of the format [x y z], where x, y, and z are the vector's components in 3D space. Direction of spin is determined by the [right-hand rule](http://en.wikipedia.org/wiki/Right-hand_rule), so if a vector points upwards, spin is counter-clockwise. The figure below demonstrates how direction of spin relates to the direction of the angular velocity vector, omega. 

![alt tag](http://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Angular_velocity.svg/352px-Angular_velocity.svg.png)

This trajectory is due to a 40Hz spin on the vector [0 0 1], or straight up. 

![alt tag](pictures/baseball-shot-curved.tiff)

Comet Orbits
=======
This script emulates orbits of bodies around the Sun. The Sun is indicated in plots as a red circle. Positions of orbiting bodies are blue circles. You can specify initial distance from the Sun in AU, as well as initial speed of the orbiting body, in AU/year. Due to these units, you can recover Earth's normal orbit by using 2*pi for initial speed. That way, Earth will complete 1 orbit in 1 Earth year. 

Using different initial speeds, you can produce elliptical orbits. A plot of gravitational potential, kinetic, and total energy is provided for comparison of energy in different orbit types. Notice that total mechanical energy is conserved. This is a close-up of a body with an orbiting speed of pi AU/year. 

![alt tag](pictures/elliptic-orbit.tiff)

Heat Conduction in a Solid Rod
========
This script plots heat conduction through a solid copper rod. Seen in the plot are temperature, distance accross the rod, and time since heat was applied. The constants that determine the rate at which heat conducts through the rod can be changed in the script, for example to make the rod act like aluminum, or like a thicker rod. 

Shown is a copper rod where one end was heated at 1000K, and the other at 0K.

![alt tag](pictures/temp-in-rod.tiff)

Heat Conduction in Solid Sheet
=======
The same model was redesigned to work with a 2D sheet using [relaxation](http://en.wikipedia.org/wiki/Relaxation_(iterative_method)) methods approximate a partial differential equation. The below plot shows a sheet with 3 edges heated to 1000K, and one edge at 0K. 

![alt tag](pictures/temp-in-sheet.tiff)

Simple Pendulum
=====
This script emulates a simple pendulum: a swinging mass under the effects of gravity. Surprisingly, this differential equation has no simple analytic solution. I've compared a formula for the small-angle approximation function with the numerical solution, and it can be seen in the plots how they deviate for angles that are not small. The energy plots show that energy is not perfectly conserved in the small-angle approximation, whereas it is very nearly so in the numerical calculation. 

![alt tag](pictures/pendulum.tiff)

Curve Fitting, Least Squares
======
This script was designed to fit a curve with any number of linear parameters to a set of data using Chi-Square methods. In this example, it was used to fit an oscillating quadratic function to CO2 data from the Mauna Loa observatory in Hawai'i. It solves a matrix of systems to find the best parameters, then checks them by minimizing their Chi-Square value. This is how the best choice of phase angle was discovered for the oscillating fit. This algorithm is generalized to fit any number of parameters, as long as they are linear parameters. They need not necessarily be linear functions, (for example, we used sine), but the parameters must be linear. (i.e. a*sine(theta) where 'a' is parameter). 

![alt tag](pictures/curve-fitting.tiff)

Linear Drag (Linear Differential Equations) 
=====
This script solves a linear ODE to emulate air drag on a falling object. You deduce terminal velocity for this object from the plots it produces. Different time-steps of the Euler method are compared for accuracy in the plots. 

![alt tag](pictures/linear-drag.tiff)

Particle Trajectories
====
This script is an interactive game in which the player tries to shoot a particle through two hoops. The player is prompted for the angle of the shot, and the resulting trajectory is plotted. 6 attempts are given before the game terminates. A message is displayed after each shot telling the player whether or not the shot was a hit. 

![alt tag](pictures/particle-trajectories-game.tiff)
