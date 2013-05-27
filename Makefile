all: loki_patch loki_flash

clean:
	rm -fr *.o loki_flash loki_patch out *~

loki_patch: loki_patch.o
	$(CC) -O0 -Wall -o $@ $^


loki_flash: loki_flash.o
	$(CC) -O0 -Wall -marm -o $@ $^

loki_patch.o: loki_patch.c
loki_flash.o: loki_flash.c
