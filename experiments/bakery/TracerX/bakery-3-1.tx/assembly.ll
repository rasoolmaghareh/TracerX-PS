; ModuleID = 'bakery.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@limit = global i32 1, align 4
@n_bread = global i32 0, align 4
@.str = private unnamed_addr constant [2 x i8] c"c\00", align 1
@.str1 = private unnamed_addr constant [15 x i8] c"Id: %d, PC %d\0A\00", align 1
@pc = common global [3 x i32] zeroinitializer, align 4
@ticket = common global [3 x i32] zeroinitializer, align 4
@.str2 = private unnamed_addr constant [17 x i8] c"Return level %d\0A\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"Bread: \00", align 1
@bread = common global [9 x i32] zeroinitializer, align 16
@.str4 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str6 = private unnamed_addr constant [7 x i8] c"MUTEX \00", align 1
@.str7 = private unnamed_addr constant [8 x i8] c"ERROR!\0A\00", align 1
@.str8 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str9 = private unnamed_addr constant [9 x i8] c"bakery.c\00", align 1
@__PRETTY_FUNCTION__.mutex = private unnamed_addr constant [16 x i8] c"void mutex(int)\00", align 1
@.str10 = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str111 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str212 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str313 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str614 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %level = alloca i32, align 4
  %id = alloca i32, align 4
  %c = alloca i32, align 4
  %i = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 0, i32* %level, align 4, !dbg !147
  br label %while.cond, !dbg !148

while.cond:                                       ; preds = %sw.epilog, %entry
  %0 = load i32* @limit, align 4, !dbg !148
  %cmp = icmp sgt i32 %0, 0, !dbg !148
  br i1 %cmp, label %while.body, label %while.end, !dbg !148

while.body:                                       ; preds = %while.cond
  store i32 0, i32* %id, align 4, !dbg !149
  %call = call i32 @klee_range(i32 0, i32 3, i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0)), !dbg !151
  store i32 %call, i32* %c, align 4, !dbg !151
  store i32 1, i32* %i, align 4, !dbg !152
  br label %for.cond, !dbg !152

for.cond:                                         ; preds = %for.inc, %while.body
  %1 = load i32* %i, align 4, !dbg !152
  %2 = load i32* %c, align 4, !dbg !152
  %cmp1 = icmp sle i32 %1, %2, !dbg !152
  br i1 %cmp1, label %for.body, label %for.end, !dbg !152

for.body:                                         ; preds = %for.cond
  %3 = load i32* %i, align 4, !dbg !154
  store i32 %3, i32* %id, align 4, !dbg !154
  br label %for.inc, !dbg !156

for.inc:                                          ; preds = %for.body
  %4 = load i32* %i, align 4, !dbg !152
  %inc = add nsw i32 %4, 1, !dbg !152
  store i32 %inc, i32* %i, align 4, !dbg !152
  br label %for.cond, !dbg !152

for.end:                                          ; preds = %for.cond
  %5 = load i32* %id, align 4, !dbg !157
  %6 = load i32* %id, align 4, !dbg !157
  %idxprom = sext i32 %6 to i64, !dbg !157
  %arrayidx = getelementptr inbounds [3 x i32]* @pc, i32 0, i64 %idxprom, !dbg !157
  %7 = load i32* %arrayidx, align 4, !dbg !157
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str1, i32 0, i32 0), i32 %5, i32 %7), !dbg !157
  %8 = load i32* %id, align 4, !dbg !158
  %idxprom3 = sext i32 %8 to i64, !dbg !158
  %arrayidx4 = getelementptr inbounds [3 x i32]* @pc, i32 0, i64 %idxprom3, !dbg !158
  %9 = load i32* %arrayidx4, align 4, !dbg !158
  switch i32 %9, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb11
    i32 2, label %sw.bb16
  ], !dbg !158

sw.bb:                                            ; preds = %for.end
  %call5 = call i32 @maxticket(), !dbg !159
  %add = add nsw i32 %call5, 1, !dbg !159
  %10 = load i32* %id, align 4, !dbg !159
  %idxprom6 = sext i32 %10 to i64, !dbg !159
  %arrayidx7 = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom6, !dbg !159
  store i32 %add, i32* %arrayidx7, align 4, !dbg !159
  %11 = load i32* %id, align 4, !dbg !159
  %idxprom8 = sext i32 %11 to i64, !dbg !159
  %arrayidx9 = getelementptr inbounds [3 x i32]* @pc, i32 0, i64 %idxprom8, !dbg !159
  store i32 1, i32* %arrayidx9, align 4, !dbg !159
  %12 = load i32* %level, align 4, !dbg !159
  %inc10 = add nsw i32 %12, 1, !dbg !159
  store i32 %inc10, i32* %level, align 4, !dbg !159
  br label %sw.epilog, !dbg !159

sw.bb11:                                          ; preds = %for.end
  %13 = load i32* %id, align 4, !dbg !161
  %call12 = call i32 @minticket(i32 %13), !dbg !161
  %tobool = icmp ne i32 %call12, 0, !dbg !161
  br i1 %tobool, label %if.then, label %if.else, !dbg !161

if.then:                                          ; preds = %sw.bb11
  %14 = load i32* %id, align 4, !dbg !163
  call void @mutex(i32 %14), !dbg !163
  %15 = load i32* %id, align 4, !dbg !163
  %idxprom13 = sext i32 %15 to i64, !dbg !163
  %arrayidx14 = getelementptr inbounds [3 x i32]* @pc, i32 0, i64 %idxprom13, !dbg !163
  store i32 2, i32* %arrayidx14, align 4, !dbg !163
  %16 = load i32* %level, align 4, !dbg !163
  %inc15 = add nsw i32 %16, 1, !dbg !163
  store i32 %inc15, i32* %level, align 4, !dbg !163
  br label %if.end, !dbg !163

if.else:                                          ; preds = %sw.bb11
  call void @exit(i32 0) #7, !dbg !165
  unreachable, !dbg !165

