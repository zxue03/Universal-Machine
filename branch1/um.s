
um:     file format elf64-x86-64


Disassembly of section .init:

0000000000400840 <_init>:
  400840:	48 83 ec 08          	sub    $0x8,%rsp
  400844:	48 8b 05 9d 17 20 00 	mov    0x20179d(%rip),%rax        # 601fe8 <__gmon_start__>
  40084b:	48 85 c0             	test   %rax,%rax
  40084e:	74 05                	je     400855 <_init+0x15>
  400850:	e8 8b 00 00 00       	callq  4008e0 <__gmon_start__@plt>
  400855:	48 83 c4 08          	add    $0x8,%rsp
  400859:	c3                   	retq   

Disassembly of section .plt:

0000000000400860 <.plt>:
  400860:	ff 35 a2 17 20 00    	pushq  0x2017a2(%rip)        # 602008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400866:	ff 25 a4 17 20 00    	jmpq   *0x2017a4(%rip)        # 602010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40086c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400870 <free@plt>:
  400870:	ff 25 a2 17 20 00    	jmpq   *0x2017a2(%rip)        # 602018 <free@GLIBC_2.2.5>
  400876:	68 00 00 00 00       	pushq  $0x0
  40087b:	e9 e0 ff ff ff       	jmpq   400860 <.plt>

0000000000400880 <abort@plt>:
  400880:	ff 25 9a 17 20 00    	jmpq   *0x20179a(%rip)        # 602020 <abort@GLIBC_2.2.5>
  400886:	68 01 00 00 00       	pushq  $0x1
  40088b:	e9 d0 ff ff ff       	jmpq   400860 <.plt>

0000000000400890 <fclose@plt>:
  400890:	ff 25 92 17 20 00    	jmpq   *0x201792(%rip)        # 602028 <fclose@GLIBC_2.2.5>
  400896:	68 02 00 00 00       	pushq  $0x2
  40089b:	e9 c0 ff ff ff       	jmpq   400860 <.plt>

00000000004008a0 <printf@plt>:
  4008a0:	ff 25 8a 17 20 00    	jmpq   *0x20178a(%rip)        # 602030 <printf@GLIBC_2.2.5>
  4008a6:	68 03 00 00 00       	pushq  $0x3
  4008ab:	e9 b0 ff ff ff       	jmpq   400860 <.plt>

00000000004008b0 <fgetc@plt>:
  4008b0:	ff 25 82 17 20 00    	jmpq   *0x201782(%rip)        # 602038 <fgetc@GLIBC_2.2.5>
  4008b6:	68 04 00 00 00       	pushq  $0x4
  4008bb:	e9 a0 ff ff ff       	jmpq   400860 <.plt>

00000000004008c0 <__libc_start_main@plt>:
  4008c0:	ff 25 7a 17 20 00    	jmpq   *0x20177a(%rip)        # 602040 <__libc_start_main@GLIBC_2.2.5>
  4008c6:	68 05 00 00 00       	pushq  $0x5
  4008cb:	e9 90 ff ff ff       	jmpq   400860 <.plt>

00000000004008d0 <fprintf@plt>:
  4008d0:	ff 25 72 17 20 00    	jmpq   *0x201772(%rip)        # 602048 <fprintf@GLIBC_2.2.5>
  4008d6:	68 06 00 00 00       	pushq  $0x6
  4008db:	e9 80 ff ff ff       	jmpq   400860 <.plt>

00000000004008e0 <__gmon_start__@plt>:
  4008e0:	ff 25 6a 17 20 00    	jmpq   *0x20176a(%rip)        # 602050 <__gmon_start__>
  4008e6:	68 07 00 00 00       	pushq  $0x7
  4008eb:	e9 70 ff ff ff       	jmpq   400860 <.plt>

00000000004008f0 <malloc@plt>:
  4008f0:	ff 25 62 17 20 00    	jmpq   *0x201762(%rip)        # 602058 <malloc@GLIBC_2.2.5>
  4008f6:	68 08 00 00 00       	pushq  $0x8
  4008fb:	e9 60 ff ff ff       	jmpq   400860 <.plt>

0000000000400900 <fflush@plt>:
  400900:	ff 25 5a 17 20 00    	jmpq   *0x20175a(%rip)        # 602060 <fflush@GLIBC_2.2.5>
  400906:	68 09 00 00 00       	pushq  $0x9
  40090b:	e9 50 ff ff ff       	jmpq   400860 <.plt>

0000000000400910 <_IO_getc@plt>:
  400910:	ff 25 52 17 20 00    	jmpq   *0x201752(%rip)        # 602068 <_IO_getc@GLIBC_2.2.5>
  400916:	68 0a 00 00 00       	pushq  $0xa
  40091b:	e9 40 ff ff ff       	jmpq   400860 <.plt>

0000000000400920 <ungetc@plt>:
  400920:	ff 25 4a 17 20 00    	jmpq   *0x20174a(%rip)        # 602070 <ungetc@GLIBC_2.2.5>
  400926:	68 0b 00 00 00       	pushq  $0xb
  40092b:	e9 30 ff ff ff       	jmpq   400860 <.plt>

0000000000400930 <longjmp@plt>:
  400930:	ff 25 42 17 20 00    	jmpq   *0x201742(%rip)        # 602078 <longjmp@GLIBC_2.2.5>
  400936:	68 0c 00 00 00       	pushq  $0xc
  40093b:	e9 20 ff ff ff       	jmpq   400860 <.plt>

0000000000400940 <fopen@plt>:
  400940:	ff 25 3a 17 20 00    	jmpq   *0x20173a(%rip)        # 602080 <fopen@GLIBC_2.2.5>
  400946:	68 0d 00 00 00       	pushq  $0xd
  40094b:	e9 10 ff ff ff       	jmpq   400860 <.plt>

0000000000400950 <exit@plt>:
  400950:	ff 25 32 17 20 00    	jmpq   *0x201732(%rip)        # 602088 <exit@GLIBC_2.2.5>
  400956:	68 0e 00 00 00       	pushq  $0xe
  40095b:	e9 00 ff ff ff       	jmpq   400860 <.plt>

0000000000400960 <fwrite@plt>:
  400960:	ff 25 2a 17 20 00    	jmpq   *0x20172a(%rip)        # 602090 <fwrite@GLIBC_2.2.5>
  400966:	68 0f 00 00 00       	pushq  $0xf
  40096b:	e9 f0 fe ff ff       	jmpq   400860 <.plt>

Disassembly of section .text:

0000000000400970 <main>:
  400970:	55                   	push   %rbp
  400971:	83 ff 02             	cmp    $0x2,%edi
  400974:	75 2a                	jne    4009a0 <main+0x30>
  400976:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
  40097a:	be 2c 16 40 00       	mov    $0x40162c,%esi
  40097f:	e8 bc ff ff ff       	callq  400940 <fopen@plt>
  400984:	48 89 c5             	mov    %rax,%rbp
  400987:	48 85 c0             	test   %rax,%rax
  40098a:	74 14                	je     4009a0 <main+0x30>
  40098c:	48 89 c7             	mov    %rax,%rdi
  40098f:	e8 fc 09 00 00       	callq  401390 <run_um>
  400994:	48 89 ef             	mov    %rbp,%rdi
  400997:	e8 f4 fe ff ff       	callq  400890 <fclose@plt>
  40099c:	31 c0                	xor    %eax,%eax
  40099e:	5d                   	pop    %rbp
  40099f:	c3                   	retq   
  4009a0:	bf 01 00 00 00       	mov    $0x1,%edi
  4009a5:	e8 a6 ff ff ff       	callq  400950 <exit@plt>

00000000004009aa <_start>:
  4009aa:	31 ed                	xor    %ebp,%ebp
  4009ac:	49 89 d1             	mov    %rdx,%r9
  4009af:	5e                   	pop    %rsi
  4009b0:	48 89 e2             	mov    %rsp,%rdx
  4009b3:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4009b7:	50                   	push   %rax
  4009b8:	54                   	push   %rsp
  4009b9:	49 c7 c0 10 16 40 00 	mov    $0x401610,%r8
  4009c0:	48 c7 c1 a0 15 40 00 	mov    $0x4015a0,%rcx
  4009c7:	48 c7 c7 70 09 40 00 	mov    $0x400970,%rdi
  4009ce:	e8 ed fe ff ff       	callq  4008c0 <__libc_start_main@plt>
  4009d3:	f4                   	hlt    
  4009d4:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4009db:	00 00 00 
  4009de:	66 90                	xchg   %ax,%ax

