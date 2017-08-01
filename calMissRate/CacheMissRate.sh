!#/bin/bash


if [ -z "$1" ]; then
	echo "no input file!!!"
	exit
else
	input=$1
fi

if [ -z "$2" ]; then
	echo "truncation distance shouldn't be zero!!"
	exit
else
	trunc=$2
fi


echo "input file is $1"
# 8K cache
./calcMissRate 8192 64 2 ${trunc} ${input} test.dump
./calcMissRate 8192 64 4 ${trunc} ${input} test.dump
./calcMissRate 8192 64 8 ${trunc} ${input} test.dump
./calcMissRate 8192 64 16 ${trunc} ${input} test.dump
./calcMissRate 8192 64 32 ${trunc} ${input} test.dump
./calcMissRate 8192 64 64 ${trunc} ${input} test.dump

#16K cache
./calcMissRate 16384 64 2 ${trunc} ${input} test.dump
./calcMissRate 16384 64 4 ${trunc} ${input} test.dump
./calcMissRate 16384 64 8 ${trunc} ${input} test.dump
./calcMissRate 16384 64 16 ${trunc} ${input} test.dump
./calcMissRate 16384 64 32 ${trunc} ${input} test.dump
./calcMissRate 16384 64 64 ${trunc} ${input} test.dump

# 32K cache
./calcMissRate 32768 64 2 ${trunc} ${input} test.dump
./calcMissRate 32768 64 4 ${trunc} ${input} test.dump
./calcMissRate 32768 64 8 ${trunc} ${input} test.dump
./calcMissRate 32768 64 16 ${trunc} ${input} test.dump
./calcMissRate 32768 64 32 ${trunc} ${input} test.dump
./calcMissRate 32768 64 64 ${trunc} ${input} test.dump

# 64K cache
./calcMissRate 65536 64 2 ${trunc} ${input} test.dump
./calcMissRate 65536 64 4 ${trunc} ${input} test.dump
./calcMissRate 65536 64 8 ${trunc} ${input} test.dump
./calcMissRate 65536 64 16 ${trunc} ${input} test.dump
./calcMissRate 65536 64 32 ${trunc} ${input} test.dump
./calcMissRate 65536 64 64 ${trunc} ${input} test.dump


# 128K cache
./calcMissRate 131072 64 2 ${trunc} ${input} test.dump
./calcMissRate 131072 64 4 ${trunc} ${input} test.dump
./calcMissRate 131072 64 8 ${trunc} ${input} test.dump
./calcMissRate 131072 64 16 ${trunc} ${input} test.dump
./calcMissRate 131072 64 32 ${trunc} ${input} test.dump
./calcMissRate 131072 64 64 ${trunc} ${input} test.dump

# 256 cache
./calcMissRate 262144 64 2 ${trunc} ${input} test.dump
./calcMissRate 262144 64 4 ${trunc} ${input} test.dump
./calcMissRate 262144 64 8 ${trunc} ${input} test.dump
./calcMissRate 262144 64 16 ${trunc} ${input} test.dump
./calcMissRate 262144 64 32 ${trunc} ${input} test.dump
./calcMissRate 262144 64 64 ${trunc} ${input} test.dump

# 512 cache
./calcMissRate 524288 64 2 ${trunc} ${input} test.dump
./calcMissRate 524288 64 4 ${trunc} ${input} test.dump
./calcMissRate 524288 64 8 ${trunc} ${input} test.dump
./calcMissRate 524288 64 16 ${trunc} ${input} test.dump
./calcMissRate 524288 64 32 ${trunc} ${input} test.dump
./calcMissRate 524288 64 64 ${trunc} ${input} test.dump
