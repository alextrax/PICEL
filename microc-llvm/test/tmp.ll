; ModuleID = 'PICEL'

@kernel = global [25 x i32] zeroinitializer
@fmti = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@str_MARBLES.bmp = private unnamed_addr constant [12 x i8] c"MARBLES.bmp\00"
@str_a_conv.bmp = private unnamed_addr constant [11 x i8] c"a_conv.bmp\00"
@fmti.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts.2 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmti.3 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts.4 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@fmti.5 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@fmts.6 = private unnamed_addr constant [4 x i8] c"%s\0A\00"

declare i32 @printf(i8*, ...)

declare { i32, i32, i32, i8* } @load(i8*, ...)

declare i32 @save({ i32, i32, i32, i8* }*, ...)

declare i32 @save_file(i8*, { i32, i32, i32, i8* }*, ...)

declare { i32, i32, i32, i8* } @newpic(i32, i32, ...)

define i32 @main() {
entry:
  %a = alloca { i32, i32, i32, i8* }
  %b = alloca { i32, i32, i32, i8* }
  %load = call { i32, i32, i32, i8* } (i8*, ...) @load(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @str_MARBLES.bmp, i32 0, i32 0))
  store { i32, i32, i32, i8* } %load, { i32, i32, i32, i8* }* %a
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 12)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 7)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 17)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 11)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 13)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 8)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 16)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 6)
  store i32 1, i32* getelementptr inbounds ([25 x i32], [25 x i32]* @kernel, i32 0, i32 18)
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

while:                                            ; preds = %while_body, %entry
  %i3 = load i32, i32* %i
  %tmp4 = icmp slt i32 %i3, 10
  br i1 %tmp4, label %while_body, label %merge

while_body:                                       ; preds = %while
  %kernel = load [25 x i32], [25 x i32]* @kernel
  %a1 = load { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a
  %convolution_result = call i32 @convolution({ i32, i32, i32, i8* } %a1, [25 x i32] %kernel)
  %i2 = load i32, i32* %i
  %tmp = add i32 %i2, 1
  store i32 %tmp, i32* %i
  br label %while

merge:                                            ; preds = %while
  %save_file = call i32 (i8*, { i32, i32, i32, i8* }*, ...) @save_file(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @str_a_conv.bmp, i32 0, i32 0), { i32, i32, i32, i8* }* %a)
  ret i32 0
}

