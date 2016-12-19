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
  %b = alloca i1
  store i1 true, i1* %b
  %a = alloca i32
  %b1 = load i1* %b
  br i1 %b1, label %then, label %else

merge:                                            ; preds = %else, %then
  %a2 = load i32* %a
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %a2)
  ret i32 0

then:                                             ; preds = %entry
  store i32 1, i32* %a
  br label %merge

else:                                             ; preds = %entry
  store i32 0, i32* %a
  br label %merge
}
