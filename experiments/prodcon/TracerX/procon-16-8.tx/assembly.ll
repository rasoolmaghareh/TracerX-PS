; ModuleID = 'procon.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"Search(%d)\0A\00", align 1
@.str1 = private unnamed_addr constant [3 x i8] c"id\00", align 1
@.str2 = private unnamed_addr constant [17 x i8] c"Return level %d\0A\00", align 1
@.str3 = private unnamed_addr constant [17 x i8] c"b >= 0 && b <= B\00", align 1
@.str4 = private unnamed_addr constant [9 x i8] c"procon.c\00", align 1
@__PRETTY_FUNCTION__.check_buffer = private unnamed_addr constant [23 x i8] c"void check_buffer(int)\00", align 1
@.str5 = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str16 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str27 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str38 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str6 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %call = call i32 @search(i32 0, i32 16, i32 0), !dbg !134
  ret i32 0, !dbg !134
}

; Function Attrs: nounwind uwtable
define i32 @search(i32 %level, i32 %p, i32 %b) #0 {
entry:
  %retval = alloca i32, align 4
  %level.addr = alloca i32, align 4
  %p.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %choice = alloca i32, align 4
  store i32 %level, i32* %level.addr, align 4
  store i32 %p, i32* %p.addr, align 4
  store i32 %b, i32* %b.addr, align 4
  %0 = load i32* %level.addr, align 4, !dbg !135
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0), i32 %0), !dbg !135
  %1 = load i32* %p.addr, align 4, !dbg !136
  %cmp = icmp eq i32 %1, 0, !dbg !136
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !136

land.lhs.true:                                    ; preds = %entry
  %2 = load i32* %b.addr, align 4, !dbg !136
  %cmp1 = icmp eq i32 %2, 0, !dbg !136
  br i1 %cmp1, label %if.then, label %if.end, !dbg !136

if.then:                                          ; preds = %land.lhs.true
  store i32 0, i32* %retval, !dbg !138
  br label %return, !dbg !138

if.end:                                           ; preds = %land.lhs.true, %entry
  %call2 = call i32 @klee_range(i32 0, i32 2, i8* getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0)), !dbg !140
  store i32 %call2, i32* %choice, align 4, !dbg !140
  %3 = load i32* %choice, align 4, !dbg !141
  switch i32 %3, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb9
  ], !dbg !141

sw.bb:                                            ; preds = %if.end
  %4 = load i32* %b.addr, align 4, !dbg !142
  %cmp3 = icmp slt i32 %4, 8, !dbg !142
  br i1 %cmp3, label %land.lhs.true4, label %if.end8, !dbg !142

land.lhs.true4:                                   ; preds = %sw.bb
  %5 = load i32* %p.addr, align 4, !dbg !142
  %cmp5 = icmp sgt i32 %5, 0, !dbg !142
  br i1 %cmp5, label %if.then6, label %if.end8, !dbg !142

if.then6:                                         ; preds = %land.lhs.true4
  %6 = load i32* %p.addr, align 4, !dbg !145
  %dec = add nsw i32 %6, -1, !dbg !145
  store i32 %dec, i32* %p.addr, align 4, !dbg !145
  %7 = load i32* %b.addr, align 4, !dbg !145
  %inc = add nsw i32 %7, 1, !dbg !145
  store i32 %inc, i32* %b.addr, align 4, !dbg !145
  %8 = load i32* %level.addr, align 4, !dbg !145
  %add = add nsw i32 %8, 1, !dbg !145
  %9 = load i32* %p.addr, align 4, !dbg !145
  %10 = load i32* %b.addr, align 4, !dbg !145
  %call7 = call i32 @search(i32 %add, i32 %9, i32 %10), !dbg !145
  br label %if.end8, !dbg !145

if.end8:                                          ; preds = %if.then6, %land.lhs.true4, %sw.bb
  br label %sw.epilog, !dbg !147

