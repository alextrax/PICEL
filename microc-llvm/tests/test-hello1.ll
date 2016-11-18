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

define i32 @main() {
entry:
  store i32 5, i32* @a
  %c = alloca i32, i32 6
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i4 = load i32, i32* %i
  %tmp5 = icmp slt i32 %i4, 5
  br i1 %tmp5, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i1 = load i32, i32* %i
  %i2 = load i32, i32* %i
  %elmt_addr = getelementptr inbounds i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @b, i32 0, i32 0), i32 %i1
  store i32 %i2, i32* %elmt_addr
  %i3 = load i32, i32* %i
  %tmp = add i32 %i3, 1
  store i32 %tmp, i32* %i
  br label %while

merge:                                            ; preds = %while
  %a = alloca i32
  store i32 0, i32* %a
  br label %while6

while6:                                           ; preds = %while_body7, %merge
  %a14 = load i32, i32* %a
  %tmp15 = icmp slt i32 %a14, 6
  br i1 %tmp15, label %while_body7, label %merge16

while_body7:                                      ; preds = %while6
  %a8 = load i32, i32* %a
  %a9 = load i32, i32* %a
  %tmp10 = add i32 %a9, 10
  %elmt_addr11 = getelementptr inbounds i32, i32* %c, i32 %a8
  store i32 %tmp10, i32* %elmt_addr11
  %a12 = load i32, i32* %a
  %tmp13 = add i32 %a12, 1
  store i32 %tmp13, i32* %a
  br label %while6

merge16:                                          ; preds = %while6
  %a17 = alloca i32
  store i32 0, i32* %a17
  br label %while18

while18:                                          ; preds = %while_body19, %merge16
  %a24 = load i32, i32* %a17
  %tmp25 = icmp slt i32 %a24, 6
  br i1 %tmp25, label %while_body19, label %merge26

while_body19:                                     ; preds = %while18
  %a20 = load i32, i32* %a17
  %elmt_addr21 = getelementptr inbounds i32, i32* %c, i32 %a20
  %elmt = load i32, i32* %elmt_addr21
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmti, i32 0, i32 0), i32 %elmt)
  %a22 = load i32, i32* %a17
  %tmp23 = add i32 %a22, 1
  store i32 %tmp23, i32* %a17
  br label %while18

merge26:                                          ; preds = %while18
  %a27 = load i32, i32* @a
  %printf28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmti, i32 0, i32 0), i32 %a27)
  %a29 = alloca i32
  store i32 0, i32* %a29
  br label %while30

while30:                                          ; preds = %while_body31, %merge26
  %a38 = load i32, i32* %a29
  %tmp39 = icmp slt i32 %a38, 5
  br i1 %tmp39, label %while_body31, label %merge40

while_body31:                                     ; preds = %while30
  %a32 = load i32, i32* %a29
  %elmt_addr33 = getelementptr inbounds i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @b, i32 0, i32 0), i32 %a32
  %elmt34 = load i32, i32* %elmt_addr33
  %printf35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmti, i32 0, i32 0), i32 %elmt34)
  %a36 = load i32, i32* %a29
  %tmp37 = add i32 %a36, 1
  store i32 %tmp37, i32* %a29
  br label %while30

merge40:                                          ; preds = %while30
  %printf41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @"str_hello world!!", i32 0, i32 0))
  ret i32 0
}
