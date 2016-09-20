subroutine sub_imbalance(sec, dummy)
  implicit none

    integer i, j, k, sec, o, start, end
    integer amount
    integer, parameter :: n=1000
    real dummy
    real, dimension(n,n) :: a, b, c
    integer omp_get_max_threads, omp_get_thread_num
    external omp_get_max_threads, omp_get_thread_num

    b=1
    c=1
    amount = sec*11303/10
!$omp parallel private(o, k, i, j, start, end) shared(amount, a, b, c)
    start = ( (omp_get_thread_num()+1)*(omp_get_thread_num()  )/2 ) &
            * amount + 1
    end   = start + (omp_get_thread_num()+1)*amount - 1
    do k=start, end
       do i=1, n
          do j=1,n
             a(i,j) = a(i,j) + b(i,j)*c(i,j)
          enddo
       enddo
    enddo
!$omp end parallel

    dummy = a(2,2)
end subroutine sub_imbalance