if.end:                                           ; preds = %if.then
  br label %sw.epilog, !dbg !167

sw.bb16:                                          ; preds = %for.end
  %17 = load i32* %id, align 4, !dbg !168
  %idxprom17 = sext i32 %17 to i64, !dbg !168
  %arrayidx18 = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom17, !dbg !168
  store i32 0, i32* %arrayidx18, align 4, !dbg !168
  %18 = load i32* %id, align 4, !dbg !168
  %idxprom19 = sext i32 %18 to i64, !dbg !168
  %arrayidx20 = getelementptr inbounds [3 x i32]* @pc, i32 0, i64 %idxprom19, !dbg !168
  store i32 0, i32* %arrayidx20, align 4, !dbg !168
  %19 = load i32* %level, align 4, !dbg !168
  %inc21 = add nsw i32 %19, 1, !dbg !168
  store i32 %inc21, i32* %level, align 4, !dbg !168
  br label %sw.epilog, !dbg !169

sw.epilog:                                        ; preds = %sw.bb16, %if.end, %sw.bb, %for.end
  %20 = load i32* %level, align 4, !dbg !170
  %call22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i32 %20), !dbg !170
  br label %while.cond, !dbg !171

while.end:                                        ; preds = %while.cond
  %call23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str3, i32 0, i32 0)), !dbg !172
  store i32 0, i32* %b, align 4, !dbg !173
  br label %for.cond24, !dbg !173

for.cond24:                                       ; preds = %for.inc33, %while.end
  %21 = load i32* %b, align 4, !dbg !173
  %cmp25 = icmp slt i32 %21, 9, !dbg !173
  br i1 %cmp25, label %land.lhs.true, label %for.end35, !dbg !173

land.lhs.true:                                    ; preds = %for.cond24
  %22 = load i32* %b, align 4, !dbg !173
  %idxprom26 = sext i32 %22 to i64, !dbg !173
  %arrayidx27 = getelementptr inbounds [9 x i32]* @bread, i32 0, i64 %idxprom26, !dbg !173
  %23 = load i32* %arrayidx27, align 4, !dbg !173
  %cmp28 = icmp ne i32 %23, -1, !dbg !173
  br i1 %cmp28, label %for.body29, label %for.end35, !dbg !173

for.body29:                                       ; preds = %land.lhs.true
  %24 = load i32* %b, align 4, !dbg !173
  %idxprom30 = sext i32 %24 to i64, !dbg !173
  %arrayidx31 = getelementptr inbounds [9 x i32]* @bread, i32 0, i64 %idxprom30, !dbg !173
  %25 = load i32* %arrayidx31, align 4, !dbg !173
  %call32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i32 %25), !dbg !173
  br label %for.inc33, !dbg !173

for.inc33:                                        ; preds = %for.body29
  %26 = load i32* %b, align 4, !dbg !173
  %inc34 = add nsw i32 %26, 1, !dbg !173
  store i32 %inc34, i32* %b, align 4, !dbg !173
  br label %for.cond24, !dbg !173

for.end35:                                        ; preds = %land.lhs.true, %for.cond24
  %call36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str5, i32 0, i32 0)), !dbg !175
  ret i32 0, !dbg !176
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define i32 @minticket(i32 %id) #0 {
entry:
  %retval = alloca i32, align 4
  %id.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %id, i32* %id.addr, align 4
  store i32 0, i32* %i, align 4, !dbg !177
  br label %for.cond, !dbg !177

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4, !dbg !177
  %cmp = icmp slt i32 %0, 3, !dbg !177
  br i1 %cmp, label %for.body, label %for.end, !dbg !177

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4, !dbg !179
  %idxprom = sext i32 %1 to i64, !dbg !179
  %arrayidx = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom, !dbg !179
  %2 = load i32* %arrayidx, align 4, !dbg !179
  %cmp1 = icmp ne i32 %2, 0, !dbg !179
  br i1 %cmp1, label %land.lhs.true, label %if.end, !dbg !179

land.lhs.true:                                    ; preds = %for.body
  %3 = load i32* %id.addr, align 4, !dbg !179
  %idxprom2 = sext i32 %3 to i64, !dbg !179
  %arrayidx3 = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom2, !dbg !179
  %4 = load i32* %arrayidx3, align 4, !dbg !179
  %5 = load i32* %i, align 4, !dbg !179
  %idxprom4 = sext i32 %5 to i64, !dbg !179
  %arrayidx5 = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom4, !dbg !179
  %6 = load i32* %arrayidx5, align 4, !dbg !179
  %cmp6 = icmp sgt i32 %4, %6, !dbg !179
  br i1 %cmp6, label %if.then, label %if.end, !dbg !179

if.then:                                          ; preds = %land.lhs.true
  store i32 0, i32* %retval, !dbg !179
  br label %return, !dbg !179

if.end:                                           ; preds = %land.lhs.true, %for.body
  br label %for.inc, !dbg !179

for.inc:                                          ; preds = %if.end
  %7 = load i32* %i, align 4, !dbg !177
  %inc = add nsw i32 %7, 1, !dbg !177
  store i32 %inc, i32* %i, align 4, !dbg !177
  br label %for.cond, !dbg !177

for.end:                                          ; preds = %for.cond
  store i32 1, i32* %retval, !dbg !181
  br label %return, !dbg !181

return:                                           ; preds = %for.end, %if.then
  %8 = load i32* %retval, !dbg !182
  ret i32 %8, !dbg !182
}

; Function Attrs: nounwind uwtable
define void @mutex(i32 %id) #0 {
entry:
  %id.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %id, i32* %id.addr, align 4
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str6, i32 0, i32 0)), !dbg !183
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str5, i32 0, i32 0)), !dbg !183
  store i32 0, i32* %i, align 4, !dbg !184
  br label %for.cond, !dbg !184

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4, !dbg !184
  %cmp = icmp slt i32 %0, 3, !dbg !184
  br i1 %cmp, label %for.body, label %for.end, !dbg !184

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4, !dbg !186
  %2 = load i32* %id.addr, align 4, !dbg !186
  %cmp2 = icmp ne i32 %1, %2, !dbg !186
  br i1 %cmp2, label %land.lhs.true, label %if.end, !dbg !186

