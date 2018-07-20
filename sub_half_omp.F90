subroutine sub_half_omp(iterations, dummy, N, a, b, c)

   use omp_lib, only : omp_get_max_threads
   implicit none

   integer i, j, k, iterations, o, nhalf
   integer :: n
   real dummy
   real, dimension(n,n) :: a, b, c

   nhalf = omp_get_max_threads() / 2

!$omp parallel do private(o,k,i,j)
   do o=1, nhalf
      do j=o, n, nhalf
         do k=1, iterations
            do i=1, n
               a(i,j) = a(i,j) + b(i,j)*c(i,j)+k
            enddo
         enddo
      enddo
   enddo

   dummy = sum(a)
end subroutine sub_half_omp

