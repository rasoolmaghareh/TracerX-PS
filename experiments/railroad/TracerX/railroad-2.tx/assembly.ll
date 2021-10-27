; ModuleID = 'railroad.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@limit = global i32 2, align 4
@clock_t = global i32 0, align 4
@clock_g = global i32 0, align 4
@clock_c = global i32 0, align 4
@pc_TRAIN = global i32 10, align 4
@pc_GATE = global i32 13, align 4
@pc_CONTROLLER = global i32 0, align 4
@.str = private unnamed_addr constant [3 x i8] c"id\00", align 1
@.str1 = private unnamed_addr constant [37 x i8] c"!(pc_TRAIN == PAST && pc_GATE == UP)\00", align 1
@.str2 = private unnamed_addr constant [11 x i8] c"railroad.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@APPROACH = common global i32 0, align 4
@EXIT = common global i32 0, align 4
@LOWER = common global i32 0, align 4
@RAISE = common global i32 0, align 4
@.str3 = private unnamed_addr constant [7 x i8] c"State:\00", align 1
@.str4 = private unnamed_addr constant [11 x i8] c"Id:Train;\0A\00", align 1
@.str5 = private unnamed_addr constant [10 x i8] c"Id:Gate;\0A\00", align 1
@.str6 = private unnamed_addr constant [16 x i8] c"Id:Controller;\0A\00", align 1
@.str7 = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str18 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str29 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str310 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str611 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %level = alloca i32, align 4
  %id = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 0, i32* %level, align 4, !dbg !150
  br label %while.cond, !dbg !151

while.cond:                                       ; preds = %sw.epilog, %entry
  %0 = load i32* @limit, align 4, !dbg !151
  %cmp = icmp sgt i32 %0, 0, !dbg !151
  br i1 %cmp, label %while.body, label %while.end, !dbg !151

while.body:                                       ; preds = %while.cond
  %call = call i32 @tick(), !dbg !152
  %call1 = call i32 @klee_range(i32 0, i32 3, i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0)), !dbg !154
  store i32 %call1, i32* %id, align 4, !dbg !154
  %1 = load i32* %id, align 4, !dbg !155
  switch i32 %1, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb3
    i32 2, label %sw.bb6
  ], !dbg !155

sw.bb:                                            ; preds = %while.body
  %call2 = call i32 @train(), !dbg !156
  %2 = load i32* %level, align 4, !dbg !156
  %inc = add nsw i32 %2, 1, !dbg !156
  store i32 %inc, i32* %level, align 4, !dbg !156
  br label %sw.epilog, !dbg !156

sw.bb3:                                           ; preds = %while.body
  %call4 = call i32 @gate(), !dbg !158
  %3 = load i32* %level, align 4, !dbg !158
  %inc5 = add nsw i32 %3, 1, !dbg !158
  store i32 %inc5, i32* %level, align 4, !dbg !158
  br label %sw.epilog, !dbg !158

sw.bb6:                                           ; preds = %while.body
  %call7 = call i32 @controller(), !dbg !159
  %4 = load i32* %level, align 4, !dbg !159
  %inc8 = add nsw i32 %4, 1, !dbg !159
  store i32 %inc8, i32* %level, align 4, !dbg !159
  br label %sw.epilog, !dbg !160

sw.epilog:                                        ; preds = %sw.bb6, %sw.bb3, %sw.bb, %while.body
  br label %while.cond, !dbg !161

while.end:                                        ; preds = %while.cond
  %5 = load i32* @pc_TRAIN, align 4, !dbg !162
  %cmp9 = icmp eq i32 %5, 12, !dbg !162
  br i1 %cmp9, label %land.lhs.true, label %cond.true, !dbg !162

land.lhs.true:                                    ; preds = %while.end
  %6 = load i32* @pc_GATE, align 4, !dbg !162
  %cmp10 = icmp eq i32 %6, 13, !dbg !162
  br i1 %cmp10, label %cond.false, label %cond.true, !dbg !162

cond.true:                                        ; preds = %land.lhs.true, %while.end
  br label %cond.end, !dbg !162

cond.false:                                       ; preds = %land.lhs.true
  %call11 = call i32 (i8*, i8*, i32, i8*, ...)* bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* getelementptr inbounds ([37 x i8]* @.str1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8]* @.str2, i32 0, i32 0), i32 38, i8* 
  br label %cond.end, !dbg !162

cond.end:                                         ; preds = %cond.false, %cond.true
  ret i32 1, !dbg !163
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: noreturn
declare i32 @__assert_fail(...) #2

; Function Attrs: nounwind uwtable
define i32 @tick() #0 {
entry:
  %retval = alloca i32, align 4
  %0 = load i32* @clock_g, align 4, !dbg !164
  %inc = add nsw i32 %0, 1, !dbg !164
  store i32 %inc, i32* @clock_g, align 4, !dbg !164
  %1 = load i32* @clock_t, align 4, !dbg !164
  %inc1 = add nsw i32 %1, 1, !dbg !164
  store i32 %inc1, i32* @clock_t, align 4, !dbg !164
  %2 = load i32* @clock_c, align 4, !dbg !164
  %inc2 = add nsw i32 %2, 1, !dbg !164
  store i32 %inc2, i32* @clock_c, align 4, !dbg !164
  %3 = load i32* %retval, !dbg !164
  ret i32 %3, !dbg !164
}

; Function Attrs: nounwind uwtable
define i32 @reset_g() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* @clock_g, align 4, !dbg !165
  %0 = load i32* %retval, !dbg !165
  ret i32 %0, !dbg !165
}

; Function Attrs: nounwind uwtable
define i32 @reset_t() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* @clock_t, align 4, !dbg !166
  %0 = load i32* %retval, !dbg !166
  ret i32 %0, !dbg !166
}

; Function Attrs: nounwind uwtable
define i32 @reset_c() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* @clock_c, align 4, !dbg !167
  %0 = load i32* %retval, !dbg !167
  ret i32 %0, !dbg !167
}

; Function Attrs: nounwind uwtable
define i32 @train() #0 {
entry:
  %retval = alloca i32, align 4
  %0 = load i32* @pc_TRAIN, align 4, !dbg !168
  switch i32 %0, label %sw.epilog [
    i32 10, label %sw.bb
    i32 11, label %sw.bb1
    i32 12, label %sw.bb3
  ], !dbg !168

sw.bb:                                            ; preds = %entry
  store i32 1, i32* @APPROACH, align 4, !dbg !169
  %call = call i32 @reset_t(), !dbg !169
  store i32 11, i32* @pc_TRAIN, align 4, !dbg !169
  br label %sw.epilog, !dbg !169

sw.bb1:                                           ; preds = %entry
  %1 = load i32* @clock_t, align 4, !dbg !171
  %cmp = icmp sle i32 %1, 5, !dbg !171
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !171

land.lhs.true:                                    ; preds = %sw.bb1
  %2 = load i32* @clock_t, align 4, !dbg !171
  %cmp2 = icmp sgt i32 %2, 2, !dbg !171
  br i1 %cmp2, label %if.then, label %if.else, !dbg !171

if.then:                                          ; preds = %land.lhs.true
  store i32 12, i32* @pc_TRAIN, align 4, !dbg !173
  br label %if.end, !dbg !173

if.else:                                          ; preds = %land.lhs.true, %sw.bb1
  call void @exit(i32 0) #7, !dbg !175
  unreachable, !dbg !175

if.end:                                           ; preds = %if.then
  br label %sw.epilog, !dbg !177

