M5_PATH=/Data/Gem5-X
CPUS=8
CKPT=1
OUTDIR=m5_HBM8
MEM_TYPE=HBM2_2000_4H_1x128


fsh: 
	export M5_PATH=$(M5_PATH)
	./build/ARM/gem5.opt \
		--outdir=$(OUTDIR) \
		configs/example/fs.py \
		--cpu-clock=1GHz \
		-n $(CPUS) \
		--kernel=vmlinux \
		--machine-type=VExpress_GEM5_V1 \
		--dtb-file=$(M5_PATH)/system/arm/dt/armv8_gem5_v1_$(CPUS)cpu.dtb \
		--disk-image=$(M5_PATH)/disks/gem5_ubuntu16.img \
		--caches \
		--l2cache \
		--l1i_size=32kB \
		--l1d_size=32kB \
		--l2_size=1MB \
		--l2_assoc=2 \
		--l2bus-width=128 \
		--membus-width=128 \
		--mem-type=$(MEM_TYPE) \
		--mem-ranks=1 \
		--mem-size=4GB \
		--sys-clock=1600MHz
		--mem-channels=8 \

fshc: 
	export M5_PATH=$(M5_PATH)
	./build/ARM/gem5.opt \
		--outdir=$(OUTDIR) \
		configs/example/fs.py \
		--cpu-clock=1GHz \
		-n $(CPUS) \
		-r $(CKPT) \
		--kernel=vmlinux \
		--machine-type=VExpress_GEM5_V1 \
		--dtb-file=$(M5_PATH)/system/arm/dt/armv8_gem5_v1_$(CPUS)cpu.dtb \
		--disk-image=$(M5_PATH)/disks/gem5_ubuntu16.img \
		--caches \
		--l2cache \
		--l1i_size=32kB \
		--l1d_size=32kB \
		--l2_size=1MB \
		--l2_assoc=2 \
		--l2bus-width=128 \
		--membus-width=128 \
		--mem-type=$(MEM_TYPE) \
		--mem-ranks=1 \
		--mem-channels=8 \
		--mem-size=4GB \
		--sys-clock=1600MHz