sw.bb9:                                           ; preds = %if.end
  %11 = load i32* %b.addr, align 4, !dbg !148
  %cmp10 = icmp sgt i32 %11, 0, !dbg !148
  br i1 %cmp10, label %if.then11, label %if.end15, !dbg !148

if.then11:                                        ; preds = %sw.bb9
  %12 = load i32* %b.addr, align 4, !dbg !150
  %dec12 = add nsw i32 %12, -1, !dbg !150
  store i32 %dec12, i32* %b.addr, align 4, !dbg !150
  %13 = load i32* %level.addr, align 4, !dbg !150
  %add13 = add nsw i32 %13, 1, !dbg !150
  %14 = load i32* %p.addr, align 4, !dbg !150
  %15 = load i32* %b.addr, align 4, !dbg !150
  %call14 = call i32 @search(i32 %add13, i32 %14, i32 %15), !dbg !150
  br label %if.end15, !dbg !150

if.end15:                                         ; preds = %if.then11, %sw.bb9
  br label %sw.epilog, !dbg !152

sw.epilog:                                        ; preds = %if.end15, %if.end8, %if.end
  %16 = load i32* %b.addr, align 4, !dbg !153
  call void @check_buffer(i32 %16), !dbg !153
  %17 = load i32* %level.addr, align 4, !dbg !154
  %call16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i32 %17), !dbg !154
  store i32 0, i32* %retval, !dbg !155
  br label %return, !dbg !155

return:                                           ; preds = %sw.epilog, %if.then
  %18 = load i32* %retval, !dbg !156
  ret i32 %18, !dbg !156
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @check_buffer(i32 %b) #0 {
entry:
  %b.addr = alloca i32, align 4
  store i32 %b, i32* %b.addr, align 4
  %0 = load i32* %b.addr, align 4, !dbg !157
  %cmp = icmp sge i32 %0, 0, !dbg !157
  br i1 %cmp, label %land.lhs.true, label %cond.false, !dbg !157

land.lhs.true:                                    ; preds = %entry
  %1 = load i32* %b.addr, align 4, !dbg !157
  %cmp1 = icmp sle i32 %1, 8, !dbg !157
  br i1 %cmp1, label %cond.true, label %cond.false, !dbg !157

cond.true:                                        ; preds = %land.lhs.true
  br label %cond.end, !dbg !157

cond.false:                                       ; preds = %land.lhs.true, %entry
  %call = call i32 (i8*, i8*, i32, i8*, ...)* bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* getelementptr inbounds ([17 x i8]* @.str3, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str4, i32 0, i32 0), i32 26, i8* get
  br label %cond.end, !dbg !157

cond.end:                                         ; preds = %cond.false, %cond.true
  ret void, !dbg !158
}

; Function Attrs: noreturn
declare i32 @__assert_fail(...) #3

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #4 {
  %1 = icmp eq i64 %z, 0, !dbg !159
  br i1 %1, label %2, label %3, !dbg !159

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str5, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str16, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str27, i64 0, i64 0)) #7, !dbg !161
  unreachable, !dbg !161

; <label>:3                                       ; preds = %0
  ret void, !dbg !162
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !163
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #8, !dbg !163
  %2 = load i32* %x, align 4, !dbg !164, !tbaa !165
  ret i32 %2, !dbg !164
}

declare void @klee_make_symbolic(i8*, i64, i8*) #6

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !169
  br i1 %1, label %3, label %2, !dbg !169

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str38, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #7, !dbg !171
  unreachable, !dbg !171