land.lhs.true:                                    ; preds = %for.body
  %3 = load i32* %i, align 4, !dbg !186
  %idxprom = sext i32 %3 to i64, !dbg !186
  %arrayidx = getelementptr inbounds [3 x i32]* @pc, i32 0, i64 %idxprom, !dbg !186
  %4 = load i32* %arrayidx, align 4, !dbg !186
  %cmp3 = icmp eq i32 %4, 2, !dbg !186
  br i1 %cmp3, label %if.then, label %if.end, !dbg !186

if.then:                                          ; preds = %land.lhs.true
  %call4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str7, i32 0, i32 0)), !dbg !188
  %call5 = call i32 (i8*, i8*, i32, i8*, ...)* bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* getelementptr inbounds ([2 x i8]* @.str8, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str9, i32 0, i32 0), i32 48, i8* get
  br label %if.end, !dbg !188

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body
  br label %for.inc, !dbg !186

for.inc:                                          ; preds = %if.end
  %5 = load i32* %i, align 4, !dbg !184
  %inc = add nsw i32 %5, 1, !dbg !184
  store i32 %inc, i32* %i, align 4, !dbg !184
  br label %for.cond, !dbg !184

for.end:                                          ; preds = %for.cond
  %6 = load i32* @limit, align 4, !dbg !190
  %dec = add nsw i32 %6, -1, !dbg !190
  store i32 %dec, i32* @limit, align 4, !dbg !190
  %7 = load i32* %id.addr, align 4, !dbg !191
  %8 = load i32* @n_bread, align 4, !dbg !191
  %inc6 = add nsw i32 %8, 1, !dbg !191
  store i32 %inc6, i32* @n_bread, align 4, !dbg !191
  %idxprom7 = sext i32 %8 to i64, !dbg !191
  %arrayidx8 = getelementptr inbounds [9 x i32]* @bread, i32 0, i64 %idxprom7, !dbg !191
  store i32 %7, i32* %arrayidx8, align 4, !dbg !191
  ret void, !dbg !192
}

; Function Attrs: noreturn
declare void @exit(i32) #3

; Function Attrs: noreturn
declare i32 @__assert_fail(...) #3

; Function Attrs: nounwind uwtable
define i32 @maxticket() #0 {
entry:
  %max = alloca i32, align 4
  %id = alloca i32, align 4
  store i32 -1, i32* %max, align 4, !dbg !193
  store i32 0, i32* %id, align 4, !dbg !194
  br label %for.cond, !dbg !194

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %id, align 4, !dbg !194
  %cmp = icmp slt i32 %0, 3, !dbg !194
  br i1 %cmp, label %for.body, label %for.end, !dbg !194

for.body:                                         ; preds = %for.cond
  %1 = load i32* %id, align 4, !dbg !196
  %idxprom = sext i32 %1 to i64, !dbg !196
  %arrayidx = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom, !dbg !196
  %2 = load i32* %arrayidx, align 4, !dbg !196
  %3 = load i32* %max, align 4, !dbg !196
  %cmp1 = icmp sgt i32 %2, %3, !dbg !196
  br i1 %cmp1, label %if.then, label %if.end, !dbg !196

if.then:                                          ; preds = %for.body
  %4 = load i32* %id, align 4, !dbg !196
  %idxprom2 = sext i32 %4 to i64, !dbg !196
  %arrayidx3 = getelementptr inbounds [3 x i32]* @ticket, i32 0, i64 %idxprom2, !dbg !196
  %5 = load i32* %arrayidx3, align 4, !dbg !196
  store i32 %5, i32* %max, align 4, !dbg !196
  br label %if.end, !dbg !196

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc, !dbg !196

for.inc:                                          ; preds = %if.end
  %6 = load i32* %id, align 4, !dbg !194
  %inc = add nsw i32 %6, 1, !dbg !194
  store i32 %inc, i32* %id, align 4, !dbg !194
  br label %for.cond, !dbg !194

for.end:                                          ; preds = %for.cond
  %7 = load i32* %max, align 4, !dbg !198
  ret i32 %7, !dbg !198
}

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #4 {
entry:
  %cmp = icmp eq i64 %z, 0, !dbg !199
  br i1 %cmp, label %if.then, label %if.end, !dbg !199

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str10, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str111, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str212, i64 0, i64 0)) #8, !dbg !201
  unreachable, !dbg !201

if.end:                                           ; preds = %entry
  ret void, !dbg !202
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #4 {
entry:
  %x = alloca i32, align 4
  %0 = bitcast i32* %x to i8*, !dbg !203
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #9, !dbg !203
  %1 = load i32* %x, align 4, !dbg !204, !tbaa !205
  ret i32 %1, !dbg !204
}

declare void @klee_make_symbolic(i8*, i64, i8*) #6

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
entry:
  %cmp = icmp ult i64 %shift, %bitWidth, !dbg !209
  br i1 %cmp, label %if.end, label %if.then, !dbg !209

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str313, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #8, !dbg !211
  unreachable, !dbg !211

if.end:                                           ; preds = %entry
  ret void, !dbg !213
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
entry:
  %x = alloca i32, align 4
  %cmp = icmp slt i32 %start, %end, !dbg !214
  br i1 %cmp, label %if.end, label %if.then, !dbg !214

if.then:                                          ; preds = %entry
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str614, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #8, !dbg !216
  unreachable, !dbg !216

if.end:                                           ; preds = %entry
  %add = add nsw i32 %start, 1, !dbg !217
  %cmp1 = icmp eq i32 %add, %end, !dbg !217
  br i1 %cmp1, label %return, label %if.else, !dbg !217

