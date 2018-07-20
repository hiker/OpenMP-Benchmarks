subroutine sub_no_omp(iterations, dummy, N, a, b, c)
   implicit none

   integer i, j, k, iterations
   integer :: N
   real dummy
   real, dimension(N, N) :: a, b, c

   do j=1, n
      do k=1, iterations
         do i=1,n
            a(i,j) = a(i,j) + b(i,j)*c(j,i)+k
         enddo
      enddo
   enddo

   dummy = sum(a)
end subroutine sub_no_omp
