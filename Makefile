all: priv/exml_event.so priv/exml_escape.so \
	ebin/exml.beam ebin/exml_event.beam ebin/exml_query.beam \
	ebin/exml_stream.beam

CWD := $(shell pwd)

ebin/%.beam: src/%.erl
	erlc -I$(CWD)/src -I$(CWD)/include -pa $(CWD)/ebin -o ebin src/$*.erl

priv/exml_event.so: c_src/exml_event.o
	cc c_src/exml_event.o -fPIC -lexpat -shared \
		-L/home/erszcz/apps/erlang/17.0/lib/erl_interface-3.7.16/lib \
		-lerl_interface -lei -o priv/exml_event.so

c_src/exml_event.o: c_src/exml_event.c
	cc -c -g -Wall -g -Wall -fPIC \
		-I/home/erszcz/apps/erlang/17.0/lib/erl_interface-3.7.16/include \
		-I/home/erszcz/apps/erlang/17.0/erts-6.0/include \
	  	c_src/exml_event.c -o c_src/exml_event.o

priv/exml_escape.so: c_src/exml_escape.o
	cc c_src/exml_escape.o -fPIC -shared \
		-L/home/erszcz/apps/erlang/17.0/lib/erl_interface-3.7.16/lib \
		-lerl_interface -lei -o priv/exml_escape.so

c_src/exml_escape.o: c_src/exml_escape.c
	cc -c -g -Wall -g -Wall -fPIC \
	   	-I/home/erszcz/apps/erlang/17.0/lib/erl_interface-3.7.16/include \
		-I/home/erszcz/apps/erlang/17.0/erts-6.0/include \
	  	c_src/exml_escape.c -o c_src/exml_escape.o

clean:
	-rm ebin/*.beam
	-rm priv/*
	-rm c_src/*.o
