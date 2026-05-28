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
##### Generic Auxiliary Functions
| **File** | **Description** |
|:--|--|
| `R_x.m` | Given an angle, computes elemental rotation matrix around X axis. |
| `R_y.m` | Given an angle, computes elemental rotation matrix around Y axis. |
| `R_z.m` | Given an angle, computes elemental rotation matrix around Z axis. |

##### Forward Kinematics
| **File** | **Description** |
|:--|--|
| `DH.m` | Function that computes transformation matrix from RF_0 to RF_n using Denavit-Hartenberg (DH) convention for reference frames. |
| `forward_kinematics_hand.m` | Script that computes forward kinematics of the whole hand, i.e. the homogeneous transformation matrices from the forearm to each fingertip. |

##### Workspaces and Kapandji score
| **File** | **Description** |
|:--|--|
| `workspace_nt.m` | Function that computes workspace of given non-thumb finger. |
| `workspace_t.m` | Function that computes workspace of thumb finger. |
| `workspaces.m` | Script that plots primary workspace of both fingertips and wrist. |

WIP
