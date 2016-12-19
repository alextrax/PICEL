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
  call void @foo(i1 true)
  ret i32 0
}

define void @foo(i1 %i) {
entry:
  %i1 = alloca i1
  store i1 %i, i1* %i1
  %i2 = alloca i32
  store i32 42, i32* %i2
  %i3 = load i32* %i2
  %i4 = load i32* %i2
  %tmp = add i32 %i3, %i4
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti1, i32 0, i32 0), i32 %tmp)
  ret void
}
