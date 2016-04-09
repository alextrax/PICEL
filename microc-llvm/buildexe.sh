 ./microc.native < ./test/struct_test.pic > ./tmp.ll
llc -filetype=obj tmp.ll
llvm-g++ tmp.o bitmap/bmplib.o

