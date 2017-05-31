X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

INCS = -I. -I/usr/include -I${X11INC} \
       `pkg-config --cflags fontconfig` \
       `pkg-config --cflags freetype2`
LIBS = -L/usr/lib -lc -L${X11LIB} -lm -lrt -lX11 -lutil -lXext -lXft -lXrender\
       `pkg-config --libs fontconfig`  \
       `pkg-config --libs freetype2`

CPPFLAGS += -DVERSION=\"${VERSION}\" -D_XOPEN_SOURCE=600
CFLAGS += -g -std=c99 -pedantic -Wall -Wvariadic-macros -Os ${INCS} ${CPPFLAGS}
LDFLAGS += -g ${LIBS}

SRC = st.c
OBJ = ${SRC:.c=.o}

all: st

st: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
	cp -f st $(DESTDIR)$(PREFIX)/bin/

clean:
	rm -f st st.o