if.else:                                          ; preds = %if.end
  %0 = bitcast i32* %x to i8*, !dbg !219
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #9, !dbg !219
  %cmp3 = icmp eq i32 %start, 0, !dbg !221
  %1 = load i32* %x, align 4, !dbg !223, !tbaa !205
  br i1 %cmp3, label %if.then4, label %if.else7, !dbg !221

if.then4:                                         ; preds = %if.else
  %cmp5 = icmp ult i32 %1, %end, !dbg !223
  %conv6 = zext i1 %cmp5 to i64, !dbg !223
  call void @klee_assume(i64 %conv6) #9, !dbg !223
  br label %if.end14, !dbg !225

if.else7:                                         ; preds = %if.else
  %cmp8 = icmp sge i32 %1, %start, !dbg !226
  %conv10 = zext i1 %cmp8 to i64, !dbg !226
  call void @klee_assume(i64 %conv10) #9, !dbg !226
  %2 = load i32* %x, align 4, !dbg !228, !tbaa !205
  %cmp11 = icmp slt i32 %2, %end, !dbg !228
  %conv13 = zext i1 %cmp11 to i64, !dbg !228
  call void @klee_assume(i64 %conv13) #9, !dbg !228
  br label %if.end14

if.end14:                                         ; preds = %if.else7, %if.then4
  %3 = load i32* %x, align 4, !dbg !229, !tbaa !205
  br label %return, !dbg !229

return:                                           ; preds = %if.end14, %if.end
  %retval.0 = phi i32 [ %3, %if.end14 ], [ %start, %if.end ]
  ret i32 %retval.0, !dbg !230
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !231
  br i1 %cmp3, label %while.end, label %while.body.preheader, !dbg !231

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
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !232
  %wide.load = load <16 x i8>* %1, align 1, !dbg !232
  %next.gep.sum282 = or i64 %index, 16, !dbg !232
  %2 = getelementptr i8* %srcaddr, i64 %next.gep.sum282, !dbg !232
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !232
  %wide.load203 = load <16 x i8>* %3, align 1, !dbg !232
  %4 = bitcast i8* %next.gep106 to <16 x i8>*, !dbg !232
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !232
  %5 = getelementptr i8* %destaddr, i64 %next.gep.sum282, !dbg !232
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !232
  store <16 x i8> %wide.load203, <16 x i8>* %6, align 1, !dbg !232
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !233

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
  %dec = add i64 %len.addr.04, -1, !dbg !231
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !232
  %8 = load i8* %src.06, align 1, !dbg !232, !tbaa !236
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !232
  store i8 %8, i8* %dest.05, align 1, !dbg !232, !tbaa !236
  %cmp = icmp eq i64 %dec, 0, !dbg !231
  br i1 %cmp, label %while.end, label %while.body, !dbg !231, !llvm.loop !237

while.end:                                        ; preds = %while.body, %middle.block, %entry
  ret i8* %destaddr, !dbg !238
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
entry:
  %cmp = icmp eq i8* %src, %dst, !dbg !239
  br i1 %cmp, label %return, label %if.end, !dbg !239

if.end:                                           ; preds = %entry
  %cmp1 = icmp ugt i8* %src, %dst, !dbg !241
  br i1 %cmp1, label %while.cond.preheader, label %if.else, !dbg !241

while.cond.preheader:                             ; preds = %if.end
  %tobool27 = icmp eq i64 %count, 0, !dbg !243
  br i1 %tobool27, label %return, label %while.body.preheader, !dbg !243

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
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !243
  %wide.load = load <16 x i8>* %1, align 1, !dbg !243
  %next.gep.sum610 = or i64 %index, 16, !dbg !243
  %2 = getelementptr i8* %src, i64 %next.gep.sum610, !dbg !243
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !243
  %wide.load233 = load <16 x i8>* %3, align 1, !dbg !243
  %4 = bitcast i8* %next.gep136 to <16 x i8>*, !dbg !243
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !243
  %5 = getelementptr i8* %dst, i64 %next.gep.sum610, !dbg !243
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !243
  store <16 x i8> %wide.load233, <16 x i8>* %6, align 1, !dbg !243
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !245

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
  %dec = add i64 %count.addr.028, -1, !dbg !243
  %incdec.ptr = getelementptr inbounds i8* %b.030, i64 1, !dbg !243
  %8 = load i8* %b.030, align 1, !dbg !243, !tbaa !236
  %incdec.ptr3 = getelementptr inbounds i8* %a.029, i64 1, !dbg !243
  store i8 %8, i8* %a.029, align 1, !dbg !243, !tbaa !236
  %tobool = icmp eq i64 %dec, 0, !dbg !243
  br i1 %tobool, label %return, label %while.body, !dbg !243, !llvm.loop !246

if.else:                                          ; preds = %if.end
  %sub = add i64 %count, -1, !dbg !247
  %tobool832 = icmp eq i64 %count, 0, !dbg !249
  br i1 %tobool832, label %return, label %while.body9.lr.ph, !dbg !249

