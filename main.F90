program main

  implicit none

#ifdef USE_MPI
  include "mpif.h"
#endif

  character (100) :: name

  real :: dummy, result
  
  integer :: i, my_rank

#ifdef USE_MPI
  integer :: ierr  
  call MPI_Init(ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierr)
#else
  my_rank = 0
#endif

  ! Go from [0:n-1] to [1:n] for multiplication below:
  my_rank = my_rank + 1
  result = 0

  do i=1, 4
      print *,"rank", my_rank," i", i
     call sub_no_omp(8*my_rank, dummy)
     result = result + dummy

     call sub_full_omp(16*my_rank, dummy)
     result = result + dummy

     call sub_half_omp(8*my_rank, dummy)
     result = result + dummy

     call sub_imbalance(8*my_rank, dummy)
     result = result + dummy

     call sub_partial_omp(8*my_rank, dummy)
     result = result + dummy
  enddo

  !Can be used to check IO measurements.
  write(name, '(I)' ) my_rank
  open(unit=2, file="dummy"//name//".out")
  write(2,*) "This is a test"
  write(2,*) "A long one"
  write(2,*) "Result is", result
  close(2)

#ifdef USE_MPI
  call MPI_Finalize(ierr)
#endif

end program
 
