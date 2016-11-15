From: David Scully <dscully@sbimagingsystems.com>
Subject: Kernel Oops while loading I2C SSDT overlay with Designware I2C
 adapter
Date: Tue, 15 Nov 2016 22:01:43 +0000
Message-ID: <2A172409E576EA4B8BB1D4D44FAD19390FFAF0A7@ORD2MBX05D.mex05.mlsrvr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp95.ord1c.emailsrvr.com ([108.166.43.95]:43632 "EHLO
        smtp95.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754598AbcKOWKV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Nov 2016 17:10:21 -0500
Received: from smtp28.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp28.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id B495C40186
        for <linux-i2c@vger.kernel.org>; Tue, 15 Nov 2016 17:01:43 -0500 (EST)
Received: from smtp28.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp28.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id B2E574027D
        for <linux-i2c@vger.kernel.org>; Tue, 15 Nov 2016 17:01:43 -0500 (EST)
Received: from smtp192.mex05.mlsrvr.com (unknown [184.106.31.85])
        by smtp28.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id A514B40186
        for <linux-i2c@vger.kernel.org>; Tue, 15 Nov 2016 17:01:43 -0500 (EST)
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hello,

I am using a platform based on the Minnowboard Turbot (Intel Atom SoC) that contains a TLV320AIC3104 connected via I2C. I am also using Linux kernel 4.8.3 which supports SSDT Overlays for augmenting open-ended hardware configurations for ACPI (see Documentation/acpi/ssdt-overlays.txt).

I have written an overlay based on a mix of the DSDT for Lenovo 100s and the example in the ssdt-overlay documentation which binds the audio codec to an i2c interface using  the Synopsys Designware I2C adapter. I have attempted to load the driver via the EFI method as well as the configfs method in the documentation, but both cause an immediate kernel oops. The overlay does not cause an oops if I target bus not controlled by the DesignWare adapter.

SSDT Overlay: https://gist.github.com/anonymous/eddfbb85aebcda2d547ee61873fa7117
Lenovo-100s DSDT: http://noraisin.net/lenovo-100s/dsdt.dsl

If I'm interpreting the disassembly correctly, I believe that the problem is that the aic31xx_i2c_probe's i2c_client argument is null for the i2c_adapter pointer.

Can anyone help me track this down?

Thanks,
David Scully

Relevant CONFIGs:
CONFIG_ACPI_CONFIGFS=y
CONFIG_SND_SOC_TLV320AIC31XX=m

uname -a:
Linux intel-corei7-64 4.8.3-yocto-standard #8 SMP PREEMPT Fri Nov 11 12:06:35 PST 2016 x86_64 x86_64 x86_64 GNU/Linux

Decoded  decodecode  output:
All code
========
   0:	00 00                		add    %al,(%rax)
   2:	31 d2                		xor    %edx,%edx
   4:	31 c9                		xor    %ecx,%ecx
   6:	48 c7 c6 c0 ae 3d a0 	mov    $0xffffffffa03daec0,%rsi
   d:	4c 89 e7             		mov    %r12,%rdi
  10:	48 89 c3             		mov    %rax,%rbx
  13:	e8 e1 d0 22 e1       	callq  0xffffffffe122d0f9
  18:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  1e:	48 89 c2             		mov    %rax,%rdx
  21:	48 89 43 18          	mov    %rax,0x18(%rbx)
  25:	0f 87 c5 00 00 00    	ja     0xf0
  2b:*	49 8b 46 18          	mov    0x18(%r14),%rax		<-- trapping instruction
  2f:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
  33:	49 89 9c 24 c0 00 00 	mov    %rbx,0xc0(%r12)
  3a:	00 
  3b:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	49 8b 46 18          	mov    0x18(%r14),%rax
   4:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
   8:	49 89 9c 24 c0 00 00 	mov    %rbx,0xc0(%r12)
   f:	00 
  10:	89                   	.byte 0x89

root@intel-corei7-64:/config/acpi/table# cat ~/audio.aml > my_ssdt/aml 
[  570.860263] ACPI: Host-directed Dynamic ACPI Table Load:
[  570.866751] ACPI: SSDT 0xFFFF8800756CE180 000081 (v01 Vendor Accel    00000003 INTL 20150515)
[  570.881027] hpet: number irqs doesn't agree with number of timers
root@intel-corei7-64:/config/acpi/table# [  570.904275] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
[  570.913176] IP: [<ffffffffa03d6512>] aic31xx_i2c_probe+0x62/0x150 [snd_soc_tlv320aic31xx]
[  570.922459] PGD 0 
[  570.924744] Oops: 0000 [#1] PREEMPT SMP
[  570.929087] Modules linked in: snd_soc_tlv320aic31xx(+) snd_soc_core ctr ccm igb arc4 intel_rapl intel_soc_dts_iosf intel_powerclamp coretemp rt2800usb rt2x00usb rt2800lib rt2x00lib snd_hda_codec_hdmis
[  570.974555] CPU: 2 PID: 199 Comm: kworker/2:3 Not tainted 4.8.3-yocto-standard #8
[  570.983026] Workqueue: events acpi_table_events_fn
[  570.988460] task: ffff880079b20000 task.stack: ffff8800741a0000
[  570.995163] RIP: 0010:[<ffffffffa03d6512>]  [<ffffffffa03d6512>] aic31xx_i2c_probe+0x62/0x150 [snd_soc_tlv320aic31xx]
[  571.007197] RSP: 0018:ffff8800741a39c0  EFLAGS: 00010287
[  571.013212] RAX: ffff880072656c00 RBX: ffff880074af7218 RCX: ffff880074983600
[  571.021293] RDX: ffff880072656c00 RSI: 0000000000000287 RDI: ffff880072657a68
[  571.032026] RBP: ffff8800741a39e8 R08: ffff880075401c00 R09: ffff880074983600
[  571.042740] R10: ffff880074983038 R11: ffff8800756c8ef8 R12: ffff880072657800
[  571.053421] R13: ffff880072657820 R14: 0000000000000000 R15: ffffffffa03d64b0
[  571.064051] FS:  0000000000000000(0000) GS:ffff880078100000(0000) knlGS:0000000000000000
[  571.075740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  571.084770] CR2: 0000000000000018 CR3: 0000000001e06000 CR4: 00000000001006e0
[  571.095332] Stack:
[  571.100058]  00000000fffffffe 0000000000000000 ffff880072657820 ffff880072657804
[  571.110937]  ffff880072657800 ffff8800741a3a20 ffffffff8176752d ffff880072657820
[  571.121813]  0000000000000000 ffffffffa03db758 0000000000000024 0000000000000000
[  571.132683] Call Trace:
[  571.137914]  [<ffffffff8176752d>] i2c_device_probe+0xfd/0x1a0
[  571.146853]  [<ffffffff815e81d2>] driver_probe_device+0x202/0x2c0
[  571.156142]  [<ffffffff815e83ac>] __device_attach_driver+0x7c/0xb0
[  571.165481]  [<ffffffff815e8330>] ? __driver_attach+0xa0/0xa0
[  571.174275]  [<ffffffff815e61ab>] bus_for_each_drv+0x5b/0x90
[  571.182982]  [<ffffffff815e7ebb>] __device_attach+0xbb/0x110
[  571.191625]  [<ffffffff815e8423>] device_initial_probe+0x13/0x20
[  571.200586]  [<ffffffff815e7252>] bus_probe_device+0x92/0xa0
[  571.209088]  [<ffffffff815e5159>] device_add+0x359/0x590
[  571.217122]  [<ffffffff815e53aa>] device_register+0x1a/0x20
[  571.225369]  [<ffffffff8176a35a>] i2c_new_device+0x18a/0x1f0
[  571.233656]  [<ffffffff8176a445>] acpi_i2c_register_device+0x25/0x70
[  571.242692]  [<ffffffff8176a599>] acpi_i2c_notify+0x89/0xa0
[  571.250819]  [<ffffffff81098fca>] notifier_call_chain+0x4a/0x70
[  571.259286]  [<ffffffff81099347>] __blocking_notifier_call_chain+0x47/0x60
[  571.268780]  [<ffffffff81099376>] blocking_notifier_call_chain+0x16/0x20
[  571.278063]  [<ffffffff81473aff>] acpi_default_enumeration+0x63/0x6c
[  571.286932]  [<ffffffff8147503d>] acpi_bus_attach+0x148/0x159
[  571.295121]  [<ffffffff81475005>] acpi_bus_attach+0x110/0x159
[  571.303268]  [<ffffffff81475005>] acpi_bus_attach+0x110/0x159
[  571.311390]  [<ffffffff81475005>] acpi_bus_attach+0x110/0x159
[  571.319462]  [<ffffffff81475131>] acpi_bus_scan+0x5c/0x67
[  571.327083]  [<ffffffff814755c0>] acpi_table_events_fn+0x21/0x31
[  571.335358]  [<ffffffff8109290e>] process_one_work+0x1de/0x4e0
[  571.343413]  [<ffffffff81092c58>] worker_thread+0x48/0x4e0
[  571.351039]  [<ffffffff81092c10>] ? process_one_work+0x4e0/0x4e0
[  571.359203]  [<ffffffff81092c10>] ? process_one_work+0x4e0/0x4e0
[  571.367316]  [<ffffffff810982e9>] kthread+0xc9/0xe0
[  571.374123]  [<ffffffff819d184f>] ret_from_fork+0x1f/0x40
[  571.381482]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
[  571.389610] Code: 00 00 31 d2 31 c9 48 c7 c6 c0 ae 3d a0 4c 89 e7 48 89 c3 e8 e1 d0 22 e1 48 3d 00 f0 ff ff 48 89 c2 48 89 43 18 0f 87 c5 00 00 00 <49> 8b 46 18 4c 89 6b 10 49 89 9c 24 c0 00 00 00 89  
[  571.415686] RIP  [<ffffffffa03d6512>] aic31xx_i2c_probe+0x62/0x150 [snd_soc_tlv320aic31xx]
[  571.426520]  RSP <ffff8800741a39c0>
[  571.431991] CR2: 0000000000000018
[  571.437253] ---[ end trace 614a27e632791261 ]---
[  571.444021] BUG: unable to handle kernel NULL pointer dereference at 0000000000000009
[  571.454047] IP: [<ffffffff810b5fab>] __wake_up_common+0x2b/0x80
[  571.461947] PGD 0 
[  571.465451] Oops: 0000 [#2] PREEMPT SMP
[  571.470992] Modules linked in: snd_soc_tlv320aic31xx(+) snd_soc_core ctr ccm igb arc4 intel_rapl intel_soc_dts_iosf intel_powerclamp coretemp rt2800usb rt2x00usb rt2800lib rt2x00lib snd_hda_codec_hdmis
[  571.523019] CPU: 2 PID: 199 Comm: kworker/2:3 Tainted: G      D         4.8.3-yocto-standard #8
[  571.534327] task: ffff880079b20000 task.stack: ffff8800741a0000
[  571.542548] RIP: 0010:[<ffffffff810b5fab>]  [<ffffffff810b5fab>] __wake_up_common+0x2b/0x80
[  571.553580] RSP: 0018:ffff8800741a3e48  EFLAGS: 00010096
[  571.561242] RAX: 0000000000000282 RBX: ffff8800741a3f18 RCX: 0000000000000000
[  571.570986] RDX: 0000000000000009 RSI: 0000000000000003 RDI: ffff8800741a3f18
[  571.580750] RBP: ffff8800741a3e80 R08: 0000000000000000 R09: 0000000000000000
[  571.590520] R10: ffffffff81e05200 R11: 0000000000000308 R12: ffff8800741a3f20
[  571.600291] R13: 0000000000000282 R14: 0000000000000046 R15: 0000000000000003
[  571.610068] FS:  0000000000000000(0000) GS:ffff880078100000(0000) knlGS:0000000000000000
[  571.620977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  571.629261] CR2: 0000000000000028 CR3: 0000000001e06000 CR4: 00000000001006e0
[  571.639136] Stack:
[  571.643250]  0000000100000000 0000000000000000 ffff8800741a3f18 ffff8800741a3f10
[  571.653469]  0000000000000282 0000000000000046 0000000000000009 ffff8800741a3e90
[  571.663623]  ffffffff810b6063 ffff8800741a3eb8 ffffffff810b6a67 ffff880079b20610
[  571.673753] Call Trace:
[  571.678246]  [<ffffffff810b6063>] __wake_up_locked+0x13/0x20
[  571.686347]  [<ffffffff810b6a67>] complete+0x37/0x50
[  571.693665]  [<ffffffff81077d2d>] mm_release+0xbd/0x140
[  571.701268]  [<ffffffff8107e224>] do_exit+0x4e4/0xb20
[  571.708638]  [<ffffffff819d29d7>] rewind_stack_do_exit+0x17/0x20
[  571.717043]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
[  571.725541] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 89 f7 41 56 41 55 41 54 4c 8d 67 08 53 48 83 ec 10 89 55 cc 48 8b 57 08 4c 89 45 d0 49 39 d4 <48> 8b 32 74 40 48 8d 42 e8 41 89 ce 4c 8d 6e e8 8b  
[  571.752398] RIP  [<ffffffff810b5fab>] __wake_up_common+0x2b/0x80
[  571.760820]  RSP <ffff8800741a3e48>
[  571.766359] CR2: 0000000000000009
[  571.771636] ---[ end trace 614a27e632791262 ]---
[  571.778350] Fixing recursive fault but reboot is needed!
[  571.785817] BUG: scheduling while atomic: kworker/2:3/199/0x00000003
[  571.794447] Modules linked in: snd_soc_tlv320aic31xx(+) snd_soc_core ctr ccm igb arc4 intel_rapl intel_soc_dts_iosf intel_powerclamp coretemp rt2800usb rt2x00usb rt2800lib rt2x00lib snd_hda_codec_hdmis
[  571.847407] CPU: 2 PID: 199 Comm: kworker/2:3 Tainted: G      D         4.8.3-yocto-standard #8
[  571.858904]  0000000000000000 ffff8800741a3e60 ffffffff813f29fa 00000000000171c0
[  571.868977]  ffff8800781171c0 ffff8800741a3e70 ffffffff8109e05f ffff8800741a3ec0
[  571.879034]  ffffffff819cd099 ffffffff81144e66 ffff880079b20000 ffff8800741a3ee8
[  571.889078] Call Trace:
[  571.893497]  [<ffffffff813f29fa>] dump_stack+0x4d/0x63
[  571.900942]  [<ffffffff8109e05f>] __schedule_bug+0x4f/0x70
[  571.908783]  [<ffffffff819cd099>] __schedule+0x469/0x610
[  571.916396]  [<ffffffff81144e66>] ? printk+0x48/0x50
[  571.923583]  [<ffffffff819cd27c>] schedule+0x3c/0x90
[  571.930743]  [<ffffffff8107e69a>] do_exit+0x95a/0xb20
[  571.937986]  [<ffffffff819d29d7>] rewind_stack_do_exit+0x17/0x20
[  571.946324]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
[  571.954778] BUG: unable to handle kernel paging request at ffffffffffffffd8
[  571.964252] IP: [<ffffffff810987c1>] kthread_data+0x11/0x20
[  571.972167] PGD 1e07067 PUD 1e09067 PMD 0 
[  571.978406] Oops: 0000 [#3] PREEMPT SMP
[  571.984266] Modules linked in: snd_soc_tlv320aic31xx(+) snd_soc_core ctr ccm igb arc4 intel_rapl intel_soc_dts_iosf intel_powerclamp coretemp rt2800usb rt2x00usb rt2800lib rt2x00lib snd_hda_codec_hdmis
[  572.037565] CPU: 2 PID: 199 Comm: kworker/2:3 Tainted: G      D W       4.8.3-yocto-standard #8
[  572.049133] task: ffff880079b20000 task.stack: ffff8800741a0000
[  572.057574] RIP: 0010:[<ffffffff810987c1>]  [<ffffffff810987c1>] kthread_data+0x11/0x20
[  572.068374] RSP: 0018:ffff8800741a3e68  EFLAGS: 00010002
[  572.076095] RAX: 0000000000000000 RBX: 00000000000171c0 RCX: 0000000000000002
[  572.085842] RDX: ffff880075405000 RSI: ffff880079b20080 RDI: ffff880079b20000
[  572.095551] RBP: ffff8800741a3e70 R08: 00000000000000c0 R09: 0000000000000000
[  572.105217] R10: 0000000000000000 R11: 00000000ce248c14 R12: ffff8800781171c0
[  572.114853] R13: 0000000000000000 R14: ffff880079b20000 R15: 0000000000000000
[  572.124449] FS:  0000000000000000(0000) GS:ffff880078100000(0000) knlGS:0000000000000000
[  572.135138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  572.143197] CR2: 0000000000000028 CR3: 0000000001e06000 CR4: 00000000001006e0
[  572.152808] Stack:
[  572.156656]  ffffffff8109407e ffff8800741a3ec0 ffffffff819ccff9 ffffffff81144e66
[  572.166641]  ffff880079b20000 ffff8800741a3ee8 ffff8800741a4000 0000000000000009
[  572.176655]  0000000000000000 0000000000000046 0000000000000009 ffff8800741a3ed8
[  572.186691] Call Trace:
[  572.191149]  [<ffffffff8109407e>] ? wq_worker_sleeping+0xe/0x80
[  572.199555]  [<ffffffff819ccff9>] __schedule+0x3c9/0x610
[  572.207272]  [<ffffffff81144e66>] ? printk+0x48/0x50
[  572.214592]  [<ffffffff819cd27c>] schedule+0x3c/0x90
[  572.221872]  [<ffffffff8107e69a>] do_exit+0x95a/0xb20
[  572.229212]  [<ffffffff819d29d7>] rewind_stack_do_exit+0x17/0x20
[  572.237624]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
[  572.246140] Code: b6 3b f7 7e 0f 85 56 ff ff ff e8 b3 89 f6 ff e9 4c ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 48 8b 87 68 04 00 00 55 48 89 e5 5d <48> 8b 40 d8 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
[  572.272875] RIP  [<ffffffff810987c1>] kthread_data+0x11/0x20
[  572.280865]  RSP <ffff8800741a3e68>
[  572.286355] CR2: ffffffffffffffd8
[  572.291589] ---[ end trace 614a27e632791263 ]---
[  572.298258] Fixing recursive fault but reboot is needed!
[  572.305693] BUG: scheduling while atomic: kworker/2:3/199/0x00000003
[  572.314294] Modules linked in: snd_soc_tlv320aic31xx(+) snd_soc_core ctr ccm igb arc4 intel_rapl intel_soc_dts_iosf intel_powerclamp coretemp rt2800usb rt2x00usb rt2800lib rt2x00lib snd_hda_codec_hdmis
[  572.367213] CPU: 2 PID: 199 Comm: kworker/2:3 Tainted: G      D W       4.8.3-yocto-standard #8
[  572.378698]  0000000000000000 ffff8800741a3e60 ffffffff813f29fa 00000000000171c0
[  572.388749]  ffff8800781171c0 ffff8800741a3e70 ffffffff8109e05f ffff8800741a3ec0
[  572.398787]  ffffffff819cd099 ffffffff81144e66 ffff880079b20000 ffff8800741a3ee8
[  572.408804] Call Trace:
[  572.413204]  [<ffffffff813f29fa>] dump_stack+0x4d/0x63
[  572.420639]  [<ffffffff8109e05f>] __schedule_bug+0x4f/0x70
[  572.428444]  [<ffffffff819cd099>] __schedule+0x469/0x610
[  572.436011]  [<ffffffff81144e66>] ? printk+0x48/0x50
[  572.443172]  [<ffffffff819cd27c>] schedule+0x3c/0x90
[  572.450314]  [<ffffffff8107e69a>] do_exit+0x95a/0xb20
[  572.457550]  [<ffffffff819d29d7>] rewind_stack_do_exit+0x17/0x20
[  572.465884]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
[  593.488004] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  593.500628]  2-...: (3 GPs behind) idle=a1b/140000000000000/0 softirq=3893/3894 fqs=5250 
[  593.516219]  (detected by 3, t=21002 jiffies, g=3909, c=3908, q=364)
[  593.529707] Task dump for CPU 2:
[  593.539404] kworker/2:3     D ffff880079b28000     0   199      2 0x00000008
[  593.553523]  ffff880074c61483 ffff88007548c400 0000000000000000 ffff8800741a3858
[  593.568045]  ffffffff814f6370 0000000000000003 ffff880074c63730 ffff8800741a3960
[  593.582553]  ffffffff81460e71 ffff8800741a38a8 ffffffff814f6157 ffffffff00000200
[  593.597148] Call Trace:
[  593.606038]  [<ffffffff814f6370>] ? drm_fb_helper_cfb_imageblit+0x30/0x40
[  593.620027]  [<ffffffff81460e71>] ? bit_putcs+0x2d1/0x520
[  593.632349]  [<ffffffff814f6157>] ? drm_fb_helper_dirty.isra.14+0xc7/0xe0
[  593.646159]  [<ffffffff814f6157>] ? drm_fb_helper_dirty.isra.14+0xc7/0xe0
[  593.659643]  [<ffffffff814f6370>] ? drm_fb_helper_cfb_imageblit+0x30/0x40
[  593.672884]  [<ffffffff8146127a>] ? soft_cursor+0x1ba/0x230
[  593.684557]  [<ffffffff81460a73>] ? bit_cursor+0x633/0x670
[  593.695916]  [<ffffffff813ff3c7>] ? __const_udelay+0x27/0x30
[  593.707310]  [<ffffffff81460440>] ? update_attr.isra.2+0x90/0x90
[  593.718955]  [<ffffffff8145c2cc>] ? fbcon_cursor+0x13c/0x1d0
[  593.730189]  [<ffffffff8109924a>] ? atomic_notifier_call_chain+0x3a/0x50
[  593.742646]  [<ffffffff814c8865>] ? vt_console_print+0x225/0x3b0
[  593.754208]  [<ffffffff810b8222>] ? up+0x32/0x50
[  593.764140]  [<ffffffff810bf25b>] ? wake_up_klogd+0x3b/0x50
[  593.775160]  [<ffffffff810bf796>] ? console_unlock+0x526/0x5d0
[  593.786526]  [<ffffffff810bfa83>] ? vprintk_emit+0x243/0x470
[  593.797690]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
[  593.809407]  [<ffffffff810bfe1f>] ? vprintk_default+0x1f/0x30
[  593.820760]  [<ffffffff81144e66>] ? printk+0x48/0x50
[  593.831196]  [<ffffffff810e9d62>] ? __module_text_address+0x12/0x60
[  593.843148]  [<ffffffff810ed605>] ? is_module_text_address+0x15/0x30
[  593.855136]  [<ffffffff81096886>] ? __kernel_text_address+0x56/0x70
[  593.866887]  [<ffffffff8101e35b>] ? print_context_stack+0x7b/0x100
[  593.878403]  [<ffffffff8101d9b8>] ? dump_trace+0x118/0x320
[  593.889055]  [<ffffffff8101e68b>] ? show_trace_log_lvl+0x4b/0x60
[  593.900224]  [<ffffffff8101dcd8>] ? show_stack_log_lvl+0x118/0x1b0
[  593.911484]  [<ffffffff8101e725>] ? show_stack+0x25/0x50
[  593.921672]  [<ffffffff810cee84>] ? rcu_note_context_switch+0x244/0x410
[  593.933353]  [<ffffffff819d1477>] ? _raw_spin_lock+0x27/0x30
[  593.943846]  [<ffffffff819ccc9f>] ? __schedule+0x6f/0x610
[  593.953925]  [<ffffffff81144e66>] ? printk+0x48/0x50
[  593.963454]  [<ffffffff819cd27c>] ? schedule+0x3c/0x90
[  593.973123]  [<ffffffff8107e69a>] ? do_exit+0x95a/0xb20
[  593.982979]  [<ffffffff819d29d7>] ? rewind_stack_do_exit+0x17/0x20
[  593.993988]  [<ffffffff81098220>] ? kthread_worker_fn+0x170/0x170
