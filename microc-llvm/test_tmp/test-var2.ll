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
  %a = alloca { i32, i32, i32, i8* }
  ret i32 0
}