sw.bb3:                                           ; preds = %entry
  %3 = load i32* @clock_t, align 4, !dbg !178
  %cmp4 = icmp sle i32 %3, 5, !dbg !178
  br i1 %cmp4, label %if.then5, label %if.else6, !dbg !178

if.then5:                                         ; preds = %sw.bb3
  store i32 1, i32* @EXIT, align 4, !dbg !180
  %4 = load i32* @limit, align 4, !dbg !180
  %dec = add nsw i32 %4, -1, !dbg !180
  store i32 %dec, i32* @limit, align 4, !dbg !180
  store i32 10, i32* @pc_TRAIN, align 4, !dbg !180
  br label %if.end7, !dbg !180

if.else6:                                         ; preds = %sw.bb3
  call void @exit(i32 0) #7, !dbg !182
  unreachable, !dbg !182

if.end7:                                          ; preds = %if.then5
  br label %sw.epilog, !dbg !184

sw.epilog:                                        ; preds = %if.end7, %if.end, %sw.bb, %entry
  %5 = load i32* %retval, !dbg !185
  ret i32 %5, !dbg !185
}

; Function Attrs: noreturn
declare void @exit(i32) #2

; Function Attrs: nounwind uwtable
define i32 @gate() #0 {
entry:
  %retval = alloca i32, align 4
  %0 = load i32* @pc_GATE, align 4, !dbg !186
  switch i32 %0, label %sw.epilog [
    i32 13, label %sw.bb
    i32 14, label %sw.bb1
    i32 15, label %sw.bb5
    i32 16, label %sw.bb11
  ], !dbg !186

sw.bb:                                            ; preds = %entry
  %1 = load i32* @LOWER, align 4, !dbg !187
  %tobool = icmp ne i32 %1, 0, !dbg !187
  br i1 %tobool, label %if.then, label %if.else, !dbg !187

if.then:                                          ; preds = %sw.bb
  store i32 0, i32* @LOWER, align 4, !dbg !190
  %call = call i32 @reset_g(), !dbg !190
  store i32 14, i32* @pc_GATE, align 4, !dbg !190
  br label %if.end, !dbg !190

if.else:                                          ; preds = %sw.bb
  call void @exit(i32 0) #7, !dbg !192
  unreachable, !dbg !192

if.end:                                           ; preds = %if.then
  br label %sw.epilog, !dbg !194

sw.bb1:                                           ; preds = %entry
  %2 = load i32* @clock_g, align 4, !dbg !195
  %cmp = icmp sle i32 %2, 1, !dbg !195
  br i1 %cmp, label %if.then2, label %if.else3, !dbg !195

if.then2:                                         ; preds = %sw.bb1
  store i32 15, i32* @pc_GATE, align 4, !dbg !197
  br label %if.end4, !dbg !197

if.else3:                                         ; preds = %sw.bb1
  call void @exit(i32 0) #7, !dbg !199
  unreachable, !dbg !199

if.end4:                                          ; preds = %if.then2
  br label %sw.epilog, !dbg !201

sw.bb5:                                           ; preds = %entry
  %3 = load i32* @RAISE, align 4, !dbg !202
  %tobool6 = icmp ne i32 %3, 0, !dbg !202
  br i1 %tobool6, label %if.then7, label %if.else9, !dbg !202

if.then7:                                         ; preds = %sw.bb5
  store i32 0, i32* @RAISE, align 4, !dbg !204
  %call8 = call i32 @reset_g(), !dbg !204
  store i32 16, i32* @pc_GATE, align 4, !dbg !204
  br label %if.end10, !dbg !204

if.else9:                                         ; preds = %sw.bb5
  call void @exit(i32 0) #7, !dbg !206
  unreachable, !dbg !206

if.end10:                                         ; preds = %if.then7
  br label %sw.epilog, !dbg !208

sw.bb11:                                          ; preds = %entry
  %4 = load i32* @clock_g, align 4, !dbg !209
  %cmp12 = icmp sle i32 %4, 2, !dbg !209
  br i1 %cmp12, label %land.lhs.true, label %if.else15, !dbg !209

land.lhs.true:                                    ; preds = %sw.bb11
  %5 = load i32* @clock_g, align 4, !dbg !209
  %cmp13 = icmp sge i32 %5, 1, !dbg !209
  br i1 %cmp13, label %if.then14, label %if.else15, !dbg !209

if.then14:                                        ; preds = %land.lhs.true
  store i32 13, i32* @pc_GATE, align 4, !dbg !211
  br label %if.end16, !dbg !211

if.else15:                                        ; preds = %land.lhs.true, %sw.bb11
  call void @exit(i32 0) #7, !dbg !213
  unreachable, !dbg !213

if.end16:                                         ; preds = %if.then14
  br label %sw.epilog, !dbg !215

sw.epilog:                                        ; preds = %if.end16, %if.end10, %if.end4, %if.end, %entry
  %6 = load i32* %retval, !dbg !216
  ret i32 %6, !dbg !216
}

; Function Attrs: nounwind uwtable
define i32 @controller() #0 {
entry:
  %retval = alloca i32, align 4
  %0 = load i32* @pc_CONTROLLER, align 4, !dbg !217
  switch i32 %0, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
    i32 2, label %sw.bb6
    i32 3, label %sw.bb12
  ], !dbg !217

sw.bb:                                            ; preds = %entry
  %1 = load i32* @APPROACH, align 4, !dbg !218
  %tobool = icmp ne i32 %1, 0, !dbg !218
  br i1 %tobool, label %if.then, label %if.else, !dbg !218

if.then:                                          ; preds = %sw.bb
  store i32 0, i32* @APPROACH, align 4, !dbg !221
  %call = call i32 @reset_c(), !dbg !221
  store i32 1, i32* @pc_CONTROLLER, align 4, !dbg !221
  br label %if.end, !dbg !221

if.else:                                          ; preds = %sw.bb
  call void @exit(i32 0) #7, !dbg !223
  unreachable, !dbg !223

if.end:                                           ; preds = %if.then
  br label %sw.epilog, !dbg !225

sw.bb1:                                           ; preds = %entry
  %2 = load i32* @clock_c, align 4, !dbg !226
  %cmp = icmp sle i32 %2, 1, !dbg !226
  br i1 %cmp, label %land.lhs.true, label %if.else4, !dbg !226

land.lhs.true:                                    ; preds = %sw.bb1
  %3 = load i32* @clock_c, align 4, !dbg !226
  %cmp2 = icmp eq i32 %3, 1, !dbg !226
  br i1 %cmp2, label %if.then3, label %if.else4, !dbg !226

if.then3:                                         ; preds = %land.lhs.true
  store i32 1, i32* @LOWER, align 4, !dbg !228
  store i32 2, i32* @pc_CONTROLLER, align 4, !dbg !228
  br label %if.end5, !dbg !228

if.else4:                                         ; preds = %land.lhs.true, %sw.bb1
  call void @exit(i32 0) #7, !dbg !230
  unreachable, !dbg !230

if.end5:                                          ; preds = %if.then3
  br label %sw.epilog, !dbg !232

sw.bb6:                                           ; preds = %entry
  %4 = load i32* @EXIT, align 4, !dbg !233
  %tobool7 = icmp ne i32 %4, 0, !dbg !233
  br i1 %tobool7, label %if.then8, label %if.else10, !dbg !233

if.then8:                                         ; preds = %sw.bb6
  store i32 0, i32* @EXIT, align 4, !dbg !235
  %call9 = call i32 @reset_c(), !dbg !235
  store i32 3, i32* @pc_CONTROLLER, align 4, !dbg !235
  br label %if.end11, !dbg !235

