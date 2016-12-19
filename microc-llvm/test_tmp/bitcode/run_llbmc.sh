#!/bin/bash
for f in ../test-*.ll; 
	do 
		echo "Processing $f file.."
		cat target.txt $f > tmp.ll 
		llvm-as-3.4 tmp.ll -o $f.bc
		mv $f.bc .
		var="$f"
		llbmc --max-loop-iterations=$1 --ignore-missing-function-bodies ${var:3}.bc
	done
