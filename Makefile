all: exe

exe: src/main.hs
	mkdir bin
	ghc src/main.hs --make -o bin/exe 

clean:
	rm -f src/*.o src/*.hi bin/exe
	rmdir bin
	