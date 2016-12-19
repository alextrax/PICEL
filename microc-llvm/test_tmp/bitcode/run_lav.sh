#!/bin/bash
for f in ../test-*.ll; 
	do 
		echo "Processing $f file.."
		cat target.txt $f > tmp.ll 
		llvm-as-3.4 tmp.ll -o $f.bc
		mv $f.bc .
		var="$f"
		LAV -solver=Yices-LA-EUF ${var:3}.bc
	done
