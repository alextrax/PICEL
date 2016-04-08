 ./microc.native < ./test/hello.pic > ./tmp.ll
llc -filetype=obj tmp.ll
llvm-g++ tmp.o bitmap/bmplib.o

