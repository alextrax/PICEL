cp ./libpic/convolution.pic source.pic
cat ./test/conv.pic >> source.pic
./microc.native < source.pic > tmp.ll
llc -filetype=obj tmp.ll 
g++ tmp.o bitmap/bmplib.o 

