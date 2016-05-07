cp ../libpic/convolution.pic source.pic
cat ../libpic/gray.pic >> source.pic
<<<<<<< HEAD
cat $1 >> source.pic
=======
cat ./conv.pic >> source.pic
>>>>>>> origin/demo_merge
../picel.native < source.pic > tmp.ll
#llc -filetype=obj tmp.ll 
opt -mem2reg -S tmp.ll > tmp_opt.ll
llc -filetype=obj tmp_opt.ll
g++ tmp_opt.o ../bitmap/bmplib.o

