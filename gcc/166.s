	.file	"166.in"
	.data
	.align 4
	.type	ptrace_nelt,@object
	.size	ptrace_nelt,4
ptrace_nelt:
	.long	0
	.align 4
	.type	twolev_nelt,@object
	.size	twolev_nelt,4
twolev_nelt:
	.long	3
	.align 4
	.type	twolev_config,@object
	.size	twolev_config,12
twolev_config:
	.long	1
	.long	1024
	.long	8
	.align 4
	.type	ruu_include_spec,@object
	.size	ruu_include_spec,4
ruu_include_spec:
	.long	1
	.align 4
	.type	RUU_size,@object
	.size	RUU_size,4
RUU_size:
	.long	8
	.align 4
	.type	LSQ_size,@object
	.size	LSQ_size,4
LSQ_size:
	.long	4
	.align 4
	.type	mem_nelt,@object
	.size	mem_nelt,4
mem_nelt:
	.long	2
	.align 4
	.type	mem_lat,@object
	.size	mem_lat,8
mem_lat:
	.long	18
	.long	2
	.align 4
	.type	pcstat_nelt,@object
	.size	pcstat_nelt,4
pcstat_nelt:
	.long	0
.globl fu_config
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"integer-ALU"
.LC1:
	.string	"integer-MULT/DIV"
.LC2:
	.string	"memory-port"
.LC3:
	.string	"FP-adder"
.LC4:
	.string	"FP-MULT/DIV"
	.data
	.align 32
	.type	fu_config,@object
	.size	fu_config,2000
fu_config:
	.quad	.LC0
	.long	4
	.long	0
	.long	1
	.long	1
	.long	1
	.zero	12
	.zero	360
	.quad	.LC1
	.long	1
	.long	0
	.long	2
	.long	3
	.long	1
	.zero	12
	.long	3
	.long	20
	.long	19
	.zero	12
	.zero	336
	.quad	.LC2
	.long	2
	.long	0
	.long	10
	.long	1
	.long	1
	.zero	12
	.long	11
	.long	1
	.long	1
	.zero	12
	.zero	336
	.quad	.LC3
	.long	4
	.long	0
	.long	4
	.long	2
	.long	1
	.zero	12
	.long	5
	.long	2
	.long	1
	.zero	12
	.long	6
	.long	2
	.long	1
	.zero	12
	.zero	312
	.quad	.LC4
	.long	1
	.long	0
	.long	7
	.long	4
	.long	1
	.zero	12
	.long	8
	.long	12
	.long	12
	.zero	12
	.long	9
	.long	24
	.long	24
	.zero	12
	.zero	312
	.align 8
	.type	sim_num_insn,@object
	.size	sim_num_insn,8
sim_num_insn:
	.quad	0
	.align 8
	.type	sim_total_insn,@object
	.size	sim_total_insn,8
sim_total_insn:
	.quad	0
	.align 8
	.type	sim_num_refs,@object
	.size	sim_num_refs,8
sim_num_refs:
	.quad	0
	.align 8
	.type	sim_total_refs,@object
	.size	sim_total_refs,8
sim_total_refs:
	.quad	0
	.align 8
	.type	sim_num_loads,@object
	.size	sim_num_loads,8
sim_num_loads:
	.quad	0
	.align 8
	.type	sim_total_loads,@object
	.size	sim_total_loads,8
sim_total_loads:
	.quad	0
	.align 8
	.type	sim_num_branches,@object
	.size	sim_num_branches,8
sim_num_branches:
	.quad	0
	.align 8
	.type	sim_total_branches,@object
	.size	sim_total_branches,8
sim_total_branches:
	.quad	0
	.align 8
	.type	sim_cycle,@object
	.size	sim_cycle,8
sim_cycle:
	.quad	0
	.align 4
	.type	inst_seq,@object
	.size	inst_seq,4
inst_seq:
	.long	0
	.align 4
	.type	ptrace_seq,@object
	.size	ptrace_seq,4
ptrace_seq:
	.long	0
	.align 4
	.type	spec_mode,@object
	.size	spec_mode,4
spec_mode:
	.long	0
	.align 4
	.type	ruu_fetch_issue_delay,@object
	.size	ruu_fetch_issue_delay,4
