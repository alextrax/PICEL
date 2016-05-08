; ModuleID = 'PICEL'

@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@"str_./test/lena.bmp" = private unnamed_addr constant [16 x i8] c"./test/lena.bmp\00"
@str_test-conv2.bmp = private unnamed_addr constant [15 x i8] c"test-conv2.bmp\00"
@fmti1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmti3 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts4 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmti5 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts6 = private unnamed_addr constant [4 x i8] c"%s\0A\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

declare { i32, i32, i32, i8* } @newpic(i32, i32, ...)

declare i32 @delete_pic({ i32, i32, i32, i8* }*, ...)

define i32 @main() {
entry:
  %a = alloca { i32, i32, i32, i8* }
  %load = call { i32, i32, i32, i8* } (i8*, ...)* @load(i8* getelementptr inbounds ([16 x i8]* @"str_./test/lena.bmp", i32 0, i32 0))
  store { i32, i32, i32, i8* } %load, { i32, i32, i32, i8* }* %a
  %b = alloca [25 x i32]
  %c = alloca [25 x i32]
  %c_ptr = bitcast [25 x i32]* %b to i32*
  %elmt_addr = getelementptr inbounds i32* %c_ptr, i32 0
  store i32 0, i32* %elmt_addr
  %c_ptr1 = bitcast [25 x i32]* %b to i32*
  %elmt_addr2 = getelementptr inbounds i32* %c_ptr1, i32 1
  store i32 0, i32* %elmt_addr2
  %c_ptr3 = bitcast [25 x i32]* %b to i32*
  %elmt_addr4 = getelementptr inbounds i32* %c_ptr3, i32 2
  store i32 0, i32* %elmt_addr4
  %c_ptr5 = bitcast [25 x i32]* %b to i32*
  %elmt_addr6 = getelementptr inbounds i32* %c_ptr5, i32 3
  store i32 0, i32* %elmt_addr6
  %c_ptr7 = bitcast [25 x i32]* %b to i32*
  %elmt_addr8 = getelementptr inbounds i32* %c_ptr7, i32 4
  store i32 0, i32* %elmt_addr8
  %c_ptr9 = bitcast [25 x i32]* %b to i32*
  %elmt_addr10 = getelementptr inbounds i32* %c_ptr9, i32 5
  store i32 0, i32* %elmt_addr10
  %c_ptr11 = bitcast [25 x i32]* %b to i32*
  %elmt_addr12 = getelementptr inbounds i32* %c_ptr11, i32 6
  store i32 -1, i32* %elmt_addr12
  %c_ptr13 = bitcast [25 x i32]* %b to i32*
  %elmt_addr14 = getelementptr inbounds i32* %c_ptr13, i32 7
  store i32 -1, i32* %elmt_addr14
  %c_ptr15 = bitcast [25 x i32]* %b to i32*
  %elmt_addr16 = getelementptr inbounds i32* %c_ptr15, i32 8
  store i32 -1, i32* %elmt_addr16
  %c_ptr17 = bitcast [25 x i32]* %b to i32*
  %elmt_addr18 = getelementptr inbounds i32* %c_ptr17, i32 9
  store i32 0, i32* %elmt_addr18
  %c_ptr19 = bitcast [25 x i32]* %b to i32*
  %elmt_addr20 = getelementptr inbounds i32* %c_ptr19, i32 10
  store i32 0, i32* %elmt_addr20
  %c_ptr21 = bitcast [25 x i32]* %b to i32*
  %elmt_addr22 = getelementptr inbounds i32* %c_ptr21, i32 11
  store i32 -1, i32* %elmt_addr22
  %c_ptr23 = bitcast [25 x i32]* %b to i32*
  %elmt_addr24 = getelementptr inbounds i32* %c_ptr23, i32 12
  store i32 9, i32* %elmt_addr24
  %c_ptr25 = bitcast [25 x i32]* %b to i32*
  %elmt_addr26 = getelementptr inbounds i32* %c_ptr25, i32 13
  store i32 -1, i32* %elmt_addr26
  %c_ptr27 = bitcast [25 x i32]* %b to i32*
  %elmt_addr28 = getelementptr inbounds i32* %c_ptr27, i32 14
  store i32 0, i32* %elmt_addr28
  %c_ptr29 = bitcast [25 x i32]* %b to i32*
  %elmt_addr30 = getelementptr inbounds i32* %c_ptr29, i32 15
  store i32 0, i32* %elmt_addr30
  %c_ptr31 = bitcast [25 x i32]* %b to i32*
  %elmt_addr32 = getelementptr inbounds i32* %c_ptr31, i32 16
  store i32 -1, i32* %elmt_addr32
  %c_ptr33 = bitcast [25 x i32]* %b to i32*
  %elmt_addr34 = getelementptr inbounds i32* %c_ptr33, i32 17
  store i32 -1, i32* %elmt_addr34
  %c_ptr35 = bitcast [25 x i32]* %b to i32*
  %elmt_addr36 = getelementptr inbounds i32* %c_ptr35, i32 18
  store i32 -1, i32* %elmt_addr36
  %c_ptr37 = bitcast [25 x i32]* %b to i32*
  %elmt_addr38 = getelementptr inbounds i32* %c_ptr37, i32 19
  store i32 0, i32* %elmt_addr38
  %c_ptr39 = bitcast [25 x i32]* %b to i32*
  %elmt_addr40 = getelementptr inbounds i32* %c_ptr39, i32 20
  store i32 0, i32* %elmt_addr40
  %c_ptr41 = bitcast [25 x i32]* %b to i32*
  %elmt_addr42 = getelementptr inbounds i32* %c_ptr41, i32 21
  store i32 0, i32* %elmt_addr42
  %c_ptr43 = bitcast [25 x i32]* %b to i32*
  %elmt_addr44 = getelementptr inbounds i32* %c_ptr43, i32 22
  store i32 0, i32* %elmt_addr44
  %c_ptr45 = bitcast [25 x i32]* %b to i32*
  %elmt_addr46 = getelementptr inbounds i32* %c_ptr45, i32 23
  store i32 0, i32* %elmt_addr46
  %c_ptr47 = bitcast [25 x i32]* %b to i32*
  %elmt_addr48 = getelementptr inbounds i32* %c_ptr47, i32 24
  store i32 0, i32* %elmt_addr48
  %c_ptr49 = bitcast [25 x i32]* %c to i32*
  %elmt_addr50 = getelementptr inbounds i32* %c_ptr49, i32 0
  store i32 0, i32* %elmt_addr50
  %c_ptr51 = bitcast [25 x i32]* %c to i32*
  %elmt_addr52 = getelementptr inbounds i32* %c_ptr51, i32 1
  store i32 0, i32* %elmt_addr52
  %c_ptr53 = bitcast [25 x i32]* %c to i32*
  %elmt_addr54 = getelementptr inbounds i32* %c_ptr53, i32 2
  store i32 0, i32* %elmt_addr54
  %c_ptr55 = bitcast [25 x i32]* %c to i32*
  %elmt_addr56 = getelementptr inbounds i32* %c_ptr55, i32 3
  store i32 0, i32* %elmt_addr56
  %c_ptr57 = bitcast [25 x i32]* %c to i32*
  %elmt_addr58 = getelementptr inbounds i32* %c_ptr57, i32 4
  store i32 0, i32* %elmt_addr58
  %c_ptr59 = bitcast [25 x i32]* %c to i32*
  %elmt_addr60 = getelementptr inbounds i32* %c_ptr59, i32 5
  store i32 0, i32* %elmt_addr60
  %c_ptr61 = bitcast [25 x i32]* %c to i32*
  %elmt_addr62 = getelementptr inbounds i32* %c_ptr61, i32 6
  store i32 -1, i32* %elmt_addr62
  %c_ptr63 = bitcast [25 x i32]* %c to i32*
  %elmt_addr64 = getelementptr inbounds i32* %c_ptr63, i32 7
  store i32 -1, i32* %elmt_addr64
  %c_ptr65 = bitcast [25 x i32]* %c to i32*
  %elmt_addr66 = getelementptr inbounds i32* %c_ptr65, i32 8
  store i32 -1, i32* %elmt_addr66
  %c_ptr67 = bitcast [25 x i32]* %c to i32*
  %elmt_addr68 = getelementptr inbounds i32* %c_ptr67, i32 9
  store i32 0, i32* %elmt_addr68
  %c_ptr69 = bitcast [25 x i32]* %c to i32*
  %elmt_addr70 = getelementptr inbounds i32* %c_ptr69, i32 10
  store i32 0, i32* %elmt_addr70
  %c_ptr71 = bitcast [25 x i32]* %c to i32*
  %elmt_addr72 = getelementptr inbounds i32* %c_ptr71, i32 11
  store i32 -1, i32* %elmt_addr72
  %c_ptr73 = bitcast [25 x i32]* %c to i32*
  %elmt_addr74 = getelementptr inbounds i32* %c_ptr73, i32 12
  store i32 8, i32* %elmt_addr74
  %c_ptr75 = bitcast [25 x i32]* %c to i32*
  %elmt_addr76 = getelementptr inbounds i32* %c_ptr75, i32 13
  store i32 -1, i32* %elmt_addr76
  %c_ptr77 = bitcast [25 x i32]* %c to i32*
  %elmt_addr78 = getelementptr inbounds i32* %c_ptr77, i32 14
  store i32 0, i32* %elmt_addr78
  %c_ptr79 = bitcast [25 x i32]* %c to i32*
  %elmt_addr80 = getelementptr inbounds i32* %c_ptr79, i32 15
  store i32 0, i32* %elmt_addr80
  %c_ptr81 = bitcast [25 x i32]* %c to i32*
  %elmt_addr82 = getelementptr inbounds i32* %c_ptr81, i32 16
  store i32 -1, i32* %elmt_addr82
  %c_ptr83 = bitcast [25 x i32]* %c to i32*
  %elmt_addr84 = getelementptr inbounds i32* %c_ptr83, i32 17
  store i32 -1, i32* %elmt_addr84
  %c_ptr85 = bitcast [25 x i32]* %c to i32*
  %elmt_addr86 = getelementptr inbounds i32* %c_ptr85, i32 18
  store i32 -1, i32* %elmt_addr86
  %c_ptr87 = bitcast [25 x i32]* %c to i32*
  %elmt_addr88 = getelementptr inbounds i32* %c_ptr87, i32 19
  store i32 0, i32* %elmt_addr88
  %c_ptr89 = bitcast [25 x i32]* %c to i32*
  %elmt_addr90 = getelementptr inbounds i32* %c_ptr89, i32 20
  store i32 0, i32* %elmt_addr90
  %c_ptr91 = bitcast [25 x i32]* %c to i32*
  %elmt_addr92 = getelementptr inbounds i32* %c_ptr91, i32 21
  store i32 0, i32* %elmt_addr92
  %c_ptr93 = bitcast [25 x i32]* %c to i32*
  %elmt_addr94 = getelementptr inbounds i32* %c_ptr93, i32 22
  store i32 0, i32* %elmt_addr94
  %c_ptr95 = bitcast [25 x i32]* %c to i32*
  %elmt_addr96 = getelementptr inbounds i32* %c_ptr95, i32 23
  store i32 0, i32* %elmt_addr96
  %c_ptr97 = bitcast [25 x i32]* %c to i32*
  %elmt_addr98 = getelementptr inbounds i32* %c_ptr97, i32 24
  store i32 0, i32* %elmt_addr98
  %c99 = load [25 x i32]* %c
  %b100 = load [25 x i32]* %b
  %a101 = load { i32, i32, i32, i8* }* %a
  %convolution_result = call { i32, i32, i32, i8* } @convolution({ i32, i32, i32, i8* } %a101, [25 x i32] %b100)
  %convolution_result102 = call { i32, i32, i32, i8* } @convolution({ i32, i32, i32, i8* } %convolution_result, [25 x i32] %c99)
  %save_file = call i32 (i8*, { i32, i32, i32, i8* }*, ...)* @save_file(i8* getelementptr inbounds ([15 x i8]* @str_test-conv2.bmp, i32 0, i32 0), { i32, i32, i32, i8* }* %a)
  ret i32 0
}

