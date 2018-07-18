subroutine sub_half_omp(sec, dummy)
  implicit none

    integer i, j, k, sec, o, nhalf
    integer, parameter :: n=1000
    real dummy
    real, dimension(n,n) :: a, b, c
    integer omp_get_max_threads, omp_get_thread_num
    external omp_get_max_threads, omp_get_thread_num

    nhalf = omp_get_max_threads() / 2
    a=0
    b=1
    c=1
!$omp parallel do private(o,k,i,j)
    do o=1, nhalf
       do k=o, sec*11303, nhalf
          do i=1, n
             do j=1,n
                a(i,j) = a(i,j) + b(i,j)*c(i,j)+k
             enddo
          enddo
       enddo
    enddo

    dummy = sum(a)
end subroutine sub_half_omp

