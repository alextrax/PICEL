
cp ./libpic/convolution.pic source.pic
cat ./conv_tests/test-conv3.pic >> source.pic
./picel.native < source.pic > tmp.ll
llc -filetype=obj tmp.ll 
g++ tmp.o bitmap/bmplib.o 

