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
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 3)
  %printf1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 -1)
  %printf2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 2)
  %printf3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 50)
  %printf4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 99)
  %printf5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 false)
  %printf6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 99)
  %printf8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 false)
  %printf10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 99)
  %printf11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 false)
  %printf13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 99)
  %printf14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 false)
  %printf17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 99)
  %printf18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 false)
  %printf19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 99)
  %printf21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 false)
  %printf22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  %printf23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i1 true)
  ret i32 0
}
