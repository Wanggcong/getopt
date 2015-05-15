#!/usr/bin/env make

NAME    ?= $(shell basename $(shell pwd))
TARGET  ?= $(NAME)
C_SRC   ?= $(wildcard *.c)
CXX_SRC ?= $(wildcard *.cpp)
OBJ     ?= $(C_SRC:.c=.o) $(CXX_SRC:.cpp=.o)


ARCH := $(shell arch)

#
# Commands
#
AR       := ar -cq
CC       := gcc
CP       := cp -f
CXX      := g++
DOXYGEN  := doxygen
MAKE     := make
MKDIR    := mkdir -p
MV       := mv -f
PYCLEAN  := pyclean
PYTHON   := python
RM       := rm -rf

#
# General compiler/linker flags.
#
CXXFLAGS += -g -pedantic -Wall -Werror -Winline -Woverloaded-virtual -Wnon-virtual-dtor -O3 -std=c++14 -MMD -fPIC -flto -fdiagnostics-color=auto
CFLAGS   += -g -pedantic -Wall -Werror -Winline -O3 -MMD -fPIC -flto -fdiagnostics-color=auto
LDFLAGS  += -rdynamic -fPIC -flto


#
# Targets
#

all:: $(TARGET)

clean::
	$(RM) $(OBJ) $(TARGET) *.d

doc::
	$(DOXYGEN) $(DOXYFILE)

$(TARGET):: $(OBJ)
	$(CXX) $(OBJ) $(LDFLAGS) -o $(TARGET)

-include *.d


#
# Suffix rules
#

.SUFFIXES:
.SUFFIXES: .cpp .c .o

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $< -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@


.PHONY: all clean doc test
