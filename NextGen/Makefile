all:
	@echo "gem5:     Clone gem5"
	@echo "gem5-X:   Clone gem5-X"
	@echo "gem5_GUI: Clone gem5_GUI"
	@echo "splash2i: Clone splash2 and patch"
	@echo "Build gem5: X86 ARM MIPS POWER"
	@echo "imn2:     Clone Darknet for Mobilenet v2"
	@echo "Docker Environments"
	@echo "	dbu??: 16|18|20 Docker Build for Ubuntu 16.04|18.04|20.04"
	@echo "	dru??: 16|18|20 Docker Run for Ubuntu 16.04|18.04|20.04"
	@echo "term	Connect dummy terminal to Full System"

M5_PATH=/Data/Gem5/aarch-system-20170616

req:
	sudo apt install python3-pydot	# To generate config.dot.svg|pdf

# Docker Build for Ubuntu 16.04 or 18.04
dbu16:
	docker build -t gem5-ubuntu16.04 -f Dockerfile.ubuntu16.04 .

dbu18:
	docker build -t gem5-ubuntu18.04 -f Dockerfile.ubuntu18.04 .

dbu20:
	docker build -t gem5-ubuntu20.04 -f Dockerfile.ubuntu20.04 .

# Docker Run for Ubuntu 16.04 or 18.04
dru16:
	docker run -ti -v `pwd`:/root/Proj \
		-v /Data:/Data \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-p 5000:5000 \
		-p 3456:3456 \
		-e DISPLAY=$(DISPLAY) \
		gem5-ubuntu16.04

dru18:
	docker run -ti -v `pwd`:/root/Proj \
		-v /Data:/Data \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-p 5000:5000 \
		-p 3456:3456 \
		-e DISPLAY=$(DISPLAY) \
		gem5-ubuntu18.04

dru20:
	docker run -ti -v `pwd`:/root/Proj \
		-v /Data:/Data \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-p 5000:5000 \
		-p 3456:3456 \
		-e DISPLAY=$(DISPLAY) \
		gem5-ubuntu20.04

# Clone Sources
gem5:
	git clone https://github.com/gem5/gem5.git
	# git clone https://gem5.googlesource.com/public/gem5
	# git clone https://github.com/powerjg/gem5.git
	cd gem5; ln -s ../Makefile.gem5 Makefile; ln -s ../Makefile.nw Makefile.nw

gem5-X:
	git clone https://github.com/esl-epfl/gem5-X.git
	cd gem5-X; ln -s ../Makefile.gem5-X Makefile; ln -s ../Makefile.fs* .

gem5_GUI:
	git clone https://github.com/afarooqui98/gem5_GUI.git
	cd gem5_GUI; ln -s ../Makefile.gem5_GUI Makefile

#
# Build Commands
#
build/X86/gem5.opt: gem5
X86: gem5
	cd gem5; scons build/X86/gem5.opt

build/ARM/gem5.opt: gem5
ARM: gem5
	cd gem5; scons build/ARM/gem5.opt

build/MIPS/gem5.opt: gem5
MIPS: gem5
	cd gem5; scons build/MIPS/gem5.opt

build/POWER/gem5.opt: gem5
POWER: gem5
	cd gem5; scons build/POWER/gem5.opt

gem5/Makefile: Makefile.gem5
	cd gem5; ln -s ../Makefile.gem5 Makefile

STREAM:
	git clone https://github.com/jeffhammond/STREAM.git
	cd STREAM; ln -s ../Makefile.STREAM Makefile.STREAM


TERM_PROG=./util/term/m5term

term: $(TERM_PROG)
	./gem5/util/term/m5term localhost 3456

$(TERM_PROG):
	cd ./gem5/util/term; make


GEM5_X_HOME = "`pwd`/gem5-X"
SPLASH2_HOME = "`pwd`/splash2"

ifndef ISA
ISA := X86
endif

SUBDIRS := codes/m5threads codes/kernels/fft codes/kernels/lu codes/kernels/radix codes/apps/fmm codes/apps/ocean codes/apps/barnes codes/apps/raytrace


help-splash2:
	@echo "GEM5_X_HOME=$(GEM5_X_HOME)"
	@echo "SPLASH2_HOME=$(SPLASH2_HOME)"
	@echo "RUN: make run-splash2 ISA=X86 CMD="FFT" OPT=\"-p1 -s\" OUT="12345""
	@echo "BUILD: make build-splash2 ISA=X86 or make build-splash2 ISA=ARM"

