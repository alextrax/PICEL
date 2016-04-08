; ModuleID = 'PICEL'

@a = global { i32, i32, i32, i8* } zeroinitializer
@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@tmp = private unnamed_addr constant [12 x i8] c"Hello_world\00"
@tmp.1 = private unnamed_addr constant [5 x i8] c"test\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }, ...)

declare i32 @save_file({ i32, i32, i32, i8* }, i8*, ...)

define i32 @main() {
entry:
  %a = load { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* @a
  %save_file = call i32 ({ i32, i32, i32, i8* }, i8*, ...) @save_file({ i32, i32, i32, i8* } %a, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @tmp, i32 0, i32 0))
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @tmp.1, i32 0, i32 0))
  ret i32 0
}
