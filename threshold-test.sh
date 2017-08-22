#!/bin/bash

cd astar/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o astar-rdv-16384-ptsize-16.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o astar-rdv-16384-ptsize-32.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o astar-rdv-16384-ptsize-64.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o astar-rdv-16384-ptsize-128.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o astar-rdv-16384-ptsize-256.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o astar-rdv-16384-ptsize-512.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o astar-rdv-16384-ptsize-1024.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &

cd ./bzip2/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o bzip2-rdv-16384-ptsize-16.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o bzip2-rdv-16384-ptsize-32.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o bzip2-rdv-16384-ptsize-64.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o bzip2-rdv-16384-ptsize-128.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o bzip2-rdv-16384-ptsize-256.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o bzip2-rdv-16384-ptsize-512.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o bzip2-rdv-16384-ptsize-1024.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &

#cd ../bwaves/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o bwaves-rdv-16384-ptsize-16.txt -- ./bwaves_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o bwaves-rdv-16384-ptsize-32.txt -- ./bwaves_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o bwaves-rdv-16384-ptsize-64.txt -- ./bwaves_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o bwaves-rdv-16384-ptsize-128.txt -- ./bwaves_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o bwaves-rdv-16384-ptsize-256.txt -- ./bwaves_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o bwaves-rdv-16384-ptsize-512.txt -- ./bwaves_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o bwaves-rdv-16384-ptsize-1024.txt -- ./bwaves_base.gcc41-amd64bit &

cd ../gcc/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o gcc-rdv-16384-ptsize-16.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o gcc-rdv-16384-ptsize-32.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o gcc-rdv-16384-ptsize-64.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o gcc-rdv-16384-ptsize-128.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o gcc-rdv-16384-ptsize-256.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o gcc-rdv-16384-ptsize-512.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o gcc-rdv-16384-ptsize-1024.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &

cd ../gobmk/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o gobmk-rdv-16384-ptsize-16.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o gobmk-rdv-16384-ptsize-32.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o gobmk-rdv-16384-ptsize-64.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o gobmk-rdv-16384-ptsize-128.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o gobmk-rdv-16384-ptsize-256.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o gobmk-rdv-16384-ptsize-512.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o gobmk-rdv-16384-ptsize-1024.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &

cd ../h264ref/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o h264ref-rdv-16384-ptsize-16.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o h264ref-rdv-16384-ptsize-32.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o h264ref-rdv-16384-ptsize-64.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o h264ref-rdv-16384-ptsize-128.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o h264ref-rdv-16384-ptsize-256.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o h264ref-rdv-16384-ptsize-512.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o h264ref-rdv-16384-ptsize-1024.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &

cd ../leslie3d/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o leslie3d-rdv-16384-ptsize-16.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o leslie3d-rdv-16384-ptsize-32.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o leslie3d-rdv-16384-ptsize-64.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o leslie3d-rdv-16384-ptsize-128.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o leslie3d-rdv-16384-ptsize-256.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o leslie3d-rdv-16384-ptsize-512.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o leslie3d-rdv-16384-ptsize-1024.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &

cd ../mcf/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o mcf-rdv-16384-ptsize-16.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o mcf-rdv-16384-ptsize-32.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o mcf-rdv-16384-ptsize-64.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o mcf-rdv-16384-ptsize-128.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o mcf-rdv-16384-ptsize-256.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o mcf-rdv-16384-ptsize-512.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o mcf-rdv-16384-ptsize-1024.txt -- ./mcf_base.gcc41-amd64bit inp.in &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 165 -o mcf-rdv-16384-ptsize-15.txt -- ./mcf_base.gcc41-amd64bit inp.in &

cd ../perlbench/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o perlbench-rdv-16384-ptsize-16.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o perlbench-rdv-16384-ptsize-32.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o perlbench-rdv-16384-ptsize-64.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o perlbench-rdv-16384-ptsize-128.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o perlbench-rdv-16384-ptsize-256.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o perlbench-rdv-16384-ptsize-512.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o perlbench-rdv-16384-ptsize-1024.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &

cd ../soplex/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o soplex-rdv-16384-ptsize-16.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o soplex-rdv-16384-ptsize-32.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o soplex-rdv-16384-ptsize-64.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o soplex-rdv-16384-ptsize-128.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o soplex-rdv-16384-ptsize-256.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o soplex-rdv-16384-ptsize-512.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o soplex-rdv-16384-ptsize-1024.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &

cd ../tonto/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o tonto-rdv-16384-ptsize-16.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o tonto-rdv-16384-ptsize-32.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o tonto-rdv-16384-ptsize-64.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o tonto-rdv-16384-ptsize-128.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o tonto-rdv-16384-ptsize-256.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o tonto-rdv-16384-ptsize-512.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o tonto-rdv-16384-ptsize-1024.txt -- ./tonto_base.gcc41-amd64bit &

cd ../zeusmp/
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 16 -o zeusmp-rdv-16384-ptsize-16.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 32 -o zeusmp-rdv-16384-ptsize-32.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 64 -o zeusmp-rdv-16384-ptsize-64.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 128 -o zeusmp-rdv-16384-ptsize-128.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 256 -o zeusmp-rdv-16384-ptsize-256.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 512 -o zeusmp-rdv-16384-ptsize-512.txt -- ./zeusmp_base.gcc41-amd64bit &
#./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -p 1024 -o zeusmp-rdv-16384-ptsize-1024.txt -- ./zeusmp_base.gcc41-amd64bit &

cd ./