splash2i: splash2 splash2/codes/m5threads
	# @echo "Modifiy BASEDIR in splash2/codes/Makefile.config to absolute splash2/codes path"

splash2:
	# wget http://web.archive.org/web/20080528165352/http://www-flash.stanford.edu/apps/SPLASH/splash2.tar.gz
	tar -xzvf /Data/Benchmarks/splash2.tar.gz
	# cd splash2; wget http://www.capsl.udel.edu/splash/splash2-modified.patch.gz
	cd splash2; patch -p1 < /Data/Benchmarks/splash2-modified.patch; \
		echo "SPLASH2_HOME := `pwd`" >> Makefile; \
		cat ../Makefile.splash2 >> Makefile; \
		cp ../Run-splash2.bat .
	cd splash2/codes;  echo "BASEDIR := `pwd`" >> Makefile.config; \
		cat ../../Makefile.config.splash2 >> Makefile.config
	# cd splash2/codes; mkdir bin; mkdir bin/X86; mkdir bin/ARM;
	@echo "splash2 copied."


splash2/codes/m5threads: splash2
	cd splash2/codes; git clone https://github.com/gem5/m5threads; \
		cd m5threads; mv Makefile Makefile.org; \
		ln -s ../../../Makefile.m5threads Makefile
	@echo "m5threads cloned."


build-splash2-all:
	@echo "BUILD: make build for both X86 and ARM"
	make build-splash2 ISA=X86
	make build-splash2 ISA=ARM

build-splash2:
	@echo "BUILD: make build ISA=X86 or make build ISA=ARM"
	cd codes/m5threads; make ISA=$(ISA)
	cd codes/kernels/fft; make ISA=$(ISA)
	cd codes/kernels/lu; make ISA=$(ISA)
	cd codes/kernels/radix; make ISA=$(ISA)
	cd codes/kernels/cholesky; make ISA=$(ISA)
	cd codes/apps/fmm; make ISA=$(ISA)
	cd codes/apps/ocean; make ISA=$(ISA)
	cd codes/apps/barnes; make ISA=$(ISA)
	cd codes/apps/raytrace; make ISA=$(ISA)
	@echo "Check Executables located in <splash2>/codes/bin/$(ISA)/*"

clean:
	make clean-splash2 ISA=ARM
	make clean-splash2 ISA=X86
	
clean-splash2: 
	@echo "CLEAN: make clean ISA=X86 or make clean ISA=ARM"
	cd codes/m5threads; make clean ISA=$(ISA)
	cd codes/kernels/fft; make clean ISA=$(ISA)
	cd codes/kernels/lu; make clean ISA=$(ISA)
	cd codes/kernels/radix; make clean ISA=$(ISA)
	cd codes/kernels/cholesky; make clean ISA=$(ISA)
	cd codes/apps/fmm; make clean ISA=$(ISA)
	cd codes/apps/ocean; make clean ISA=$(ISA)
	cd codes/apps/barnes; make clean ISA=$(ISA)
	cd codes/apps/raytrace; make clean ISA=$(ISA)
	rm codes/bin/$(ISA)/*
	@echo "Check Executables located in <splash2>/codes/bin/$(ISA)/*"


run-splash2: # see run-batch scripts 
	@time $(GEM5_X_HOME)/build/$(ISA)/gem5-$(PROTOCOL).opt \
		$(GEM5_X_OPT) \
		--outdir=m5out-$(PROTOCOL)-$(OUT) \
		--stats-file=$(OUT)-stats.txt \
		$(GEM5_X_HOME)/configs/example/se.py \
		$(SE_OPT) \
		--cmd="$(SPLASH2_HOME)/codes/bin/$(ISA)/$(APP_CMD)" \
		--option="$(APP_OPT)" \
		--output=m5out-$(PROTOCOL)-$(OUT)/$(OUT)-stdout.txt\
		--errout=m5out-$(PROTOCOL)-$(OUT)/$(OUT)-stderr.txt

$(SUBIDRS) :
	$(MAKE) -C $(MAKECMDGOALS)
	
.PHONY: all clean $(SUBDIRS)

imn2:
	clone https://github.com/WePCf/darknet-mobilenet-v2.git

mnt: imgdir
	sudo mount -o loop,offset=32256 gem5/disks/arm/aarch64-ubuntu-trusty-headless.img imgdir

imgdir:
	mkdir imgdir

umnt:
	sudo umount imgdir
