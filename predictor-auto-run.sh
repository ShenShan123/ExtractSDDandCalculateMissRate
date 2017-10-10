#!/bin/bash

cd astar/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o astar-misprediction.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &

cd ../bzip2/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o bzip2-misprediction.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &

cd ../bwaves/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o bwaves-misprediction.txt -- ./bwaves_base.gcc41-amd64bit & 

cd ../gcc/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o gcc-misprediction.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &

cd ../perlbench/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o perlbench-misprediction.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &

cd ../cactusADM/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o cactusADM-misprediction.txt -- ./cactusADM_base.gcc41-amd64bit benchADM.par &

cd ../calculix/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o calculix-misprediction.txt -- ./calculix_base.gcc41-amd64bit -i hyperviscoplastic &

cd ../dealII/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o dealII-misprediction.txt -- ./dealII_base.gcc41-amd64bit 23 &

cd ../GemsFDTD/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o GemsFDTD-misprediction.txt -- ./GemsFDTD_base.gcc41-amd64bit &

cd ../gobmk/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o gobmk-misprediction.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
#
cd ../gromacs/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o gromacs-misprediction.txt -- ./gromacs_base.gcc41-amd64bit -silent -deffnm gromacs -nice 0 &

cd ../h264ref/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o h264ref-misprediction.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &

cd ../hmmer/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o hmmer-misprediction.txt -- ./hmmer_base.gcc41-amd64bit nph3.hmm swiss41 &

cd ../lbm/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o lbm-misprediction.txt -- ./lbm_base.gcc41-amd64bit 3000 reference.dat 0 0 100_100_130_ldc.of &

cd ../leslie3d/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o leslie3d-misprediction.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &

cd ../libquantum/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o libquantum-misprediction.txt -- ./libquantum_base.gcc41-amd64bit 1397 8 &

cd ../mcf/
#./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o mcf-misprediction.txt -- ./mcf_base.gcc41-amd64bit inp.in &

cd ../milc/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o milc-misprediction.txt -- ./milc_base.gcc41-amd64bit < su3imp.in &

cd ../namd/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o namd-misprediction.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &

cd ../omnetpp/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o omnetpp-misprediction.txt -- ./omnetpp_base.gcc41-amd64bit omnetpp.ini &

cd ../povray/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o povray-misprediction.txt -- ./povray_base.gcc41-amd64bit SPEC-benchmark-ref.ini &

cd ../soplex/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o soplex-misprediction.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &

cd ../sjeng/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o sjeng-misprediction.txt -- ./sjeng_base.gcc41-amd64bit ref.txt &

cd ../tonto/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o tonto-misprediction.txt -- ./tonto_base.gcc41-amd64bit &

cd ../zeusmp/
./../../../../pin.sh -t  ../obj-intel64/phasePredictor.so -t 9 -p 256 -s 256 -o zeusmp-misprediction.txt -- ./zeusmp_base.gcc41-amd64bit &

cd ./
