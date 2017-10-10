#!/bin/bash

if [ -z $1 ]; then
	echo "set the threshold first!!"
	exit
fi

cd astar/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o astar-rdv-16384-t$1-p16.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o astar-rdv-16384-t$1-p32.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o astar-rdv-16384-t$1-p64.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o astar-rdv-16384-t$1-p128.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o astar-rdv-16384-t$1-p256.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o astar-rdv-16384-t$1-p512.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o astar-rdv-16384-t$1-p1024.txt -- ./astar_base.gcc41-amd64bit BigLakes2048.cfg &

cd ../bzip2/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o bzip2-rdv-16384-t$1-p16.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o bzip2-rdv-16384-t$1-p32.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o bzip2-rdv-16384-t$1-p64.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o bzip2-rdv-16384-t$1-p128.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o bzip2-rdv-16384-t$1-p256.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o bzip2-rdv-16384-t$1-p512.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o bzip2-rdv-16384-t$1-p1024.txt -- ./bzip2_base.gcc41-amd64bit chicken.jpg 30 &

cd ../gcc/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o gcc-rdv-16384-t$1-p16.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o gcc-rdv-16384-t$1-p32.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o gcc-rdv-16384-t$1-p64.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o gcc-rdv-16384-t$1-p128.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o gcc-rdv-16384-t$1-p256.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o gcc-rdv-16384-t$1-p512.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o gcc-rdv-16384-t$1-p1024.txt -- ./gcc_base.gcc41-amd64bit 166.in -o 166.s &
#
cd ../gobmk/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o gobmk-rdv-16384-t$1-p16.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o gobmk-rdv-16384-t$1-p32.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o gobmk-rdv-16384-t$1-p64.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o gobmk-rdv-16384-t$1-p128.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o gobmk-rdv-16384-t$1-p256.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o gobmk-rdv-16384-t$1-p512.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o gobmk-rdv-16384-t$1-p1024.txt -- ./gobmk_base.gcc41-amd64bit --quiet --mode gtp < 13x13.tst &
#
cd ../h264ref/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o h264ref-rdv-16384-t$1-p16.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o h264ref-rdv-16384-t$1-p32.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o h264ref-rdv-16384-t$1-p64.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o h264ref-rdv-16384-t$1-p128.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o h264ref-rdv-16384-t$1-p256.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o h264ref-rdv-16384-t$1-p512.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o h264ref-rdv-16384-t$1-p1024.txt -- ./h264ref_base.gcc41-amd64bit -d foreman_ref_encoder_baseline.cfg &
#
cd ../leslie3d/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o leslie3d-rdv-16384-t$1-p16.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o leslie3d-rdv-16384-t$1-p32.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o leslie3d-rdv-16384-t$1-p64.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o leslie3d-rdv-16384-t$1-p128.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o leslie3d-rdv-16384-t$1-p256.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o leslie3d-rdv-16384-t$1-p512.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o leslie3d-rdv-16384-t$1-p1024.txt -- ./leslie3d_base.gcc41-amd64bit < leslie3d.in &

cd ../namd/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o namd-rdv-16384-t$1-p16.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o namd-rdv-16384-t$1-p32.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o namd-rdv-16384-t$1-p64.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o namd-rdv-16384-t$1-p128.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o namd-rdv-16384-t$1-p256.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o namd-rdv-16384-t$1-p512.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o namd-rdv-16384-t$1-p1024.txt -- ./namd_base.gcc41-amd64bit --input namd.input --iterations 38 --output namd.out &

cd ../perlbench/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o perlbench-rdv-16384-t$1-p16.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o perlbench-rdv-16384-t$1-p32.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o perlbench-rdv-16384-t$1-p64.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o perlbench-rdv-16384-t$1-p128.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o perlbench-rdv-16384-t$1-p256.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o perlbench-rdv-16384-t$1-p512.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o perlbench-rdv-16384-t$1-p1024.txt -- ./perlbench_base.gcc41-amd64bit -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 &
#
cd ../soplex/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o soplex-rdv-16384-t$1-p16.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o soplex-rdv-16384-t$1-p32.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o soplex-rdv-16384-t$1-p64.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o soplex-rdv-16384-t$1-p128.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o soplex-rdv-16384-t$1-p256.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o soplex-rdv-16384-t$1-p512.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o soplex-rdv-16384-t$1-p1024.txt -- ./soplex_base.gcc41-amd64bit -s1 -e -m45000 pds-50.mps &
#
cd ../tonto/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o tonto-rdv-16384-t$1-p16.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o tonto-rdv-16384-t$1-p32.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o tonto-rdv-16384-t$1-p64.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o tonto-rdv-16384-t$1-p128.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o tonto-rdv-16384-t$1-p256.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o tonto-rdv-16384-t$1-p512.txt -- ./tonto_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o tonto-rdv-16384-t$1-p1024.txt -- ./tonto_base.gcc41-amd64bit &
#
cd ../zeusmp/
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 16 -o zeusmp-rdv-16384-t$1-p16.txt -- ./zeusmp_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 32 -o zeusmp-rdv-16384-t$1-p32.txt -- ./zeusmp_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 64 -o zeusmp-rdv-16384-t$1-p64.txt -- ./zeusmp_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 128 -o zeusmp-rdv-16384-t$1-p128.txt -- ./zeusmp_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 256 -o zeusmp-rdv-16384-t$1-p256.txt -- ./zeusmp_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 512 -o zeusmp-rdv-16384-t$1-p512.txt -- ./zeusmp_base.gcc41-amd64bit &
./../../../../pin.sh -t  ../obj-intel64/memTraceSimple.so -t $1 -p 1024 -o zeusmp-rdv-16384-t$1-p1024.txt -- ./zeusmp_base.gcc41-amd64bit &

cd ./