if.else10:                                        ; preds = %sw.bb6
  call void @exit(i32 0) #7, !dbg !237
  unreachable, !dbg !237

if.end11:                                         ; preds = %if.then8
  br label %sw.epilog, !dbg !239

sw.bb12:                                          ; preds = %entry
  %5 = load i32* @clock_c, align 4, !dbg !240
  %cmp13 = icmp sle i32 %5, 1, !dbg !240
  br i1 %cmp13, label %if.then14, label %if.else15, !dbg !240

if.then14:                                        ; preds = %sw.bb12
  store i32 1, i32* @RAISE, align 4, !dbg !242
  store i32 0, i32* @pc_CONTROLLER, align 4, !dbg !242
  br label %if.end16, !dbg !242

if.else15:                                        ; preds = %sw.bb12
  call void @exit(i32 0) #7, !dbg !244
  unreachable, !dbg !244

if.end16:                                         ; preds = %if.then14
  br label %sw.epilog, !dbg !246

sw.epilog:                                        ; preds = %if.end16, %if.end11, %if.end5, %if.end, %entry
  %6 = load i32* %retval, !dbg !247
  ret i32 %6, !dbg !247
}

; Function Attrs: nounwind uwtable
define void @print_state(i32 %id) #0 {
entry:
  %id.addr = alloca i32, align 4
  store i32 %id, i32* %id.addr, align 4
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0)), !dbg !248
  %0 = load i32* %id.addr, align 4, !dbg !249
  %cmp = icmp eq i32 %0, 0, !dbg !249
  br i1 %cmp, label %if.then, label %if.else, !dbg !249

if.then:                                          ; preds = %entry
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str4, i32 0, i32 0)), !dbg !249
  br label %if.end10, !dbg !249

if.else:                                          ; preds = %entry
  %1 = load i32* %id.addr, align 4, !dbg !251
  %cmp2 = icmp eq i32 %1, 1, !dbg !251
  br i1 %cmp2, label %if.then3, label %if.else5, !dbg !251

if.then3:                                         ; preds = %if.else
  %call4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str5, i32 0, i32 0)), !dbg !251
  br label %if.end9, !dbg !251

if.else5:                                         ; preds = %if.else
  %2 = load i32* %id.addr, align 4, !dbg !253
  %cmp6 = icmp eq i32 %2, 2, !dbg !253
  br i1 %cmp6, label %if.then7, label %if.end, !dbg !253

if.then7:                                         ; preds = %if.else5
  %call8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str6, i32 0, i32 0)), !dbg !253
  br label %if.end, !dbg !253

if.end:                                           ; preds = %if.then7, %if.else5
  br label %if.end9

if.end9:                                          ; preds = %if.end, %if.then3
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  ret void, !dbg !255
}

declare i32 @printf(i8*, ...) #3

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #4 {
entry:
  %cmp = icmp eq i64 %z, 0, !dbg !256
  br i1 %cmp, label %if.then, label %if.end, !dbg !256

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str7, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str18, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str29, i64 0, i64 0)) #8, !dbg !258
  unreachable, !dbg !258

if.end:                                           ; preds = %entry
  ret void, !dbg !259
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #4 {
entry:
  %x = alloca i32, align 4
  %0 = bitcast i32* %x to i8*, !dbg !260
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #9, !dbg !260
  %1 = load i32* %x, align 4, !dbg !261, !tbaa !262
  ret i32 %1, !dbg !261
}

declare void @klee_make_symbolic(i8*, i64, i8*) #6

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
entry:
  %cmp = icmp ult i64 %shift, %bitWidth, !dbg !266
  br i1 %cmp, label %if.end, label %if.then, !dbg !266

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str310, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #8, !dbg !268
  unreachable, !dbg !268

if.end:                                           ; preds = %entry
  ret void, !dbg !270
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
entry:
  %x = alloca i32, align 4
  %cmp = icmp slt i32 %start, %end, !dbg !271
  br i1 %cmp, label %if.end, label %if.then, !dbg !271

if.then:                                          ; preds = %entry
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str611, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #8, !dbg !273
  unreachable, !dbg !273

if.end:                                           ; preds = %entry
  %add = add nsw i32 %start, 1, !dbg !274
  %cmp1 = icmp eq i32 %add, %end, !dbg !274
  br i1 %cmp1, label %return, label %if.else, !dbg !274

if.else:                                          ; preds = %if.end
  %0 = bitcast i32* %x to i8*, !dbg !276
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #9, !dbg !276
  %cmp3 = icmp eq i32 %start, 0, !dbg !278
  %1 = load i32* %x, align 4, !dbg !280, !tbaa !262
  br i1 %cmp3, label %if.then4, label %if.else7, !dbg !278

if.then4:                                         ; preds = %if.else
  %cmp5 = icmp ult i32 %1, %end, !dbg !280
  %conv6 = zext i1 %cmp5 to i64, !dbg !280
  call void @klee_assume(i64 %conv6) #9, !dbg !280
  br label %if.end14, !dbg !282

if.else7:                                         ; preds = %if.else
  %cmp8 = icmp sge i32 %1, %start, !dbg !283
  %conv10 = zext i1 %cmp8 to i64, !dbg !283
  call void @klee_assume(i64 %conv10) #9, !dbg !283
  %2 = load i32* %x, align 4, !dbg !285, !tbaa !262
  %cmp11 = icmp slt i32 %2, %end, !dbg !285
  %conv13 = zext i1 %cmp11 to i64, !dbg !285
  call void @klee_assume(i64 %conv13) #9, !dbg !285
  br label %if.end14

if.end14:                                         ; preds = %if.else7, %if.then4
  %3 = load i32* %x, align 4, !dbg !286, !tbaa !262
  br label %return, !dbg !286

return:                                           ; preds = %if.end14, %if.end
  %retval.0 = phi i32 [ %3, %if.end14 ], [ %start, %if.end ]
  ret i32 %retval.0, !dbg !287
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !288
  br i1 %cmp3, label %while.end, label %while.body.preheader, !dbg !288

