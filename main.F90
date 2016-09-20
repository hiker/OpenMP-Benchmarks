program main
  implicit none
  integer :: ierr, rank
  character (100) :: name

  real :: dummy


  call sub_no_omp(8, dummy)
  
  call sub_full_omp(16, dummy)

  call sub_half_omp(8, dummy)

  call sub_imbalance(8, dummy)

  call sub_partial_omp(8, dummy)

  !Can be used to check IO measurements.
  !write(name, '(I)' ) rank
  !open(unit=2, file="dummy"//name//".out")
  !write(2,*) "This is a test"
  !write(2,*) "A long one"
  !close(2)

end program
 