00000000004009e0 <deregister_tm_clones>:
  4009e0:	48 8d 3d c9 16 20 00 	lea    0x2016c9(%rip),%rdi        # 6020b0 <__TMC_END__>
  4009e7:	48 8d 05 c2 16 20 00 	lea    0x2016c2(%rip),%rax        # 6020b0 <__TMC_END__>
  4009ee:	48 39 f8             	cmp    %rdi,%rax
  4009f1:	74 15                	je     400a08 <deregister_tm_clones+0x28>
  4009f3:	48 8b 05 e6 15 20 00 	mov    0x2015e6(%rip),%rax        # 601fe0 <_ITM_deregisterTMCloneTable>
  4009fa:	48 85 c0             	test   %rax,%rax
  4009fd:	74 09                	je     400a08 <deregister_tm_clones+0x28>
  4009ff:	ff e0                	jmpq   *%rax
  400a01:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  400a08:	c3                   	retq   
  400a09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400a10 <register_tm_clones>:
  400a10:	48 8d 3d 99 16 20 00 	lea    0x201699(%rip),%rdi        # 6020b0 <__TMC_END__>
  400a17:	48 8d 35 92 16 20 00 	lea    0x201692(%rip),%rsi        # 6020b0 <__TMC_END__>
  400a1e:	48 29 fe             	sub    %rdi,%rsi
  400a21:	48 89 f0             	mov    %rsi,%rax
  400a24:	48 c1 ee 3f          	shr    $0x3f,%rsi
  400a28:	48 c1 f8 03          	sar    $0x3,%rax
  400a2c:	48 01 c6             	add    %rax,%rsi
  400a2f:	48 d1 fe             	sar    %rsi
  400a32:	74 14                	je     400a48 <register_tm_clones+0x38>
  400a34:	48 8b 05 b5 15 20 00 	mov    0x2015b5(%rip),%rax        # 601ff0 <_ITM_registerTMCloneTable>
  400a3b:	48 85 c0             	test   %rax,%rax
  400a3e:	74 08                	je     400a48 <register_tm_clones+0x38>
  400a40:	ff e0                	jmpq   *%rax
  400a42:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  400a48:	c3                   	retq   
  400a49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400a50 <__do_global_dtors_aux>:
  400a50:	80 3d 71 16 20 00 00 	cmpb   $0x0,0x201671(%rip)        # 6020c8 <completed.7307>
  400a57:	75 17                	jne    400a70 <__do_global_dtors_aux+0x20>
  400a59:	55                   	push   %rbp
  400a5a:	48 89 e5             	mov    %rsp,%rbp
  400a5d:	e8 7e ff ff ff       	callq  4009e0 <deregister_tm_clones>
  400a62:	c6 05 5f 16 20 00 01 	movb   $0x1,0x20165f(%rip)        # 6020c8 <completed.7307>
  400a69:	5d                   	pop    %rbp
  400a6a:	c3                   	retq   
  400a6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400a70:	c3                   	retq   
  400a71:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400a76:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400a7d:	00 00 00 

0000000000400a80 <frame_dummy>:
  400a80:	eb 8e                	jmp    400a10 <register_tm_clones>
  400a82:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400a89:	00 00 00 
  400a8c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400a90 <Bitpack_fitsu>:
  400a90:	b8 01 00 00 00       	mov    $0x1,%eax
  400a95:	83 fe 20             	cmp    $0x20,%esi
  400a98:	74 09                	je     400aa3 <Bitpack_fitsu+0x13>
  400a9a:	89 f1                	mov    %esi,%ecx
  400a9c:	d3 ef                	shr    %cl,%edi
  400a9e:	85 ff                	test   %edi,%edi
  400aa0:	0f 94 c0             	sete   %al
  400aa3:	c3                   	retq   
  400aa4:	66 90                	xchg   %ax,%ax
  400aa6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400aad:	00 00 00 

0000000000400ab0 <Bitpack_getu>:
  400ab0:	41 89 d0             	mov    %edx,%r8d
  400ab3:	ba 20 00 00 00       	mov    $0x20,%edx
  400ab8:	31 c0                	xor    %eax,%eax
  400aba:	29 f2                	sub    %esi,%edx
  400abc:	89 d1                	mov    %edx,%ecx
  400abe:	44 29 c1             	sub    %r8d,%ecx
  400ac1:	d3 e7                	shl    %cl,%edi
  400ac3:	83 f9 20             	cmp    $0x20,%ecx
  400ac6:	89 d1                	mov    %edx,%ecx
  400ac8:	0f 44 f8             	cmove  %eax,%edi
  400acb:	d3 ef                	shr    %cl,%edi
  400acd:	83 fa 20             	cmp    $0x20,%edx
  400ad0:	0f 45 c7             	cmovne %edi,%eax
  400ad3:	c3                   	retq   
  400ad4:	66 90                	xchg   %ax,%ax
  400ad6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400add:	00 00 00 

0000000000400ae0 <Bitpack_newu>:
  400ae0:	41 89 c8             	mov    %ecx,%r8d
  400ae3:	8d 0c 32             	lea    (%rdx,%rsi,1),%ecx
  400ae6:	89 fe                	mov    %edi,%esi
  400ae8:	31 c0                	xor    %eax,%eax
  400aea:	d3 ee                	shr    %cl,%esi
  400aec:	d3 e6                	shl    %cl,%esi
  400aee:	83 f9 20             	cmp    $0x20,%ecx
  400af1:	b9 20 00 00 00       	mov    $0x20,%ecx
  400af6:	0f 44 f0             	cmove  %eax,%esi
  400af9:	29 d1                	sub    %edx,%ecx
  400afb:	d3 e7                	shl    %cl,%edi
  400afd:	d3 ef                	shr    %cl,%edi
  400aff:	83 f9 20             	cmp    $0x20,%ecx
  400b02:	89 d1                	mov    %edx,%ecx
  400b04:	0f 45 c7             	cmovne %edi,%eax
  400b07:	41 d3 e0             	shl    %cl,%r8d
  400b0a:	41 09 f0             	or     %esi,%r8d
  400b0d:	44 09 c0             	or     %r8d,%eax
  400b10:	c3                   	retq   
  400b11:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400b16:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400b1d:	00 00 00 

