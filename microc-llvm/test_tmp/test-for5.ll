; ModuleID = 'PICEL'

@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@"str_first loop:" = private unnamed_addr constant [12 x i8] c"first loop:\00"
@"str_second loop:" = private unnamed_addr constant [13 x i8] c"second loop:\00"
@"str_third loop:" = private unnamed_addr constant [12 x i8] c"third loop:\00"
@"str_count:" = private unnamed_addr constant [7 x i8] c"count:\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

declare { i32, i32, i32, i8* } @newpic(i32, i32, ...)

declare i32 @delete_pic({ i32, i32, i32, i8* }*, ...)

define i32 @main() {
entry:
  %count = alloca i32
  store i32 0, i32* %count
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %merge28, %entry
  %i31 = load i32* %i
  %tmp32 = icmp slt i32 %i31, 2
  br i1 %tmp32, label %while_body, label %merge33

while_body:                                       ; preds = %while
  %printf = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8]* @"str_first loop:", i32 0, i32 0))
  %i1 = load i32* %i
  %printf2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %i1)
  %count3 = load i32* %count
  %tmp = add i32 %count3, 1
  store i32 %tmp, i32* %count
  %i4 = alloca i32
  store i32 2, i32* %i4
  br label %while5

while5:                                           ; preds = %merge, %while_body
  %i26 = load i32* %i4
  %tmp27 = icmp slt i32 %i26, 4
  br i1 %tmp27, label %while_body6, label %merge28

while_body6:                                      ; preds = %while5
  %printf7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8]* @"str_second loop:", i32 0, i32 0))
  %i8 = load i32* %i4
  %printf9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %i8)
  %count10 = load i32* %count
  %tmp11 = add i32 %count10, 1
  store i32 %tmp11, i32* %count
  %i12 = alloca i32
  store i32 4, i32* %i12
  br label %while13

while13:                                          ; preds = %while_body14, %while_body6
  %i22 = load i32* %i12
  %tmp23 = icmp slt i32 %i22, 6
  br i1 %tmp23, label %while_body14, label %merge

while_body14:                                     ; preds = %while13
  %printf15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8]* @"str_third loop:", i32 0, i32 0))
  %i16 = load i32* %i12
  %printf17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %i16)
  %count18 = load i32* %count
  %tmp19 = add i32 %count18, 1
  store i32 %tmp19, i32* %count
  %i20 = load i32* %i12
  %tmp21 = add i32 %i20, 1
  store i32 %tmp21, i32* %i12
  br label %while13

merge:                                            ; preds = %while13
  %i24 = load i32* %i4
  %tmp25 = add i32 %i24, 1
  store i32 %tmp25, i32* %i4
  br label %while5

merge28:                                          ; preds = %while5
  %i29 = load i32* %i
  %tmp30 = add i32 %i29, 1
  store i32 %tmp30, i32* %i
  br label %while

merge33:                                          ; preds = %while
  %printf34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmts, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8]* @"str_count:", i32 0, i32 0))
  %count35 = load i32* %count
  %printf36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @fmti, i32 0, i32 0), i32 %count35)
  ret i32 0
}
