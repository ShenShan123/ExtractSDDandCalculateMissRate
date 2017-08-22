#!/bin/bash

for file in ./*
do
    if test -d $file
    then
        echo $file 是文件
		mv ${file}/full-rdd-2048.txt ${file}/${file}-full-rdd-2048.txt
    fi
done

cp **/**-full-rdd-2048.txt ./
