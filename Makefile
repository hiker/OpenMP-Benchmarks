F90=ftn

TAU=yes
ifeq ($(TAU), yes)
    F90=tau_f90.sh -optKeepFiles
    EXEC_NAME=test1m.tau
else
    F90=ftn
    EXEC_NAME=test1m
endif

FFLAGS=-O3 -openmp -g
FFLAGS=-O3 -fopenmp -g

OBJ=sub_half_omp.o sub_partial.o sub_imbalance.o sub_full_omp.o  \
    sub_no_omp.o collapse.o main.o

default:	$(EXEC_NAME)

$(EXEC_NAME):	$(OBJ)
	$(F90) $(FFLAGS) $^ -o $(EXEC_NAME)
	#$(F90) $(FFLAGS) $^ -o $(EXEC_NAME) -L/apps/openmpi/1.6.5/lib -lmpi_f90 -lmpi_f77 -lmpi -ldl -lm -Wl,--export-dynamic -lrt -lnsl -lutil

test1:	test1.o
	$(F90) $(FFLAGS) $^ -o test1

clean:
	rm -f $(OBJ) test1.o test1 test1m.o $(EXEC_NAME)

%.o:	%.F90
	$(F90) $(FFLAGS) -c $<
