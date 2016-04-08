#
# Platform Independent
# Bitmap Image Reader Writer Library
# By Arash Partow - 2002
#
# URL: http://partow.net/programming/bitmap/index.html
#
# Copyright Notice:
# Free use of this library is permitted under the
# guidelines and in accordance with the most
# current version of the Common Public License.
# http://www.opensource.org/licenses/cpl1.0.php
#

COMPILER      = g++
OPTIONS       = -ansi -pedantic-errors  -c -o
LINKER_OPT    = -L/usr/lib -lstdc++

all: bitmap_lib

bitmap_lib: bmplib.cpp bitmap_image.hpp
	$(COMPILER) $(OPTIONS) bmplib.o bmplib.cpp 

valgrind_check:
	valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./bitmap_test

clean:
	rm -f core *.o *.bak *stackdump *~

#
# The End !
#
