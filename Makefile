# signatures
MD5 = $(shell cat *cpp *hpp | md5sum | cut -d' ' -f1)

TARGET = png
########################################################################
TAG = $(shell whoami)

# Lua version
LUA_V ?= 5.3

# Base install directory
PREFIX ?= /usr/local

# Directory where to install Lua modules
L_DIR = $(PREFIX)/share/lua/$(LUA_V)
# Directory where to install Lua C modules
C_DIR = $(PREFIX)/lib/lua/$(LUA_V)
# Directory where to install C headers
H_DIR = $(PREFIX)/include

ifeq ($(D),1)
DEBUG=1
endif

# LUA + GSL source
INCDIR = -I/usr/include -I/usr/include/lua$(LUA_V)
LIBDIR = -L/usr/lib
LIBS = -lpng

########################################################################
default: build

.SUFFIXES: .o .cpp

%.o: %.c %.h
	$(CXX) $(CFLAGS) $(DEBUG) -c $<

%.o: %.cpp %.hpp
	$(CXX) $(CXXFLAGS) $(DEBUG) -c $<

# all: $(TARGET)
#    $(LINK) -o $(TARGET) $(OBJS) $(LDSTATIC)

# $(TARGET): $(OBJS)

where:
	@echo "OS = "$(OS)
	@echo "CC = "$(CC)
	@echo "CXX = "$(CXX)
	@echo "PREFIX = "$(PREFIX)
	@echo "LUA_V = "$(LUA_V)
	@echo $(L_DIR)
	@echo $(C_DIR)
	@echo $(H_DIR)
	@echo "SRCS = "$(SRCS)
	@echo "OBJS = "$(OBJS)

########################################################################
LINK = $(CXX)

SRCS ?= $(wildcard *.c)
OBJS ?= $(SRCS:.c=.o)

CPPSRCS ?= $(wildcard *.cpp)
CPPOBJS ?= $(CPPSRCS:.cpp=.o)

AOJ = $(OBJS) $(CPPOBJS)

# C/C++ common options
OPT += -O2
OPT += -Wall -Wextra
OPT += -DLUA_V=$(LUA_V)
# OPT += -DUSE_GL=1 -DUSE_IMAGES=1

OPT += -DLINUX
OPT += -fpic

ifdef DEBUG
OPT += -DDEBUG
OPT += -Wfatal-errors -Wpedantic
OPT += -Wshadow -Wsign-compare -Wundef -Wwrite-strings
OPT += -Wdisabled-optimization
endif
OPT +=  $(INCDIR)

# C only options
COPT = $(OPT)
COPT += -std=gnu99
ifdef DEBUG
COPT += -Wdeclaration-after-statement
COPT += -Wmissing-prototypes -Wstrict-prototypes -Wnested-externs
COPT += -Wc++-compat -Wold-style-definition
endif
DOPT += -DMD5='"$(MD5)"' -DOPT='"$(OPT)"'

override CFLAGS = $(COPT) $(DOPT)

# C++ only options
CXXOPT = $(OPT)
override CXXFLAGS = $(CXXOPT) $(DOPT)
override LDFLAGS =

########################################################################
build: $(OBJS) $(CPPOBJS)
	$(CXX) -shared -o $(TARGET).so $(AOJ) $(LIBDIR) $(LDFLAGS) $(LIBS)

install uninstall:

clean:
	rm -f $(TARGET).symbols $(TARGET).o $(TARGET).so 2> /dev/null

symbols: build
	@objdump -T $(TARGET).so > $(TARGET).symbols

# docs:
#     @cd ../doc;  $(MAKE)

cleanall: clean

backup: clean
