all: bin/exe

bin/exe:
	mkdir -p bin
	ghc src/main.hs -o bin/exe 

clean:
	rm -f src/*.o src/*.hi bin/exe
	rmdir bin
	