; ModuleID = 'PICEL'

@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

declare { i32, i32, i32, i8* } @newpic(i32, i32, ...)

declare i32 @delete_pic({ i32, i32, i32, i8* }*, ...)

define i32 @main() {
entry:
  %a = alloca [4 x i32]
  %c_ptr = bitcast [4 x i32]* %a to i32*
  %elmt_addr = getelementptr inbounds i32* %c_ptr, i32 0
  store i32 0, i32* %elmt_addr
  %c_ptr1 = bitcast [4 x i32]* %a to i32*
  %elmt_addr2 = getelementptr inbounds i32* %c_ptr1, i32 1
  store i32 1, i32* %elmt_addr2
  %c_ptr3 = bitcast [4 x i32]* %a to i32*
  %elmt_addr4 = getelementptr inbounds i32* %c_ptr3, i32 2
  store i32 2, i32* %elmt_addr4
  %c_ptr5 = bitcast [4 x i32]* %a to i32*
  %elmt_addr6 = getelementptr inbounds i32* %c_ptr5, i32 3
  store i32 3, i32* %elmt_addr6
  %c_ptr7 = bitcast [4 x i32]* %a to i32*
  %elmt_addr8 = getelementptr inbounds i32* %c_ptr7, i32 3
  %elmt = load i32* %elmt_addr8
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %elmt)
  ret i32 0
}