0000000000400b20 <read_instructions>:
  400b20:	41 56                	push   %r14
  400b22:	41 55                	push   %r13
  400b24:	41 54                	push   %r12
  400b26:	49 89 fc             	mov    %rdi,%r12
  400b29:	55                   	push   %rbp
  400b2a:	4c 89 e7             	mov    %r12,%rdi
  400b2d:	53                   	push   %rbx
  400b2e:	48 83 ec 10          	sub    $0x10,%rsp
  400b32:	e8 79 fd ff ff       	callq  4008b0 <fgetc@plt>
  400b37:	89 c7                	mov    %eax,%edi
  400b39:	83 f8 ff             	cmp    $0xffffffff,%eax
  400b3c:	0f 84 d2 00 00 00    	je     400c14 <read_instructions+0xf4>
  400b42:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  400b48:	4c 89 e6             	mov    %r12,%rsi
  400b4b:	bd 20 00 00 00       	mov    $0x20,%ebp
  400b50:	31 db                	xor    %ebx,%ebx
  400b52:	41 bd 28 00 00 00    	mov    $0x28,%r13d
  400b58:	e8 c3 fd ff ff       	callq  400920 <ungetc@plt>
  400b5d:	4c 89 e7             	mov    %r12,%rdi
  400b60:	e8 4b fd ff ff       	callq  4008b0 <fgetc@plt>
  400b65:	44 89 ea             	mov    %r13d,%edx
  400b68:	8d 7d f8             	lea    -0x8(%rbp),%edi
  400b6b:	29 ea                	sub    %ebp,%edx
  400b6d:	83 fd 20             	cmp    $0x20,%ebp
  400b70:	0f 84 4a 01 00 00    	je     400cc0 <read_instructions+0x1a0>
  400b76:	89 e9                	mov    %ebp,%ecx
  400b78:	89 de                	mov    %ebx,%esi
  400b7a:	d3 ee                	shr    %cl,%esi
  400b7c:	d3 e6                	shl    %cl,%esi
  400b7e:	83 fa 20             	cmp    $0x20,%edx
  400b81:	0f 85 19 01 00 00    	jne    400ca0 <read_instructions+0x180>
  400b87:	09 f0                	or     %esi,%eax
  400b89:	89 c3                	mov    %eax,%ebx
  400b8b:	44 8b 2d 9e 15 20 00 	mov    0x20159e(%rip),%r13d        # 602130 <unmapped>
  400b92:	8b 3d 9c 15 20 00    	mov    0x20159c(%rip),%edi        # 602134 <unmapped+0x4>
  400b98:	48 8b 2d 99 15 20 00 	mov    0x201599(%rip),%rbp        # 602138 <unmapped+0x8>
  400b9f:	41 39 fd             	cmp    %edi,%r13d
  400ba2:	72 51                	jb     400bf5 <read_instructions+0xd5>
  400ba4:	8d 04 3f             	lea    (%rdi,%rdi,1),%eax
  400ba7:	c1 e7 03             	shl    $0x3,%edi
  400baa:	89 05 84 15 20 00    	mov    %eax,0x201584(%rip)        # 602134 <unmapped+0x4>
  400bb0:	e8 3b fd ff ff       	callq  4008f0 <malloc@plt>
  400bb5:	31 d2                	xor    %edx,%edx
  400bb7:	49 89 c6             	mov    %rax,%r14
  400bba:	41 8d 45 ff          	lea    -0x1(%r13),%eax
  400bbe:	45 85 ed             	test   %r13d,%r13d
  400bc1:	74 19                	je     400bdc <read_instructions+0xbc>
  400bc3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400bc8:	8b 4c 95 00          	mov    0x0(%rbp,%rdx,4),%ecx
  400bcc:	41 89 0c 96          	mov    %ecx,(%r14,%rdx,4)
  400bd0:	48 89 d1             	mov    %rdx,%rcx
  400bd3:	48 83 c2 01          	add    $0x1,%rdx
  400bd7:	48 39 c8             	cmp    %rcx,%rax
  400bda:	75 ec                	jne    400bc8 <read_instructions+0xa8>
  400bdc:	48 89 ef             	mov    %rbp,%rdi
  400bdf:	4c 89 f5             	mov    %r14,%rbp
  400be2:	e8 89 fc ff ff       	callq  400870 <free@plt>
  400be7:	4c 89 35 4a 15 20 00 	mov    %r14,0x20154a(%rip)        # 602138 <unmapped+0x8>
  400bee:	44 8b 2d 3b 15 20 00 	mov    0x20153b(%rip),%r13d        # 602130 <unmapped>
  400bf5:	42 89 5c ad 00       	mov    %ebx,0x0(%rbp,%r13,4)
  400bfa:	4c 89 e7             	mov    %r12,%rdi
  400bfd:	83 05 2c 15 20 00 01 	addl   $0x1,0x20152c(%rip)        # 602130 <unmapped>
  400c04:	e8 a7 fc ff ff       	callq  4008b0 <fgetc@plt>
  400c09:	89 c7                	mov    %eax,%edi
  400c0b:	83 f8 ff             	cmp    $0xffffffff,%eax
  400c0e:	0f 85 34 ff ff ff    	jne    400b48 <read_instructions+0x28>
  400c14:	8b 2d 16 15 20 00    	mov    0x201516(%rip),%ebp        # 602130 <unmapped>
  400c1a:	48 8b 1d c7 14 20 00 	mov    0x2014c7(%rip),%rbx        # 6020e8 <segments+0x8>
  400c21:	89 2b                	mov    %ebp,(%rbx)
  400c23:	8d 3c ad 00 00 00 00 	lea    0x0(,%rbp,4),%edi
  400c2a:	e8 c1 fc ff ff       	callq  4008f0 <malloc@plt>
  400c2f:	48 85 c0             	test   %rax,%rax
  400c32:	0f 84 9d 00 00 00    	je     400cd5 <read_instructions+0x1b5>
  400c38:	48 8b 3d f9 14 20 00 	mov    0x2014f9(%rip),%rdi        # 602138 <unmapped+0x8>
  400c3f:	31 d2                	xor    %edx,%edx
  400c41:	85 ed                	test   %ebp,%ebp
  400c43:	74 12                	je     400c57 <read_instructions+0x137>
  400c45:	0f 1f 00             	nopl   (%rax)
  400c48:	89 d1                	mov    %edx,%ecx
  400c4a:	83 c2 01             	add    $0x1,%edx
  400c4d:	8b 34 8f             	mov    (%rdi,%rcx,4),%esi
  400c50:	89 34 88             	mov    %esi,(%rax,%rcx,4)
  400c53:	39 13                	cmp    %edx,(%rbx)
  400c55:	77 f1                	ja     400c48 <read_instructions+0x128>
  400c57:	48 89 43 08          	mov    %rax,0x8(%rbx)
  400c5b:	83 05 7e 14 20 00 01 	addl   $0x1,0x20147e(%rip)        # 6020e0 <segments>
  400c62:	e8 09 fc ff ff       	callq  400870 <free@plt>
  400c67:	bf 40 9c 00 00       	mov    $0x9c40,%edi
  400c6c:	48 b8 00 00 00 00 10 	movabs $0x271000000000,%rax
  400c73:	27 00 00 
  400c76:	48 89 05 b3 14 20 00 	mov    %rax,0x2014b3(%rip)        # 602130 <unmapped>
  400c7d:	e8 6e fc ff ff       	callq  4008f0 <malloc@plt>
  400c82:	48 89 05 af 14 20 00 	mov    %rax,0x2014af(%rip)        # 602138 <unmapped+0x8>
  400c89:	48 83 c4 10          	add    $0x10,%rsp
  400c8d:	5b                   	pop    %rbx
  400c8e:	5d                   	pop    %rbp
  400c8f:	41 5c                	pop    %r12
  400c91:	41 5d                	pop    %r13
  400c93:	41 5e                	pop    %r14
  400c95:	c3                   	retq   
  400c96:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400c9d:	00 00 00 
  400ca0:	89 d1                	mov    %edx,%ecx
  400ca2:	89 fd                	mov    %edi,%ebp
  400ca4:	d3 e3                	shl    %cl,%ebx
  400ca6:	d3 eb                	shr    %cl,%ebx
  400ca8:	89 f9                	mov    %edi,%ecx
  400caa:	d3 e0                	shl    %cl,%eax
  400cac:	09 c3                	or     %eax,%ebx
  400cae:	09 f3                	or     %esi,%ebx
  400cb0:	85 ff                	test   %edi,%edi
  400cb2:	0f 85 a5 fe ff ff    	jne    400b5d <read_instructions+0x3d>
  400cb8:	e9 ce fe ff ff       	jmpq   400b8b <read_instructions+0x6b>
  400cbd:	0f 1f 00             	nopl   (%rax)
  400cc0:	89 d1                	mov    %edx,%ecx
  400cc2:	c1 e0 18             	shl    $0x18,%eax
  400cc5:	bd 18 00 00 00       	mov    $0x18,%ebp
  400cca:	d3 e3                	shl    %cl,%ebx
  400ccc:	d3 eb                	shr    %cl,%ebx
  400cce:	09 c3                	or     %eax,%ebx
  400cd0:	e9 88 fe ff ff       	jmpq   400b5d <read_instructions+0x3d>
  400cd5:	ba 24 01 00 00       	mov    $0x124,%edx
  400cda:	be 24 16 40 00       	mov    $0x401624,%esi
  400cdf:	bf e8 1d 60 00       	mov    $0x601de8,%edi
  400ce4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  400ce9:	e8 72 07 00 00       	callq  401460 <Except_raise>
  400cee:	48 8b 1d f3 13 20 00 	mov    0x2013f3(%rip),%rbx        # 6020e8 <segments+0x8>
  400cf5:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  400cfa:	8b 2b                	mov    (%rbx),%ebp
  400cfc:	e9 37 ff ff ff       	jmpq   400c38 <read_instructions+0x118>
  400d01:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400d06:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400d0d:	00 00 00 