while.body.preheader:                             ; preds = %entry
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %0 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %while.body.preheader
  %scevgep7 = getelementptr i8* %srcaddr, i64 %0
  %scevgep = getelementptr i8* %destaddr, i64 %0
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep7, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end9 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep106 = getelementptr i8* %destaddr, i64 %index
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !289
  %wide.load = load <16 x i8>* %1, align 1, !dbg !289
  %next.gep.sum282 = or i64 %index, 16, !dbg !289
  %2 = getelementptr i8* %srcaddr, i64 %next.gep.sum282, !dbg !289
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !289
  %wide.load203 = load <16 x i8>* %3, align 1, !dbg !289
  %4 = bitcast i8* %next.gep106 to <16 x i8>*, !dbg !289
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !289
  %5 = getelementptr i8* %destaddr, i64 %next.gep.sum282, !dbg !289
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !289
  store <16 x i8> %wide.load203, <16 x i8>* %6, align 1, !dbg !289
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !290

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %while.body.preheader
  %resume.val = phi i8* [ %srcaddr, %while.body.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val8 = phi i8* [ %destaddr, %while.body.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end9, %vector.body ]
  %resume.val10 = phi i64 [ %len, %while.body.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %while.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %middle.block
  %src.06 = phi i8* [ %incdec.ptr, %while.body ], [ %resume.val, %middle.block ]
  %dest.05 = phi i8* [ %incdec.ptr1, %while.body ], [ %resume.val8, %middle.block ]
  %len.addr.04 = phi i64 [ %dec, %while.body ], [ %resume.val10, %middle.block ]
  %dec = add i64 %len.addr.04, -1, !dbg !288
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !289
  %8 = load i8* %src.06, align 1, !dbg !289, !tbaa !293
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !289
  store i8 %8, i8* %dest.05, align 1, !dbg !289, !tbaa !293
  %cmp = icmp eq i64 %dec, 0, !dbg !288
  br i1 %cmp, label %while.end, label %while.body, !dbg !288, !llvm.loop !294

while.end:                                        ; preds = %while.body, %middle.block, %entry
  ret i8* %destaddr, !dbg !295
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
entry:
  %cmp = icmp eq i8* %src, %dst, !dbg !296
  br i1 %cmp, label %return, label %if.end, !dbg !296

if.end:                                           ; preds = %entry
  %cmp1 = icmp ugt i8* %src, %dst, !dbg !298
  br i1 %cmp1, label %while.cond.preheader, label %if.else, !dbg !298

while.cond.preheader:                             ; preds = %if.end
  %tobool27 = icmp eq i64 %count, 0, !dbg !300
  br i1 %tobool27, label %return, label %while.body.preheader, !dbg !300

while.body.preheader:                             ; preds = %while.cond.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %0 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %while.body.preheader
  %scevgep37 = getelementptr i8* %src, i64 %0
  %scevgep = getelementptr i8* %dst, i64 %0
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep37, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end39 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep136 = getelementptr i8* %dst, i64 %index
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !300
  %wide.load = load <16 x i8>* %1, align 1, !dbg !300
  %next.gep.sum610 = or i64 %index, 16, !dbg !300
  %2 = getelementptr i8* %src, i64 %next.gep.sum610, !dbg !300
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !300
  %wide.load233 = load <16 x i8>* %3, align 1, !dbg !300
  %4 = bitcast i8* %next.gep136 to <16 x i8>*, !dbg !300
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !300
  %5 = getelementptr i8* %dst, i64 %next.gep.sum610, !dbg !300
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !300
  store <16 x i8> %wide.load233, <16 x i8>* %6, align 1, !dbg !300
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !302

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %while.body.preheader
  %resume.val = phi i8* [ %src, %while.body.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val38 = phi i8* [ %dst, %while.body.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end39, %vector.body ]
  %resume.val40 = phi i64 [ %count, %while.body.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %while.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %return, label %while.body

while.body:                                       ; preds = %while.body, %middle.block
  %b.030 = phi i8* [ %incdec.ptr, %while.body ], [ %resume.val, %middle.block ]
  %a.029 = phi i8* [ %incdec.ptr3, %while.body ], [ %resume.val38, %middle.block ]
  %count.addr.028 = phi i64 [ %dec, %while.body ], [ %resume.val40, %middle.block ]
  %dec = add i64 %count.addr.028, -1, !dbg !300
  %incdec.ptr = getelementptr inbounds i8* %b.030, i64 1, !dbg !300
  %8 = load i8* %b.030, align 1, !dbg !300, !tbaa !293
  %incdec.ptr3 = getelementptr inbounds i8* %a.029, i64 1, !dbg !300
  store i8 %8, i8* %a.029, align 1, !dbg !300, !tbaa !293
  %tobool = icmp eq i64 %dec, 0, !dbg !300
  br i1 %tobool, label %return, label %while.body, !dbg !300, !llvm.loop !303

if.else:                                          ; preds = %if.end
  %sub = add i64 %count, -1, !dbg !304
  %tobool832 = icmp eq i64 %count, 0, !dbg !306
  br i1 %tobool832, label %return, label %while.body9.lr.ph, !dbg !306

while.body9.lr.ph:                                ; preds = %if.else
  %add.ptr5 = getelementptr inbounds i8* %src, i64 %sub, !dbg !307
  %add.ptr = getelementptr inbounds i8* %dst, i64 %sub, !dbg !304
  %n.vec241 = and i64 %count, -32
  %cmp.zero243 = icmp eq i64 %n.vec241, 0
  br i1 %cmp.zero243, label %middle.block236, label %vector.memcheck250

vector.memcheck250:                               ; preds = %while.body9.lr.ph
  %bound1247 = icmp ule i8* %add.ptr5, %dst
  %bound0246 = icmp ule i8* %add.ptr, %src
  %memcheck.conflict249 = and i1 %bound0246, %bound1247
  %add.ptr5.sum = sub i64 %sub, %n.vec241
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %add.ptr5.sum
  %rev.ptr.ind.end255 = getelementptr i8* %dst, i64 %add.ptr5.sum
  %rev.ind.end257 = sub i64 %count, %n.vec241
  br i1 %memcheck.conflict249, label %middle.block236, label %vector.body235

vector.body235:                                   ; preds = %vector.body235, %vector.memcheck250
  %index238 = phi i64 [ %index.next260, %vector.body235 ], [ 0, %vector.memcheck250 ]
  %add.ptr5.sum465 = sub i64 %sub, %index238
  %next.gep262.sum = add i64 %add.ptr5.sum465, -15, !dbg !306
  %9 = getelementptr i8* %src, i64 %next.gep262.sum, !dbg !306
  %10 = bitcast i8* %9 to <16 x i8>*, !dbg !306
  %wide.load460 = load <16 x i8>* %10, align 1, !dbg !306
  %reverse = shufflevector <16 x i8> %wide.load460, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !306
  %.sum = add i64 %add.ptr5.sum465, -31, !dbg !306
  %11 = getelementptr i8* %src, i64 %.sum, !dbg !306
  %12 = bitcast i8* %11 to <16 x i8>*, !dbg !306
  %wide.load461 = load <16 x i8>* %12, align 1, !dbg !306
  %reverse462 = shufflevector <16 x i8> %wide.load461, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !306
  %reverse463 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !306
  %13 = getelementptr i8* %dst, i64 %next.gep262.sum, !dbg !306
  %14 = bitcast i8* %13 to <16 x i8>*, !dbg !306
  store <16 x i8> %reverse463, <16 x i8>* %14, align 1, !dbg !306
  %reverse464 = shufflevector <16 x i8> %reverse462, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !306
  %15 = getelementptr i8* %dst, i64 %.sum, !dbg !306
  %16 = bitcast i8* %15 to <16 x i8>*, !dbg !306
  store <16 x i8> %reverse464, <16 x i8>* %16, align 1, !dbg !306
  %index.next260 = add i64 %index238, 32
  %17 = icmp eq i64 %index.next260, %n.vec241
  br i1 %17, label %middle.block236, label %vector.body235, !llvm.loop !308

middle.block236:                                  ; preds = %vector.body235, %vector.memcheck250, %while.body9.lr.ph
  %resume.val251 = phi i8* [ %add.ptr5, %while.body9.lr.ph ], [ %add.ptr5, %vector.memcheck250 ], [ %rev.ptr.ind.end, %vector.body235 ]
  %resume.val253 = phi i8* [ %add.ptr, %while.body9.lr.ph ], [ %add.ptr, %vector.memcheck250 ], [ %rev.ptr.ind.end255, %vector.body235 ]
  %resume.val256 = phi i64 [ %count, %while.body9.lr.ph ], [ %count, %vector.memcheck250 ], [ %rev.ind.end257, %vector.body235 ]
  %new.indc.resume.val258 = phi i64 [ 0, %while.body9.lr.ph ], [ 0, %vector.memcheck250 ], [ %n.vec241, %vector.body235 ]
  %cmp.n259 = icmp eq i64 %new.indc.resume.val258, %count
  br i1 %cmp.n259, label %return, label %while.body9

while.body9:                                      ; preds = %while.body9, %middle.block236
  %b.135 = phi i8* [ %incdec.ptr10, %while.body9 ], [ %resume.val251, %middle.block236 ]
  %a.134 = phi i8* [ %incdec.ptr11, %while.body9 ], [ %resume.val253, %middle.block236 ]
  %count.addr.133 = phi i64 [ %dec7, %while.body9 ], [ %resume.val256, %middle.block236 ]
  %dec7 = add i64 %count.addr.133, -1, !dbg !306
  %incdec.ptr10 = getelementptr inbounds i8* %b.135, i64 -1, !dbg !306
  %18 = load i8* %b.135, align 1, !dbg !306, !tbaa !293
  %incdec.ptr11 = getelementptr inbounds i8* %a.134, i64 -1, !dbg !306
  store i8 %18, i8* %a.134, align 1, !dbg !306, !tbaa !293
  %tobool8 = icmp eq i64 %dec7, 0, !dbg !306
  br i1 %tobool8, label %return, label %while.body9, !dbg !306, !llvm.loop !309

return:                                           ; preds = %while.body9, %middle.block236, %if.else, %while.body, %middle.block, %while.cond.preheader, %entry
  ret i8* %dst, !dbg !310
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !311
  br i1 %cmp3, label %while.end, label %while.body.preheader, !dbg !311

while.body.preheader:                             ; preds = %entry
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %0 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %while.body.preheader
  %scevgep8 = getelementptr i8* %srcaddr, i64 %0
  %scevgep7 = getelementptr i8* %destaddr, i64 %0
  %bound1 = icmp uge i8* %scevgep7, %srcaddr
  %bound0 = icmp uge i8* %scevgep8, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end10 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep107 = getelementptr i8* %destaddr, i64 %index
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !312
  %wide.load = load <16 x i8>* %1, align 1, !dbg !312
  %next.gep.sum283 = or i64 %index, 16, !dbg !312
  %2 = getelementptr i8* %srcaddr, i64 %next.gep.sum283, !dbg !312
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !312
  %wide.load204 = load <16 x i8>* %3, align 1, !dbg !312
  %4 = bitcast i8* %next.gep107 to <16 x i8>*, !dbg !312
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !312
  %5 = getelementptr i8* %destaddr, i64 %next.gep.sum283, !dbg !312
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !312
  store <16 x i8> %wide.load204, <16 x i8>* %6, align 1, !dbg !312
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !313

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %while.body.preheader
  %resume.val = phi i8* [ %srcaddr, %while.body.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val9 = phi i8* [ %destaddr, %while.body.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end10, %vector.body ]
  %resume.val11 = phi i64 [ %len, %while.body.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %while.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %while.cond.while.end_crit_edge, label %while.body

while.body:                                       ; preds = %while.body, %middle.block
  %src.06 = phi i8* [ %incdec.ptr, %while.body ], [ %resume.val, %middle.block ]
  %dest.05 = phi i8* [ %incdec.ptr1, %while.body ], [ %resume.val9, %middle.block ]
  %len.addr.04 = phi i64 [ %dec, %while.body ], [ %resume.val11, %middle.block ]
  %dec = add i64 %len.addr.04, -1, !dbg !311
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !312
  %8 = load i8* %src.06, align 1, !dbg !312, !tbaa !293
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !312
  store i8 %8, i8* %dest.05, align 1, !dbg !312, !tbaa !293
  %cmp = icmp eq i64 %dec, 0, !dbg !311
  br i1 %cmp, label %while.cond.while.end_crit_edge, label %while.body, !dbg !311, !llvm.loop !314

while.cond.while.end_crit_edge:                   ; preds = %while.body, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %while.end, !dbg !311

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %entry
  %dest.0.lcssa = phi i8* [ %scevgep, %while.cond.while.end_crit_edge ], [ %destaddr, %entry ]
  ret i8* %dest.0.lcssa, !dbg !315
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
entry:
  %cmp2 = icmp eq i64 %count, 0, !dbg !316
  br i1 %cmp2, label %while.end, label %while.body.lr.ph, !dbg !316

while.body.lr.ph:                                 ; preds = %entry
  %conv = trunc i32 %s to i8, !dbg !317
  br label %while.body, !dbg !316

while.body:                                       ; preds = %while.body, %while.body.lr.ph
  %a.04 = phi i8* [ %dst, %while.body.lr.ph ], [ %incdec.ptr, %while.body ]
  %count.addr.03 = phi i64 [ %count, %while.body.lr.ph ], [ %dec, %while.body ]
  %dec = add i64 %count.addr.03, -1, !dbg !316
  %incdec.ptr = getelementptr inbounds i8* %a.04, i64 1, !dbg !317
  store volatile i8 %conv, i8* %a.04, align 1, !dbg !317, !tbaa !293
  %cmp = icmp eq i64 %dec, 0, !dbg !316
  br i1 %cmp, label %while.end, label %while.body, !dbg !316

while.end:                                        ; preds = %while.body, %entry
  ret i8* %dst, !dbg !318
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn }
attributes #8 = { nobuiltin noreturn nounwind }
attributes #9 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0, !31, !42, !56, !68, !81, !101, !116, !131}
!llvm.module.flags = !{!147, !148}
!llvm.ident = !{!149, !149, !149, !149, !149, !149, !149, !149, !149}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !19, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!1 = metadata !{metadata !"railroad.c", metadata !"/home/rasool/POPL2021-CONCUR/railroad-tx"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !9, metadata !10, metadata !11, metadata !12, metadata !13, metadata !14, metadata !15, metadata !16}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 25, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 25} ; [ DW_TAG_subprogram ] [
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"tick", metadata !"tick", metadata !"", i32 42, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @tick, null, null, metadata !2, i32 42} ; [ DW_TAG_subprogram ] [
!10 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"reset_g", metadata !"reset_g", metadata !"", i32 43, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @reset_g, null, null, metadata !2, i32 43} ; [ DW_TAG_subp
!11 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"reset_t", metadata !"reset_t", metadata !"", i32 44, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @reset_t, null, null, metadata !2, i32 44} ; [ DW_TAG_subp
!12 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"reset_c", metadata !"reset_c", metadata !"", i32 45, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @reset_c, null, null, metadata !2, i32 45} ; [ DW_TAG_subp
!13 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"train", metadata !"train", metadata !"", i32 47, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @train, null, null, metadata !2, i32 47} ; [ DW_TAG_subprogram
!14 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"gate", metadata !"gate", metadata !"", i32 56, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @gate, null, null, metadata !2, i32 56} ; [ DW_TAG_subprogram ] 
!15 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"controller", metadata !"controller", metadata !"", i32 66, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @controller, null, null, metadata !2, i32 66} ; [ DW
!16 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"print_state", metadata !"print_state", metadata !"", i32 77, metadata !17, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @print_state, null, null, metadata !2, i32 
!17 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !18, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!18 = metadata !{null, metadata !8}
!19 = metadata !{metadata !20, metadata !21, metadata !22, metadata !23, metadata !24, metadata !25, metadata !26, metadata !27, metadata !28, metadata !29, metadata !30}
!20 = metadata !{i32 786484, i32 0, null, metadata !"limit", metadata !"limit", metadata !"", metadata !5, i32 16, metadata !8, i32 0, i32 1, i32* @limit, null} ; [ DW_TAG_variable ] [limit] [line 16] [def]
!21 = metadata !{i32 786484, i32 0, null, metadata !"clock_t", metadata !"clock_t", metadata !"", metadata !5, i32 17, metadata !8, i32 0, i32 1, i32* @clock_t, null} ; [ DW_TAG_variable ] [clock_t] [line 17] [def]
!22 = metadata !{i32 786484, i32 0, null, metadata !"clock_g", metadata !"clock_g", metadata !"", metadata !5, i32 17, metadata !8, i32 0, i32 1, i32* @clock_g, null} ; [ DW_TAG_variable ] [clock_g] [line 17] [def]
!23 = metadata !{i32 786484, i32 0, null, metadata !"clock_c", metadata !"clock_c", metadata !"", metadata !5, i32 17, metadata !8, i32 0, i32 1, i32* @clock_c, null} ; [ DW_TAG_variable ] [clock_c] [line 17] [def]
!24 = metadata !{i32 786484, i32 0, null, metadata !"pc_TRAIN", metadata !"pc_TRAIN", metadata !"", metadata !5, i32 18, metadata !8, i32 0, i32 1, i32* @pc_TRAIN, null} ; [ DW_TAG_variable ] [pc_TRAIN] [line 18] [def]
!25 = metadata !{i32 786484, i32 0, null, metadata !"pc_GATE", metadata !"pc_GATE", metadata !"", metadata !5, i32 18, metadata !8, i32 0, i32 1, i32* @pc_GATE, null} ; [ DW_TAG_variable ] [pc_GATE] [line 18] [def]
!26 = metadata !{i32 786484, i32 0, null, metadata !"pc_CONTROLLER", metadata !"pc_CONTROLLER", metadata !"", metadata !5, i32 18, metadata !8, i32 0, i32 1, i32* @pc_CONTROLLER, null} ; [ DW_TAG_variable ] [pc_CONTROLLER] [line 18] [def]
!27 = metadata !{i32 786484, i32 0, null, metadata !"RAISE", metadata !"RAISE", metadata !"", metadata !5, i32 19, metadata !8, i32 0, i32 1, i32* @RAISE, null} ; [ DW_TAG_variable ] [RAISE] [line 19] [def]
!28 = metadata !{i32 786484, i32 0, null, metadata !"APPROACH", metadata !"APPROACH", metadata !"", metadata !5, i32 19, metadata !8, i32 0, i32 1, i32* @APPROACH, null} ; [ DW_TAG_variable ] [APPROACH] [line 19] [def]
!29 = metadata !{i32 786484, i32 0, null, metadata !"LOWER", metadata !"LOWER", metadata !"", metadata !5, i32 19, metadata !8, i32 0, i32 1, i32* @LOWER, null} ; [ DW_TAG_variable ] [LOWER] [line 19] [def]
!30 = metadata !{i32 786484, i32 0, null, metadata !"EXIT", metadata !"EXIT", metadata !"", metadata !5, i32 19, metadata !8, i32 0, i32 1, i32* @EXIT, null} ; [ DW_TAG_variable ] [EXIT] [line 19] [def]
!31 = metadata !{i32 786449, metadata !32, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !33, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!32 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!33 = metadata !{metadata !34}
!34 = metadata !{i32 786478, metadata !35, metadata !36, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !37, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!35 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!36 = metadata !{i32 786473, metadata !35}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_div_zero_check.c]
!37 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !38, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!38 = metadata !{null, metadata !39}
!39 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!40 = metadata !{metadata !41}
!41 = metadata !{i32 786689, metadata !34, metadata !"z", metadata !36, i32 16777228, metadata !39, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!42 = metadata !{i32 786449, metadata !43, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !44, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!43 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_int.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!44 = metadata !{metadata !45}
!45 = metadata !{i32 786478, metadata !46, metadata !47, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !48, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !53, i32 13} ; [ 
!46 = metadata !{metadata !"klee_int.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!47 = metadata !{i32 786473, metadata !46}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_int.c]
!48 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !49, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!49 = metadata !{metadata !8, metadata !50}
!50 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !51} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!51 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!52 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!53 = metadata !{metadata !54, metadata !55}
!54 = metadata !{i32 786689, metadata !45, metadata !"name", metadata !47, i32 16777229, metadata !50, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!55 = metadata !{i32 786688, metadata !45, metadata !"x", metadata !47, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!56 = metadata !{i32 786449, metadata !57, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !58, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!57 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!58 = metadata !{metadata !59}
!59 = metadata !{i32 786478, metadata !60, metadata !61, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !62, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!60 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!61 = metadata !{i32 786473, metadata !60}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c]
!62 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !63, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!63 = metadata !{null, metadata !64, metadata !64}
!64 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!65 = metadata !{metadata !66, metadata !67}
!66 = metadata !{i32 786689, metadata !59, metadata !"bitWidth", metadata !61, i32 16777236, metadata !64, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!67 = metadata !{i32 786689, metadata !59, metadata !"shift", metadata !61, i32 33554452, metadata !64, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!68 = metadata !{i32 786449, metadata !69, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !70, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!69 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_range.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!70 = metadata !{metadata !71}
!71 = metadata !{i32 786478, metadata !72, metadata !73, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !74, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!72 = metadata !{metadata !"klee_range.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!73 = metadata !{i32 786473, metadata !72}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!74 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !75, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!75 = metadata !{metadata !8, metadata !8, metadata !8, metadata !50}
!76 = metadata !{metadata !77, metadata !78, metadata !79, metadata !80}
!77 = metadata !{i32 786689, metadata !71, metadata !"start", metadata !73, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!78 = metadata !{i32 786689, metadata !71, metadata !"end", metadata !73, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!79 = metadata !{i32 786689, metadata !71, metadata !"name", metadata !73, i32 50331661, metadata !50, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!80 = metadata !{i32 786688, metadata !71, metadata !"x", metadata !73, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!81 = metadata !{i32 786449, metadata !82, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !83, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!82 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/memcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!83 = metadata !{metadata !84}
!84 = metadata !{i32 786478, metadata !85, metadata !86, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !87, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !94, i32 12} 
!85 = metadata !{metadata !"memcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!86 = metadata !{i32 786473, metadata !85}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/memcpy.c]
!87 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !88, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!88 = metadata !{metadata !89, metadata !89, metadata !90, metadata !92}
!89 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!90 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !91} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!91 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!92 = metadata !{i32 786454, metadata !85, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !93} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!93 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!94 = metadata !{metadata !95, metadata !96, metadata !97, metadata !98, metadata !100}
!95 = metadata !{i32 786689, metadata !84, metadata !"destaddr", metadata !86, i32 16777228, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!96 = metadata !{i32 786689, metadata !84, metadata !"srcaddr", metadata !86, i32 33554444, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!97 = metadata !{i32 786689, metadata !84, metadata !"len", metadata !86, i32 50331660, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!98 = metadata !{i32 786688, metadata !84, metadata !"dest", metadata !86, i32 13, metadata !99, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!99 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !52} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!100 = metadata !{i32 786688, metadata !84, metadata !"src", metadata !86, i32 14, metadata !50, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!101 = metadata !{i32 786449, metadata !102, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !103, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!102 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/memmove.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!103 = metadata !{metadata !104}
!104 = metadata !{i32 786478, metadata !105, metadata !106, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !107, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !110, 
!105 = metadata !{metadata !"memmove.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!106 = metadata !{i32 786473, metadata !105}      ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!107 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !108, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!108 = metadata !{metadata !89, metadata !89, metadata !90, metadata !109}
!109 = metadata !{i32 786454, metadata !105, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !93} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!110 = metadata !{metadata !111, metadata !112, metadata !113, metadata !114, metadata !115}
!111 = metadata !{i32 786689, metadata !104, metadata !"dst", metadata !106, i32 16777228, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!112 = metadata !{i32 786689, metadata !104, metadata !"src", metadata !106, i32 33554444, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!113 = metadata !{i32 786689, metadata !104, metadata !"count", metadata !106, i32 50331660, metadata !109, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!114 = metadata !{i32 786688, metadata !104, metadata !"a", metadata !106, i32 13, metadata !99, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!115 = metadata !{i32 786688, metadata !104, metadata !"b", metadata !106, i32 14, metadata !50, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!116 = metadata !{i32 786449, metadata !117, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !118, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!117 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/mempcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!118 = metadata !{metadata !119}
!119 = metadata !{i32 786478, metadata !120, metadata !121, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !122, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !125, 
!120 = metadata !{metadata !"mempcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!121 = metadata !{i32 786473, metadata !120}      ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/mempcpy.c]
!122 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !123, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!123 = metadata !{metadata !89, metadata !89, metadata !90, metadata !124}
!124 = metadata !{i32 786454, metadata !120, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !93} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!125 = metadata !{metadata !126, metadata !127, metadata !128, metadata !129, metadata !130}
!126 = metadata !{i32 786689, metadata !119, metadata !"destaddr", metadata !121, i32 16777227, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!127 = metadata !{i32 786689, metadata !119, metadata !"srcaddr", metadata !121, i32 33554443, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!128 = metadata !{i32 786689, metadata !119, metadata !"len", metadata !121, i32 50331659, metadata !124, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!129 = metadata !{i32 786688, metadata !119, metadata !"dest", metadata !121, i32 12, metadata !99, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!130 = metadata !{i32 786688, metadata !119, metadata !"src", metadata !121, i32 13, metadata !50, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!131 = metadata !{i32 786449, metadata !132, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !133, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!132 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/memset.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!133 = metadata !{metadata !134}
!134 = metadata !{i32 786478, metadata !135, metadata !136, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !137, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !140, i32
!135 = metadata !{metadata !"memset.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!136 = metadata !{i32 786473, metadata !135}      ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/memset.c]
!137 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !138, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!138 = metadata !{metadata !89, metadata !89, metadata !8, metadata !139}
!139 = metadata !{i32 786454, metadata !135, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !93} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!140 = metadata !{metadata !141, metadata !142, metadata !143, metadata !144}
!141 = metadata !{i32 786689, metadata !134, metadata !"dst", metadata !136, i32 16777227, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!142 = metadata !{i32 786689, metadata !134, metadata !"s", metadata !136, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!143 = metadata !{i32 786689, metadata !134, metadata !"count", metadata !136, i32 50331659, metadata !139, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!144 = metadata !{i32 786688, metadata !134, metadata !"a", metadata !136, i32 12, metadata !145, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!145 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !146} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!146 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!147 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!148 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!149 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!150 = metadata !{i32 26, i32 0, metadata !4, null}
!151 = metadata !{i32 28, i32 0, metadata !4, null}
!152 = metadata !{i32 30, i32 0, metadata !153, null}
!153 = metadata !{i32 786443, metadata !1, metadata !4, i32 29, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!154 = metadata !{i32 31, i32 0, metadata !153, null}
!155 = metadata !{i32 32, i32 0, metadata !153, null}
!156 = metadata !{i32 33, i32 0, metadata !157, null}
!157 = metadata !{i32 786443, metadata !1, metadata !153, i32 32, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!158 = metadata !{i32 34, i32 0, metadata !157, null}
!159 = metadata !{i32 35, i32 0, metadata !157, null}
!160 = metadata !{i32 36, i32 0, metadata !157, null}
!161 = metadata !{i32 37, i32 0, metadata !153, null}
!162 = metadata !{i32 38, i32 0, metadata !4, null}
!163 = metadata !{i32 39, i32 0, metadata !4, null}
!164 = metadata !{i32 42, i32 0, metadata !9, null}
!165 = metadata !{i32 43, i32 0, metadata !10, null}
!166 = metadata !{i32 44, i32 0, metadata !11, null}
!167 = metadata !{i32 45, i32 0, metadata !12, null}
!168 = metadata !{i32 49, i32 0, metadata !13, null}
!169 = metadata !{i32 50, i32 0, metadata !170, null}
!170 = metadata !{i32 786443, metadata !1, metadata !13, i32 49, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!171 = metadata !{i32 51, i32 0, metadata !172, null}
!172 = metadata !{i32 786443, metadata !1, metadata !170, i32 51, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!173 = metadata !{i32 51, i32 0, metadata !174, null}
!174 = metadata !{i32 786443, metadata !1, metadata !172, i32 51, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!175 = metadata !{i32 51, i32 0, metadata !176, null}
!176 = metadata !{i32 786443, metadata !1, metadata !172, i32 51, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!177 = metadata !{i32 51, i32 0, metadata !170, null}
!178 = metadata !{i32 52, i32 0, metadata !179, null}
!179 = metadata !{i32 786443, metadata !1, metadata !170, i32 52, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!180 = metadata !{i32 52, i32 0, metadata !181, null}
!181 = metadata !{i32 786443, metadata !1, metadata !179, i32 52, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!182 = metadata !{i32 52, i32 0, metadata !183, null}
!183 = metadata !{i32 786443, metadata !1, metadata !179, i32 52, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!184 = metadata !{i32 52, i32 0, metadata !170, null}
!185 = metadata !{i32 54, i32 0, metadata !13, null}
!186 = metadata !{i32 58, i32 0, metadata !14, null} ; [ DW_TAG_imported_module ]
!187 = metadata !{i32 59, i32 0, metadata !188, null}
!188 = metadata !{i32 786443, metadata !1, metadata !189, i32 59, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!189 = metadata !{i32 786443, metadata !1, metadata !14, i32 58, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!190 = metadata !{i32 59, i32 0, metadata !191, null}
!191 = metadata !{i32 786443, metadata !1, metadata !188, i32 59, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!192 = metadata !{i32 59, i32 0, metadata !193, null}
!193 = metadata !{i32 786443, metadata !1, metadata !188, i32 59, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!194 = metadata !{i32 59, i32 0, metadata !189, null}
!195 = metadata !{i32 60, i32 0, metadata !196, null}
!196 = metadata !{i32 786443, metadata !1, metadata !189, i32 60, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!197 = metadata !{i32 60, i32 0, metadata !198, null}
!198 = metadata !{i32 786443, metadata !1, metadata !196, i32 60, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!199 = metadata !{i32 60, i32 0, metadata !200, null}
!200 = metadata !{i32 786443, metadata !1, metadata !196, i32 60, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!201 = metadata !{i32 60, i32 0, metadata !189, null}
!202 = metadata !{i32 61, i32 0, metadata !203, null}
!203 = metadata !{i32 786443, metadata !1, metadata !189, i32 61, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!204 = metadata !{i32 61, i32 0, metadata !205, null}
!205 = metadata !{i32 786443, metadata !1, metadata !203, i32 61, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!206 = metadata !{i32 61, i32 0, metadata !207, null}
!207 = metadata !{i32 786443, metadata !1, metadata !203, i32 61, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!208 = metadata !{i32 61, i32 0, metadata !189, null}
!209 = metadata !{i32 62, i32 0, metadata !210, null}
!210 = metadata !{i32 786443, metadata !1, metadata !189, i32 62, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!211 = metadata !{i32 62, i32 0, metadata !212, null}
!212 = metadata !{i32 786443, metadata !1, metadata !210, i32 62, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!213 = metadata !{i32 62, i32 0, metadata !214, null}
!214 = metadata !{i32 786443, metadata !1, metadata !210, i32 62, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!215 = metadata !{i32 62, i32 0, metadata !189, null}
!216 = metadata !{i32 64, i32 0, metadata !14, null}
!217 = metadata !{i32 68, i32 0, metadata !15, null}
!218 = metadata !{i32 69, i32 0, metadata !219, null}
!219 = metadata !{i32 786443, metadata !1, metadata !220, i32 69, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!220 = metadata !{i32 786443, metadata !1, metadata !15, i32 68, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!221 = metadata !{i32 69, i32 0, metadata !222, null}
!222 = metadata !{i32 786443, metadata !1, metadata !219, i32 69, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!223 = metadata !{i32 69, i32 0, metadata !224, null}
!224 = metadata !{i32 786443, metadata !1, metadata !219, i32 69, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!225 = metadata !{i32 69, i32 0, metadata !220, null}
!226 = metadata !{i32 70, i32 0, metadata !227, null}
!227 = metadata !{i32 786443, metadata !1, metadata !220, i32 70, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!228 = metadata !{i32 70, i32 0, metadata !229, null}
!229 = metadata !{i32 786443, metadata !1, metadata !227, i32 70, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!230 = metadata !{i32 70, i32 0, metadata !231, null}
!231 = metadata !{i32 786443, metadata !1, metadata !227, i32 70, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!232 = metadata !{i32 70, i32 0, metadata !220, null}
!233 = metadata !{i32 71, i32 0, metadata !234, null}
!234 = metadata !{i32 786443, metadata !1, metadata !220, i32 71, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!235 = metadata !{i32 71, i32 0, metadata !236, null}
!236 = metadata !{i32 786443, metadata !1, metadata !234, i32 71, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!237 = metadata !{i32 71, i32 0, metadata !238, null}
!238 = metadata !{i32 786443, metadata !1, metadata !234, i32 71, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!239 = metadata !{i32 71, i32 0, metadata !220, null}
!240 = metadata !{i32 72, i32 0, metadata !241, null}
!241 = metadata !{i32 786443, metadata !1, metadata !220, i32 72, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!242 = metadata !{i32 72, i32 0, metadata !243, null}
!243 = metadata !{i32 786443, metadata !1, metadata !241, i32 72, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!244 = metadata !{i32 72, i32 0, metadata !245, null}
!245 = metadata !{i32 786443, metadata !1, metadata !241, i32 72, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!246 = metadata !{i32 72, i32 0, metadata !220, null}
!247 = metadata !{i32 74, i32 0, metadata !15, null}
!248 = metadata !{i32 79, i32 0, metadata !16, null}
!249 = metadata !{i32 80, i32 0, metadata !250, null}
!250 = metadata !{i32 786443, metadata !1, metadata !16, i32 80, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!251 = metadata !{i32 81, i32 0, metadata !252, null}
!252 = metadata !{i32 786443, metadata !1, metadata !250, i32 81, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!253 = metadata !{i32 82, i32 0, metadata !254, null}
!254 = metadata !{i32 786443, metadata !1, metadata !252, i32 82, i32 0, i32 37} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/railroad-tx/railroad.c]
!255 = metadata !{i32 85, i32 0, metadata !16, null}
!256 = metadata !{i32 13, i32 0, metadata !257, null}
!257 = metadata !{i32 786443, metadata !35, metadata !34, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_div_zero_check.c]
!258 = metadata !{i32 14, i32 0, metadata !257, null}
!259 = metadata !{i32 15, i32 0, metadata !34, null}
!260 = metadata !{i32 15, i32 0, metadata !45, null}
!261 = metadata !{i32 16, i32 0, metadata !45, null}
!262 = metadata !{metadata !263, metadata !263, i64 0}
!263 = metadata !{metadata !"int", metadata !264, i64 0}
!264 = metadata !{metadata !"omnipotent char", metadata !265, i64 0}
!265 = metadata !{metadata !"Simple C/C++ TBAA"}
!266 = metadata !{i32 21, i32 0, metadata !267, null}
!267 = metadata !{i32 786443, metadata !60, metadata !59, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c]
!268 = metadata !{i32 27, i32 0, metadata !269, null}
!269 = metadata !{i32 786443, metadata !60, metadata !267, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c]
!270 = metadata !{i32 29, i32 0, metadata !59, null}
!271 = metadata !{i32 16, i32 0, metadata !272, null}
!272 = metadata !{i32 786443, metadata !72, metadata !71, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!273 = metadata !{i32 17, i32 0, metadata !272, null}
!274 = metadata !{i32 19, i32 0, metadata !275, null}
!275 = metadata !{i32 786443, metadata !72, metadata !71, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!276 = metadata !{i32 22, i32 0, metadata !277, null}
!277 = metadata !{i32 786443, metadata !72, metadata !275, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!278 = metadata !{i32 25, i32 0, metadata !279, null}
!279 = metadata !{i32 786443, metadata !72, metadata !277, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!280 = metadata !{i32 26, i32 0, metadata !281, null}
!281 = metadata !{i32 786443, metadata !72, metadata !279, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!282 = metadata !{i32 27, i32 0, metadata !281, null}
!283 = metadata !{i32 28, i32 0, metadata !284, null}
!284 = metadata !{i32 786443, metadata !72, metadata !279, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!285 = metadata !{i32 29, i32 0, metadata !284, null}
!286 = metadata !{i32 32, i32 0, metadata !277, null}
!287 = metadata !{i32 34, i32 0, metadata !71, null}
!288 = metadata !{i32 16, i32 0, metadata !84, null}
!289 = metadata !{i32 17, i32 0, metadata !84, null}
!290 = metadata !{metadata !290, metadata !291, metadata !292}
!291 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!292 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!293 = metadata !{metadata !264, metadata !264, i64 0}
!294 = metadata !{metadata !294, metadata !291, metadata !292}
!295 = metadata !{i32 18, i32 0, metadata !84, null}
!296 = metadata !{i32 16, i32 0, metadata !297, null}
!297 = metadata !{i32 786443, metadata !105, metadata !104, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!298 = metadata !{i32 19, i32 0, metadata !299, null}
!299 = metadata !{i32 786443, metadata !105, metadata !104, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!300 = metadata !{i32 20, i32 0, metadata !301, null}
!301 = metadata !{i32 786443, metadata !105, metadata !299, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!302 = metadata !{metadata !302, metadata !291, metadata !292}
!303 = metadata !{metadata !303, metadata !291, metadata !292}
!304 = metadata !{i32 22, i32 0, metadata !305, null}
!305 = metadata !{i32 786443, metadata !105, metadata !299, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!306 = metadata !{i32 24, i32 0, metadata !305, null}
!307 = metadata !{i32 23, i32 0, metadata !305, null}
!308 = metadata !{metadata !308, metadata !291, metadata !292}
!309 = metadata !{metadata !309, metadata !291, metadata !292}
!310 = metadata !{i32 28, i32 0, metadata !104, null}
!311 = metadata !{i32 15, i32 0, metadata !119, null}
!312 = metadata !{i32 16, i32 0, metadata !119, null}
!313 = metadata !{metadata !313, metadata !291, metadata !292}
!314 = metadata !{metadata !314, metadata !291, metadata !292}
!315 = metadata !{i32 17, i32 0, metadata !119, null}
!316 = metadata !{i32 13, i32 0, metadata !134, null}
!317 = metadata !{i32 14, i32 0, metadata !134, null}
!318 = metadata !{i32 15, i32 0, metadata !134, null}
