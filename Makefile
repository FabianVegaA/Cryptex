all: exe

exe: src/main.hs
	ghc -o bin/exe src/main.hs