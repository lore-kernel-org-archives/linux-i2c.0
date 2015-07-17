From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910 family
Date: Fri, 17 Jul 2015 21:49:31 +0200
Message-ID: <87d1zqimyc.fsf@belgarion.home>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
	<20150714113436.GD1517@katana> <55A4F434.9080407@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A4F434.9080407-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (Vaibhav Hiremath's message of
	"Tue, 14 Jul 2015 17:06:20 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

>> So, I applied patches 1-6 to for-next to make some progress.
>>
>> The others need more thought because of the bindings which shall be
>> discussed replying to the patches in question.
>>
>> Thanks for the updated work with lots of proper references.
>>
>
> OK, Thanks and no issues.
>
> Lets discuss more on the bindings.

I made a simple try on my reference platform with the whole patchset.
It oopses on a NULL dereference.

The stack is in [1].
I think it boils down to :
 - i2c_pxa_do_sclk_adj()
   - reg_ilcr = readl(_ILCR(i2c));

I also think the faulty patch is :
 - i2c: pxa: Add ILCR (tLow & tHigh) configuration support

My case, an I2C master case, I'd like you to find the issue and fix it.

Cheers.

-- 
Robert

[1] Stack
&Unable to handle kernel NULL pointer dereference at virtual address 00000000
&pgd = c0004000
"[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc2-next-20150713+ #705
Hardware name: MIO A701
task: c3856bc0 ti: c3858000 task.ti: c3858000
PC is at i2c_pxa_reset+0x114/0x1cc
LR is at i2c_pxa_probe+0x35c/0x428
pc : [<c02ee4b0>]    lr : [<c02ef080>]    psr: 68000053
sp : c3859d50  ip : c3859d70  fp : c3859d6c
r10: c38f75ac  r9 : c06c7668  r8 : 00000000
r7 : c394a300  r6 : c06c42f0  r5 : c38f7410  r4 : 00000002
r3 : 000087a0  r2 : f2301690  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0000397f  Table: a0004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc3858198)
Stack: (0xc3859d50 to 0xc385a000)
9d40:                                     00004080 c38f7410 c06c42e0 c06c42f0
9d60: c3859dbc c3859d70 c02ef080 c02ee3a8 00004080 c38d7b40 c38f7410 c3859d88
9d80: c014eb08 c04d1878 00000001 00000000 00000000 c06c42f0 c06c42f0 c06f10c8
9da0: fffffdfb 00000000 c0678550 00000000 c3859ddc c3859dc0 c0280b18 c02eed30
9dc0: c06c42f0 c0731330 c0705098 c06f10c8 c3859e0c c3859de0 c027e850 c0280ad0
9de0: c3859e0c c3859df0 c06c42f0 c06f10c8 c06c4324 00000000 c0704fc0 c0678550
9e00: c3859e2c c3859e10 c027eb64 c027e6c8 00000000 00000000 c06f10c8 c027eaec
9e20: c3859e54 c3859e30 c027c5c4 c027eaf8 c389b96c c38dc6d0 c3940c78 c06f10c8
9e40: c39408e0 c06ec778 c3859e64 c3859e58 c027e228 c027c56c c3859e94 c3859e68
9e60: c027dbc8 c027e20c c05803d0 c394a3e0 c3859e94 c06f10c8 c06c2380 c394a3e0
9e80: c069a888 00000000 c3859eac c3859e98 c027f6d4 c027dac0 c06c2380 c06c2380
9ea0: c3859ebc c3859eb0 c0280a38 c027f630 c3859ecc c3859ec0 c069a8a0 c02809ec
9ec0: c3859f4c c3859ed0 c000975c c069a894 c3859efc c3859ee0 c3859efc c3859ee8
9ee0: c00389e0 c0201e98 00000000 c3ffcbe1 c3859f4c c3859f00 c0038c00 c00389cc
9f00: c004710c c003eea8 00000000 00000004 00000004 c3ffcbfd c0615b48 c057cd28
9f20: 00000000 00000004 c070f7a0 00000004 c070f7a0 c06bd020 c070f7a0 c06a64b0
9f40: c3859f94 c3859f50 c0678e3c c000963c 00000004 00000004 00000000 c0678550
9f60: c0497ffc 00000085 00000000 00000000 c0497ffc 00000000 00000000 00000000
9f80: 00000000 00000000 c3859fac c3859f98 c0498014 c0678d44 c3858000 00000000
9fa0: 00000000 c3859fb0 c000a5f0 c0498008 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 b3ff8c5d 4cc3d76f
[<c02ee4b0>] (i2c_pxa_reset) from [<c02ef080>] (i2c_pxa_probe+0x35c/0x428)
[<c02ef080>] (i2c_pxa_probe) from [<c0280b18>] (platform_drv_probe+0x54/0xb0)
[<c0280b18>] (platform_drv_probe) from [<c027e850>] (driver_probe_device+0x194/0x430)
[<c027e850>] (driver_probe_device) from [<c027eb64>] (__driver_attach+0x78/0x9c)
[<c027eb64>] (__driver_attach) from [<c027c5c4>] (bus_for_each_dev+0x64/0xb4)
[<c027c5c4>] (bus_for_each_dev) from [<c027e228>] (driver_attach+0x28/0x30)
[<c027e228>] (driver_attach) from [<c027dbc8>] (bus_add_driver+0x114/0x274)
[<c027dbc8>] (bus_add_driver) from [<c027f6d4>] (driver_register+0xb0/0xf8)
[<c027f6d4>] (driver_register) from [<c0280a38>] (__platform_driver_register+0x58/0x6c)
[<c0280a38>] (__platform_driver_register) from [<c069a8a0>] (i2c_adap_pxa_init+0x18/0x20)
[<c069a8a0>] (i2c_adap_pxa_init) from [<c000975c>] (do_one_initcall+0x12c/0x220)
[<c000975c>] (do_one_initcall) from [<c0678e3c>] (kernel_init_freeable+0x104/0x1d8)
[<c0678e3c>] (kernel_init_freeable) from [<c0498014>] (kernel_init+0x18/0xfc)
[<c0498014>] (kernel_init) from [<c000a5f0>] (ret_from_fork+0x14/0x24)
Code: 03a00000 e1803003 e5823000 e5950318 (e5903000) 
---[ end trace 76138ae455db32c0 ]---

[2] Disassembly of the i2c_pxa_reset() and its inlined i2c_pxa_do_sclk_adj()
512	
513	static void i2c_pxa_do_sclk_adj(struct pxa_i2c *i2c)
514	{
515		unsigned int reg_ilcr;
516	
517		reg_ilcr = readl(_ILCR(i2c));
   0xc02ee4ac <+272>:	ldr	r0, [r5, #792]	; 0x318

518	
519		/* For standard/fast mode tlow and thigh counters are same */
520		if (i2c->sclk_tlow_load_cnt) {
   0xc02ee4b4 <+280>:	ldr	r12, [r5, #828]	; 0x33c
   0xc02ee4b8 <+284>:	cmp	r12, #0
   0xc02ee4bc <+288>:	beq	0xc02ee4fc <i2c_pxa_reset+352>
