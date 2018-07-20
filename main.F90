program main

  implicit none

#ifdef USE_MPI
  include "mpif.h"
#endif

  integer, parameter :: N = 1000
  integer, parameter :: sec = 8      ! Roughly 8 seconds per subroutine

  real, dimension(N, N) :: a, b, c

  character (100) :: name

  real :: dummy, correct_result, result
  
  integer :: i, my_rank, iterations



#ifdef USE_MPI
  integer :: ierr  
  call MPI_Init(ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierr)
#else
  my_rank = 0
#endif

  ! Go from [0:n-1] to [1:n] for multiplication below:
  my_rank = my_rank + 1

  iterations = 11303*sec*my_rank     ! VERY rough estimation for runtime
  iterations = 1130*sec*my_rank     ! VERY rough estimation for runtime

  ! That's the correct result, except floating point errors will cause
  ! some result differences
  correct_result = real(N*N)*(iterations+iterations*(iterations+1.0)/2.0)

  do i=1, 4
     print *,"rank", my_rank," i", i, iterations
     a=0
     b=1
     c=1
     call sub_no_omp(iterations, dummy, N, a, b, c)
     result = result + dummy

     a=0
     b=1
     c=1
     call sub_full_omp(iterations, dummy, N, a, b, c)
     result = result + dummy

     a=0
     b=1
     c=1
     call sub_half_omp(iterations, dummy, N, a, b, c)
     result = result + dummy

     a=0
     b=1
     c=1
     call sub_imbalance(iterations, dummy, N, a, b, c)
     result = result + dummy

     a=0
     b=1
     c=1
     call sub_partial_omp(iterations, dummy, N, a, b, c)
     result = result + dummy
  enddo

  !Can be used to check IO measurements.
  write(name, '(I)' ) my_rank
  !name = trim(name)
  name=adjustl(name)
  open(unit=2, file="dummy"//trim(name)//".out")
  write(2,*) "This is a test"
  write(2,*) "A long one"
  write(2,*) "Result is", result
  close(2)

#ifdef USE_MPI
  call MPI_Finalize(ierr)
#endif

end program
 