0000000000400d10 <execute_instructions>:
  400d10:	41 57                	push   %r15
  400d12:	41 56                	push   %r14
  400d14:	41 55                	push   %r13
  400d16:	41 54                	push   %r12
  400d18:	55                   	push   %rbp
  400d19:	53                   	push   %rbx
  400d1a:	48 83 ec 18          	sub    $0x18,%rsp
  400d1e:	48 8b 05 c3 13 20 00 	mov    0x2013c3(%rip),%rax        # 6020e8 <segments+0x8>
  400d25:	8b 0d f5 13 20 00    	mov    0x2013f5(%rip),%ecx        # 602120 <um+0x20>
  400d2b:	48 8b 68 08          	mov    0x8(%rax),%rbp
  400d2f:	90                   	nop
  400d30:	89 c8                	mov    %ecx,%eax
  400d32:	8b 44 85 00          	mov    0x0(%rbp,%rax,4),%eax
  400d36:	89 c2                	mov    %eax,%edx
  400d38:	c1 ea 1c             	shr    $0x1c,%edx
  400d3b:	3d ff ff ff df       	cmp    $0xdfffffff,%eax
  400d40:	0f 87 f4 03 00 00    	ja     40113a <execute_instructions+0x42a>
  400d46:	ff 24 d5 48 16 40 00 	jmpq   *0x401648(,%rdx,8)
  400d4d:	0f 1f 00             	nopl   (%rax)
  400d50:	89 c3                	mov    %eax,%ebx
  400d52:	83 e0 07             	and    $0x7,%eax
  400d55:	c1 e3 1a             	shl    $0x1a,%ebx
  400d58:	8b 0c 85 00 21 60 00 	mov    0x602100(,%rax,4),%ecx
  400d5f:	c1 eb 1d             	shr    $0x1d,%ebx
  400d62:	8b 04 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%eax
  400d69:	89 0d b1 13 20 00    	mov    %ecx,0x2013b1(%rip)        # 602120 <um+0x20>
  400d6f:	85 c0                	test   %eax,%eax
  400d71:	74 bd                	je     400d30 <execute_instructions+0x20>
  400d73:	48 8b 05 6e 13 20 00 	mov    0x20136e(%rip),%rax        # 6020e8 <segments+0x8>
  400d7a:	48 8b 78 08          	mov    0x8(%rax),%rdi
  400d7e:	e8 ed fa ff ff       	callq  400870 <free@plt>
  400d83:	8b 04 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%eax
  400d8a:	4c 8b 3d 57 13 20 00 	mov    0x201357(%rip),%r15        # 6020e8 <segments+0x8>
  400d91:	49 89 c6             	mov    %rax,%r14
  400d94:	48 c1 e0 04          	shl    $0x4,%rax
  400d98:	4c 01 f8             	add    %r15,%rax
  400d9b:	44 8b 28             	mov    (%rax),%r13d
  400d9e:	4c 8b 60 08          	mov    0x8(%rax),%r12
  400da2:	42 8d 3c ad 00 00 00 	lea    0x0(,%r13,4),%edi
  400da9:	00 
  400daa:	e8 41 fb ff ff       	callq  4008f0 <malloc@plt>
  400daf:	48 85 c0             	test   %rax,%rax
  400db2:	0f 84 14 05 00 00    	je     4012cc <execute_instructions+0x5bc>
  400db8:	41 8d 75 ff          	lea    -0x1(%r13),%esi
  400dbc:	31 d2                	xor    %edx,%edx
  400dbe:	45 85 ed             	test   %r13d,%r13d
  400dc1:	74 18                	je     400ddb <execute_instructions+0xcb>
  400dc3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400dc8:	41 8b 0c 94          	mov    (%r12,%rdx,4),%ecx
  400dcc:	89 0c 90             	mov    %ecx,(%rax,%rdx,4)
  400dcf:	48 89 d1             	mov    %rdx,%rcx
  400dd2:	48 83 c2 01          	add    $0x1,%rdx
  400dd6:	48 39 ce             	cmp    %rcx,%rsi
  400dd9:	75 ed                	jne    400dc8 <execute_instructions+0xb8>
  400ddb:	45 85 f6             	test   %r14d,%r14d
  400dde:	45 89 2f             	mov    %r13d,(%r15)
  400de1:	8b 0d 39 13 20 00    	mov    0x201339(%rip),%ecx        # 602120 <um+0x20>
  400de7:	49 89 47 08          	mov    %rax,0x8(%r15)
  400deb:	48 0f 45 e8          	cmovne %rax,%rbp
  400def:	e9 3c ff ff ff       	jmpq   400d30 <execute_instructions+0x20>
  400df4:	0f 1f 40 00          	nopl   0x0(%rax)
  400df8:	48 8b 3d c1 12 20 00 	mov    0x2012c1(%rip),%rdi        # 6020c0 <stdin@@GLIBC_2.2.5>
  400dff:	83 e0 07             	and    $0x7,%eax
  400e02:	89 c3                	mov    %eax,%ebx
  400e04:	e8 07 fb ff ff       	callq  400910 <_IO_getc@plt>
  400e09:	83 f8 ff             	cmp    $0xffffffff,%eax
  400e0c:	0f 84 0e 04 00 00    	je     401220 <execute_instructions+0x510>
  400e12:	89 04 9d 00 21 60 00 	mov    %eax,0x602100(,%rbx,4)
  400e19:	8b 05 01 13 20 00    	mov    0x201301(%rip),%eax        # 602120 <um+0x20>
  400e1f:	8d 48 01             	lea    0x1(%rax),%ecx
  400e22:	89 0d f8 12 20 00    	mov    %ecx,0x2012f8(%rip)        # 602120 <um+0x20>
  400e28:	e9 03 ff ff ff       	jmpq   400d30 <execute_instructions+0x20>
  400e2d:	0f 1f 00             	nopl   (%rax)
  400e30:	83 e0 07             	and    $0x7,%eax
  400e33:	bf 29 16 40 00       	mov    $0x401629,%edi
  400e38:	8b 34 85 00 21 60 00 	mov    0x602100(,%rax,4),%esi
  400e3f:	31 c0                	xor    %eax,%eax
  400e41:	e8 5a fa ff ff       	callq  4008a0 <printf@plt>
  400e46:	8b 05 d4 12 20 00    	mov    0x2012d4(%rip),%eax        # 602120 <um+0x20>
  400e4c:	8d 48 01             	lea    0x1(%rax),%ecx
  400e4f:	89 0d cb 12 20 00    	mov    %ecx,0x2012cb(%rip)        # 602120 <um+0x20>
  400e55:	e9 d6 fe ff ff       	jmpq   400d30 <execute_instructions+0x20>
  400e5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  400e60:	89 c3                	mov    %eax,%ebx
  400e62:	83 e3 07             	and    $0x7,%ebx
  400e65:	8b 04 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%eax
  400e6c:	48 c1 e0 04          	shl    $0x4,%rax
  400e70:	48 03 05 71 12 20 00 	add    0x201271(%rip),%rax        # 6020e8 <segments+0x8>
  400e77:	48 8b 78 08          	mov    0x8(%rax),%rdi
  400e7b:	e8 f0 f9 ff ff       	callq  400870 <free@plt>
  400e80:	8b 04 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%eax
  400e87:	44 8b 2d a2 12 20 00 	mov    0x2012a2(%rip),%r13d        # 602130 <unmapped>
  400e8e:	4c 8b 25 a3 12 20 00 	mov    0x2012a3(%rip),%r12        # 602138 <unmapped+0x8>
  400e95:	48 89 c2             	mov    %rax,%rdx
  400e98:	48 c1 e0 04          	shl    $0x4,%rax
  400e9c:	48 03 05 45 12 20 00 	add    0x201245(%rip),%rax        # 6020e8 <segments+0x8>
  400ea3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  400ea9:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  400eb0:	00 
  400eb1:	8b 05 7d 12 20 00    	mov    0x20127d(%rip),%eax        # 602134 <unmapped+0x4>
  400eb7:	41 39 c5             	cmp    %eax,%r13d
  400eba:	0f 83 f8 02 00 00    	jae    4011b8 <execute_instructions+0x4a8>
  400ec0:	43 89 14 ac          	mov    %edx,(%r12,%r13,4)
  400ec4:	8b 05 56 12 20 00    	mov    0x201256(%rip),%eax        # 602120 <um+0x20>
  400eca:	83 05 5f 12 20 00 01 	addl   $0x1,0x20125f(%rip)        # 602130 <unmapped>
  400ed1:	8d 48 01             	lea    0x1(%rax),%ecx
  400ed4:	89 0d 46 12 20 00    	mov    %ecx,0x201246(%rip)        # 602120 <um+0x20>
  400eda:	e9 51 fe ff ff       	jmpq   400d30 <execute_instructions+0x20>
  400edf:	90                   	nop
  400ee0:	89 c3                	mov    %eax,%ebx
  400ee2:	41 89 c4             	mov    %eax,%r12d
  400ee5:	83 e3 07             	and    $0x7,%ebx
  400ee8:	41 c1 e4 1a          	shl    $0x1a,%r12d
  400eec:	8b 0c 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%ecx
  400ef3:	41 c1 ec 1d          	shr    $0x1d,%r12d
  400ef7:	8d 3c 8d 00 00 00 00 	lea    0x0(,%rcx,4),%edi
  400efe:	89 4c 24 08          	mov    %ecx,0x8(%rsp)
  400f02:	e8 e9 f9 ff ff       	callq  4008f0 <malloc@plt>
  400f07:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
  400f0b:	48 85 c0             	test   %rax,%rax
  400f0e:	49 89 c5             	mov    %rax,%r13
  400f11:	0f 84 e7 03 00 00    	je     4012fe <execute_instructions+0x5ee>
  400f17:	85 c9                	test   %ecx,%ecx
  400f19:	74 24                	je     400f3f <execute_instructions+0x22f>
  400f1b:	8d 51 ff             	lea    -0x1(%rcx),%edx
  400f1e:	4c 89 e8             	mov    %r13,%rax
  400f21:	49 8d 54 95 04       	lea    0x4(%r13,%rdx,4),%rdx
  400f26:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400f2d:	00 00 00 
  400f30:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  400f36:	48 83 c0 04          	add    $0x4,%rax
  400f3a:	48 39 c2             	cmp    %rax,%rdx
  400f3d:	75 f1                	jne    400f30 <execute_instructions+0x220>
  400f3f:	8b 05 eb 11 20 00    	mov    0x2011eb(%rip),%eax        # 602130 <unmapped>
  400f45:	4c 8b 35 9c 11 20 00 	mov    0x20119c(%rip),%r14        # 6020e8 <segments+0x8>
  400f4c:	85 c0                	test   %eax,%eax
  400f4e:	0f 84 f4 02 00 00    	je     401248 <execute_instructions+0x538>
  400f54:	48 8b 15 dd 11 20 00 	mov    0x2011dd(%rip),%rdx        # 602138 <unmapped+0x8>
  400f5b:	8d 70 ff             	lea    -0x1(%rax),%esi
  400f5e:	44 8b 3c b2          	mov    (%rdx,%rsi,4),%r15d
  400f62:	89 35 c8 11 20 00    	mov    %esi,0x2011c8(%rip)        # 602130 <unmapped>
  400f68:	44 89 f8             	mov    %r15d,%eax
  400f6b:	48 c1 e0 04          	shl    $0x4,%rax
  400f6f:	49 01 c6             	add    %rax,%r14
  400f72:	8b 05 a8 11 20 00    	mov    0x2011a8(%rip),%eax        # 602120 <um+0x20>
  400f78:	41 89 0e             	mov    %ecx,(%r14)
  400f7b:	8d 48 01             	lea    0x1(%rax),%ecx
  400f7e:	4d 89 6e 08          	mov    %r13,0x8(%r14)
  400f82:	46 89 3c a5 00 21 60 	mov    %r15d,0x602100(,%r12,4)
  400f89:	00 
  400f8a:	89 0d 90 11 20 00    	mov    %ecx,0x201190(%rip)        # 602120 <um+0x20>
  400f90:	e9 9b fd ff ff       	jmpq   400d30 <execute_instructions+0x20>
  400f95:	0f 1f 00             	nopl   (%rax)
  400f98:	83 c1 01             	add    $0x1,%ecx
  400f9b:	89 0d 7f 11 20 00    	mov    %ecx,0x20117f(%rip)        # 602120 <um+0x20>
  400fa1:	48 83 c4 18          	add    $0x18,%rsp
  400fa5:	5b                   	pop    %rbx
  400fa6:	5d                   	pop    %rbp
  400fa7:	41 5c                	pop    %r12
  400fa9:	41 5d                	pop    %r13
  400fab:	41 5e                	pop    %r14
  400fad:	41 5f                	pop    %r15
  400faf:	c3                   	retq   
  400fb0:	89 c6                	mov    %eax,%esi
  400fb2:	89 c7                	mov    %eax,%edi
  400fb4:	89 c2                	mov    %eax,%edx
  400fb6:	83 c1 01             	add    $0x1,%ecx
  400fb9:	c1 e6 1a             	shl    $0x1a,%esi
  400fbc:	83 e7 07             	and    $0x7,%edi
  400fbf:	c1 e2 17             	shl    $0x17,%edx
  400fc2:	89 0d 58 11 20 00    	mov    %ecx,0x201158(%rip)        # 602120 <um+0x20>
  400fc8:	c1 ee 1d             	shr    $0x1d,%esi
  400fcb:	c1 ea 1d             	shr    $0x1d,%edx
  400fce:	8b 04 b5 00 21 60 00 	mov    0x602100(,%rsi,4),%eax
  400fd5:	23 04 bd 00 21 60 00 	and    0x602100(,%rdi,4),%eax
  400fdc:	f7 d0                	not    %eax
  400fde:	89 04 95 00 21 60 00 	mov    %eax,0x602100(,%rdx,4)
  400fe5:	e9 46 fd ff ff       	jmpq   400d30 <execute_instructions+0x20>
  400fea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  400ff0:	89 c2                	mov    %eax,%edx
  400ff2:	89 c6                	mov    %eax,%esi
  400ff4:	89 c7                	mov    %eax,%edi
  400ff6:	83 c1 01             	add    $0x1,%ecx
  400ff9:	c1 e2 1a             	shl    $0x1a,%edx
  400ffc:	83 e7 07             	and    $0x7,%edi
  400fff:	c1 e6 17             	shl    $0x17,%esi
  401002:	89 0d 18 11 20 00    	mov    %ecx,0x201118(%rip)        # 602120 <um+0x20>
  401008:	c1 ea 1d             	shr    $0x1d,%edx
  40100b:	c1 ee 1d             	shr    $0x1d,%esi
  40100e:	8b 04 95 00 21 60 00 	mov    0x602100(,%rdx,4),%eax
  401015:	31 d2                	xor    %edx,%edx
  401017:	f7 34 bd 00 21 60 00 	divl   0x602100(,%rdi,4)
  40101e:	89 04 b5 00 21 60 00 	mov    %eax,0x602100(,%rsi,4)
  401025:	e9 06 fd ff ff       	jmpq   400d30 <execute_instructions+0x20>
  40102a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401030:	89 c6                	mov    %eax,%esi
  401032:	89 c7                	mov    %eax,%edi
  401034:	89 c2                	mov    %eax,%edx
  401036:	83 c1 01             	add    $0x1,%ecx
  401039:	c1 e6 1a             	shl    $0x1a,%esi
  40103c:	83 e7 07             	and    $0x7,%edi
  40103f:	c1 e2 17             	shl    $0x17,%edx
  401042:	89 0d d8 10 20 00    	mov    %ecx,0x2010d8(%rip)        # 602120 <um+0x20>
  401048:	c1 ee 1d             	shr    $0x1d,%esi
  40104b:	c1 ea 1d             	shr    $0x1d,%edx
  40104e:	8b 04 b5 00 21 60 00 	mov    0x602100(,%rsi,4),%eax
  401055:	0f af 04 bd 00 21 60 	imul   0x602100(,%rdi,4),%eax
  40105c:	00 
  40105d:	89 04 95 00 21 60 00 	mov    %eax,0x602100(,%rdx,4)
  401064:	e9 c7 fc ff ff       	jmpq   400d30 <execute_instructions+0x20>
  401069:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401070:	89 c6                	mov    %eax,%esi
  401072:	89 c2                	mov    %eax,%edx
  401074:	83 e0 07             	and    $0x7,%eax
  401077:	83 c1 01             	add    $0x1,%ecx
  40107a:	c1 e6 1a             	shl    $0x1a,%esi
  40107d:	c1 e2 17             	shl    $0x17,%edx
  401080:	8b 04 85 00 21 60 00 	mov    0x602100(,%rax,4),%eax
  401087:	89 0d 93 10 20 00    	mov    %ecx,0x201093(%rip)        # 602120 <um+0x20>
  40108d:	c1 ee 1d             	shr    $0x1d,%esi
  401090:	c1 ea 1d             	shr    $0x1d,%edx
  401093:	03 04 b5 00 21 60 00 	add    0x602100(,%rsi,4),%eax
  40109a:	89 04 95 00 21 60 00 	mov    %eax,0x602100(,%rdx,4)
  4010a1:	e9 8a fc ff ff       	jmpq   400d30 <execute_instructions+0x20>
  4010a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4010ad:	00 00 00 
  4010b0:	89 c2                	mov    %eax,%edx
  4010b2:	83 e2 07             	and    $0x7,%edx
  4010b5:	8b 34 95 00 21 60 00 	mov    0x602100(,%rdx,4),%esi
  4010bc:	89 c2                	mov    %eax,%edx
  4010be:	c1 e0 1a             	shl    $0x1a,%eax
  4010c1:	c1 e2 17             	shl    $0x17,%edx
  4010c4:	c1 e8 1d             	shr    $0x1d,%eax
  4010c7:	c1 ea 1d             	shr    $0x1d,%edx
  4010ca:	8b 0c 85 00 21 60 00 	mov    0x602100(,%rax,4),%ecx
  4010d1:	8b 14 95 00 21 60 00 	mov    0x602100(,%rdx,4),%edx
  4010d8:	48 c1 e2 04          	shl    $0x4,%rdx
  4010dc:	48 03 15 05 10 20 00 	add    0x201005(%rip),%rdx        # 6020e8 <segments+0x8>
  4010e3:	48 8b 42 08          	mov    0x8(%rdx),%rax
  4010e7:	89 34 88             	mov    %esi,(%rax,%rcx,4)
  4010ea:	8b 05 30 10 20 00    	mov    0x201030(%rip),%eax        # 602120 <um+0x20>
  4010f0:	8d 48 01             	lea    0x1(%rax),%ecx
  4010f3:	89 0d 27 10 20 00    	mov    %ecx,0x201027(%rip)        # 602120 <um+0x20>
  4010f9:	e9 32 fc ff ff       	jmpq   400d30 <execute_instructions+0x20>
  4010fe:	66 90                	xchg   %ax,%ax
  401100:	89 c2                	mov    %eax,%edx
  401102:	89 c6                	mov    %eax,%esi
  401104:	c1 e0 17             	shl    $0x17,%eax
  401107:	c1 e2 1a             	shl    $0x1a,%edx
  40110a:	83 e6 07             	and    $0x7,%esi
  40110d:	c1 e8 1d             	shr    $0x1d,%eax
  401110:	c1 ea 1d             	shr    $0x1d,%edx
  401113:	8b 34 b5 00 21 60 00 	mov    0x602100(,%rsi,4),%esi
  40111a:	8b 14 95 00 21 60 00 	mov    0x602100(,%rdx,4),%edx
  401121:	48 c1 e2 04          	shl    $0x4,%rdx
  401125:	48 03 15 bc 0f 20 00 	add    0x200fbc(%rip),%rdx        # 6020e8 <segments+0x8>
  40112c:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  401130:	8b 14 b2             	mov    (%rdx,%rsi,4),%edx
  401133:	89 14 85 00 21 60 00 	mov    %edx,0x602100(,%rax,4)
  40113a:	83 c1 01             	add    $0x1,%ecx
  40113d:	89 0d dd 0f 20 00    	mov    %ecx,0x200fdd(%rip)        # 602120 <um+0x20>
  401143:	e9 e8 fb ff ff       	jmpq   400d30 <execute_instructions+0x20>
  401148:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40114f:	00 
  401150:	89 c2                	mov    %eax,%edx
  401152:	83 c1 01             	add    $0x1,%ecx
  401155:	83 e2 07             	and    $0x7,%edx
  401158:	8b 14 95 00 21 60 00 	mov    0x602100(,%rdx,4),%edx
  40115f:	85 d2                	test   %edx,%edx
  401161:	0f 84 bb fc ff ff    	je     400e22 <execute_instructions+0x112>
  401167:	89 c2                	mov    %eax,%edx
  401169:	c1 e0 17             	shl    $0x17,%eax
  40116c:	89 0d ae 0f 20 00    	mov    %ecx,0x200fae(%rip)        # 602120 <um+0x20>
  401172:	c1 e2 1a             	shl    $0x1a,%edx
  401175:	c1 e8 1d             	shr    $0x1d,%eax
  401178:	c1 ea 1d             	shr    $0x1d,%edx
  40117b:	8b 14 95 00 21 60 00 	mov    0x602100(,%rdx,4),%edx
  401182:	89 14 85 00 21 60 00 	mov    %edx,0x602100(,%rax,4)
  401189:	e9 a2 fb ff ff       	jmpq   400d30 <execute_instructions+0x20>
  40118e:	66 90                	xchg   %ax,%ax
  401190:	89 c2                	mov    %eax,%edx
  401192:	83 c1 01             	add    $0x1,%ecx
  401195:	25 ff ff ff 01       	and    $0x1ffffff,%eax
  40119a:	c1 e2 04             	shl    $0x4,%edx
  40119d:	89 0d 7d 0f 20 00    	mov    %ecx,0x200f7d(%rip)        # 602120 <um+0x20>
  4011a3:	c1 ea 1d             	shr    $0x1d,%edx
  4011a6:	89 04 95 00 21 60 00 	mov    %eax,0x602100(,%rdx,4)
  4011ad:	e9 7e fb ff ff       	jmpq   400d30 <execute_instructions+0x20>
  4011b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4011b8:	8d 14 00             	lea    (%rax,%rax,1),%edx
  4011bb:	8d 3c c5 00 00 00 00 	lea    0x0(,%rax,8),%edi
  4011c2:	89 15 6c 0f 20 00    	mov    %edx,0x200f6c(%rip)        # 602134 <unmapped+0x4>
  4011c8:	e8 23 f7 ff ff       	callq  4008f0 <malloc@plt>
  4011cd:	48 8b 3d 64 0f 20 00 	mov    0x200f64(%rip),%rdi        # 602138 <unmapped+0x8>
  4011d4:	31 d2                	xor    %edx,%edx
  4011d6:	49 89 c4             	mov    %rax,%r12
  4011d9:	41 8d 45 ff          	lea    -0x1(%r13),%eax
  4011dd:	45 85 ed             	test   %r13d,%r13d
  4011e0:	74 19                	je     4011fb <execute_instructions+0x4eb>
  4011e2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4011e8:	8b 0c 97             	mov    (%rdi,%rdx,4),%ecx
  4011eb:	41 89 0c 94          	mov    %ecx,(%r12,%rdx,4)
  4011ef:	48 89 d1             	mov    %rdx,%rcx
  4011f2:	48 83 c2 01          	add    $0x1,%rdx
  4011f6:	48 39 c8             	cmp    %rcx,%rax
  4011f9:	75 ed                	jne    4011e8 <execute_instructions+0x4d8>
  4011fb:	e8 70 f6 ff ff       	callq  400870 <free@plt>
  401200:	4c 89 25 31 0f 20 00 	mov    %r12,0x200f31(%rip)        # 602138 <unmapped+0x8>
  401207:	44 8b 2d 22 0f 20 00 	mov    0x200f22(%rip),%r13d        # 602130 <unmapped>
  40120e:	8b 14 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%edx
  401215:	e9 a6 fc ff ff       	jmpq   400ec0 <execute_instructions+0x1b0>
  40121a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401220:	89 d8                	mov    %ebx,%eax
  401222:	c7 04 85 00 21 60 00 	movl   $0xffffffff,0x602100(,%rax,4)
  401229:	ff ff ff ff 
  40122d:	8b 05 ed 0e 20 00    	mov    0x200eed(%rip),%eax        # 602120 <um+0x20>
  401233:	8d 48 01             	lea    0x1(%rax),%ecx
  401236:	89 0d e4 0e 20 00    	mov    %ecx,0x200ee4(%rip)        # 602120 <um+0x20>
  40123c:	e9 ef fa ff ff       	jmpq   400d30 <execute_instructions+0x20>
  401241:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401248:	44 8b 3d 91 0e 20 00 	mov    0x200e91(%rip),%r15d        # 6020e0 <segments>
  40124f:	8b 05 8f 0e 20 00    	mov    0x200e8f(%rip),%eax        # 6020e4 <segments+0x4>
  401255:	41 39 c7             	cmp    %eax,%r15d
  401258:	72 63                	jb     4012bd <execute_instructions+0x5ad>
  40125a:	8d 14 00             	lea    (%rax,%rax,1),%edx
  40125d:	c1 e0 05             	shl    $0x5,%eax
  401260:	89 c7                	mov    %eax,%edi
  401262:	89 15 7c 0e 20 00    	mov    %edx,0x200e7c(%rip)        # 6020e4 <segments+0x4>
  401268:	e8 83 f6 ff ff       	callq  4008f0 <malloc@plt>
  40126d:	45 85 ff             	test   %r15d,%r15d
  401270:	74 21                	je     401293 <execute_instructions+0x583>
  401272:	41 8d 4f ff          	lea    -0x1(%r15),%ecx
  401276:	31 d2                	xor    %edx,%edx
  401278:	48 83 c1 01          	add    $0x1,%rcx
  40127c:	48 c1 e1 04          	shl    $0x4,%rcx
  401280:	f3 41 0f 6f 04 16    	movdqu (%r14,%rdx,1),%xmm0
  401286:	0f 11 04 10          	movups %xmm0,(%rax,%rdx,1)
  40128a:	48 83 c2 10          	add    $0x10,%rdx
  40128e:	48 39 ca             	cmp    %rcx,%rdx
  401291:	75 ed                	jne    401280 <execute_instructions+0x570>
  401293:	4c 89 f7             	mov    %r14,%rdi
  401296:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  40129b:	e8 d0 f5 ff ff       	callq  400870 <free@plt>
  4012a0:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  4012a5:	44 8b 3d 34 0e 20 00 	mov    0x200e34(%rip),%r15d        # 6020e0 <segments>
  4012ac:	8b 0c 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%ecx
  4012b3:	48 89 05 2e 0e 20 00 	mov    %rax,0x200e2e(%rip)        # 6020e8 <segments+0x8>
  4012ba:	49 89 c6             	mov    %rax,%r14
  4012bd:	41 8d 47 01          	lea    0x1(%r15),%eax
  4012c1:	89 05 19 0e 20 00    	mov    %eax,0x200e19(%rip)        # 6020e0 <segments>
  4012c7:	e9 9c fc ff ff       	jmpq   400f68 <execute_instructions+0x258>
  4012cc:	ba d5 00 00 00       	mov    $0xd5,%edx
  4012d1:	be 24 16 40 00       	mov    $0x401624,%esi
  4012d6:	bf e8 1d 60 00       	mov    $0x601de8,%edi
  4012db:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  4012e0:	e8 7b 01 00 00       	callq  401460 <Except_raise>
  4012e5:	44 8b 34 9d 00 21 60 	mov    0x602100(,%rbx,4),%r14d
  4012ec:	00 
  4012ed:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  4012f2:	4c 8b 3d ef 0d 20 00 	mov    0x200def(%rip),%r15        # 6020e8 <segments+0x8>
  4012f9:	e9 ba fa ff ff       	jmpq   400db8 <execute_instructions+0xa8>
  4012fe:	ba 92 00 00 00       	mov    $0x92,%edx
  401303:	be 24 16 40 00       	mov    $0x401624,%esi
  401308:	bf e8 1d 60 00       	mov    $0x601de8,%edi
  40130d:	e8 4e 01 00 00       	callq  401460 <Except_raise>
  401312:	8b 0c 9d 00 21 60 00 	mov    0x602100(,%rbx,4),%ecx
  401319:	e9 f9 fb ff ff       	jmpq   400f17 <execute_instructions+0x207>
  40131e:	66 90                	xchg   %ax,%ax

