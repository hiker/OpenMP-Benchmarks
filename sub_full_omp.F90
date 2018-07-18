subroutine sub_full_omp(sec, dummy)
  implicit none

    integer i, j, k, sec, o
    integer, parameter :: n=1000
    real dummy

    real, dimension(n,n) :: a, b, c
    a=0
    b=1
    c=1
!$omp parallel do private(o,k,i,j)
       do k=1, sec*11303
          do i=1, n
             do j=1,n
                a(i,j) = a(i,j) + b(i,j)*c(i,j)+k
             enddo
          enddo
       enddo
       	
    dummy = sum(a)
end subroutine sub_full_omp