; <label>:3                                       ; preds = %0
  ret void, !dbg !173
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !174
  br i1 %1, label %3, label %2, !dbg !174

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #7, !dbg !176
  unreachable, !dbg !176

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !177
  %5 = icmp eq i32 %4, %end, !dbg !177
  br i1 %5, label %21, label %6, !dbg !177

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !179
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #8, !dbg !179
  %8 = icmp eq i32 %start, 0, !dbg !181
  %9 = load i32* %x, align 4, !dbg !183, !tbaa !165
  br i1 %8, label %10, label %13, !dbg !181

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !183
  %12 = zext i1 %11 to i64, !dbg !183
  call void @klee_assume(i64 %12) #8, !dbg !183
  br label %19, !dbg !185

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !186
  %15 = zext i1 %14 to i64, !dbg !186
  call void @klee_assume(i64 %15) #8, !dbg !186
  %16 = load i32* %x, align 4, !dbg !188, !tbaa !165
  %17 = icmp slt i32 %16, %end, !dbg !188
  %18 = zext i1 %17 to i64, !dbg !188
  call void @klee_assume(i64 %18) #8, !dbg !188
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !189, !tbaa !165
  br label %21, !dbg !189

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !190
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !191
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !191

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep4 = getelementptr i8* %srcaddr, i64 %2
  %scevgep = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep4, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end6 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep103 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !192
  %wide.load = load <16 x i8>* %3, align 1, !dbg !192
  %next.gep.sum279 = or i64 %index, 16, !dbg !192
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !192
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !192
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !192
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !192
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !192
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum279, !dbg !192
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !192
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !192
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !193

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val5 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end6, %vector.body ]
  %resume.val7 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val5, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val7, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !191
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !192
  %12 = load i8* %src.03, align 1, !dbg !192, !tbaa !196
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !192
  store i8 %12, i8* %dest.02, align 1, !dbg !192, !tbaa !196
  %14 = icmp eq i64 %10, 0, !dbg !191
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !191, !llvm.loop !197

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !198
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
  %1 = icmp eq i8* %src, %dst, !dbg !199
  br i1 %1, label %.loopexit, label %2, !dbg !199

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !201
  br i1 %3, label %.preheader, label %18, !dbg !201

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !203
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !203

