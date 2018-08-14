A simple test program for performance measurement tools.

It contains a set of subroutines with various OMP behaviour:
- sub_full_omp.F90: A fully parallelised subroutine.
- sub_no_omp.F90: A subroutine that is not parallelised at all.
- sub_imbalance.F90: A subroutine which is fully parallelised, but has a load imbalance.
- sub_half_omp.F90: A subroutine which is fully parallelised, but only uses half of the available threads
- sub_partial.F90: A subroutine in which only half of the work is parallelised.
A performance measurement tool can be evaluated against those set of subroutine to check
if the various problems can be detected in the output (and how they can be detected.
For example load imbalance might show of as different waiting time, or compute time, or both).

The application can be compiled with or without MPI: if MPI is used, rank X will have (X-1)
times the amount of work of rank 0. So you see a load imbalance across MPI ranks.

To build the application:
modify the makefile as appropriate to specify compiler and compiler flags (atm the
Makefile contains settings for the Intel compiler in the Cray environment using ftn).
The following variables can be specified:
make USE_MPI=yes TAU=yes SCOREP=yes
USE_MPI enables MPI in the tests. TAU and SCOREP (which are exclusive) trigger the
use of the tau or scorep compiler wrapper instead of the configured compiler.

