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
| `workspace_nt.m` | Function that computes workspace of given non-thumb finger. |
| `workspace_t.m` | Function that computes workspace of thumb finger. |
| `workspaces.m` | Script that plots primary workspace of both fingertips and wrist. |

WIP