ruu_fetch_issue_delay:
	.long	0
	.align 4
	.type	pred_perfect,@object
	.size	pred_perfect,4
pred_perfect:
	.long	0
	.align 8
	.type	fu_pool,@object
	.size	fu_pool,8
fu_pool:
	.quad	0
	.align 32
	.type	RSLINK_NULL,@object
	.size	RSLINK_NULL,32
RSLINK_NULL:
	.quad	0
	.quad	0
	.long	0
	.zero	12
	.align 16
	.type	CVLINK_NULL,@object
	.size	CVLINK_NULL,16
CVLINK_NULL:
	.quad	0
	.long	0
	.zero	4
	.section	.rodata.str1.1
.LC5:
	.string	"n/a"
.LC6:
	.string	"$r1"
.LC7:
	.string	"$r2"
.LC8:
	.string	"$r3"
.LC9:
	.string	"$r4"
.LC10:
	.string	"$r5"
.LC11:
	.string	"$r6"
.LC12:
	.string	"$r7"
.LC13:
	.string	"$r8"
.LC14:
	.string	"$r9"
.LC15:
	.string	"$r10"
.LC16:
	.string	"$r11"
.LC17:
	.string	"$r12"
.LC18:
	.string	"$r13"
.LC19:
	.string	"$r14"
.LC20:
	.string	"$r15"
.LC21:
	.string	"$r16"
.LC22:
	.string	"$r17"
.LC23:
	.string	"$r18"
.LC24:
	.string	"$r19"
.LC25:
	.string	"$r20"
.LC26:
	.string	"$r21"
.LC27:
	.string	"$r22"
.LC28:
	.string	"$r23"
.LC29:
	.string	"$r24"
.LC30:
	.string	"$r25"
.LC31:
	.string	"$r26"
.LC32:
	.string	"$r27"
.LC33:
	.string	"$r28"
.LC34:
	.string	"$r29"
.LC35:
	.string	"$r30"
.LC36:
	.string	"$r31"
.LC37:
	.string	"$f0"
.LC38:
	.string	"$f1"
.LC39:
	.string	"$f2"
.LC40:
	.string	"$f3"
.LC41:
	.string	"$f4"
.LC42:
	.string	"$f5"
.LC43:
	.string	"$f6"
.LC44:
	.string	"$f7"
.LC45:
	.string	"$f8"
.LC46:
	.string	"$f9"
.LC47:
	.string	"$f10"
.LC48:
	.string	"$f11"
.LC49:
	.string	"$f12"
.LC50:
	.string	"$f13"
.LC51:
	.string	"$f14"
.LC52:
	.string	"$f15"
.LC53:
	.string	"$f16"
.LC54:
	.string	"$f17"
.LC55:
	.string	"$f18"
.LC56:
	.string	"$f19"
.LC57:
	.string	"$f20"
.LC58:
	.string	"$f21"
.LC59:
	.string	"$f22"
.LC60:
	.string	"$f23"
.LC61:
	.string	"$f24"
.LC62:
	.string	"$f25"
.LC63:
	.string	"$f26"
.LC64:
	.string	"$f27"
.LC65:
	.string	"$f28"
.LC66:
	.string	"$f29"
.LC67:
	.string	"$f30"
.LC68:
	.string	"$f31"
.LC69:
	.string	"$hi"
.LC70:
	.string	"$lo"
.LC71:
	.string	"$fcc"
.LC72:
	.string	"$tmp"
	.data
	.align 32
	.type	dep_names,@object
	.size	dep_names,560
dep_names:
	.quad	.LC5
	.quad	.LC6
	.quad	.LC7
	.quad	.LC8
	.quad	.LC9
	.quad	.LC10
	.quad	.LC11
	.quad	.LC12
	.quad	.LC13
	.quad	.LC14
	.quad	.LC15
	.quad	.LC16
	.quad	.LC17
	.quad	.LC18
	.quad	.LC19
	.quad	.LC20
	.quad	.LC21
	.quad	.LC22
	.quad	.LC23
	.quad	.LC24
	.quad	.LC25
	.quad	.LC26
	.quad	.LC27
	.quad	.LC28
	.quad	.LC29
	.quad	.LC30
	.qua