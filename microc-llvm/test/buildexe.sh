cp ../libpic/convolution.pic source.pic
cat ../libpic/gray.pic >> source.pic
<<<<<<< HEAD
<<<<<<< HEAD
cat $1 >> source.pic
../picel.native < source.pic > tmp.ll
#llc -filetype=obj tmp.ll 
opt -mem2reg -S tmp.ll > tmp_opt.ll
llc -filetype=obj tmp_opt.ll
g++ tmp_opt.o ../bitmap/bmplib.o

=======
=======
>>>>>>> 5fdaa1c5e31138257dc167bb084e5703a8aa19f8
cat ./conv.pic >> source.pic
../microc.native < source.pic > tmp.ll
#llc -filetype=obj tmp.ll 
opt -mem2reg -S tmp.ll > tmp_opt.ll
llc -filetype=obj tmp_opt.ll
<<<<<<< HEAD
llvm-g++ tmp_opt.o ../bitmap/bmplib.o
>>>>>>> 5fdaa1c5e31138257dc167bb084e5703a8aa19f8
=======
llvm-g++ tmp_opt.o ../bitmap/bmplib.o
>>>>>>> 5fdaa1c5e31138257dc167bb084e5703a8aa19f8
