#!/bin/bash

make run-splash2 OUT=10001 ISA="X86" PROTOCOL=MOESI_hammer APP_CMD=FFT APP_OPT="-p1 -s" SE_OPT="--num-cpu=16 --num-dir=16"
make run-splash2 OUT=10002 ISA="X86" PROTOCOL=MOESI_hammer APP_CMD=FFT APP_OPT="-p4 -s" SE_OPT="--num-cpu=16 --num-dir=16 --caches --l1d_size=64kB --l1i_size=16kB"
make run-splash2 OUT=10003 ISA="X86" PROTOCOL=MOESI_hammer APP_CMD=FFT APP_OPT="-p4 -s" SE_OPT="--num-cpu=16 --num-dir=16 --cpu-type=TimingSimpleCPU" 
make run-splash2 OUT=10004 ISA="X86" PROTOCOL=MOESI_hammer APP_CMD=FFT APP_OPT="-p4 -s" SE_OPT="--num-cpu=16 --num-dir=16 --cpu-type=TimingSimpleCPU --caches --l1d_size=64kB --l1i_size=16kB "
make run-splash2 OUT=10005 ISA="X86" PROTOCOL=MOESI_hammer APP_CMD=FFT APP_OPT="-p4 -s" SE_OPT="--num-cpu=16 --num-dir=16 --cpu-type=TimingSimpleCPU --ruby --l1d_size=64kB --l1i_size=16kB "
