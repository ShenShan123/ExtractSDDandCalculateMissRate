#!/bin/bash

cd astar/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o astar-rdv-16384-s10.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o astar-rdv-16384-s100.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o astar-rdv-16384-s1000.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o astar-rdv-16384-s10000.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o astar-rdv-16384-s100000.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o astar-rdv-16384-s1000000.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &

cd ../bzip2/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o bzip2-rdv-16384-s10.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o bzip2-rdv-16384-s100.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o bzip2-rdv-16384-s1000.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o bzip2-rdv-16384-s10000.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o bzip2-rdv-16384-s100000.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o bzip2-rdv-16384-s1000000.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &

cd ../gcc/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o gcc-rdv-16384-s10.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o gcc-rdv-16384-s100.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o gcc-rdv-16384-s1000.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o gcc-rdv-16384-s10000.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o gcc-rdv-16384-s100000.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o gcc-rdv-16384-s1000000.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
#
cd ../gobmk/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5  -s 10 -p 256 -o gobmk-rdv-16384-s10.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5  -s 100 -p 256 -o gobmk-rdv-16384-s100.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5  -s 1000 -p 256 -o gobmk-rdv-16384-s1000.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5  -s 10000 -p 256 -o gobmk-rdv-16384-s10000.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5  -s 100000 -p 256 -o gobmk-rdv-16384-s100000.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5  -s 1000000 -p 256 -o gobmk-rdv-16384-s1000000.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
#
cd ../h264ref/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256  -o h264ref-rdv-16384-s10.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256  -o h264ref-rdv-16384-s100.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256  -o h264ref-rdv-16384-s1000.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256  -o h264ref-rdv-16384-s10000.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256  -o h264ref-rdv-16384-s100000.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256  -o h264ref-rdv-16384-s1000000.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
#

cd ../leslie3d/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o leslie3d-rdv-16384-s10.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o leslie3d-rdv-16384-s100.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o leslie3d-rdv-16384-s1000.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o leslie3d-rdv-16384-s10000.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o leslie3d-rdv-16384-s100000.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o leslie3d-rdv-16384-s1000000.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &

#cd ../namd/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o namd-rdv-16384-s10.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o namd-rdv-16384-s100.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o namd-rdv-16384-s1000.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o namd-rdv-16384-s10000.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o namd-rdv-16384-s100000.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o namd-rdv-16384-s1000000.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &

#cd ../perlbench/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o perlbench-rdv-16384-s10.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o perlbench-rdv-16384-s100.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o perlbench-rdv-16384-s1000.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o perlbench-rdv-16384-s10000.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o perlbench-rdv-16384-s100000.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o perlbench-rdv-16384-s1000000.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &

#cd ../soplex/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o soplex-rdv-16384-s10.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o soplex-rdv-16384-s100.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o soplex-rdv-16384-s1000.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o soplex-rdv-16384-s10000.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o soplex-rdv-16384-s100000.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o soplex-rdv-16384-s1000000.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &

#cd ../tonto/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o tonto-rdv-16384-s10.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o tonto-rdv-16384-s100.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o tonto-rdv-16384-s1000.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o tonto-rdv-16384-s10000.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o tonto-rdv-16384-s100000.txt -- ./tonto_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o tonto-rdv-16384-s1000000.txt -- ./tonto_base.gcc41-amd64bit &

#cd ../zeusmp/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10 -p 256 -o zeusmp-rdv-16384-s10.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100 -p 256 -o zeusmp-rdv-16384-s100.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000 -p 256 -o zeusmp-rdv-16384-s1000.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 10000 -p 256 -o zeusmp-rdv-16384-s10000.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 100000 -p 256 -o zeusmp-rdv-16384-s100000.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t 5 -s 1000000 -p 256 -o zeusmp-rdv-16384-s1000000.txt -- ./zeusmp_base.gcc41-amd64bit &

cd ./
