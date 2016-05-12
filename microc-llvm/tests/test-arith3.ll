; ModuleID = 'PICEL'

@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmti.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts.2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

define i32 @main() {
entry:
  %a = alloca i32
  store i32 42, i32* %a
  %a1 = load i32, i32* %a
  %tmp = add i32 %a1, 5
  store i32 %tmp, i32* %a
  %a2 = load i32, i32* %a
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmti, i32 0, i32 0), i32 %a2)
  ret i32 0
}

define i32 @foo(i32 %a) {
entry:
  %a1 = alloca i32
  store i32 %a, i32* %a1
  %a2 = alloca i32
  store i32 10, i32* %a2
  %a3 = load i32, i32* %a2
  ret i32 %a3
}
