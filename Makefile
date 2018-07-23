F90=ftn

TAU=no
MPI=no
SCOREP=yes

NAME_PREFIX=
ifeq ($(TAU), yes)
    F90=tau_f90.sh -optKeepFiles
    NAME_PREFIX=.tau
endif
ifeq ($(SCOREP), yes)
    F90=scorep ftn
    NAME_PREFIX=.scorep
endif

FFLAGS=-O3 -qopenmp
#FFLAGS=-O3 -homp
#FFLAGS=-O2 -qopenmp -g

PAR_NAME=
ifeq ($(MPI), yes)
    FFLAGS+=-DUSE_MPI
    PAR_NAME=.MPI
endif

EXEC_NAME=omp-test$(PAR_NAME)$(NAME_PREFIX)

OBJ=sub_half_omp.o sub_partial.o sub_imbalance.o sub_full_omp.o  \
    sub_no_omp.o main.o

default:	$(EXEC_NAME)

$(EXEC_NAME):	$(OBJ)
	$(F90) $(FFLAGS) $^ -o $(EXEC_NAME)

test1:	test1.o
	$(F90) $(FFLAGS) $^ -o test1

clean:
	rm -f $(OBJ) test1.o test1 test$(EXEC_NAME)

%.o:	%.F90
	$(F90) $(FFLAGS) -c $<