0000000000401320 <free_um>:
  401320:	55                   	push   %rbp
  401321:	53                   	push   %rbx
  401322:	48 83 ec 08          	sub    $0x8,%rsp
  401326:	8b 2d b4 0d 20 00    	mov    0x200db4(%rip),%ebp        # 6020e0 <segments>
  40132c:	48 85 ed             	test   %rbp,%rbp
  40132f:	74 36                	je     401367 <free_um+0x47>
  401331:	31 db                	xor    %ebx,%ebx
  401333:	eb 0c                	jmp    401341 <free_um+0x21>
  401335:	0f 1f 00             	nopl   (%rax)
  401338:	48 83 c3 01          	add    $0x1,%rbx
  40133c:	48 39 dd             	cmp    %rbx,%rbp
  40133f:	74 26                	je     401367 <free_um+0x47>
  401341:	48 89 d8             	mov    %rbx,%rax
  401344:	48 c1 e0 04          	shl    $0x4,%rax
  401348:	48 03 05 99 0d 20 00 	add    0x200d99(%rip),%rax        # 6020e8 <segments+0x8>
  40134f:	8b 10                	mov    (%rax),%edx
  401351:	85 d2                	test   %edx,%edx
  401353:	74 e3                	je     401338 <free_um+0x18>
  401355:	48 8b 78 08          	mov    0x8(%rax),%rdi
  401359:	48 83 c3 01          	add    $0x1,%rbx
  40135d:	e8 0e f5 ff ff       	callq  400870 <free@plt>
  401362:	48 39 dd             	cmp    %rbx,%rbp
  401365:	75 da                	jne    401341 <free_um+0x21>
  401367:	48 8b 3d ca 0d 20 00 	mov    0x200dca(%rip),%rdi        # 602138 <unmapped+0x8>
  40136e:	e8 fd f4 ff ff       	callq  400870 <free@plt>
  401373:	48 8b 3d 6e 0d 20 00 	mov    0x200d6e(%rip),%rdi        # 6020e8 <segments+0x8>
  40137a:	48 83 c4 08          	add    $0x8,%rsp
  40137e:	5b                   	pop    %rbx
  40137f:	5d                   	pop    %rbp
  401380:	e9 eb f4 ff ff       	jmpq   400870 <free@plt>
  401385:	90                   	nop
  401386:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40138d:	00 00 00 

