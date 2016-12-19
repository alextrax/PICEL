; ModuleID = 'PICEL'

@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmti1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

declare { i32, i32, i32, i8* } @newpic(i32, i32, ...)

declare i32 @delete_pic({ i32, i32, i32, i8* }*, ...)

define i32 @main() {
entry:
  call void @printem(i32 42, i32 17, i32 192, i32 8)
  ret i32 0
}

define void @printem(i32 %a, i32 %b, i32 %c, i32 %d) {
entry:
  %a1 = alloca i32
  store i32 %a, i32* %a1
  %b2 = alloca i32
  store i32 %b, i32* %b2
  %c3 = alloca i32
  store i32 %c, i32* %c3
  %d4 = alloca i32
  store i32 %d, i32* %d4
  %a5 = load i32* %a1
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti1, i32 0, i32 0), i32 %a5)
  %b6 = load i32* %b2
  %printf7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti1, i32 0, i32 0), i32 %b6)
  %c8 = load i32* %c3
  %printf9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti1, i32 0, i32 0), i32 %c8)
  %d10 = load i32* %d4
  %printf11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti1, i32 0, i32 0), i32 %d10)
  ret void
}