define i32 @convolution({ i32, i32, i32, i8* } %a, [25 x i32] %kernel) {
entry:
  %a1 = alloca { i32, i32, i32, i8* }
  store { i32, i32, i32, i8* } %a, { i32, i32, i32, i8* }* %a1
  %kernel2 = alloca [25 x i32]
  store [25 x i32] %kernel, [25 x i32]* %kernel2
  %temp = alloca { i32, i32, i32, i8* }
  %h = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h3 = load i32, i32* %h
  %w = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w4 = load i32, i32* %w
  %newpic = call { i32, i32, i32, i8* } (i32, i32, ...) @newpic(i32 %w4, i32 %h3)
  store { i32, i32, i32, i8* } %newpic, { i32, i32, i32, i8* }* %temp
  %size = alloca i32
  store i32 5, i32* %size
  %s1 = alloca i32
  %size5 = load i32, i32* %size
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
  %i19 = load i32, i32* %i
  %size20 = load i32, i32* %size
  %tmp21 = icmp slt i32 %i19, %size20
  br i1 %tmp21, label %while_body, label %merge22

while_body:                                       ; preds = %while
  store i32 0, i32* %j
  br label %while6

while6:                                           ; preds = %while_body7, %while_body
  %j14 = load i32, i32* %j
  %size15 = load i32, i32* %size
  %tmp16 = icmp slt i32 %j14, %size15
  br i1 %tmp16, label %while_body7, label %merge

while_body7:                                      ; preds = %while6
  %tot8 = load i32, i32* %tot
  %i9 = load i32, i32* %i
  %j10 = load i32, i32* %j
  %x_mul_m = mul i32 %i9, 5
  %xm_add_y = add i32 %x_mul_m, %j10
  %c_ptr = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr = getelementptr inbounds i32, i32* %c_ptr, i32 %xm_add_y
  %elmt = load i32, i32* %elmt_addr
  %tmp11 = add i32 %tot8, %elmt
  store i32 %tmp11, i32* %tot
  %j12 = load i32, i32* %j
  %tmp13 = add i32 %j12, 1
  store i32 %tmp13, i32* %j
  br label %while6

merge:                                            ; preds = %while6
  %i17 = load i32, i32* %i
  %tmp18 = add i32 %i17, 1
  store i32 %tmp18, i32* %i
  br label %while

merge22:                                          ; preds = %while
  %tot23 = load i32, i32* %tot
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

while26:                                          ; preds = %merge270, %merge25
  %i273 = load i32, i32* %i
  %w274 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w275 = load i32, i32* %w274
  %tmp276 = icmp slt i32 %i273, %w275
  br i1 %tmp276, label %while_body27, label %merge277

while_body27:                                     ; preds = %while26
  store i32 0, i32* %j
  br label %while28

while28:                                          ; preds = %merge202, %while_body27
  %j266 = load i32, i32* %j
  %h267 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h268 = load i32, i32* %h267
  %tmp269 = icmp slt i32 %j266, %h268
  br i1 %tmp269, label %while_body29, label %merge270

while_body29:                                     ; preds = %while28
  store i32 0, i32* %tempb
  store i32 0, i32* %tempg
  store i32 0, i32* %tempr
  store i32 0, i32* %x
  br label %while30

while30:                                          ; preds = %merge196, %while_body29
  %x199 = load i32, i32* %x
  %size200 = load i32, i32* %size
  %tmp201 = icmp slt i32 %x199, %size200
  br i1 %tmp201, label %while_body31, label %merge202

while_body31:                                     ; preds = %while30
  store i32 0, i32* %y
  br label %while32

while32:                                          ; preds = %merge59, %while_body31
  %y193 = load i32, i32* %y
  %size194 = load i32, i32* %size
  %tmp195 = icmp slt i32 %y193, %size194
  br i1 %tmp195, label %while_body33, label %merge196

while_body33:                                     ; preds = %while32
  %i34 = load i32, i32* %i
  %x35 = load i32, i32* %x
  %tmp36 = add i32 %i34, %x35
  %s137 = load i32, i32* %s1
  %tmp38 = sub i32 %tmp36, %s137
  store i32 %tmp38, i32* %i1
  %j39 = load i32, i32* %j
  %y40 = load i32, i32* %y
  %tmp41 = add i32 %j39, %y40
  %s142 = load i32, i32* %s1
  %tmp43 = sub i32 %tmp41, %s142
  store i32 %tmp43, i32* %j1
  %i144 = load i32, i32* %i1
  %tmp45 = icmp slt i32 %i144, 0
  %i146 = load i32, i32* %i1
  %w47 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w48 = load i32, i32* %w47
  %tmp49 = icmp sge i32 %i146, %w48
  %tmp50 = or i1 %tmp45, %tmp49
  %j151 = load i32, i32* %j1
  %tmp52 = icmp slt i32 %j151, 0
  %tmp53 = or i1 %tmp50, %tmp52
  %j154 = load i32, i32* %j1
  %h55 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h56 = load i32, i32* %h55
  %tmp57 = icmp sge i32 %j154, %h56
  %tmp58 = or i1 %tmp53, %tmp57
  br i1 %tmp58, label %then60, label %else103

merge59:                                          ; preds = %else103, %then60
  %tempr158 = load i32, i32* %tempr
  %r159 = load i32, i32* %r
  %x160 = load i32, i32* %x
  %y161 = load i32, i32* %y
  %x_mul_m162 = mul i32 %x160, 5
  %xm_add_y163 = add i32 %x_mul_m162, %y161
  %c_ptr164 = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr165 = getelementptr inbounds i32, i32* %c_ptr164, i32 %xm_add_y163
  %elmt166 = load i32, i32* %elmt_addr165
  %tmp167 = mul i32 %r159, %elmt166
  %tmp168 = add i32 %tempr158, %tmp167
  store i32 %tmp168, i32* %tempr
  %tempg169 = load i32, i32* %tempg
  %g170 = load i32, i32* %g
  %x171 = load i32, i32* %x
  %y172 = load i32, i32* %y
  %x_mul_m173 = mul i32 %x171, 5
  %xm_add_y174 = add i32 %x_mul_m173, %y172
  %c_ptr175 = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr176 = getelementptr inbounds i32, i32* %c_ptr175, i32 %xm_add_y174
  %elmt177 = load i32, i32* %elmt_addr176
  %tmp178 = mul i32 %g170, %elmt177
  %tmp179 = add i32 %tempg169, %tmp178
  store i32 %tmp179, i32* %tempg
  %tempb180 = load i32, i32* %tempb
  %b181 = load i32, i32* %b
  %x182 = load i32, i32* %x
  %y183 = load i32, i32* %y
  %x_mul_m184 = mul i32 %x182, 5
  %xm_add_y185 = add i32 %x_mul_m184, %y183
  %c_ptr186 = bitcast [25 x i32]* %kernel2 to i32*
  %elmt_addr187 = getelementptr inbounds i32, i32* %c_ptr186, i32 %xm_add_y185
  %elmt188 = load i32, i32* %elmt_addr187
  %tmp189 = mul i32 %b181, %elmt188
  %tmp190 = add i32 %tempb180, %tmp189
  store i32 %tmp190, i32* %tempb
  %y191 = load i32, i32* %y
  %tmp192 = add i32 %y191, 1
  store i32 %tmp192, i32* %y
  br label %while32

then60:                                           ; preds = %while_body33
  %i61 = load i32, i32* %i
  %j62 = load i32, i32* %j
  %tmp_w = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w63 = load i32, i32* %tmp_w
  %tmp_h = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h64 = load i32, i32* %tmp_h
  %tmp_bpp = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp65 = load i32, i32* %tmp_bpp
  %row_increment = mul i32 %tmp_w63, %tmp_bpp65
  %y_mul_rincre = mul i32 %j62, %row_increment
  %x_mul_bpp = mul i32 %i61, %tmp_bpp65
  %x_add_y = add i32 %y_mul_rincre, %x_mul_bpp
  %data_index = add i32 %x_add_y, 2
  %r66 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr = load i8*, i8** %r66
  %rgb_addr = getelementptr inbounds i8, i8* %data_ptr, i32 %data_index
  %rgb_value = load i8, i8* %rgb_addr
  %casted_value = zext i8 %rgb_value to i32
  store i32 %casted_value, i32* %r
  %i67 = load i32, i32* %i
  %j68 = load i32, i32* %j
  %tmp_w69 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w70 = load i32, i32* %tmp_w69
  %tmp_h71 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h72 = load i32, i32* %tmp_h71
  %tmp_bpp73 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp74 = load i32, i32* %tmp_bpp73
  %row_increment75 = mul i32 %tmp_w70, %tmp_bpp74
  %y_mul_rincre76 = mul i32 %j68, %row_increment75
  %x_mul_bpp77 = mul i32 %i67, %tmp_bpp74
  %x_add_y78 = add i32 %y_mul_rincre76, %x_mul_bpp77
  %data_index79 = add i32 %x_add_y78, 1
  %g80 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr81 = load i8*, i8** %g80
  %rgb_addr82 = getelementptr inbounds i8, i8* %data_ptr81, i32 %data_index79
  %rgb_value83 = load i8, i8* %rgb_addr82
  %casted_value84 = zext i8 %rgb_value83 to i32
  store i32 %casted_value84, i32* %g
  %i85 = load i32, i32* %i
  %j86 = load i32, i32* %j
  %tmp_w87 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w88 = load i32, i32* %tmp_w87
  %tmp_h89 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h90 = load i32, i32* %tmp_h89
  %tmp_bpp91 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp92 = load i32, i32* %tmp_bpp91
  %row_increment93 = mul i32 %tmp_w88, %tmp_bpp92
  %y_mul_rincre94 = mul i32 %j86, %row_increment93
  %x_mul_bpp95 = mul i32 %i85, %tmp_bpp92
  %x_add_y96 = add i32 %y_mul_rincre94, %x_mul_bpp95
  %data_index97 = add i32 %x_add_y96, 0
  %b98 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr99 = load i8*, i8** %b98
  %rgb_addr100 = getelementptr inbounds i8, i8* %data_ptr99, i32 %data_index97
  %rgb_value101 = load i8, i8* %rgb_addr100
  %casted_value102 = zext i8 %rgb_value101 to i32
  store i32 %casted_value102, i32* %b
  br label %merge59

else103:                                          ; preds = %while_body33
  %i1104 = load i32, i32* %i1
  %j1105 = load i32, i32* %j1
  %tmp_w106 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w107 = load i32, i32* %tmp_w106
  %tmp_h108 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h109 = load i32, i32* %tmp_h108
  %tmp_bpp110 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp111 = load i32, i32* %tmp_bpp110
  %row_increment112 = mul i32 %tmp_w107, %tmp_bpp111
  %y_mul_rincre113 = mul i32 %j1105, %row_increment112
  %x_mul_bpp114 = mul i32 %i1104, %tmp_bpp111
  %x_add_y115 = add i32 %y_mul_rincre113, %x_mul_bpp114
  %data_index116 = add i32 %x_add_y115, 2
  %r117 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr118 = load i8*, i8** %r117
  %rgb_addr119 = getelementptr inbounds i8, i8* %data_ptr118, i32 %data_index116
  %rgb_value120 = load i8, i8* %rgb_addr119
  %casted_value121 = zext i8 %rgb_value120 to i32
  store i32 %casted_value121, i32* %r
  %i1122 = load i32, i32* %i1
  %j1123 = load i32, i32* %j1
  %tmp_w124 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w125 = load i32, i32* %tmp_w124
  %tmp_h126 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h127 = load i32, i32* %tmp_h126
  %tmp_bpp128 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp129 = load i32, i32* %tmp_bpp128
  %row_increment130 = mul i32 %tmp_w125, %tmp_bpp129
  %y_mul_rincre131 = mul i32 %j1123, %row_increment130
  %x_mul_bpp132 = mul i32 %i1122, %tmp_bpp129
  %x_add_y133 = add i32 %y_mul_rincre131, %x_mul_bpp132
  %data_index134 = add i32 %x_add_y133, 1
  %g135 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr136 = load i8*, i8** %g135
  %rgb_addr137 = getelementptr inbounds i8, i8* %data_ptr136, i32 %data_index134
  %rgb_value138 = load i8, i8* %rgb_addr137
  %casted_value139 = zext i8 %rgb_value138 to i32
  store i32 %casted_value139, i32* %g
  %i1140 = load i32, i32* %i1
  %j1141 = load i32, i32* %j1
  %tmp_w142 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w143 = load i32, i32* %tmp_w142
  %tmp_h144 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h145 = load i32, i32* %tmp_h144
  %tmp_bpp146 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp147 = load i32, i32* %tmp_bpp146
  %row_increment148 = mul i32 %tmp_w143, %tmp_bpp147
  %y_mul_rincre149 = mul i32 %j1141, %row_increment148
  %x_mul_bpp150 = mul i32 %i1140, %tmp_bpp147
  %x_add_y151 = add i32 %y_mul_rincre149, %x_mul_bpp150
  %data_index152 = add i32 %x_add_y151, 0
  %b153 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr154 = load i8*, i8** %b153
  %rgb_addr155 = getelementptr inbounds i8, i8* %data_ptr154, i32 %data_index152
  %rgb_value156 = load i8, i8* %rgb_addr155
  %casted_value157 = zext i8 %rgb_value156 to i32
  store i32 %casted_value157, i32* %b
  br label %merge59

merge196:                                         ; preds = %while32
  %x197 = load i32, i32* %x
  %tmp198 = add i32 %x197, 1
  store i32 %tmp198, i32* %x
  br label %while30

merge202:                                         ; preds = %while30
  %i203 = load i32, i32* %i
  %j204 = load i32, i32* %j
  %tempr205 = load i32, i32* %tempr
  %tot206 = load i32, i32* %tot
  %tmp207 = sdiv i32 %tempr205, %tot206
  %bound_result = call i32 @bound(i32 %tmp207)
  %tmp_w208 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w209 = load i32, i32* %tmp_w208
  %tmp_h210 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 1
  %tmp_h211 = load i32, i32* %tmp_h210
  %tmp_bpp212 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp213 = load i32, i32* %tmp_bpp212
  %row_increment214 = mul i32 %tmp_w209, %tmp_bpp213
  %y_mul_rincre215 = mul i32 %j204, %row_increment214
  %x_mul_bpp216 = mul i32 %i203, %tmp_bpp213
  %x_add_y217 = add i32 %y_mul_rincre215, %x_mul_bpp216
  %data_index218 = add i32 %x_add_y217, 2
  %r219 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr220 = load i8*, i8** %r219
  %char_RGB = trunc i32 %bound_result to i8
  %rgb_addr221 = getelementptr inbounds i8, i8* %data_ptr220, i32 %data_index218
  store i8 %char_RGB, i8* %rgb_addr221
  %i222 = load i32, i32* %i
  %j223 = load i32, i32* %j
  %tempg224 = load i32, i32* %tempg
  %tot225 = load i32, i32* %tot
  %tmp226 = sdiv i32 %tempg224, %tot225
  %bound_result227 = call i32 @bound(i32 %tmp226)
  %tmp_w228 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w229 = load i32, i32* %tmp_w228
  %tmp_h230 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 1
  %tmp_h231 = load i32, i32* %tmp_h230
  %tmp_bpp232 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp233 = load i32, i32* %tmp_bpp232
  %row_increment234 = mul i32 %tmp_w229, %tmp_bpp233
  %y_mul_rincre235 = mul i32 %j223, %row_increment234
  %x_mul_bpp236 = mul i32 %i222, %tmp_bpp233
  %x_add_y237 = add i32 %y_mul_rincre235, %x_mul_bpp236
  %data_index238 = add i32 %x_add_y237, 1
  %g239 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr240 = load i8*, i8** %g239
  %char_RGB241 = trunc i32 %bound_result227 to i8
  %rgb_addr242 = getelementptr inbounds i8, i8* %data_ptr240, i32 %data_index238
  store i8 %char_RGB241, i8* %rgb_addr242
  %i243 = load i32, i32* %i
  %j244 = load i32, i32* %j
  %tempb245 = load i32, i32* %tempb
  %tot246 = load i32, i32* %tot
  %tmp247 = sdiv i32 %tempb245, %tot246
  %bound_result248 = call i32 @bound(i32 %tmp247)
  %tmp_w249 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w250 = load i32, i32* %tmp_w249
  %tmp_h251 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 1
  %tmp_h252 = load i32, i32* %tmp_h251
  %tmp_bpp253 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp254 = load i32, i32* %tmp_bpp253
  %row_increment255 = mul i32 %tmp_w250, %tmp_bpp254
  %y_mul_rincre256 = mul i32 %j244, %row_increment255
  %x_mul_bpp257 = mul i32 %i243, %tmp_bpp254
  %x_add_y258 = add i32 %y_mul_rincre256, %x_mul_bpp257
  %data_index259 = add i32 %x_add_y258, 0
  %b260 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr261 = load i8*, i8** %b260
  %char_RGB262 = trunc i32 %bound_result248 to i8
  %rgb_addr263 = getelementptr inbounds i8, i8* %data_ptr261, i32 %data_index259
  store i8 %char_RGB262, i8* %rgb_addr263
  %j264 = load i32, i32* %j
  %tmp265 = add i32 %j264, 1
  store i32 %tmp265, i32* %j
  br label %while28

merge270:                                         ; preds = %while28
  %i271 = load i32, i32* %i
  %tmp272 = add i32 %i271, 1
  store i32 %tmp272, i32* %i
  br label %while26

merge277:                                         ; preds = %while26
  store i32 0, i32* %i
  br label %while278

while278:                                         ; preds = %merge387, %merge277
  %i390 = load i32, i32* %i
  %w391 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %w392 = load i32, i32* %w391
  %tmp393 = icmp slt i32 %i390, %w392
  br i1 %tmp393, label %while_body279, label %merge394

while_body279:                                    ; preds = %while278
  store i32 0, i32* %j
  br label %while280

while280:                                         ; preds = %while_body281, %while_body279
  %j383 = load i32, i32* %j
  %h384 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %h385 = load i32, i32* %h384
  %tmp386 = icmp slt i32 %j383, %h385
  br i1 %tmp386, label %while_body281, label %merge387

while_body281:                                    ; preds = %while280
  %i282 = load i32, i32* %i
  %j283 = load i32, i32* %j
  %i284 = load i32, i32* %i
  %j285 = load i32, i32* %j
  %tmp_w286 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w287 = load i32, i32* %tmp_w286
  %tmp_h288 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 1
  %tmp_h289 = load i32, i32* %tmp_h288
  %tmp_bpp290 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp291 = load i32, i32* %tmp_bpp290
  %row_increment292 = mul i32 %tmp_w287, %tmp_bpp291
  %y_mul_rincre293 = mul i32 %j285, %row_increment292
  %x_mul_bpp294 = mul i32 %i284, %tmp_bpp291
  %x_add_y295 = add i32 %y_mul_rincre293, %x_mul_bpp294
  %data_index296 = add i32 %x_add_y295, 2
  %r297 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr298 = load i8*, i8** %r297
  %rgb_addr299 = getelementptr inbounds i8, i8* %data_ptr298, i32 %data_index296
  %rgb_value300 = load i8, i8* %rgb_addr299
  %tmp_w301 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w302 = load i32, i32* %tmp_w301
  %tmp_h303 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h304 = load i32, i32* %tmp_h303
  %tmp_bpp305 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp306 = load i32, i32* %tmp_bpp305
  %row_increment307 = mul i32 %tmp_w302, %tmp_bpp306
  %y_mul_rincre308 = mul i32 %j283, %row_increment307
  %x_mul_bpp309 = mul i32 %i282, %tmp_bpp306
  %x_add_y310 = add i32 %y_mul_rincre308, %x_mul_bpp309
  %data_index311 = add i32 %x_add_y310, 2
  %r312 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr313 = load i8*, i8** %r312
  %rgb_addr314 = getelementptr inbounds i8, i8* %data_ptr313, i32 %data_index311
  store i8 %rgb_value300, i8* %rgb_addr314
  %i315 = load i32, i32* %i
  %j316 = load i32, i32* %j
  %i317 = load i32, i32* %i
  %j318 = load i32, i32* %j
  %tmp_w319 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w320 = load i32, i32* %tmp_w319
  %tmp_h321 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 1
  %tmp_h322 = load i32, i32* %tmp_h321
  %tmp_bpp323 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp324 = load i32, i32* %tmp_bpp323
  %row_increment325 = mul i32 %tmp_w320, %tmp_bpp324
  %y_mul_rincre326 = mul i32 %j318, %row_increment325
  %x_mul_bpp327 = mul i32 %i317, %tmp_bpp324
  %x_add_y328 = add i32 %y_mul_rincre326, %x_mul_bpp327
  %data_index329 = add i32 %x_add_y328, 1
  %g330 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr331 = load i8*, i8** %g330
  %rgb_addr332 = getelementptr inbounds i8, i8* %data_ptr331, i32 %data_index329
  %rgb_value333 = load i8, i8* %rgb_addr332
  %tmp_w334 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w335 = load i32, i32* %tmp_w334
  %tmp_h336 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h337 = load i32, i32* %tmp_h336
  %tmp_bpp338 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp339 = load i32, i32* %tmp_bpp338
  %row_increment340 = mul i32 %tmp_w335, %tmp_bpp339
  %y_mul_rincre341 = mul i32 %j316, %row_increment340
  %x_mul_bpp342 = mul i32 %i315, %tmp_bpp339
  %x_add_y343 = add i32 %y_mul_rincre341, %x_mul_bpp342
  %data_index344 = add i32 %x_add_y343, 1
  %g345 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr346 = load i8*, i8** %g345
  %rgb_addr347 = getelementptr inbounds i8, i8* %data_ptr346, i32 %data_index344
  store i8 %rgb_value333, i8* %rgb_addr347
  %i348 = load i32, i32* %i
  %j349 = load i32, i32* %j
  %i350 = load i32, i32* %i
  %j351 = load i32, i32* %j
  %tmp_w352 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 0
  %tmp_w353 = load i32, i32* %tmp_w352
  %tmp_h354 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 1
  %tmp_h355 = load i32, i32* %tmp_h354
  %tmp_bpp356 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 2
  %tmp_bpp357 = load i32, i32* %tmp_bpp356
  %row_increment358 = mul i32 %tmp_w353, %tmp_bpp357
  %y_mul_rincre359 = mul i32 %j351, %row_increment358
  %x_mul_bpp360 = mul i32 %i350, %tmp_bpp357
  %x_add_y361 = add i32 %y_mul_rincre359, %x_mul_bpp360
  %data_index362 = add i32 %x_add_y361, 0
  %b363 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %temp, i32 0, i32 3
  %data_ptr364 = load i8*, i8** %b363
  %rgb_addr365 = getelementptr inbounds i8, i8* %data_ptr364, i32 %data_index362
  %rgb_value366 = load i8, i8* %rgb_addr365
  %tmp_w367 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 0
  %tmp_w368 = load i32, i32* %tmp_w367
  %tmp_h369 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 1
  %tmp_h370 = load i32, i32* %tmp_h369
  %tmp_bpp371 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 2
  %tmp_bpp372 = load i32, i32* %tmp_bpp371
  %row_increment373 = mul i32 %tmp_w368, %tmp_bpp372
  %y_mul_rincre374 = mul i32 %j349, %row_increment373
  %x_mul_bpp375 = mul i32 %i348, %tmp_bpp372
  %x_add_y376 = add i32 %y_mul_rincre374, %x_mul_bpp375
  %data_index377 = add i32 %x_add_y376, 0
  %b378 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %a1, i32 0, i32 3
  %data_ptr379 = load i8*, i8** %b378
  %rgb_addr380 = getelementptr inbounds i8, i8* %data_ptr379, i32 %data_index377
  store i8 %rgb_value366, i8* %rgb_addr380
  %j381 = load i32, i32* %j
  %tmp382 = add i32 %j381, 1
  store i32 %tmp382, i32* %j
  br label %while280

merge387:                                         ; preds = %while280
  %i388 = load i32, i32* %i
  %tmp389 = add i32 %i388, 1
  store i32 %tmp389, i32* %i
  br label %while278

merge394:                                         ; preds = %while278
  ret i32 0
}