0000000000401390 <run_um>:
  401390:	55                   	push   %rbp
  401391:	48 89 fd             	mov    %rdi,%rbp
  401394:	bf 00 71 02 00       	mov    $0x27100,%edi
  401399:	53                   	push   %rbx
  40139a:	48 bb 00 00 00 00 10 	movabs $0x271000000000,%rbx
  4013a1:	27 00 00 
  4013a4:	48 83 ec 08          	sub    $0x8,%rsp
  4013a8:	48 89 1d 31 0d 20 00 	mov    %rbx,0x200d31(%rip)        # 6020e0 <segments>
  4013af:	e8 3c f5 ff ff       	callq  4008f0 <malloc@plt>
  4013b4:	bf 40 9c 00 00       	mov    $0x9c40,%edi
  4013b9:	48 89 1d 70 0d 20 00 	mov    %rbx,0x200d70(%rip)        # 602130 <unmapped>
  4013c0:	48 89 05 21 0d 20 00 	mov    %rax,0x200d21(%rip)        # 6020e8 <segments+0x8>
  4013c7:	e8 24 f5 ff ff       	callq  4008f0 <malloc@plt>
  4013cc:	48 89 ef             	mov    %rbp,%rdi
  4013cf:	48 c7 05 26 0d 20 00 	movq   $0x0,0x200d26(%rip)        # 602100 <um>
  4013d6:	00 00 00 00 
  4013da:	48 89 05 57 0d 20 00 	mov    %rax,0x200d57(%rip)        # 602138 <unmapped+0x8>
  4013e1:	48 c7 05 1c 0d 20 00 	movq   $0x0,0x200d1c(%rip)        # 602108 <um+0x8>
  4013e8:	00 00 00 00 
  4013ec:	48 c7 05 19 0d 20 00 	movq   $0x0,0x200d19(%rip)        # 602110 <um+0x10>
  4013f3:	00 00 00 00 
  4013f7:	48 c7 05 16 0d 20 00 	movq   $0x0,0x200d16(%rip)        # 602118 <um+0x18>
  4013fe:	00 00 00 00 
  401402:	c7 05 14 0d 20 00 00 	movl   $0x0,0x200d14(%rip)        # 602120 <um+0x20>
  401409:	00 00 00 
  40140c:	e8 0f f7 ff ff       	callq  400b20 <read_instructions>
  401411:	31 c0                	xor    %eax,%eax
  401413:	e8 f8 f8 ff ff       	callq  400d10 <execute_instructions>
  401418:	48 83 c4 08          	add    $0x8,%rsp
  40141c:	31 c0                	xor    %eax,%eax
  40141e:	5b                   	pop    %rbx
  40141f:	5d                   	pop    %rbp
  401420:	e9 fb fe ff ff       	jmpq   401320 <free_um>
  401425:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40142c:	00 00 00 
  40142f:	90                   	nop

