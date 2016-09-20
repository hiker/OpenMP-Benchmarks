program main
  use MPI

  implicit none
  !include 'mpif.h'
  integer :: ierr, rank
  character (100) :: name

  real :: dummy

print *,"Before MPI_Init"
  call MPI_Init(ierr)
print *,"After MPI_Init"

  call sub_no_omp(8, dummy)
print *,"After no_omp"
  call MPI_Barrier(MPI_COMM_WORLD, ierr)
  
  call sub_full_omp(16, dummy)
  call MPI_Barrier(MPI_COMM_WORLD, ierr)

  call sub_half_omp(8, dummy)
  call MPI_Barrier(MPI_COMM_WORLD, ierr)

  call sub_imbalance(8, dummy)
  call MPI_Barrier(MPI_COMM_WORLD, ierr)

  call sub_partial_omp(8, dummy)

  call collapse1(8, dummy)
  call collapse2(8, dummy)

  call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

  !write(name, '(I)' ) rank
  !open(unit=2, file="dummy"//name//".out")
  !write(2,*) "This is a test"
  !write(2,*) "A long one"
  !close(2)

  call MPI_Finalize(ierr)

end program
 
