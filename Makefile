all:
	nim c -d:release \
	--cpu:arm --os:linux \
	--arm.linux.gcc.exe:/opt/arm-unknown-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc \
	--arm.linux.gcc.linkerexe:/opt/arm-unknown-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc \
	-o:bin/main_raspi_zero \
	src/ndeneme.nim