.lr.ph.preheader:                                 ; preds = %.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %5 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep11 = getelementptr i8* %src, i64 %5
  %scevgep = getelementptr i8* %dst, i64 %5
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep11, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end13 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep110 = getelementptr i8* %dst, i64 %index
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !203
  %wide.load = load <16 x i8>* %6, align 1, !dbg !203
  %next.gep.sum586 = or i64 %index, 16, !dbg !203
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !203
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !203
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !203
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !203
  %10 = getelementptr i8* %dst, i64 %next.gep.sum586, !dbg !203
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !203
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !205

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %src, %.lr.ph.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val12 = phi i8* [ %dst, %.lr.ph.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end13, %vector.body ]
  %resume.val14 = phi i64 [ %count, %.lr.ph.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %b.04 = phi i8* [ %14, %.lr.ph ], [ %resume.val, %middle.block ]
  %a.03 = phi i8* [ %16, %.lr.ph ], [ %resume.val12, %middle.block ]
  %.02 = phi i64 [ %13, %.lr.ph ], [ %resume.val14, %middle.block ]
  %13 = add i64 %.02, -1, !dbg !203
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !203
  %15 = load i8* %b.04, align 1, !dbg !203, !tbaa !196
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !203
  store i8 %15, i8* %a.03, align 1, !dbg !203, !tbaa !196
  %17 = icmp eq i64 %13, 0, !dbg !203
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !203, !llvm.loop !206

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !207
  %20 = icmp eq i64 %count, 0, !dbg !209
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !209

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !210
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !207
  %n.vec215 = and i64 %count, -32
  %cmp.zero217 = icmp eq i64 %n.vec215, 0
  br i1 %cmp.zero217, label %middle.block210, label %vector.memcheck224

vector.memcheck224:                               ; preds = %.lr.ph9
  %bound1221 = icmp ule i8* %21, %dst
  %bound0220 = icmp ule i8* %22, %src
  %memcheck.conflict223 = and i1 %bound0220, %bound1221
  %.sum = sub i64 %19, %n.vec215
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %.sum
  %rev.ptr.ind.end229 = getelementptr i8* %dst, i64 %.sum
  %rev.ind.end231 = sub i64 %count, %n.vec215
  br i1 %memcheck.conflict223, label %middle.block210, label %vector.body209

vector.body209:                                   ; preds = %vector.body209, %vector.memcheck224
  %index212 = phi i64 [ %index.next234, %vector.body209 ], [ 0, %vector.memcheck224 ]
  %.sum440 = sub i64 %19, %index212
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !209
  %23 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !209
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !209
  %wide.load434 = load <16 x i8>* %24, align 1, !dbg !209
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !209
  %.sum505 = add i64 %.sum440, -31, !dbg !209
  %25 = getelementptr i8* %src, i64 %.sum505, !dbg !209
  %26 = bitcast i8* %25 to <16 x i8>*, !dbg !209
  %wide.load435 = load <16 x i8>* %26, align 1, !dbg !209
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !209
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !209
  %27 = getelementptr i8* %dst, i64 %next.gep236.sum, !dbg !209
  %28 = bitcast i8* %27 to <16 x i8>*, !dbg !209
  store <16 x i8> %reverse437, <16 x i8>* %28, align 1, !dbg !209
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !209
  %29 = getelementptr i8* %dst, i64 %.sum505, !dbg !209
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !209
  store <16 x i8> %reverse438, <16 x i8>* %30, align 1, !dbg !209
  %index.next234 = add i64 %index212, 32
  %31 = icmp eq i64 %index.next234, %n.vec215
  br i1 %31, label %middle.block210, label %vector.body209, !llvm.loop !211

middle.block210:                                  ; preds = %vector.body209, %vector.memcheck224, %.lr.ph9
  %resume.val225 = phi i8* [ %21, %.lr.ph9 ], [ %21, %vector.memcheck224 ], [ %rev.ptr.ind.end, %vector.body209 ]
  %resume.val227 = phi i8* [ %22, %.lr.ph9 ], [ %22, %vector.memcheck224 ], [ %rev.ptr.ind.end229, %vector.body209 ]
  %resume.val230 = phi i64 [ %count, %.lr.ph9 ], [ %count, %vector.memcheck224 ], [ %rev.ind.end231, %vector.body209 ]
  %new.indc.resume.val232 = phi i64 [ 0, %.lr.ph9 ], [ 0, %vector.memcheck224 ], [ %n.vec215, %vector.body209 ]
  %cmp.n233 = icmp eq i64 %new.indc.resume.val232, %count
  br i1 %cmp.n233, label %.loopexit, label %scalar.ph211

scalar.ph211:                                     ; preds = %scalar.ph211, %middle.block210
  %b.18 = phi i8* [ %33, %scalar.ph211 ], [ %resume.val225, %middle.block210 ]
  %a.17 = phi i8* [ %35, %scalar.ph211 ], [ %resume.val227, %middle.block210 ]
  %.16 = phi i64 [ %32, %scalar.ph211 ], [ %resume.val230, %middle.block210 ]
  %32 = add i64 %.16, -1, !dbg !209
  %33 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !209
  %34 = load i8* %b.18, align 1, !dbg !209, !tbaa !196
  %35 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !209
  store i8 %34, i8* %a.17, align 1, !dbg !209, !tbaa !196
  %36 = icmp eq i64 %32, 0, !dbg !209
  br i1 %36, label %.loopexit, label %scalar.ph211, !dbg !209, !llvm.loop !212

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !213
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !214
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !214

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep5 = getelementptr i8* %srcaddr, i64 %2
  %scevgep4 = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep4, %srcaddr
  %bound0 = icmp uge i8* %scevgep5, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end7 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep104 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !215
  %wide.load = load <16 x i8>* %3, align 1, !dbg !215
  %next.gep.sum280 = or i64 %index, 16, !dbg !215
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !215
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !215
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !215
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !215
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !215
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum280, !dbg !215
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !215
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !215
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !216

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val6 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end7, %vector.body ]
  %resume.val8 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val6, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val8, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !214
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !215
  %12 = load i8* %src.03, align 1, !dbg !215, !tbaa !196
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !215
  store i8 %12, i8* %dest.02, align 1, !dbg !215, !tbaa !196
  %14 = icmp eq i64 %10, 0, !dbg !214
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !214, !llvm.loop !217

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !214

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !218
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
  %1 = icmp eq i64 %count, 0, !dbg !219
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !219

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !220
  br label %3, !dbg !219

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !219
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !220
  store volatile i8 %2, i8* %a.02, align 1, !dbg !220, !tbaa !196
  %6 = icmp eq i64 %4, 0, !dbg !219
  br i1 %6, label %._crit_edge, label %3, !dbg !219

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !221
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nobuiltin noreturn nounwind }
attributes #8 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0, !15, !26, !40, !52, !65, !85, !100, !115}
!llvm.module.flags = !{!131, !132}
!llvm.ident = !{!133, !133, !133, !133, !133, !133, !133, !133, !133}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/
!1 = metadata !{metadata !"procon.c", metadata !"/home/rasool/POPL2021-CONCUR/prodcon-tracerx"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !9, metadata !12}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 9, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 9} ; [ DW_TAG_subprogram ] [li
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"search", metadata !"search", metadata !"", i32 11, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32, i32)* @search, null, null, metadata !2, i32 11} ; [
!10 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !11, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!11 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8}
!12 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"check_buffer", metadata !"check_buffer", metadata !"", i32 25, metadata !13, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @check_buffer, null, null, metadata !2, i
!13 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !14, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!14 = metadata !{null, metadata !8}
!15 = metadata !{i32 786449, metadata !16, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !17, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!16 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!17 = metadata !{metadata !18}
!18 = metadata !{i32 786478, metadata !19, metadata !20, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !21, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!19 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!20 = metadata !{i32 786473, metadata !19}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_div_zero_check.c]
!21 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !22, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!22 = metadata !{null, metadata !23}
!23 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!24 = metadata !{metadata !25}
!25 = metadata !{i32 786689, metadata !18, metadata !"z", metadata !20, i32 16777228, metadata !23, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!26 = metadata !{i32 786449, metadata !27, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !28, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!27 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_int.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!28 = metadata !{metadata !29}
!29 = metadata !{i32 786478, metadata !30, metadata !31, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !32, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !37, i32 13} ; [ 
!30 = metadata !{metadata !"klee_int.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!31 = metadata !{i32 786473, metadata !30}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_int.c]
!32 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !33, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!33 = metadata !{metadata !8, metadata !34}
!34 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !35} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!35 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !36} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!36 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!37 = metadata !{metadata !38, metadata !39}
!38 = metadata !{i32 786689, metadata !29, metadata !"name", metadata !31, i32 16777229, metadata !34, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!39 = metadata !{i32 786688, metadata !29, metadata !"x", metadata !31, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!40 = metadata !{i32 786449, metadata !41, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !42, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!41 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!42 = metadata !{metadata !43}
!43 = metadata !{i32 786478, metadata !44, metadata !45, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !46, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!44 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!45 = metadata !{i32 786473, metadata !44}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c]
!46 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !47, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!47 = metadata !{null, metadata !48, metadata !48}
!48 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!49 = metadata !{metadata !50, metadata !51}
!50 = metadata !{i32 786689, metadata !43, metadata !"bitWidth", metadata !45, i32 16777236, metadata !48, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!51 = metadata !{i32 786689, metadata !43, metadata !"shift", metadata !45, i32 33554452, metadata !48, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!52 = metadata !{i32 786449, metadata !53, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !54, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!53 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!54 = metadata !{metadata !55}
!55 = metadata !{i32 786478, metadata !56, metadata !57, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !58, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!56 = metadata !{metadata !"klee_range.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!57 = metadata !{i32 786473, metadata !56}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!58 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !59, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!59 = metadata !{metadata !8, metadata !8, metadata !8, metadata !34}
!60 = metadata !{metadata !61, metadata !62, metadata !63, metadata !64}
!61 = metadata !{i32 786689, metadata !55, metadata !"start", metadata !57, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!62 = metadata !{i32 786689, metadata !55, metadata !"end", metadata !57, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!63 = metadata !{i32 786689, metadata !55, metadata !"name", metadata !57, i32 50331661, metadata !34, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!64 = metadata !{i32 786688, metadata !55, metadata !"x", metadata !57, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!65 = metadata !{i32 786449, metadata !66, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !67, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!66 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!67 = metadata !{metadata !68}
!68 = metadata !{i32 786478, metadata !69, metadata !70, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !71, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !78, i32 12} 
!69 = metadata !{metadata !"memcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!70 = metadata !{i32 786473, metadata !69}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memcpy.c]
!71 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !72, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!72 = metadata !{metadata !73, metadata !73, metadata !74, metadata !76}
!73 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!74 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !75} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!75 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!76 = metadata !{i32 786454, metadata !69, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !77} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!77 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!78 = metadata !{metadata !79, metadata !80, metadata !81, metadata !82, metadata !84}
!79 = metadata !{i32 786689, metadata !68, metadata !"destaddr", metadata !70, i32 16777228, metadata !73, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!80 = metadata !{i32 786689, metadata !68, metadata !"srcaddr", metadata !70, i32 33554444, metadata !74, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!81 = metadata !{i32 786689, metadata !68, metadata !"len", metadata !70, i32 50331660, metadata !76, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!82 = metadata !{i32 786688, metadata !68, metadata !"dest", metadata !70, i32 13, metadata !83, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!83 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !36} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!84 = metadata !{i32 786688, metadata !68, metadata !"src", metadata !70, i32 14, metadata !34, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!85 = metadata !{i32 786449, metadata !86, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !87, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!86 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!87 = metadata !{metadata !88}
!88 = metadata !{i32 786478, metadata !89, metadata !90, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !91, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !94, i32 1
!89 = metadata !{metadata !"memmove.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!90 = metadata !{i32 786473, metadata !89}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!91 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !92, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!92 = metadata !{metadata !73, metadata !73, metadata !74, metadata !93}
!93 = metadata !{i32 786454, metadata !89, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !77} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!94 = metadata !{metadata !95, metadata !96, metadata !97, metadata !98, metadata !99}
!95 = metadata !{i32 786689, metadata !88, metadata !"dst", metadata !90, i32 16777228, metadata !73, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!96 = metadata !{i32 786689, metadata !88, metadata !"src", metadata !90, i32 33554444, metadata !74, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!97 = metadata !{i32 786689, metadata !88, metadata !"count", metadata !90, i32 50331660, metadata !93, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!98 = metadata !{i32 786688, metadata !88, metadata !"a", metadata !90, i32 13, metadata !83, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!99 = metadata !{i32 786688, metadata !88, metadata !"b", metadata !90, i32 14, metadata !34, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!100 = metadata !{i32 786449, metadata !101, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !102, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!101 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/mempcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!102 = metadata !{metadata !103}
!103 = metadata !{i32 786478, metadata !104, metadata !105, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !106, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !109, 
!104 = metadata !{metadata !"mempcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!105 = metadata !{i32 786473, metadata !104}      ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/mempcpy.c]
!106 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !107, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!107 = metadata !{metadata !73, metadata !73, metadata !74, metadata !108}
!108 = metadata !{i32 786454, metadata !104, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !77} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!109 = metadata !{metadata !110, metadata !111, metadata !112, metadata !113, metadata !114}
!110 = metadata !{i32 786689, metadata !103, metadata !"destaddr", metadata !105, i32 16777227, metadata !73, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!111 = metadata !{i32 786689, metadata !103, metadata !"srcaddr", metadata !105, i32 33554443, metadata !74, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!112 = metadata !{i32 786689, metadata !103, metadata !"len", metadata !105, i32 50331659, metadata !108, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!113 = metadata !{i32 786688, metadata !103, metadata !"dest", metadata !105, i32 12, metadata !83, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!114 = metadata !{i32 786688, metadata !103, metadata !"src", metadata !105, i32 13, metadata !34, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!115 = metadata !{i32 786449, metadata !116, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !117, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!116 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memset.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!117 = metadata !{metadata !118}
!118 = metadata !{i32 786478, metadata !119, metadata !120, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !121, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !124, i32
!119 = metadata !{metadata !"memset.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!120 = metadata !{i32 786473, metadata !119}      ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memset.c]
!121 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !122, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!122 = metadata !{metadata !73, metadata !73, metadata !8, metadata !123}
!123 = metadata !{i32 786454, metadata !119, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !77} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!124 = metadata !{metadata !125, metadata !126, metadata !127, metadata !128}
!125 = metadata !{i32 786689, metadata !118, metadata !"dst", metadata !120, i32 16777227, metadata !73, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!126 = metadata !{i32 786689, metadata !118, metadata !"s", metadata !120, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!127 = metadata !{i32 786689, metadata !118, metadata !"count", metadata !120, i32 50331659, metadata !123, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!128 = metadata !{i32 786688, metadata !118, metadata !"a", metadata !120, i32 12, metadata !129, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!129 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !130} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!130 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !36} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!131 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!132 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!133 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!134 = metadata !{i32 9, i32 0, metadata !4, null}
!135 = metadata !{i32 12, i32 0, metadata !9, null}
!136 = metadata !{i32 13, i32 0, metadata !137, null}
!137 = metadata !{i32 786443, metadata !1, metadata !9, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!138 = metadata !{i32 13, i32 0, metadata !139, null}
!139 = metadata !{i32 786443, metadata !1, metadata !137, i32 13, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!140 = metadata !{i32 15, i32 0, metadata !9, null}
!141 = metadata !{i32 16, i32 0, metadata !9, null}
!142 = metadata !{i32 17, i32 0, metadata !143, null}
!143 = metadata !{i32 786443, metadata !1, metadata !144, i32 17, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!144 = metadata !{i32 786443, metadata !1, metadata !9, i32 16, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!145 = metadata !{i32 17, i32 0, metadata !146, null}
!146 = metadata !{i32 786443, metadata !1, metadata !143, i32 17, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!147 = metadata !{i32 17, i32 0, metadata !144, null}
!148 = metadata !{i32 18, i32 0, metadata !149, null}
!149 = metadata !{i32 786443, metadata !1, metadata !144, i32 18, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!150 = metadata !{i32 18, i32 0, metadata !151, null}
!151 = metadata !{i32 786443, metadata !1, metadata !149, i32 18, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/rasool/POPL2021-CONCUR/prodcon-tracerx/procon.c]
!152 = metadata !{i32 18, i32 0, metadata !144, null}
!153 = metadata !{i32 20, i32 0, metadata !9, null}
!154 = metadata !{i32 21, i32 0, metadata !9, null}
!155 = metadata !{i32 22, i32 0, metadata !9, null}
!156 = metadata !{i32 23, i32 0, metadata !9, null}
!157 = metadata !{i32 26, i32 0, metadata !12, null}
!158 = metadata !{i32 27, i32 0, metadata !12, null}
!159 = metadata !{i32 13, i32 0, metadata !160, null}
!160 = metadata !{i32 786443, metadata !19, metadata !18, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_div_zero_check.c]
!161 = metadata !{i32 14, i32 0, metadata !160, null}
!162 = metadata !{i32 15, i32 0, metadata !18, null}
!163 = metadata !{i32 15, i32 0, metadata !29, null}
!164 = metadata !{i32 16, i32 0, metadata !29, null}
!165 = metadata !{metadata !166, metadata !166, i64 0}
!166 = metadata !{metadata !"int", metadata !167, i64 0}
!167 = metadata !{metadata !"omnipotent char", metadata !168, i64 0}
!168 = metadata !{metadata !"Simple C/C++ TBAA"}
!169 = metadata !{i32 21, i32 0, metadata !170, null}
!170 = metadata !{i32 786443, metadata !44, metadata !43, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c]
!171 = metadata !{i32 27, i32 0, metadata !172, null}
!172 = metadata !{i32 786443, metadata !44, metadata !170, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c]
!173 = metadata !{i32 29, i32 0, metadata !43, null}
!174 = metadata !{i32 16, i32 0, metadata !175, null}
!175 = metadata !{i32 786443, metadata !56, metadata !55, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!176 = metadata !{i32 17, i32 0, metadata !175, null}
!177 = metadata !{i32 19, i32 0, metadata !178, null}
!178 = metadata !{i32 786443, metadata !56, metadata !55, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!179 = metadata !{i32 22, i32 0, metadata !180, null}
!180 = metadata !{i32 786443, metadata !56, metadata !178, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!181 = metadata !{i32 25, i32 0, metadata !182, null}
!182 = metadata !{i32 786443, metadata !56, metadata !180, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!183 = metadata !{i32 26, i32 0, metadata !184, null}
!184 = metadata !{i32 786443, metadata !56, metadata !182, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!185 = metadata !{i32 27, i32 0, metadata !184, null}
!186 = metadata !{i32 28, i32 0, metadata !187, null}
!187 = metadata !{i32 786443, metadata !56, metadata !182, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!188 = metadata !{i32 29, i32 0, metadata !187, null}
!189 = metadata !{i32 32, i32 0, metadata !180, null}
!190 = metadata !{i32 34, i32 0, metadata !55, null}
!191 = metadata !{i32 16, i32 0, metadata !68, null}
!192 = metadata !{i32 17, i32 0, metadata !68, null}
!193 = metadata !{metadata !193, metadata !194, metadata !195}
!194 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!195 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!196 = metadata !{metadata !167, metadata !167, i64 0}
!197 = metadata !{metadata !197, metadata !194, metadata !195}
!198 = metadata !{i32 18, i32 0, metadata !68, null}
!199 = metadata !{i32 16, i32 0, metadata !200, null}
!200 = metadata !{i32 786443, metadata !89, metadata !88, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!201 = metadata !{i32 19, i32 0, metadata !202, null}
!202 = metadata !{i32 786443, metadata !89, metadata !88, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!203 = metadata !{i32 20, i32 0, metadata !204, null}
!204 = metadata !{i32 786443, metadata !89, metadata !202, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!205 = metadata !{metadata !205, metadata !194, metadata !195}
!206 = metadata !{metadata !206, metadata !194, metadata !195}
!207 = metadata !{i32 22, i32 0, metadata !208, null}
!208 = metadata !{i32 786443, metadata !89, metadata !202, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!209 = metadata !{i32 24, i32 0, metadata !208, null}
!210 = metadata !{i32 23, i32 0, metadata !208, null}
!211 = metadata !{metadata !211, metadata !194, metadata !195}
!212 = metadata !{metadata !212, metadata !194, metadata !195}
!213 = metadata !{i32 28, i32 0, metadata !88, null}
!214 = metadata !{i32 15, i32 0, metadata !103, null}
!215 = metadata !{i32 16, i32 0, metadata !103, null}
!216 = metadata !{metadata !216, metadata !194, metadata !195}
!217 = metadata !{metadata !217, metadata !194, metadata !195}
!218 = metadata !{i32 17, i32 0, metadata !103, null}
!219 = metadata !{i32 13, i32 0, metadata !118, null}
!220 = metadata !{i32 14, i32 0, metadata !118, null}
!221 = metadata !{i32 15, i32 0, metadata !118, null}
