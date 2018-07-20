subroutine sub_imbalance(iterations, dummy, n, a, b, c)
  use omp_lib, only : omp_get_max_threads, omp_get_thread_num
  implicit none

    integer i, j, k, iterations, o, start, last
    integer amount, id
    integer :: n
    real dummy
    real, dimension(n,n) :: a, b, c
    
    amount = N / (omp_get_max_threads() * (omp_get_max_threads()+1)/2)
    
!$omp parallel private(o, k, i, j, start, last) shared(amount, a, b, c)
    id    = omp_get_thread_num()
    start = ( id*(id+1)/2 )  * amount + 1
    if(id == omp_get_max_threads()-1) then
       last   = N
    else
       last   = start + (id+1) * amount - 1
    endif
    do j=start, last
       do k=1, iterations
          do i=1, n
             a(i,j) = a(i,j) + b(i,j)*c(j, i)+k
          enddo
       enddo
    enddo
!$omp end parallel

    dummy = sum(a)
end subroutine sub_imbalance

