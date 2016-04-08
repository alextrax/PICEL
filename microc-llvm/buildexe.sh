 ./microc.native < ./test/struct_test.pic > ./tmp.ll
llc -filetype=obj tmp.ll
g++ tmp.o bitmap/bmplib.o