define i32 @bound(i32 %input) {
entry:
  %input1 = alloca i32
  store i32 %input, i32* %input1
  %input2 = load i32, i32* %input1
  %tmp = icmp slt i32 %input2, 0
  br i1 %tmp, label %then, label %else

merge:                                            ; preds = %merge5
  ret i32 0

then:                                             ; preds = %entry
  ret i32 0

else:                                             ; preds = %entry
  %input3 = load i32, i32* %input1
  %tmp4 = icmp sgt i32 %input3, 255
  br i1 %tmp4, label %then6, label %else7

merge5:                                           ; No predecessors!
  br label %merge

then6:                                            ; preds = %else
  ret i32 255

else7:                                            ; preds = %else
  %input8 = load i32, i32* %input1
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
  %i96 = load i32, i32* %i
  %w = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %w97 = load i32, i32* %w
  %tmp98 = icmp slt i32 %i96, %w97
  br i1 %tmp98, label %while_body, label %merge99

while_body:                                       ; preds = %while
  store i32 0, i32* %j
  br label %while3

while3:                                           ; preds = %while_body4, %while_body
  %j91 = load i32, i32* %j
  %h = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 1
  %h92 = load i32, i32* %h
  %tmp93 = icmp slt i32 %j91, %h92
  br i1 %tmp93, label %while_body4, label %merge

while_body4:                                      ; preds = %while3
  %i5 = load i32, i32* %i
  %j6 = load i32, i32* %j
  %i7 = load i32, i32* %i
  %j8 = load i32, i32* %j
  %tmp_w = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %tmp_w9 = load i32, i32* %tmp_w
  %tmp_h = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 1
  %tmp_h10 = load i32, i32* %tmp_h
  %tmp_bpp = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 2
  %tmp_bpp11 = load i32, i32* %tmp_bpp
  %row_increment = mul i32 %tmp_w9, %tmp_bpp11
  %y_mul_rincre = mul i32 %j8, %row_increment
  %x_mul_bpp = mul i32 %i7, %tmp_bpp11
  %x_add_y = add i32 %y_mul_rincre, %x_mul_bpp
  %data_index = add i32 %x_add_y, 2
  %r = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 3
  %data_ptr = load i8*, i8** %r
  %rgb_addr = getelementptr inbounds i8, i8* %data_ptr, i32 %data_index
  %rgb_value = load i8, i8* %rgb_addr
  %tmp_w12 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 0
  %tmp_w13 = load i32, i32* %tmp_w12
  %tmp_h14 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 1
  %tmp_h15 = load i32, i32* %tmp_h14
  %tmp_bpp16 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 2
  %tmp_bpp17 = load i32, i32* %tmp_bpp16
  %row_increment18 = mul i32 %tmp_w13, %tmp_bpp17
  %y_mul_rincre19 = mul i32 %j6, %row_increment18
  %x_mul_bpp20 = mul i32 %i5, %tmp_bpp17
  %x_add_y21 = add i32 %y_mul_rincre19, %x_mul_bpp20
  %data_index22 = add i32 %x_add_y21, 2
  %r23 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 3
  %data_ptr24 = load i8*, i8** %r23
  %rgb_addr25 = getelementptr inbounds i8, i8* %data_ptr24, i32 %data_index22
  store i8 %rgb_value, i8* %rgb_addr25
  %i26 = load i32, i32* %i
  %j27 = load i32, i32* %j
  %i28 = load i32, i32* %i
  %j29 = load i32, i32* %j
  %tmp_w30 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %tmp_w31 = load i32, i32* %tmp_w30
  %tmp_h32 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 1
  %tmp_h33 = load i32, i32* %tmp_h32
  %tmp_bpp34 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 2
  %tmp_bpp35 = load i32, i32* %tmp_bpp34
  %row_increment36 = mul i32 %tmp_w31, %tmp_bpp35
  %y_mul_rincre37 = mul i32 %j29, %row_increment36
  %x_mul_bpp38 = mul i32 %i28, %tmp_bpp35
  %x_add_y39 = add i32 %y_mul_rincre37, %x_mul_bpp38
  %data_index40 = add i32 %x_add_y39, 1
  %g = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 3
  %data_ptr41 = load i8*, i8** %g
  %rgb_addr42 = getelementptr inbounds i8, i8* %data_ptr41, i32 %data_index40
  %rgb_value43 = load i8, i8* %rgb_addr42
  %tmp_w44 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 0
  %tmp_w45 = load i32, i32* %tmp_w44
  %tmp_h46 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 1
  %tmp_h47 = load i32, i32* %tmp_h46
  %tmp_bpp48 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 2
  %tmp_bpp49 = load i32, i32* %tmp_bpp48
  %row_increment50 = mul i32 %tmp_w45, %tmp_bpp49
  %y_mul_rincre51 = mul i32 %j27, %row_increment50
  %x_mul_bpp52 = mul i32 %i26, %tmp_bpp49
  %x_add_y53 = add i32 %y_mul_rincre51, %x_mul_bpp52
  %data_index54 = add i32 %x_add_y53, 1
  %g55 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 3
  %data_ptr56 = load i8*, i8** %g55
  %rgb_addr57 = getelementptr inbounds i8, i8* %data_ptr56, i32 %data_index54
  store i8 %rgb_value43, i8* %rgb_addr57
  %i58 = load i32, i32* %i
  %j59 = load i32, i32* %j
  %i60 = load i32, i32* %i
  %j61 = load i32, i32* %j
  %tmp_w62 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 0
  %tmp_w63 = load i32, i32* %tmp_w62
  %tmp_h64 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 1
  %tmp_h65 = load i32, i32* %tmp_h64
  %tmp_bpp66 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 2
  %tmp_bpp67 = load i32, i32* %tmp_bpp66
  %row_increment68 = mul i32 %tmp_w63, %tmp_bpp67
  %y_mul_rincre69 = mul i32 %j61, %row_increment68
  %x_mul_bpp70 = mul i32 %i60, %tmp_bpp67
  %x_add_y71 = add i32 %y_mul_rincre69, %x_mul_bpp70
  %data_index72 = add i32 %x_add_y71, 0
  %b = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %src1, i32 0, i32 3
  %data_ptr73 = load i8*, i8** %b
  %rgb_addr74 = getelementptr inbounds i8, i8* %data_ptr73, i32 %data_index72
  %rgb_value75 = load i8, i8* %rgb_addr74
  %tmp_w76 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 0
  %tmp_w77 = load i32, i32* %tmp_w76
  %tmp_h78 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 1
  %tmp_h79 = load i32, i32* %tmp_h78
  %tmp_bpp80 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 2
  %tmp_bpp81 = load i32, i32* %tmp_bpp80
  %row_increment82 = mul i32 %tmp_w77, %tmp_bpp81
  %y_mul_rincre83 = mul i32 %j59, %row_increment82
  %x_mul_bpp84 = mul i32 %i58, %tmp_bpp81
  %x_add_y85 = add i32 %y_mul_rincre83, %x_mul_bpp84
  %data_index86 = add i32 %x_add_y85, 0
  %b87 = getelementptr inbounds { i32, i32, i32, i8* }, { i32, i32, i32, i8* }* %dst2, i32 0, i32 3
  %data_ptr88 = load i8*, i8** %b87
  %rgb_addr89 = getelementptr inbounds i8, i8* %data_ptr88, i32 %data_index86
  store i8 %rgb_value75, i8* %rgb_addr89
  %j90 = load i32, i32* %j
  %tmp = add i32 %j90, 1
  store i32 %tmp, i32* %j
  br label %while3

merge:                                            ; preds = %while3
  %i94 = load i32, i32* %i
  %tmp95 = add i32 %i94, 1
  store i32 %tmp95, i32* %i
  br label %while

merge99:                                          ; preds = %while
  ret void
}
