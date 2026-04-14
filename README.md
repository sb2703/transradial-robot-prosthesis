# Modeling, Control and Simulation of a Transradial Robotic Prosthesis

*By* **Samuele Bani**

This repository contains the code written for my master thesis in Computer Engineering and Robotics, "Modeling, Control and Simulation of a Transradial Robotic Prosthesis", at University of Perugia (Italy).

## Contents
- [Thesis Summary](#1)
- [Files Summary](#2)

## Thesis Summary
The aim of this thesis is to describe the elements underlying the design of a transradial robotic prosthesis: the kinematic model, the dynamic model and the control law. 

 - The *kinematic model* consists of a spherical wrist with 3 DoF, a rigid palm and five fingers with 4 DoF each. The kinematic model is described using the Denavit-Hartenberg convention and is obtained by composing smaller robotic systems.
 - The *dynamic model* is defined starting from the kinematic model and is obtained in closed form by applying the Lagrange method. The dynamic model includes the actuation model based on artificial tendons and torsion springs, as well as the kinematic coupling constraints expressed by the multiplier matrix **G**.
 - The *control law* is based on inverse dynamics control and is designed to comply with the kinematic coupling constraints expressed by the multiplier matrix **G**.

At the moment, the thesis is only available in Italian, but the code in this repository is written and commented so that it can be understood by anyone.

## Files Summary
WIP
