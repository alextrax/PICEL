cp ../libpic/convolution.pic source.pic
<<<<<<< HEAD
cat ./conv.pic >> source.pic
../picel.native < source.pic > tmp.ll
llc -filetype=obj tmp.ll 
llvm-g++ tmp.o ../bitmap/bmplib.o 
=======
cat ../libpic/gray.pic >> source.pic
cat $1 >> source.pic
../microc.native < source.pic > tmp.ll
#llc -filetype=obj tmp.ll 
opt -mem2reg -S tmp.ll > tmp_opt.ll
llc -filetype=obj tmp_opt.ll
llvm-g++ tmp_opt.o ../bitmap/bmplib.o
>>>>>>> origin/convol

