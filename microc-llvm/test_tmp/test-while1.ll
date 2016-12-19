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
  %i = alloca i32
  store i32 5, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i3 = load i32* %i
  %tmp4 = icmp sgt i32 %i3, 0
  br i1 %tmp4, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i1 = load i32* %i
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %i1)
  %i2 = load i32* %i
  %tmp = sub i32 %i2, 1
  store i32 %tmp, i32* %i
  br label %while

merge:                                            ; preds = %while
  %printf5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 42)
  ret i32 0
}
