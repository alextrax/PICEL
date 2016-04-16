 ./microc.native < ./test/struct_test.pic > ./tmp.ll
llvm-link ./tmp.ll ./libpic/convolution.ll -o conv_test.ll
llc -filetype=obj conv_test.ll 
llvm-g++  conv_test.o bitmap/bmplib.o 

