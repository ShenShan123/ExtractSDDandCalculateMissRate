#!/bin/bash

cd astar/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o astar-rdv-16384.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o astar-bbv-16.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o astar-cbv-16.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
#
cd ../bzip2/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o bzip2-rdv-16384.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o bzip2-bbv-16.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o bzip2-cbv-16.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &

cd ../bwaves/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o bwaves-rdv-16384.txt -- ./bwaves_base.gcc41-amd64bit & 
./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o bwaves-bbv-16.txt -- ./bwaves_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o bwaves-cbv-16.txt -- ./bwaves_base.gcc41-amd64bit &

cd ../gcc/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o gcc-rdv-16384.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o gcc-bbv-16.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o gcc-cbv-16.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
#
cd ../perlbench/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o perlbench-rdv-16384.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o perlbench-bbv-16.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o perlbench-cbv-16.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#
cd ../cactusADM/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o cactusADM-rdv-16384.txt -- ./cactusADM_base.gcc41-amd64bit benchADM.par &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o cactusADM-bbv-16.txt -- ./cactusADM_base.gcc41-amd64bit benchADM.par &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o cactusADM-cbv-16.txt -- ./cactusADM_base.gcc41-amd64bit benchADM.par &
#
cd ../calculix/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o calculix-rdv-16384.txt -- ./calculix_base.gcc41-amd64bit -i hyperviscoplastic &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o calculix-bbv-16.txt -- ./calculix_base.gcc41-amd64bit -i hyperviscoplastic &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o calculix-cbv-16.txt -- ./calculix_base.gcc41-amd64bit -i hyperviscoplastic &
#
cd ../dealII/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o dealII-rdv-16384.txt -- ./dealII_base.gcc41-amd64bit 23 &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o dealII-bbv-16.txt -- ./dealII_base.gcc41-amd64bit 23 &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o dealII-cbv-16.txt -- ./dealII_base.gcc41-amd64bit 23 &
#
cd ../GemsFDTD/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o GemsFDTD-rdv-16384.txt -- ./GemsFDTD_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o GemsFDTD-bbv-16.txt -- ./GemsFDTD_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o GemsFDTD-cbv-16.txt -- ./GemsFDTD_base.gcc41-amd64bit &
#
cd ../gobmk/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o gobmk-rdv-16384.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o gobmk-bbv-16.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o gobmk-cbv-16.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
#
cd ../gromacs/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o gromacs-rdv-16384.txt -- ./gromacs_base.gcc41-amd64bit -silent -deffnm gromacs -nice 0 &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o gromacs-bbv-16.txt -- ./gromacs_base.gcc41-amd64bit -silent -deffnm gromacs -nice 0 &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o gromacs-cbv-16.txt -- ./gromacs_base.gcc41-amd64bit -silent -deffnm gromacs -nice 0 &
#
cd ../h264ref/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o h264ref-rdv-16384.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o h264ref-bbv-16.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o h264ref-cbv-16.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
#
cd ../hmmer/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o hmmer-rdv-16384.txt -- ./hmmer_base.gcc41-amd64bit nph3.hmm swiss41 &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o hmmer-bbv-16.txt -- ./hmmer_base.gcc41-amd64bit nph3.hmm swiss41 &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o hmmer-cbv-16.txt -- ./hmmer_base.gcc41-amd64bit nph3.hmm swiss41 &
#
cd ../lbm/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o lbm-rdv-16384.txt -- ./lbm_base.gcc41-amd64bit 3000 reference.dat 0 0 100_100_130_ldc.of &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o lbm-bbv-16.txt -- ./lbm_base.gcc41-amd64bit 3000 reference.dat 0 0 100_100_130_ldc.of &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o lbm-cbv-16.txt -- ./lbm_base.gcc41-amd64bit 3000 reference.dat 0 0 100_100_130_ldc.of &
#
cd ../leslie3d/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o leslie3d-rdv-16384.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o leslie3d-bbv-16.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o leslie3d-cbv-16.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
#
cd ../libquantum/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o libquantum-rdv-16384.txt -- ./libquantum_base.gcc41-amd64bit 1397 8 &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o libquantum-bbv-16.txt -- ./libquantum_base.gcc41-amd64bit 1397 8 &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o libquantum-cbv-16.txt -- ./libquantum_base.gcc41-amd64bit 1397 8 &
#
cd ../mcf/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o mcf-rdv-16384.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o mcf-bbv-16.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o mcf-cbv-16.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#
cd ../milc/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o milc-rdv-16384.txt -- ./milc_base.gcc41-amd64bit < su3imp.in &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o milc-bbv-16.txt -- ./milc_base.gcc41-amd64bit < su3imp.in &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o milc-cbv-16.txt -- ./milc_base.gcc41-amd64bit < su3imp.in &
#
cd ../namd/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o namd-rdv-16384.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o namd-bbv-16.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o namd-cbv-16.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#
cd ../omnetpp/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o omnetpp-rdv-16384.txt -- ./omnetpp_base.gcc41-amd64bit omnetpp.ini &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o omnetpp-bbv-16.txt -- ./omnetpp_base.gcc41-amd64bit omnetpp.ini &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o omnetpp-cbv-16.txt -- ./omnetpp_base.gcc41-amd64bit omnetpp.ini &
#
cd ../povray/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o povray-rdv-16384.txt -- ./povray_base.gcc41-amd64bit SPEC-benchmark-ref.ini &
./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o povray-bbv-16.txt -- ./povray_base.gcc41-amd64bit SPEC-benchmark-ref.ini &
./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o povray-cbv-16.txt -- ./povray_base.gcc41-amd64bit SPEC-benchmark-ref.ini &
#
cd ../soplex/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o soplex-rdv-16384.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o soplex-bbv-16.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o soplex-cbv-16.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &

cd ../sjeng/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o sjeng-rdv-16384.txt -- ./sjeng_base.gcc41-amd64bit ref.txt &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o sjeng-bbv-16.txt -- ./sjeng_base.gcc41-amd64bit ref.txt &
./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o sjeng-cbv-16.txt -- ./sjeng_base.gcc41-amd64bit ref.txt &


cd ../tonto/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o tonto-rdv-16384.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o tonto-bbv-16.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o tonto-cbv-16.txt -- ./tonto_base.gcc41-amd64bit &
#
cd ../zeusmp/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -o zeusmp-rdv-16384.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/bbvTrace.so -o zeusmp-bbv-16.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/cbvTrace.so -o zeusmp-cbv-16.txt -- ./zeusmp_base.gcc41-amd64bit &

cd ./