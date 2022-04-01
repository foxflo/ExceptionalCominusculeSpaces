# ExceptionalCominusculeSpaces
Accompanying code for the paper "Mirror Symmetry for the Exceptional Cominuscule Homogeneous Spaces" by Peter Spacek and myself.

This sage code (using Sage version 9.4) performs Lusztig torus expansions of generalized minors (including usual Plucker coordinates) for the exceptional (co)minuscule spaces of types E6 and E7. The small Macaulay2 script uses these results to express generalized minors as polynomials in Plucker coordinates. 

To run the code for E6, run "sage e6.sage" at the command line. This may require editing the last few lines of e6.sage so that the correct output is presented. Similarly, "sage e7.sage" runs the code for E7. However, the full execution requires quite a long time, even on a fast computer, so it may be desirable to edit line 205 to specify which generalized minors to compute. To understand the notation, check Geiss-Leclerc-Schroer "Partial Flag Varieties and Preprojective Algebras." The M2 file is meant to be loaded as a function in M2 and executed manually.

The code should be relatively straightforward to modify such that the entire process can be performed at once as well as to apply to other cominuscule types, though there is some hardcoding of representations required. Unfortunately, it is relatively unpolished.

Please let me know if you have any questions, or find any errors. Feel free to email me at cmwang@math.harvard.edu.
