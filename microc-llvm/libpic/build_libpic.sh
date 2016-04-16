 ../microc.native < ./convolution.pic > ./convolution.ll
llc -filetype=obj convolution.ll


