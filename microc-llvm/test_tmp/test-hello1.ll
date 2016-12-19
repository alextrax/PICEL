; ModuleID = 'PICEL'

@a = global i32 0
@b = global [5 x i32] zeroinitializer
@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@"str_hello world!!" = private unnamed_addr constant [14 x i8] c"hello world!!\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

declare { i32, i32, i32, i8* } @newpic(i32, i32, ...)

declare i32 @delete_pic({ i32, i32, i32, i8* }*, ...)

define i32 @main() {
entry:
  store i32 5, i32* @a
  %c = alloca [6 x i32]
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i4 = load i32* %i
  %tmp5 = icmp slt i32 %i4, 5
  br i1 %tmp5, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i1 = load i32* %i
  %i2 = load i32* %i
  %elmt_addr = getelementptr inbounds i32* getelementptr inbounds ([5 x i32]* @b, i32 0, i32 0), i32 %i1
  store i32 %i2, i32* %elmt_addr
  %i3 = load i32* %i
  %tmp = add i32 %i3, 1
  store i32 %tmp, i32* %i
  br label %while

merge:                                            ; preds = %while
  %a = alloca i32
  store i32 0, i32* %a
  br label %while6

while6:                                           ; preds = %while_body7, %merge
  %a14 = load i32* %a
  %tmp15 = icmp slt i32 %a14, 6
  br i1 %tmp15, label %while_body7, label %merge16

while_body7:                                      ; preds = %while6
  %a8 = load i32* %a
  %a9 = load i32* %a
  %tmp10 = add i32 %a9, 10
  %c_ptr = bitcast [6 x i32]* %c to i32*
  %elmt_addr11 = getelementptr inbounds i32* %c_ptr, i32 %a8
  store i32 %tmp10, i32* %elmt_addr11
  %a12 = load i32* %a
  %tmp13 = add i32 %a12, 1
  store i32 %tmp13, i32* %a
  br label %while6

merge16:                                          ; preds = %while6
  %a17 = alloca i32
  store i32 0, i32* %a17
  br label %while18

while18:                                          ; preds = %while_body19, %merge16
  %a25 = load i32* %a17
  %tmp26 = icmp slt i32 %a25, 6
  br i1 %tmp26, label %while_body19, label %merge27

while_body19:                                     ; preds = %while18
  %a20 = load i32* %a17
  %c_ptr21 = bitcast [6 x i32]* %c to i32*
  %elmt_addr22 = getelementptr inbounds i32* %c_ptr21, i32 %a20
  %elmt = load i32* %elmt_addr22
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %elmt)
  %a23 = load i32* %a17
  %tmp24 = add i32 %a23, 1
  store i32 %tmp24, i32* %a17
  br label %while18

merge27:                                          ; preds = %while18
  %a28 = load i32* @a
  %printf29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %a28)
  %a30 = alloca i32
  store i32 0, i32* %a30
  br label %while31

while31:                                          ; preds = %while_body32, %merge27
  %a39 = load i32* %a30
  %tmp40 = icmp slt i32 %a39, 5
  br i1 %tmp40, label %while_body32, label %merge41

while_body32:                                     ; preds = %while31
  %a33 = load i32* %a30
  %elmt_addr34 = getelementptr inbounds i32* getelementptr inbounds ([5 x i32]* @b, i32 0, i32 0), i32 %a33
  %elmt35 = load i32* %elmt_addr34
  %printf36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %elmt35)
  %a37 = load i32* %a30
  %tmp38 = add i32 %a37, 1
  store i32 %tmp38, i32* %a30
  br label %while31

merge41:                                          ; preds = %while31
  %printf42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8]* @"str_hello world!!", i32 0, i32 0))
  ret i32 0
}