0000000000401430 <assert>:
  401430:	85 ff                	test   %edi,%edi
  401432:	74 0c                	je     401440 <assert+0x10>
  401434:	f3 c3                	repz retq 
  401436:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40143d:	00 00 00 
  401440:	48 8d 3d a1 09 20 00 	lea    0x2009a1(%rip),%rdi        # 601de8 <Assert_Failed>
  401447:	48 8d 35 72 02 00 00 	lea    0x272(%rip),%rsi        # 4016c0 <SEGMENT_SIZE+0x4>
  40144e:	ba 05 00 00 00       	mov    $0x5,%edx
  401453:	e9 08 00 00 00       	jmpq   401460 <Except_raise>
  401458:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40145f:	00 

0000000000401460 <Except_raise>:
  401460:	48 89 5c 24 d8       	mov    %rbx,-0x28(%rsp)
  401465:	48 89 6c 24 e0       	mov    %rbp,-0x20(%rsp)
  40146a:	48 89 fb             	mov    %rdi,%rbx
  40146d:	4c 89 64 24 e8       	mov    %r12,-0x18(%rsp)
  401472:	4c 89 74 24 f8       	mov    %r14,-0x8(%rsp)
  401477:	49 89 f4             	mov    %rsi,%r12
  40147a:	4c 89 6c 24 f0       	mov    %r13,-0x10(%rsp)
  40147f:	48 83 ec 28          	sub    $0x28,%rsp
  401483:	4c 8d 35 46 0c 20 00 	lea    0x200c46(%rip),%r14        # 6020d0 <Except_stack>
  40148a:	48 85 ff             	test   %rdi,%rdi
  40148d:	89 d5                	mov    %edx,%ebp
  40148f:	4d 8b 2e             	mov    (%r14),%r13
  401492:	0f 84 a8 00 00 00    	je     401540 <Except_raise+0xe0>
  401498:	4d 85 ed             	test   %r13,%r13
  40149b:	74 33                	je     4014d0 <Except_raise+0x70>
  40149d:	49 8b 06             	mov    (%r14),%rax
  4014a0:	49 8d 7d 08          	lea    0x8(%r13),%rdi
  4014a4:	49 89 9d e0 00 00 00 	mov    %rbx,0xe0(%r13)
  4014ab:	4d 89 a5 d0 00 00 00 	mov    %r12,0xd0(%r13)
  4014b2:	41 89 ad d8 00 00 00 	mov    %ebp,0xd8(%r13)
  4014b9:	be 01 00 00 00       	mov    $0x1,%esi
  4014be:	48 8b 00             	mov    (%rax),%rax
  4014c1:	49 89 06             	mov    %rax,(%r14)
  4014c4:	e8 67 f4 ff ff       	callq  400930 <longjmp@plt>
  4014c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4014d0:	4c 8b 2d 21 0b 20 00 	mov    0x200b21(%rip),%r13        # 601ff8 <stderr@GLIBC_2.2.5>
  4014d7:	48 8d 3d 0d 02 00 00 	lea    0x20d(%rip),%rdi        # 4016eb <SEGMENT_SIZE+0x2f>
  4014de:	ba 12 00 00 00       	mov    $0x12,%edx
  4014e3:	be 01 00 00 00       	mov    $0x1,%esi
  4014e8:	49 8b 4d 00          	mov    0x0(%r13),%rcx
  4014ec:	e8 6f f4 ff ff       	callq  400960 <fwrite@plt>
  4014f1:	48 8b 13             	mov    (%rbx),%rdx
  4014f4:	48 85 d2             	test   %rdx,%rdx
  4014f7:	0f 84 83 00 00 00    	je     401580 <Except_raise+0x120>
  4014fd:	49 8b 7d 00          	mov    0x0(%r13),%rdi
  401501:	48 8d 35 f6 01 00 00 	lea    0x1f6(%rip),%rsi        # 4016fe <SEGMENT_SIZE+0x42>
  401508:	31 c0                	xor    %eax,%eax
  40150a:	e8 c1 f3 ff ff       	callq  4008d0 <fprintf@plt>
  40150f:	85 ed                	test   %ebp,%ebp
  401511:	7f 4d                	jg     401560 <Except_raise+0x100>
  401513:	49 8b 4d 00          	mov    0x0(%r13),%rcx
  401517:	48 8d 3d ff 01 00 00 	lea    0x1ff(%rip),%rdi        # 40171d <SEGMENT_SIZE+0x61>
  40151e:	ba 0c 00 00 00       	mov    $0xc,%edx
  401523:	be 01 00 00 00       	mov    $0x1,%esi
  401528:	e8 33 f4 ff ff       	callq  400960 <fwrite@plt>
  40152d:	49 8b 7d 00          	mov    0x0(%r13),%rdi
  401531:	e8 ca f3 ff ff       	callq  400900 <fflush@plt>
  401536:	e8 45 f3 ff ff       	callq  400880 <abort@plt>
  40153b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401540:	48 8d 3d a1 08 20 00 	lea    0x2008a1(%rip),%rdi        # 601de8 <Assert_Failed>
  401547:	48 8d 35 90 01 00 00 	lea    0x190(%rip),%rsi        # 4016de <SEGMENT_SIZE+0x22>
  40154e:	ba 13 00 00 00       	mov    $0x13,%edx
  401553:	e8 08 ff ff ff       	callq  401460 <Except_raise>
  401558:	e9 3b ff ff ff       	jmpq   401498 <Except_raise+0x38>
  40155d:	0f 1f 00             	nopl   (%rax)
  401560:	4d 85 e4             	test   %r12,%r12
  401563:	74 ae                	je     401513 <Except_raise+0xb3>
  401565:	49 8b 7d 00          	mov    0x0(%r13),%rdi
  401569:	48 8d 35 9b 01 00 00 	lea    0x19b(%rip),%rsi        # 40170b <SEGMENT_SIZE+0x4f>
  401570:	89 e9                	mov    %ebp,%ecx
  401572:	4c 89 e2             	mov    %r12,%rdx
  401575:	31 c0                	xor    %eax,%eax
  401577:	e8 54 f3 ff ff       	callq  4008d0 <fprintf@plt>
  40157c:	eb 95                	jmp    401513 <Except_raise+0xb3>
  40157e:	66 90                	xchg   %ax,%ax
  401580:	49 8b 7d 00          	mov    0x0(%r13),%rdi
  401584:	48 8d 35 77 01 00 00 	lea    0x177(%rip),%rsi        # 401702 <SEGMENT_SIZE+0x46>
  40158b:	48 89 da             	mov    %rbx,%rdx
  40158e:	31 c0                	xor    %eax,%eax
  401590:	e8 3b f3 ff ff       	callq  4008d0 <fprintf@plt>
  401595:	e9 75 ff ff ff       	jmpq   40150f <Except_raise+0xaf>
  40159a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000004015a0 <__libc_csu_init>:
  4015a0:	41 57                	push   %r15
  4015a2:	41 89 ff             	mov    %edi,%r15d
  4015a5:	41 56                	push   %r14
  4015a7:	49 89 f6             	mov    %rsi,%r14
  4015aa:	41 55                	push   %r13
  4015ac:	49 89 d5             	mov    %rdx,%r13
  4015af:	41 54                	push   %r12
  4015b1:	4c 8d 25 20 08 20 00 	lea    0x200820(%rip),%r12        # 601dd8 <__frame_dummy_init_array_entry>
  4015b8:	55                   	push   %rbp
  4015b9:	48 8d 2d 20 08 20 00 	lea    0x200820(%rip),%rbp        # 601de0 <__init_array_end>
  4015c0:	53                   	push   %rbx
  4015c1:	4c 29 e5             	sub    %r12,%rbp
  4015c4:	31 db                	xor    %ebx,%ebx
  4015c6:	48 c1 fd 03          	sar    $0x3,%rbp
  4015ca:	48 83 ec 08          	sub    $0x8,%rsp
  4015ce:	e8 6d f2 ff ff       	callq  400840 <_init>
  4015d3:	48 85 ed             	test   %rbp,%rbp
  4015d6:	74 1e                	je     4015f6 <__libc_csu_init+0x56>
  4015d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4015df:	00 
  4015e0:	4c 89 ea             	mov    %r13,%rdx
  4015e3:	4c 89 f6             	mov    %r14,%rsi
  4015e6:	44 89 ff             	mov    %r15d,%edi
  4015e9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4015ed:	48 83 c3 01          	add    $0x1,%rbx
  4015f1:	48 39 eb             	cmp    %rbp,%rbx
  4015f4:	75 ea                	jne    4015e0 <__libc_csu_init+0x40>
  4015f6:	48 83 c4 08          	add    $0x8,%rsp
  4015fa:	5b                   	pop    %rbx
  4015fb:	5d                   	pop    %rbp
  4015fc:	41 5c                	pop    %r12
  4015fe:	41 5d                	pop    %r13
  401600:	41 5e                	pop    %r14
  401602:	41 5f                	pop    %r15
  401604:	c3                   	retq   
  401605:	90                   	nop
  401606:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40160d:	00 00 00 

0000000000401610 <__libc_csu_fini>:
  401610:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000401614 <_fini>:
  401614:	48 83 ec 08          	sub    $0x8,%rsp
  401618:	48 83 c4 08          	add    $0x8,%rsp
  40161c:	c3                   	retq   
