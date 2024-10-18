# Makefile para conexión SSH

.PHONY: ssh all

all: ssh

ssh:
	@read -p "Introduce el número del nivel (dos dígitos, del 00 al 99): " nivel; \
	if [ $${nivel} -ge 00 -a $${nivel} -le 99 ]; then \
		echo ssh level$${nivel}@192.168.122.1 -p 4242; \
		ssh level$${nivel}@192.168.122.1 -p 4242; \
	else \
		echo "Error: debes introducir dos dígitos (00-99)"; \
	fi

copy:
	@read -p "Introduce el número del nivel (dos dígitos, del 00 al 99): " nivel; \
	read -p "Introduce el nombre del archivo a copiar: " archivo; \
	if [ $${nivel} -ge 00 -a $${nivel} -le 99 ]; then \
		echo scp -P 4242 level$${nivel}/Ressources/$${archivo} level$${nivel}@192.168.122.1:/tmp/$${archivo}; \
		scp -P 4242 level$${nivel}/Ressources/$${archivo} level$${nivel}@192.168.122.1:/tmp/$${archivo}; \
	fi