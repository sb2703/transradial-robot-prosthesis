## Files Summary
##### Generic Auxiliary Functions
| **File** | **Description** |
|:--|--|
| `R_x.m` | Function that, given an angle, computes elemental rotation matrix around X axis. |
| `R_y.m` | Function that, given an angle, computes elemental rotation matrix around Y axis. |
| `R_z.m` | Function that, given an angle, computes elemental rotation matrix around Z axis. |

##### Forward Kinematics
| **File** | **Description** |
|:--|--|
| `DH.m` | Function that computes transformation matrix from RF_0 to RF_n using Denavit-Hartenberg (DH) convention for reference frames. |
| `forward_kinematics_hand.m` | Script that computes forward kinematics of the whole hand, i.e. the homogeneous transformation matrices from the forearm to each fingertip. |

##### Plotting of the Hand
| **File** | **Description** |
|:--|--|
| `plot_hand.m` | Function that plots 3D model of the whole hand. |
| `points_to_plot_nt.m` | Function that computes points to plot of (given) non-thumb finger. |
| `points_to_plot_t.m` | Function that computes points to plot of thumb. |

##### Workspaces and Kapandji Score
| **File** | **Description** |
|:--|--|
| `find_contact_point.m` | Function that, given the workspaces of the thumb and a non-thumb finger, finds the best contact point (with reference to thumb fingertip). |
| `kapandji_test.m` | Script that computes and plots all 11 tests proposed by I. A. Kapandji for evaluating thumb opposition. |
| `newton.m` | Function that implements Newton algorithm to solve inverse kinematics problem. |
| `workspace_df.m` | Function that computes workspace of given non-thumb finger, with reference to both the fingertip and the (midpoint of) distal phalanx. |
| `workspace_dip.m` | Function that computes workspace of given non-thumb finger, with reference to both the fingertip and the distal interphalangeal (DIP) joint. |
| `workspace_mf.m` | Function that computes workspace of given non-thumb finger, with reference to both the fingertip and the (midpoint of) middle phalanx. |
| `workspace_nt.m` | Function that computes workspace of given non-thumb finger. |
| `workspace_pf.m` | Function that computes workspace of given non-thumb finger, with reference to both the fingertip and the (midpoint of) proximal phalanx. |
| `workspace_pip.m` | Function that computes workspace of given non-thumb finger, with reference to both the fingertip and the proximal interphalangeal (PIP) joint. |
| `workspace_t.m` | Function that computes workspace of thumb finger. |
| `workspace_w.m` | Function that computes workspace of spherical wrist. |
| `workspaces.m` | Script that plots primary workspace of both fingertips and wrist. |

##### Dynamic Model
| **File** | **Description** |
|:--|--|
| `dyn_hand.m` | Script that derives the dynamic model of the whole hand (through Lagrange formulation). |
| `link_inertia.m` | Function that computes inertia tensor of link in RF_0. |
| `palm_inertia.m` | Function that computes inertia tensor of palm in RF_0. |

WIP