while.body9.lr.ph:                                ; preds = %if.else
  %add.ptr5 = getelementptr inbounds i8* %src, i64 %sub, !dbg !250
  %add.ptr = getelementptr inbounds i8* %dst, i64 %sub, !dbg !247
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
  %next.gep262.sum = add i64 %add.ptr5.sum465, -15, !dbg !249
  %9 = getelementptr i8* %src, i64 %next.gep262.sum, !dbg !249
  %10 = bitcast i8* %9 to <16 x i8>*, !dbg !249
  %wide.load460 = load <16 x i8>* %10, align 1, !dbg !249
  %reverse = shufflevector <16 x i8> %wide.load460, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !249
  %.sum = add i64 %add.ptr5.sum465, -31, !dbg !249
  %11 = getelementptr i8* %src, i64 %.sum, !dbg !249
  %12 = bitcast i8* %11 to <16 x i8>*, !dbg !249
  %wide.load461 = load <16 x i8>* %12, align 1, !dbg !249
  %reverse462 = shufflevector <16 x i8> %wide.load461, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !249
  %reverse463 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !249
  %13 = getelementptr i8* %dst, i64 %next.gep262.sum, !dbg !249
  %14 = bitcast i8* %13 to <16 x i8>*, !dbg !249
  store <16 x i8> %reverse463, <16 x i8>* %14, align 1, !dbg !249
  %reverse464 = shufflevector <16 x i8> %reverse462, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !249
  %15 = getelementptr i8* %dst, i64 %.sum, !dbg !249
  %16 = bitcast i8* %15 to <16 x i8>*, !dbg !249
  store <16 x i8> %reverse464, <16 x i8>* %16, align 1, !dbg !249
  %index.next260 = add i64 %index238, 32
  %17 = icmp eq i64 %index.next260, %n.vec241
  br i1 %17, label %middle.block236, label %vector.body235, !llvm.loop !251

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
  %dec7 = add i64 %count.addr.133, -1, !dbg !249
  %incdec.ptr10 = getelementptr inbounds i8* %b.135, i64 -1, !dbg !249
  %18 = load i8* %b.135, align 1, !dbg !249, !tbaa !236
  %incdec.ptr11 = getelementptr inbounds i8* %a.134, i64 -1, !dbg !249
  store i8 %18, i8* %a.134, align 1, !dbg !249, !tbaa !236
  %tobool8 = icmp eq i64 %dec7, 0, !dbg !249
  br i1 %tobool8, label %return, label %while.body9, !dbg !249, !llvm.loop !252

return:                                           ; preds = %while.body9, %middle.block236, %if.else, %while.body, %middle.block, %while.cond.preheader, %entry
  ret i8* %dst, !dbg !253
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !254
  br i1 %cmp3, label %while.end, label %while.body.preheader, !dbg !254

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
  %1 = bitcast i8* %next.gep to <16 x i8>*, !dbg !255
  %wide.load = load <16 x i8>* %1, align 1, !dbg !255
  %next.gep.sum283 = or i64 %index, 16, !dbg !255
  %2 = getelementptr i8* %srcaddr, i64 %next.gep.sum283, !dbg !255
  %3 = bitcast i8* %2 to <16 x i8>*, !dbg !255
  %wide.load204 = load <16 x i8>* %3, align 1, !dbg !255
  %4 = bitcast i8* %next.gep107 to <16 x i8>*, !dbg !255
  store <16 x i8> %wide.load, <16 x i8>* %4, align 1, !dbg !255
  %5 = getelementptr i8* %destaddr, i64 %next.gep.sum283, !dbg !255
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !255
  store <16 x i8> %wide.load204, <16 x i8>* %6, align 1, !dbg !255
  %index.next = add i64 %index, 32
  %7 = icmp eq i64 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !256

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
  %dec = add i64 %len.addr.04, -1, !dbg !254
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !255
  %8 = load i8* %src.06, align 1, !dbg !255, !tbaa !236
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !255
  store i8 %8, i8* %dest.05, align 1, !dbg !255, !tbaa !236
  %cmp = icmp eq i64 %dec, 0, !dbg !254
  br i1 %cmp, label %while.cond.while.end_crit_edge, label %while.body, !dbg !254, !llvm.loop !257

while.cond.while.end_crit_edge:                   ; preds = %while.body, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %while.end, !dbg !254

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %entry
  %dest.0.lcssa = phi i8* [ %scevgep, %while.cond.while.end_crit_edge ], [ %destaddr, %entry ]
  ret i8* %dest.0.lcssa, !dbg !258
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
entry:
  %cmp2 = icmp eq i64 %count, 0, !dbg !259
  br i1 %cmp2, label %while.end, label %while.body.lr.ph, !dbg !259

while.body.lr.ph:                                 ; preds = %entry
  %conv = trunc i32 %s to i8, !dbg !260
  br label %while.body, !dbg !259

while.body:                                       ; preds = %while.body, %while.body.lr.ph
  %a.04 = phi i8* [ %dst, %while.body.lr.ph ], [ %incdec.ptr, %while.body ]
  %count.addr.03 = phi i64 [ %count, %while.body.lr.ph ], [ %dec, %while.body ]
  %dec = add i64 %count.addr.03, -1, !dbg !259
  %incdec.ptr = getelementptr inbounds i8* %a.04, i64 1, !dbg !260
  store volatile i8 %conv, i8* %a.04, align 1, !dbg !260, !tbaa !236
  %cmp = icmp eq i64 %dec, 0, !dbg !259
  br i1 %cmp, label %while.end, label %while.body, !dbg !259

