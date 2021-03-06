# variable

CC = gcc

EXEC = rsa.exe
ARCHIVE = groupe
TAR = tar.gz

SRCDIR = src
OBJDIR = obj
BINDIR = bin

DEPS = $(wildcard $(SRCDIR)/*.h) $(wildcard $(SRCDIR)/*/*.h)
SRC = $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/*/*.c)
OBJ = $(SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

FLAG = -Wall -g3

GMP = -lgmp

MATH = -lm

GUI = `pkg-config --libs --cflags gtk+-3.0`
GUIDEBUG = `pkg-config --libs gtk+-3.0`
GUILIB = -L. lib.a

# make

all: config compil

compil: $(OBJ)
	@ $(CC) -o $(BINDIR)/$(EXEC) $(OBJ) $(GMP) $(MATH) $(GUI) $(GUIDEBUG)
	@ echo "Linking complete!"

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	@ $(CC) -c -o $@ $< $(GMP) $(MATH) $(FLAG) $(GUI) $(GUIDEBUG)
	@ echo "Compiled "$@" successfully!"

run:
	@ ./$(BINDIR)/$(EXEC)
	
clean:
	@ if [ $(ARCHIVE).$(TAR) ]; then rm -f $(ARCHIVE).$(TAR); echo "Archive removed!"; fi
	@ rm -rf $(OBJDIR)
	@ echo "Object files removed!"
	@ rm -rf $(BINDIR)
	@ echo "Executable removed!"
	
package: clean
	@ tar -czvf $(ARCHIVE).$(TAR) *
	@ echo "Archive created!"

config:
	@ $(shell ./.script.sh) 
