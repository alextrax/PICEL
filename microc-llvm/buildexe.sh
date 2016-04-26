
cp ./libpic/convolution.pic tests/test-pic1.pic
cat ./test/conv.pic >> tests/test-pic1.pic
./microc.native < tests/test-pic1.pic > tmp.ll
llc -filetype=obj tmp.ll 
g++ tmp.o bitmap/bmplib.o 