while.end:                                        ; preds = %while.body, %entry
  ret i8* %dst, !dbg !261
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn }
attributes #8 = { nobuiltin noreturn nounwind }
attributes #9 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0, !28, !39, !53, !65, !78, !98, !113, !128}
!llvm.module.flags = !{!144, !145}
!llvm.ident = !{!146, !146, !146, !146, !146, !146, !146, !146, !146}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !16, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!1 = metadata !{metadata !"bakery.c", metadata !"/home/rasool/POPL2021-CONCUR/bakery-tx"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !9, metadata !12, metadata !15}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 23, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 23} ; [ DW_TAG_subprogram ] [
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"mutex", metadata !"mutex", metadata !"", i32 46, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @mutex, null, null, metadata !2, i32 46} ; [ DW_TAG_subp
!10 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !11, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!11 = metadata !{null, metadata !8}
!12 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"minticket", metadata !"minticket", metadata !"", i32 53, metadata !13, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32)* @minticket, null, null, metadata !2, i32 53} ; [
!13 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !14, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!14 = metadata !{metadata !8, metadata !8}
!15 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"maxticket", metadata !"maxticket", metadata !"", i32 58, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @maxticket, null, null, metadata !2, i32 58} ; [ DW_TA
!16 = metadata !{metadata !17, metadata !18, metadata !19, metadata !23, metadata !24}
!17 = metadata !{i32 786484, i32 0, null, metadata !"limit", metadata !"limit", metadata !"", metadata !5, i32 15, metadata !8, i32 0, i32 1, i32* @limit, null} ; [ DW_TAG_variable ] [limit] [line 15] [def]
!18 = metadata !{i32 786484, i32 0, null, metadata !"n_bread", metadata !"n_bread", metadata !"", metadata !5, i32 16, metadata !8, i32 0, i32 1, i32* @n_bread, null} ; [ DW_TAG_variable ] [n_bread] [line 16] [def]
!19 = metadata !{i32 786484, i32 0, null, metadata !"pc", metadata !"pc", metadata !"", metadata !5, i32 13, metadata !20, i32 0, i32 1, [3 x i32]* @pc, null} ; [ DW_TAG_variable ] [pc] [line 13] [def]
!20 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 96, i64 32, i32 0, i32 0, metadata !8, metadata !21, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 96, align 32, offset 0] [from int]
!21 = metadata !{metadata !22}
!22 = metadata !{i32 786465, i64 0, i64 3}        ; [ DW_TAG_subrange_type ] [0, 2]
!23 = metadata !{i32 786484, i32 0, null, metadata !"ticket", metadata !"ticket", metadata !"", metadata !5, i32 13, metadata !20, i32 0, i32 1, [3 x i32]* @ticket, null} ; [ DW_TAG_variable ] [ticket] [line 13] [def]
!24 = metadata !{i32 786484, i32 0, null, metadata !"bread", metadata !"bread", metadata !"", metadata !5, i32 13, metadata !25, i32 0, i32 1, [9 x i32]* @bread, null} ; [ DW_TAG_variable ] [bread] [line 13] [def]
!25 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 288, i64 32, i32 0, i32 0, metadata !8, metadata !26, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 288, align 32, offset 0] [from int]
!26 = metadata !{metadata !27}
!27 = metadata !{i32 786465, i64 0, i64 9}        ; [ DW_TAG_subrange_type ] [0, 8]
!28 = metadata !{i32 786449, metadata !29, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !30, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!29 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!30 = metadata !{metadata !31}
!31 = metadata !{i32 786478, metadata !32, metadata !33, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !34, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!32 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!33 = metadata !{i32 786473, metadata !32}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_div_zero_check.c]
!34 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !35, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!35 = metadata !{null, metadata !36}
!36 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!37 = metadata !{metadata !38}
!38 = metadata !{i32 786689, metadata !31, metadata !"z", metadata !33, i32 16777228, metadata !36, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!39 = metadata !{i32 786449, metadata !40, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !41, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!40 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_int.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!41 = metadata !{metadata !42}
!42 = metadata !{i32 786478, metadata !43, metadata !44, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !45, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !50, i32 13} ; [ 
!43 = metadata !{metadata !"klee_int.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!44 = metadata !{i32 786473, metadata !43}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_int.c]
!45 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !46, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!46 = metadata !{metadata !8, metadata !47}
!47 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !48} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!48 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !49} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!49 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!50 = metadata !{metadata !51, metadata !52}
!51 = metadata !{i32 786689, metadata !42, metadata !"name", metadata !44, i32 16777229, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!52 = metadata !{i32 786688, metadata !42, metadata !"x", metadata !44, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!53 = metadata !{i32 786449, metadata !54, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !55, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!54 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!55 = metadata !{metadata !56}
!56 = metadata !{i32 786478, metadata !57, metadata !58, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !59, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!57 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!58 = metadata !{i32 786473, metadata !57}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c]
!59 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !60, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!60 = metadata !{null, metadata !61, metadata !61}
!61 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!62 = metadata !{metadata !63, metadata !64}
!63 = metadata !{i32 786689, metadata !56, metadata !"bitWidth", metadata !58, i32 16777236, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!64 = metadata !{i32 786689, metadata !56, metadata !"shift", metadata !58, i32 33554452, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!65 = metadata !{i32 786449, metadata !66, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !67, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!66 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/klee_range.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!67 = metadata !{metadata !68}
!68 = metadata !{i32 786478, metadata !69, metadata !70, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !71, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!69 = metadata !{metadata !"klee_range.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!70 = metadata !{i32 786473, metadata !69}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!71 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !72, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!72 = metadata !{metadata !8, metadata !8, metadata !8, metadata !47}
!73 = metadata !{metadata !74, metadata !75, metadata !76, metadata !77}
!74 = metadata !{i32 786689, metadata !68, metadata !"start", metadata !70, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!75 = metadata !{i32 786689, metadata !68, metadata !"end", metadata !70, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!76 = metadata !{i32 786689, metadata !68, metadata !"name", metadata !70, i32 50331661, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!77 = metadata !{i32 786688, metadata !68, metadata !"x", metadata !70, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!78 = metadata !{i32 786449, metadata !79, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !80, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!79 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/memcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!80 = metadata !{metadata !81}
!81 = metadata !{i32 786478, metadata !82, metadata !83, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !84, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !91, i32 12} 
!82 = metadata !{metadata !"memcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!83 = metadata !{i32 786473, metadata !82}        ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/memcpy.c]
!84 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !85, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!85 = metadata !{metadata !86, metadata !86, metadata !87, metadata !89}
!86 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!87 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !88} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!88 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!89 = metadata !{i32 786454, metadata !82, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !90} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!90 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!91 = metadata !{metadata !92, metadata !93, metadata !94, metadata !95, metadata !97}
!92 = metadata !{i32 786689, metadata !81, metadata !"destaddr", metadata !83, i32 16777228, metadata !86, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!93 = metadata !{i32 786689, metadata !81, metadata !"srcaddr", metadata !83, i32 33554444, metadata !87, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!94 = metadata !{i32 786689, metadata !81, metadata !"len", metadata !83, i32 50331660, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!95 = metadata !{i32 786688, metadata !81, metadata !"dest", metadata !83, i32 13, metadata !96, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!96 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !49} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!97 = metadata !{i32 786688, metadata !81, metadata !"src", metadata !83, i32 14, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!98 = metadata !{i32 786449, metadata !99, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !100, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/hom
!99 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/memmove.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!100 = metadata !{metadata !101}
!101 = metadata !{i32 786478, metadata !102, metadata !103, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !104, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !107, 
!102 = metadata !{metadata !"memmove.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!103 = metadata !{i32 786473, metadata !102}      ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!104 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !105, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!105 = metadata !{metadata !86, metadata !86, metadata !87, metadata !106}
!106 = metadata !{i32 786454, metadata !102, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !90} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!107 = metadata !{metadata !108, metadata !109, metadata !110, metadata !111, metadata !112}
!108 = metadata !{i32 786689, metadata !101, metadata !"dst", metadata !103, i32 16777228, metadata !86, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!109 = metadata !{i32 786689, metadata !101, metadata !"src", metadata !103, i32 33554444, metadata !87, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!110 = metadata !{i32 786689, metadata !101, metadata !"count", metadata !103, i32 50331660, metadata !106, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!111 = metadata !{i32 786688, metadata !101, metadata !"a", metadata !103, i32 13, metadata !96, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!112 = metadata !{i32 786688, metadata !101, metadata !"b", metadata !103, i32 14, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!113 = metadata !{i32 786449, metadata !114, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !115, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!114 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/mempcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!115 = metadata !{metadata !116}
!116 = metadata !{i32 786478, metadata !117, metadata !118, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !119, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !122, 
!117 = metadata !{metadata !"mempcpy.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!118 = metadata !{i32 786473, metadata !117}      ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/mempcpy.c]
!119 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !120, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!120 = metadata !{metadata !86, metadata !86, metadata !87, metadata !121}
!121 = metadata !{i32 786454, metadata !117, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !90} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!122 = metadata !{metadata !123, metadata !124, metadata !125, metadata !126, metadata !127}
!123 = metadata !{i32 786689, metadata !116, metadata !"destaddr", metadata !118, i32 16777227, metadata !86, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!124 = metadata !{i32 786689, metadata !116, metadata !"srcaddr", metadata !118, i32 33554443, metadata !87, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!125 = metadata !{i32 786689, metadata !116, metadata !"len", metadata !118, i32 50331659, metadata !121, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!126 = metadata !{i32 786688, metadata !116, metadata !"dest", metadata !118, i32 12, metadata !96, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!127 = metadata !{i32 786688, metadata !116, metadata !"src", metadata !118, i32 13, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!128 = metadata !{i32 786449, metadata !129, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !130, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!129 = metadata !{metadata !"/home/rasool/klee/runtime/Intrinsic/memset.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!130 = metadata !{metadata !131}
!131 = metadata !{i32 786478, metadata !132, metadata !133, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !134, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !137, i32
!132 = metadata !{metadata !"memset.c", metadata !"/home/rasool/klee/runtime/Intrinsic"}
!133 = metadata !{i32 786473, metadata !132}      ; [ DW_TAG_file_type ] [/home/rasool/klee/runtime/Intrinsic/memset.c]
!134 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !135, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!135 = metadata !{metadata !86, metadata !86, metadata !8, metadata !136}
!136 = metadata !{i32 786454, metadata !132, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !90} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!137 = metadata !{metadata !138, metadata !139, metadata !140, metadata !141}
!138 = metadata !{i32 786689, metadata !131, metadata !"dst", metadata !133, i32 16777227, metadata !86, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!139 = metadata !{i32 786689, metadata !131, metadata !"s", metadata !133, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!140 = metadata !{i32 786689, metadata !131, metadata !"count", metadata !133, i32 50331659, metadata !136, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!141 = metadata !{i32 786688, metadata !131, metadata !"a", metadata !133, i32 12, metadata !142, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!142 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !143} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!143 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !49} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!144 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!145 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!146 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!147 = metadata !{i32 24, i32 0, metadata !4, null}
!148 = metadata !{i32 25, i32 0, metadata !4, null}
!149 = metadata !{i32 26, i32 0, metadata !150, null}
!150 = metadata !{i32 786443, metadata !1, metadata !4, i32 25, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!151 = metadata !{i32 27, i32 0, metadata !150, null}
!152 = metadata !{i32 28, i32 0, metadata !153, null}
!153 = metadata !{i32 786443, metadata !1, metadata !150, i32 28, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!154 = metadata !{i32 29, i32 0, metadata !155, null}
!155 = metadata !{i32 786443, metadata !1, metadata !153, i32 28, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!156 = metadata !{i32 30, i32 0, metadata !155, null}
!157 = metadata !{i32 31, i32 0, metadata !150, null}
!158 = metadata !{i32 32, i32 0, metadata !150, null}
!159 = metadata !{i32 33, i32 0, metadata !160, null}
!160 = metadata !{i32 786443, metadata !1, metadata !150, i32 32, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!161 = metadata !{i32 34, i32 0, metadata !162, null}
!162 = metadata !{i32 786443, metadata !1, metadata !160, i32 34, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!163 = metadata !{i32 34, i32 0, metadata !164, null}
!164 = metadata !{i32 786443, metadata !1, metadata !162, i32 34, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!165 = metadata !{i32 34, i32 0, metadata !166, null}
!166 = metadata !{i32 786443, metadata !1, metadata !162, i32 34, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!167 = metadata !{i32 34, i32 0, metadata !160, null}
!168 = metadata !{i32 35, i32 0, metadata !160, null}
!169 = metadata !{i32 36, i32 0, metadata !160, null}
!170 = metadata !{i32 37, i32 0, metadata !150, null}
!171 = metadata !{i32 38, i32 0, metadata !150, null}
!172 = metadata !{i32 39, i32 0, metadata !4, null}
!173 = metadata !{i32 40, i32 0, metadata !174, null}
!174 = metadata !{i32 786443, metadata !1, metadata !4, i32 40, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!175 = metadata !{i32 41, i32 0, metadata !4, null}
!176 = metadata !{i32 42, i32 0, metadata !4, null}
!177 = metadata !{i32 54, i32 0, metadata !178, null}
!178 = metadata !{i32 786443, metadata !1, metadata !12, i32 54, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!179 = metadata !{i32 54, i32 0, metadata !180, null}
!180 = metadata !{i32 786443, metadata !1, metadata !178, i32 54, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!181 = metadata !{i32 55, i32 0, metadata !12, null}
!182 = metadata !{i32 56, i32 0, metadata !12, null}
!183 = metadata !{i32 47, i32 0, metadata !9, null}
!184 = metadata !{i32 48, i32 0, metadata !185, null}
!185 = metadata !{i32 786443, metadata !1, metadata !9, i32 48, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!186 = metadata !{i32 48, i32 0, metadata !187, null}
!187 = metadata !{i32 786443, metadata !1, metadata !185, i32 48, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!188 = metadata !{i32 48, i32 0, metadata !189, null}
!189 = metadata !{i32 786443, metadata !1, metadata !187, i32 48, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!190 = metadata !{i32 49, i32 0, metadata !9, null}
!191 = metadata !{i32 50, i32 0, metadata !9, null}
!192 = metadata !{i32 51, i32 0, metadata !9, null}
!193 = metadata !{i32 59, i32 0, metadata !15, null}
!194 = metadata !{i32 60, i32 0, metadata !195, null}
!195 = metadata !{i32 786443, metadata !1, metadata !15, i32 60, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!196 = metadata !{i32 60, i32 0, metadata !197, null}
!197 = metadata !{i32 786443, metadata !1, metadata !195, i32 60, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/bakery-tx/bakery.c]
!198 = metadata !{i32 61, i32 0, metadata !15, null}
!199 = metadata !{i32 13, i32 0, metadata !200, null}
!200 = metadata !{i32 786443, metadata !32, metadata !31, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_div_zero_check.c]
!201 = metadata !{i32 14, i32 0, metadata !200, null}
!202 = metadata !{i32 15, i32 0, metadata !31, null}
!203 = metadata !{i32 15, i32 0, metadata !42, null}
!204 = metadata !{i32 16, i32 0, metadata !42, null}
!205 = metadata !{metadata !206, metadata !206, i64 0}
!206 = metadata !{metadata !"int", metadata !207, i64 0}
!207 = metadata !{metadata !"omnipotent char", metadata !208, i64 0}
!208 = metadata !{metadata !"Simple C/C++ TBAA"}
!209 = metadata !{i32 21, i32 0, metadata !210, null}
!210 = metadata !{i32 786443, metadata !57, metadata !56, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c]
!211 = metadata !{i32 27, i32 0, metadata !212, null}
!212 = metadata !{i32 786443, metadata !57, metadata !210, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_overshift_check.c]
!213 = metadata !{i32 29, i32 0, metadata !56, null}
!214 = metadata !{i32 16, i32 0, metadata !215, null}
!215 = metadata !{i32 786443, metadata !69, metadata !68, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!216 = metadata !{i32 17, i32 0, metadata !215, null}
!217 = metadata !{i32 19, i32 0, metadata !218, null}
!218 = metadata !{i32 786443, metadata !69, metadata !68, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!219 = metadata !{i32 22, i32 0, metadata !220, null}
!220 = metadata !{i32 786443, metadata !69, metadata !218, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!221 = metadata !{i32 25, i32 0, metadata !222, null}
!222 = metadata !{i32 786443, metadata !69, metadata !220, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!223 = metadata !{i32 26, i32 0, metadata !224, null}
!224 = metadata !{i32 786443, metadata !69, metadata !222, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!225 = metadata !{i32 27, i32 0, metadata !224, null}
!226 = metadata !{i32 28, i32 0, metadata !227, null}
!227 = metadata !{i32 786443, metadata !69, metadata !222, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/klee_range.c]
!228 = metadata !{i32 29, i32 0, metadata !227, null}
!229 = metadata !{i32 32, i32 0, metadata !220, null}
!230 = metadata !{i32 34, i32 0, metadata !68, null}
!231 = metadata !{i32 16, i32 0, metadata !81, null}
!232 = metadata !{i32 17, i32 0, metadata !81, null}
!233 = metadata !{metadata !233, metadata !234, metadata !235}
!234 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!235 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!236 = metadata !{metadata !207, metadata !207, i64 0}
!237 = metadata !{metadata !237, metadata !234, metadata !235}
!238 = metadata !{i32 18, i32 0, metadata !81, null}
!239 = metadata !{i32 16, i32 0, metadata !240, null}
!240 = metadata !{i32 786443, metadata !102, metadata !101, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!241 = metadata !{i32 19, i32 0, metadata !242, null}
!242 = metadata !{i32 786443, metadata !102, metadata !101, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!243 = metadata !{i32 20, i32 0, metadata !244, null}
!244 = metadata !{i32 786443, metadata !102, metadata !242, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!245 = metadata !{metadata !245, metadata !234, metadata !235}
!246 = metadata !{metadata !246, metadata !234, metadata !235}
!247 = metadata !{i32 22, i32 0, metadata !248, null}
!248 = metadata !{i32 786443, metadata !102, metadata !242, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/klee/runtime/Intrinsic/memmove.c]
!249 = metadata !{i32 24, i32 0, metadata !248, null}
!250 = metadata !{i32 23, i32 0, metadata !248, null}
!251 = metadata !{metadata !251, metadata !234, metadata !235}
!252 = metadata !{metadata !252, metadata !234, metadata !235}
!253 = metadata !{i32 28, i32 0, metadata !101, null}
!254 = metadata !{i32 15, i32 0, metadata !116, null}
!255 = metadata !{i32 16, i32 0, metadata !116, null}
!256 = metadata !{metadata !256, metadata !234, metadata !235}
!257 = metadata !{metadata !257, metadata !234, metadata !235}
!258 = metadata !{i32 17, i32 0, metadata !116, null}
!259 = metadata !{i32 13, i32 0, metadata !131, null}
!260 = metadata !{i32 14, i32 0, metadata !131, null}
!261 = metadata !{i32 15, i32 0, metadata !131, null}
