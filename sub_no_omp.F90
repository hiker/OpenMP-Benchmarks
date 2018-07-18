
! A wrapper for 'thinkhard' - if we make n a parameter inside
! of think hard, the compiler optimised everything away.


subroutine sub_no_omp(sec, dummy)
  implicit none

    integer i, j, k, sec
    integer, parameter :: n=1000
    real dummy
    real, dimension(n,n) :: a, b, c
    a=0
    b=1
    c=1
    do k=1, 11303*sec
       do i=1, n
          do j=1,n
            a(i,j) = a(i,j) + b(i,j)*c(j,i)+k
          enddo
       enddo
    enddo

    dummy = sum(a)
end subroutine sub_no_omp