define { i32, i32, i32, i8* } @convolution({ i32, i32, i32, i8* } %a, [25 x i32] %kernel) {
entry:
  %a1 = alloca { i32, i32, i32, i8* }
  store { i32, i32, i32, i8* } %a, { i32, i32, i32, i8* }* %a1
  %kernel2 = alloca [25 x i32]
  store [25 x i32] %kernel, [25 x i32]* %kernel2
  %temp = alloca { i32, i32, i32, i8* }
  %w = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w3 = load i32* %w
  %h = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h4 = load i32* %h
  %newpic = call { i32, i32, i32, i8* } (i32, i32, ...)* @newpic(i32 %h4, i32 %w3)
  store { i32, i32, i32, i8* } %newpic, { i32, i32, i32, i8* }* %temp
  %size = alloca i32
  store i32 5, i32* %size
  %s1 = alloca i32
  %size5 = load i32* %size
  %tmp = sdiv i32 %size5, 2
  store i32 %tmp, i32* %s1
  %r = alloca i32
  store i32 0, i32* %r
  %g = alloca i32
  store i32 0, i32* %g
  %b = alloca i32
  store i32 0, i32* %b
  %tempr = alloca i32
  %tempg = alloca i32
  %tempb = alloca i32
  %i1 = alloca i32
  %j1 = alloca i32
  %i = alloca i32
  %j = alloca i32
  %x = alloca i32
  %y = alloca i32
  %tot = alloca i32
  store i32 0, i32* %tot
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %merge, %entry
  %i19 = load i32* %i
  %size20 = load i32* %size
  %tmp21 = icmp slt i32 %i19, %size20
  br i1 %tmp21, label %while_body, label %merge22

while_body:                                       ; preds = %while
  store i32 0, i32* %j
  br label %while6

while6:                                           ; preds = %while_body7, %while_body
  %j14 = load i32* %j
  %size15 = load i32* %size
  %tmp16 = icmp slt i32 %j14, %size15
  br i1 %tmp16, label %while_body7, label %merge

while_body7:                                      ; preds = %while6
  %tot8 = load i32* %tot
  %i9 = load i32* %i
  %j10 = load i32* %j
  %x_mul_m = mul i32 %i9, 5
  %xm_add_y = add i32 %x_mul_m, %j10
  %c_ptr = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr = getelementptr inbounds i32* %c_ptr, i32 %xm_add_y
  %elmt = load i32* %elmt_addr
  %tmp11 = add i32 %tot8, %elmt
  store i32 %tmp11, i32* %tot
  %j12 = load i32* %j
  %tmp13 = add i32 %j12, 1
  store i32 %tmp13, i32* %j
  br label %while6

merge:                                            ; preds = %while6
  %i17 = load i32* %i
  %tmp18 = add i32 %i17, 1
  store i32 %tmp18, i32* %i
  br label %while

merge22:                                          ; preds = %while
  %tot23 = load i32* %tot
  %tmp24 = icmp eq i32 %tot23, 0
  br i1 %tmp24, label %then, label %else

merge25:                                          ; preds = %else, %then
  store i32 0, i32* %i
  br label %while26

then:                                             ; preds = %merge22
  store i32 1, i32* %tot
  br label %merge25

else:                                             ; preds = %merge22
  br label %merge25

while26:                                          ; preds = %merge253, %merge25
  %i256 = load i32* %i
  %h257 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h258 = load i32* %h257
  %tmp259 = icmp slt i32 %i256, %h258
  br i1 %tmp259, label %while_body27, label %merge260

while_body27:                                     ; preds = %while26
  store i32 0, i32* %j
  br label %while28

while28:                                          ; preds = %merge191, %while_body27
  %j249 = load i32* %j
  %w250 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w251 = load i32* %w250
  %tmp252 = icmp slt i32 %j249, %w251
  br i1 %tmp252, label %while_body29, label %merge253

while_body29:                                     ; preds = %while28
  store i32 0, i32* %tempb
  store i32 0, i32* %tempg
  store i32 0, i32* %tempr
  store i32 0, i32* %x
  br label %while30

while30:                                          ; preds = %merge185, %while_body29
  %x188 = load i32* %x
  %size189 = load i32* %size
  %tmp190 = icmp slt i32 %x188, %size189
  br i1 %tmp190, label %while_body31, label %merge191

while_body31:                                     ; preds = %while30
  store i32 0, i32* %y
  br label %while32

while32:                                          ; preds = %merge59, %while_body31
  %y182 = load i32* %y
  %size183 = load i32* %size
  %tmp184 = icmp slt i32 %y182, %size183
  br i1 %tmp184, label %while_body33, label %merge185

while_body33:                                     ; preds = %while32
  %i34 = load i32* %i
  %x35 = load i32* %x
  %tmp36 = add i32 %i34, %x35
  %s137 = load i32* %s1
  %tmp38 = sub i32 %tmp36, %s137
  store i32 %tmp38, i32* %i1
  %j39 = load i32* %j
  %y40 = load i32* %y
  %tmp41 = add i32 %j39, %y40
  %s142 = load i32* %s1
  %tmp43 = sub i32 %tmp41, %s142
  store i32 %tmp43, i32* %j1
  %i144 = load i32* %i1
  %tmp45 = icmp slt i32 %i144, 0
  %i146 = load i32* %i1
  %h47 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h48 = load i32* %h47
  %tmp49 = icmp sge i32 %i146, %h48
  %tmp50 = or i1 %tmp45, %tmp49
  %j151 = load i32* %j1
  %tmp52 = icmp slt i32 %j151, 0
  %tmp53 = or i1 %tmp50, %tmp52
  %j154 = load i32* %j1
  %w55 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w56 = load i32* %w55
  %tmp57 = icmp sge i32 %j154, %w56
  %tmp58 = or i1 %tmp53, %tmp57
  br i1 %tmp58, label %then60, label %else98

merge59:                                          ; preds = %else98, %then60
  %tempr147 = load i32* %tempr
  %r148 = load i32* %r
  %x149 = load i32* %x
  %y150 = load i32* %y
  %x_mul_m151 = mul i32 %x149, 5
  %xm_add_y152 = add i32 %x_mul_m151, %y150
  %c_ptr153 = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr154 = getelementptr inbounds i32* %c_ptr153, i32 %xm_add_y152
  %elmt155 = load i32* %elmt_addr154
  %tmp156 = mul i32 %r148, %elmt155
  %tmp157 = add i32 %tempr147, %tmp156
  store i32 %tmp157, i32* %tempr
  %tempg158 = load i32* %tempg
  %g159 = load i32* %g
  %x160 = load i32* %x
  %y161 = load i32* %y
  %x_mul_m162 = mul i32 %x160, 5
  %xm_add_y163 = add i32 %x_mul_m162, %y161
  %c_ptr164 = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr165 = getelementptr inbounds i32* %c_ptr164, i32 %xm_add_y163
  %elmt166 = load i32* %elmt_addr165
  %tmp167 = mul i32 %g159, %elmt166
  %tmp168 = add i32 %tempg158, %tmp167
  store i32 %tmp168, i32* %tempg
  %tempb169 = load i32* %tempb
  %b170 = load i32* %b
  %x171 = load i32* %x
  %y172 = load i32* %y
  %x_mul_m173 = mul i32 %x171, 5
  %xm_add_y174 = add i32 %x_mul_m173, %y172
  %c_ptr175 = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr176 = getelementptr inbounds i32* %c_ptr175, i32 %xm_add_y174
  %elmt177 = load i32* %elmt_addr176
  %tmp178 = mul i32 %b170, %elmt177
  %tmp179 = add i32 %tempb169, %tmp178
  store i32 %tmp179, i32* %tempb
  %y180 = load i32* %y
  %tmp181 = add i32 %y180, 1
  store i32 %tmp181, i32* %y
  br label %while32

then60:                                           ; preds = %while_body33
  %j61 = load i32* %j
  %i62 = load i32* %i
  %tmp_w = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w63 = load i32* %tmp_w
  %tmp_bpp = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp64 = load i32* %tmp_bpp
  %row_increment = mul i32 %tmp_w63, %tmp_bpp64
  %y_mul_rincre = mul i32 %i62, %row_increment
  %x_mul_bpp = mul i32 %j61, %tmp_bpp64
  %x_add_y = add i32 %y_mul_rincre, %x_mul_bpp
  %data_index = add i32 %x_add_y, 2
  %r65 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr = load i8** %r65
  %rgb_addr = getelementptr inbounds i8* %data_ptr, i32 %data_index
  %rgb_value = load i8* %rgb_addr
  %casted_value = zext i8 %rgb_value to i32
  store i32 %casted_value, i32* %r
  %j66 = load i32* %j
  %i67 = load i32* %i
  %tmp_w68 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w69 = load i32* %tmp_w68
  %tmp_bpp70 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp71 = load i32* %tmp_bpp70
  %row_increment72 = mul i32 %tmp_w69, %tmp_bpp71
  %y_mul_rincre73 = mul i32 %i67, %row_increment72
  %x_mul_bpp74 = mul i32 %j66, %tmp_bpp71
  %x_add_y75 = add i32 %y_mul_rincre73, %x_mul_bpp74
  %data_index76 = add i32 %x_add_y75, 1
  %g77 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr78 = load i8** %g77
  %rgb_addr79 = getelementptr inbounds i8* %data_ptr78, i32 %data_index76
  %rgb_value80 = load i8* %rgb_addr79
  %casted_value81 = zext i8 %rgb_value80 to i32
  store i32 %casted_value81, i32* %g
  %j82 = load i32* %j
  %i83 = load i32* %i
  %tmp_w84 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w85 = load i32* %tmp_w84
  %tmp_bpp86 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp87 = load i32* %tmp_bpp86
  %row_increment88 = mul i32 %tmp_w85, %tmp_bpp87
  %y_mul_rincre89 = mul i32 %i83, %row_increment88
  %x_mul_bpp90 = mul i32 %j82, %tmp_bpp87
  %x_add_y91 = add i32 %y_mul_rincre89, %x_mul_bpp90
  %data_index92 = add i32 %x_add_y91, 0
  %b93 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr94 = load i8** %b93
  %rgb_addr95 = getelementptr inbounds i8* %data_ptr94, i32 %data_index92
  %rgb_value96 = load i8* %rgb_addr95
  %casted_value97 = zext i8 %rgb_value96 to i32
  store i32 %casted_value97, i32* %b
  br label %merge59

else98:                                           ; preds = %while_body33
  %j199 = load i32* %j1
  %i1100 = load i32* %i1
  %tmp_w101 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w102 = load i32* %tmp_w101
  %tmp_bpp103 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp104 = load i32* %tmp_bpp103
  %row_increment105 = mul i32 %tmp_w102, %tmp_bpp104
  %y_mul_rincre106 = mul i32 %i1100, %row_increment105
  %x_mul_bpp107 = mul i32 %j199, %tmp_bpp104
  %x_add_y108 = add i32 %y_mul_rincre106, %x_mul_bpp107
  %data_index109 = add i32 %x_add_y108, 2
  %r110 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr111 = load i8** %r110
  %rgb_addr112 = getelementptr inbounds i8* %data_ptr111, i32 %data_index109
  %rgb_value113 = load i8* %rgb_addr112
  %casted_value114 = zext i8 %rgb_value113 to i32
  store i32 %casted_value114, i32* %r
  %j1115 = load i32* %j1
  %i1116 = load i32* %i1
  %tmp_w117 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w118 = load i32* %tmp_w117
  %tmp_bpp119 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp120 = load i32* %tmp_bpp119
  %row_increment121 = mul i32 %tmp_w118, %tmp_bpp120
  %y_mul_rincre122 = mul i32 %i1116, %row_increment121
  %x_mul_bpp123 = mul i32 %j1115, %tmp_bpp120
  %x_add_y124 = add i32 %y_mul_rincre122, %x_mul_bpp123
  %data_index125 = add i32 %x_add_y124, 1
  %g126 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr127 = load i8** %g126
  %rgb_addr128 = getelementptr inbounds i8* %data_ptr127, i32 %data_index125
  %rgb_value129 = load i8* %rgb_addr128
  %casted_value130 = zext i8 %rgb_value129 to i32
  store i32 %casted_value130, i32* %g
  %j1131 = load i32* %j1
  %i1132 = load i32* %i1
  %tmp_w133 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w134 = load i32* %tmp_w133
  %tmp_bpp135 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp136 = load i32* %tmp_bpp135
  %row_increment137 = mul i32 %tmp_w134, %tmp_bpp136
  %y_mul_rincre138 = mul i32 %i1132, %row_increment137
  %x_mul_bpp139 = mul i32 %j1131, %tmp_bpp136
  %x_add_y140 = add i32 %y_mul_rincre138, %x_mul_bpp139
  %data_index141 = add i32 %x_add_y140, 0
  %b142 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr143 = load i8** %b142
  %rgb_addr144 = getelementptr inbounds i8* %data_ptr143, i32 %data_index141
  %rgb_value145 = load i8* %rgb_addr144
  %casted_value146 = zext i8 %rgb_value145 to i32
  store i32 %casted_value146, i32* %b
  br label %merge59

merge185:                                         ; preds = %while32
  %x186 = load i32* %x
  %tmp187 = add i32 %x186, 1
  store i32 %tmp187, i32* %x
  br label %while30

merge191:                                         ; preds = %while30
  %j192 = load i32* %j
  %i193 = load i32* %i
  %tempr194 = load i32* %tempr
  %tot195 = load i32* %tot
  %tmp196 = sdiv i32 %tempr194, %tot195
  %bound_result = call i32 @bound(i32 %tmp196)
  %tmp_w197 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w198 = load i32* %tmp_w197
  %tmp_bpp199 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp200 = load i32* %tmp_bpp199
  %row_increment201 = mul i32 %tmp_w198, %tmp_bpp200
  %y_mul_rincre202 = mul i32 %i193, %row_increment201
  %x_mul_bpp203 = mul i32 %j192, %tmp_bpp200
  %x_add_y204 = add i32 %y_mul_rincre202, %x_mul_bpp203
  %data_index205 = add i32 %x_add_y204, 2
  %r206 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr207 = load i8** %r206
  %char_RGB = trunc i32 %bound_result to i8
  %rgb_addr208 = getelementptr inbounds i8* %data_ptr207, i32 %data_index205
  store i8 %char_RGB, i8* %rgb_addr208
  %j209 = load i32* %j
  %i210 = load i32* %i
  %tempg211 = load i32* %tempg
  %tot212 = load i32* %tot
  %tmp213 = sdiv i32 %tempg211, %tot212
  %bound_result214 = call i32 @bound(i32 %tmp213)
  %tmp_w215 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w216 = load i32* %tmp_w215
  %tmp_bpp217 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp218 = load i32* %tmp_bpp217
  %row_increment219 = mul i32 %tmp_w216, %tmp_bpp218
  %y_mul_rincre220 = mul i32 %i210, %row_increment219
  %x_mul_bpp221 = mul i32 %j209, %tmp_bpp218
  %x_add_y222 = add i32 %y_mul_rincre220, %x_mul_bpp221
  %data_index223 = add i32 %x_add_y222, 1
  %g224 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr225 = load i8** %g224
  %char_RGB226 = trunc i32 %bound_result214 to i8
  %rgb_addr227 = getelementptr inbounds i8* %data_ptr225, i32 %data_index223
  store i8 %char_RGB226, i8* %rgb_addr227
  %j228 = load i32* %j
  %i229 = load i32* %i
  %tempb230 = load i32* %tempb
  %tot231 = load i32* %tot
  %tmp232 = sdiv i32 %tempb230, %tot231
  %bound_result233 = call i32 @bound(i32 %tmp232)
  %tmp_w234 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w235 = load i32* %tmp_w234
  %tmp_bpp236 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp237 = load i32* %tmp_bpp236
  %row_increment238 = mul i32 %tmp_w235, %tmp_bpp237
  %y_mul_rincre239 = mul i32 %i229, %row_increment238
  %x_mul_bpp240 = mul i32 %j228, %tmp_bpp237
  %x_add_y241 = add i32 %y_mul_rincre239, %x_mul_bpp240
  %data_index242 = add i32 %x_add_y241, 0
  %b243 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr244 = load i8** %b243
  %char_RGB245 = trunc i32 %bound_result233 to i8
  %rgb_addr246 = getelementptr inbounds i8* %data_ptr244, i32 %data_index242
  store i8 %char_RGB245, i8* %rgb_addr246
  %j247 = load i32* %j
  %tmp248 = add i32 %j247, 1
  store i32 %tmp248, i32* %j
  br label %while28

merge253:                                         ; preds = %while28
  %i254 = load i32* %i
  %tmp255 = add i32 %i254, 1
  store i32 %tmp255, i32* %i
  br label %while26

merge260:                                         ; preds = %while26
  store i32 0, i32* %i
  br label %while261

while261:                                         ; preds = %merge358, %merge260
  %i361 = load i32* %i
  %h362 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h363 = load i32* %h362
  %tmp364 = icmp slt i32 %i361, %h363
  br i1 %tmp364, label %while_body262, label %merge365

while_body262:                                    ; preds = %while261
  store i32 0, i32* %j
  br label %while263

while263:                                         ; preds = %while_body264, %while_body262
  %j354 = load i32* %j
  %w355 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w356 = load i32* %w355
  %tmp357 = icmp slt i32 %j354, %w356
  br i1 %tmp357, label %while_body264, label %merge358

while_body264:                                    ; preds = %while263
  %j265 = load i32* %j
  %i266 = load i32* %i
  %j267 = load i32* %j
  %i268 = load i32* %i
  %tmp_w269 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w270 = load i32* %tmp_w269
  %tmp_bpp271 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp272 = load i32* %tmp_bpp271
  %row_increment273 = mul i32 %tmp_w270, %tmp_bpp272
  %y_mul_rincre274 = mul i32 %i268, %row_increment273
  %x_mul_bpp275 = mul i32 %j267, %tmp_bpp272
  %x_add_y276 = add i32 %y_mul_rincre274, %x_mul_bpp275
  %data_index277 = add i32 %x_add_y276, 2
  %r278 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr279 = load i8** %r278
  %rgb_addr280 = getelementptr inbounds i8* %data_ptr279, i32 %data_index277
  %rgb_value281 = load i8* %rgb_addr280
  %tmp_w282 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w283 = load i32* %tmp_w282
  %tmp_bpp284 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp285 = load i32* %tmp_bpp284
  %row_increment286 = mul i32 %tmp_w283, %tmp_bpp285
  %y_mul_rincre287 = mul i32 %i266, %row_increment286
  %x_mul_bpp288 = mul i32 %j265, %tmp_bpp285
  %x_add_y289 = add i32 %y_mul_rincre287, %x_mul_bpp288
  %data_index290 = add i32 %x_add_y289, 2
  %r291 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr292 = load i8** %r291
  %rgb_addr293 = getelementptr inbounds i8* %data_ptr292, i32 %data_index290
  store i8 %rgb_value281, i8* %rgb_addr293
  %j294 = load i32* %j
  %i295 = load i32* %i
  %j296 = load i32* %j
  %i297 = load i32* %i
  %tmp_w298 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w299 = load i32* %tmp_w298
  %tmp_bpp300 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp301 = load i32* %tmp_bpp300
  %row_increment302 = mul i32 %tmp_w299, %tmp_bpp301
  %y_mul_rincre303 = mul i32 %i297, %row_increment302
  %x_mul_bpp304 = mul i32 %j296, %tmp_bpp301
  %x_add_y305 = add i32 %y_mul_rincre303, %x_mul_bpp304
  %data_index306 = add i32 %x_add_y305, 1
  %g307 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr308 = load i8** %g307
  %rgb_addr309 = getelementptr inbounds i8* %data_ptr308, i32 %data_index306
  %rgb_value310 = load i8* %rgb_addr309
  %tmp_w311 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w312 = load i32* %tmp_w311
  %tmp_bpp313 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp314 = load i32* %tmp_bpp313
  %row_increment315 = mul i32 %tmp_w312, %tmp_bpp314
  %y_mul_rincre316 = mul i32 %i295, %row_increment315
  %x_mul_bpp317 = mul i32 %j294, %tmp_bpp314
  %x_add_y318 = add i32 %y_mul_rincre316, %x_mul_bpp317
  %data_index319 = add i32 %x_add_y318, 1
  %g320 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr321 = load i8** %g320
  %rgb_addr322 = getelementptr inbounds i8* %data_ptr321, i32 %data_index319
  store i8 %rgb_value310, i8* %rgb_addr322
  %j323 = load i32* %j
  %i324 = load i32* %i
  %j325 = load i32* %j
  %i326 = load i32* %i
  %tmp_w327 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w328 = load i32* %tmp_w327
  %tmp_bpp329 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp330 = load i32* %tmp_bpp329
  %row_increment331 = mul i32 %tmp_w328, %tmp_bpp330
  %y_mul_rincre332 = mul i32 %i326, %row_increment331
  %x_mul_bpp333 = mul i32 %j325, %tmp_bpp330
  %x_add_y334 = add i32 %y_mul_rincre332, %x_mul_bpp333
  %data_index335 = add i32 %x_add_y334, 0
  %b336 = getelementptr inbounds { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr337 = load i8** %b336
  %rgb_addr338 = getelementptr inbounds i8* %data_ptr337, i32 %data_index335
  %rgb_value339 = load i8* %rgb_addr338
  %tmp_w340 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w341 = load i32* %tmp_w340
  %tmp_bpp342 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp343 = load i32* %tmp_bpp342
  %row_increment344 = mul i32 %tmp_w341, %tmp_bpp343
  %y_mul_rincre345 = mul i32 %i324, %row_increment344
  %x_mul_bpp346 = mul i32 %j323, %tmp_bpp343
  %x_add_y347 = add i32 %y_mul_rincre345, %x_mul_bpp346
  %data_index348 = add i32 %x_add_y347, 0
  %b349 = getelementptr inbounds { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr350 = load i8** %b349
  %rgb_addr351 = getelementptr inbounds i8* %data_ptr350, i32 %data_index348
  store i8 %rgb_value339, i8* %rgb_addr351
  %j352 = load i32* %j
  %tmp353 = add i32 %j352, 1
  store i32 %tmp353, i32* %j
  br label %while263

merge358:                                         ; preds = %while263
  %i359 = load i32* %i
  %tmp360 = add i32 %i359, 1
  store i32 %tmp360, i32* %i
  br label %while261

merge365:                                         ; preds = %while261
  %temp366 = load { i32, i32, i32, i8* }* %temp
  %delete_pic = call i32 ({ i32, i32, i32, i8* }*, ...)* @delete_pic({ i32, i32, i32, i8* }* %temp)
  %a367 = load { i32, i32, i32, i8* }* %a1
  ret { i32, i32, i32, i8* } %a367
}

define i32 @bound(i32 %input) {
entry:
  %input1 = alloca i32
  store i32 %input, i32* %input1
  %input2 = load i32* %input1
  %tmp = icmp slt i32 %input2, 0
  br i1 %tmp, label %then, label %else

merge:                                            ; preds = %merge5
  ret i32 0

then:                                             ; preds = %entry
  ret i32 0

else:                                             ; preds = %entry
  %input3 = load i32* %input1
  %tmp4 = icmp sgt i32 %input3, 255
  br i1 %tmp4, label %then6, label %else7

merge5:                                           ; No predecessors!
  br label %merge

then6:                                            ; preds = %else
  ret i32 255

else7:                                            ; preds = %else
  %input8 = load i32* %input1
  ret i32 %input8
}

define void @copy_pic({ i32, i32, i32, i8* } %src, { i32, i32, i32, i8* } %dst) {
entry:
  %src1 = alloca { i32, i32, i32, i8* }
  store { i32, i32, i32, i8* } %src, { i32, i32, i32, i8* }* %src1
  %dst2 = alloca { i32, i32, i32, i8* }
  store { i32, i32, i32, i8* } %dst, { i32, i32, i32, i8* }* %dst2
  %i = alloca i32
  %j = alloca i32
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %merge, %entry
  %i85 = load i32* %i
  %h = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 1
  %h86 = load i32* %h
  %tmp87 = icmp slt i32 %i85, %h86
  br i1 %tmp87, label %while_body, label %merge88

while_body:                                       ; preds = %while
  store i32 0, i32* %j
  br label %while3

while3:                                           ; preds = %while_body4, %while_body
  %j80 = load i32* %j
  %w = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %w81 = load i32* %w
  %tmp82 = icmp slt i32 %j80, %w81
  br i1 %tmp82, label %while_body4, label %merge

while_body4:                                      ; preds = %while3
  %j5 = load i32* %j
  %i6 = load i32* %i
  %j7 = load i32* %j
  %i8 = load i32* %i
  %tmp_w = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %tmp_w9 = load i32* %tmp_w
  %tmp_bpp = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 2
  %tmp_bpp10 = load i32* %tmp_bpp
  %row_increment = mul i32 %tmp_w9, %tmp_bpp10
  %y_mul_rincre = mul i32 %i8, %row_increment
  %x_mul_bpp = mul i32 %j7, %tmp_bpp10
  %x_add_y = add i32 %y_mul_rincre, %x_mul_bpp
  %data_index = add i32 %x_add_y, 2
  %r = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 3
  %data_ptr = load i8** %r
  %rgb_addr = getelementptr inbounds i8* %data_ptr, i32 %data_index
  %rgb_value = load i8* %rgb_addr
  %tmp_w11 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 0
  %tmp_w12 = load i32* %tmp_w11
  %tmp_bpp13 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 2
  %tmp_bpp14 = load i32* %tmp_bpp13
  %row_increment15 = mul i32 %tmp_w12, %tmp_bpp14
  %y_mul_rincre16 = mul i32 %i6, %row_increment15
  %x_mul_bpp17 = mul i32 %j5, %tmp_bpp14
  %x_add_y18 = add i32 %y_mul_rincre16, %x_mul_bpp17
  %data_index19 = add i32 %x_add_y18, 2
  %r20 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 3
  %data_ptr21 = load i8** %r20
  %rgb_addr22 = getelementptr inbounds i8* %data_ptr21, i32 %data_index19
  store i8 %rgb_value, i8* %rgb_addr22
  %j23 = load i32* %j
  %i24 = load i32* %i
  %j25 = load i32* %j
  %i26 = load i32* %i
  %tmp_w27 = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %tmp_w28 = load i32* %tmp_w27
  %tmp_bpp29 = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 2
  %tmp_bpp30 = load i32* %tmp_bpp29
  %row_increment31 = mul i32 %tmp_w28, %tmp_bpp30
  %y_mul_rincre32 = mul i32 %i26, %row_increment31
  %x_mul_bpp33 = mul i32 %j25, %tmp_bpp30
  %x_add_y34 = add i32 %y_mul_rincre32, %x_mul_bpp33
  %data_index35 = add i32 %x_add_y34, 1
  %g = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 3
  %data_ptr36 = load i8** %g
  %rgb_addr37 = getelementptr inbounds i8* %data_ptr36, i32 %data_index35
  %rgb_value38 = load i8* %rgb_addr37
  %tmp_w39 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 0
  %tmp_w40 = load i32* %tmp_w39
  %tmp_bpp41 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 2
  %tmp_bpp42 = load i32* %tmp_bpp41
  %row_increment43 = mul i32 %tmp_w40, %tmp_bpp42
  %y_mul_rincre44 = mul i32 %i24, %row_increment43
  %x_mul_bpp45 = mul i32 %j23, %tmp_bpp42
  %x_add_y46 = add i32 %y_mul_rincre44, %x_mul_bpp45
  %data_index47 = add i32 %x_add_y46, 1
  %g48 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 3
  %data_ptr49 = load i8** %g48
  %rgb_addr50 = getelementptr inbounds i8* %data_ptr49, i32 %data_index47
  store i8 %rgb_value38, i8* %rgb_addr50
  %j51 = load i32* %j
  %i52 = load i32* %i
  %j53 = load i32* %j
  %i54 = load i32* %i
  %tmp_w55 = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %tmp_w56 = load i32* %tmp_w55
  %tmp_bpp57 = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 2
  %tmp_bpp58 = load i32* %tmp_bpp57
  %row_increment59 = mul i32 %tmp_w56, %tmp_bpp58
  %y_mul_rincre60 = mul i32 %i54, %row_increment59
  %x_mul_bpp61 = mul i32 %j53, %tmp_bpp58
  %x_add_y62 = add i32 %y_mul_rincre60, %x_mul_bpp61
  %data_index63 = add i32 %x_add_y62, 0
  %b = getelementptr inbounds { i32, i32, i32, i8* }* %src1, i32 0, i32 3
  %data_ptr64 = load i8** %b
  %rgb_addr65 = getelementptr inbounds i8* %data_ptr64, i32 %data_index63
  %rgb_value66 = load i8* %rgb_addr65
  %tmp_w67 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 0
  %tmp_w68 = load i32* %tmp_w67
  %tmp_bpp69 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 2
  %tmp_bpp70 = load i32* %tmp_bpp69
  %row_increment71 = mul i32 %tmp_w68, %tmp_bpp70
  %y_mul_rincre72 = mul i32 %i52, %row_increment71
  %x_mul_bpp73 = mul i32 %j51, %tmp_bpp70
  %x_add_y74 = add i32 %y_mul_rincre72, %x_mul_bpp73
  %data_index75 = add i32 %x_add_y74, 0
  %b76 = getelementptr inbounds { i32, i32, i32, i8* }* %dst2, i32 0, i32 3
  %data_ptr77 = load i8** %b76
  %rgb_addr78 = getelementptr inbounds i8* %data_ptr77, i32 %data_index75
  store i8 %rgb_value66, i8* %rgb_addr78
  %j79 = load i32* %j
  %tmp = add i32 %j79, 1
  store i32 %tmp, i32* %j
  br label %while3

merge:                                            ; preds = %while3
  %i83 = load i32* %i
  %tmp84 = add i32 %i83, 1
  store i32 %tmp84, i32* %i
  br label %while

merge88:                                          ; preds = %while
  ret void
}
