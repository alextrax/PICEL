cp ../libpic/convolution.pic source.pic
cat ../libpic/gray.pic >> source.pic
cat $1 >> source.pic
../picel.native < source.pic > _tmp.ll
cp ./target.txt ./tmp.ll
cat ./_tmp.ll >> tmp.ll
rm ./_tmp.ll
#llc -filetype=obj tmp.ll 
#opt -mem2reg -S tmp.ll > tmp_opt.ll
llvm-as-3.4 tmp.ll -o tmp.bc
#llc -filetype=obj tmp_opt.ll
#llvm-g++ tmp_opt.o ../bitmap/bmplib.o

