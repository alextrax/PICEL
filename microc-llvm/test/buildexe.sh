cp ../libpic/convolution.pic source.pic
cat ../libpic/gray.pic >> source.pic
cat ./conv.pic >> source.pic
../microc.native < source.pic > tmp.ll
#llc -filetype=obj tmp.ll 
opt -mem2reg -S tmp.ll > tmp_opt.ll
llc -filetype=obj tmp_opt.ll
llvm-g++ tmp_opt.o ../bitmap/bmplib.o

