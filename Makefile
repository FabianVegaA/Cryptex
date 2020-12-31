all: exe

exe: src/main.hs
	mkdir bin
	ghc -o bin/exe src/main.hs