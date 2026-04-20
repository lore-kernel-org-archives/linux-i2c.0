Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F80382F0A
	for <linux-i2c@vger.kernel.org>; Mon, 20 Apr 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720983; cv=none; b=OepQHIerxBtIJcivjjipcioD/olTJHprfBpL2cFPBSAMQQNLqMX6PcVo23aAvZDIMoR/lH6B7MhkWkagc1XTIzIHgj984Uy8gKrFvzF5lYvX95uahzzX36hD0FRA2HiV1BDq3rBUweUAG4dwlbzWOvvjXYKo4fKm+CqMHfVw+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720983; c=relaxed/simple;
	bh=zUSqDae8ehhpIsaM8InHRH02iEAP/P1P5q7nP5d4CWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mh0be0fh6xn30a/ZEH0yR/N0liyIlDqjdPbgOIv+ef1SxhPZyV+6ujb7+6wROG7+G+yZedMg69NvF+zwoDZZF4DgKHfgbocptEh52hBi/U1t/u96j00bPgxCuyP70xlOHt0/cSQQZht+RxbrqGD8UxEUtEiSFr8mkWV+RAgJ9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6948d83a548so2928167eaf.0
        for <linux-i2c@vger.kernel.org>; Mon, 20 Apr 2026 14:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720981; x=1777325781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEXQxlFpDs5DHiWxH1HFe8jxhbypKF6txLcWt+SIIVs=;
        b=GBi82wA3z1k75Lox6Zd5A9iGP/zjHt/fHqDUf94LtEG4bnEq9yXoHeFGxYrDQWAf5W
         zG712DFklqvDTQ3WP8kWlO0qN9NuEn0wsBiHzIrZtr8xKrRFWa2mwb7N6kjJbk32ik8D
         pOkbvUQnZnsF1t3Cr1GdofPE1/tQj8QMbu/ALnDs2YRUulFngvIsnE3PWeEUwMvG1dNc
         pLir3xYFp8djYFvA1YvWt2BQtA5BOOd7ekJGHuZLld+o8pXhO56Qn7E5tC4469A9GWw/
         b6ziR7Rz1bPQIzrn1r0/tGu4BcZFEfnEoqItGkBcqJ/a/wFLqyT2XDhEc0nZCNOScmxq
         RXrA==
X-Gm-Message-State: AOJu0Ywh+essOHgZGtdqGPW58pt6XIY65GwjXg0xNvf8uJ7cTIu/mOX6
	dN58REDwGesxUipWQbtLQKwGRmijJM7/toLb1+oYfc8RVZuA4EoGTvZZl4J+xUmNtlf9TVCzJpE
	8s4ji7FfjRI0GbBYzpLPMElnsCKFD6kzgzowJkU/+5HOUBFmbHbMW87f9XVWhrA==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a2:b0:67e:42b0:b35e with SMTP id
 006d021491bc7-69462dee1dfmr7430813eaf.4.1776720981030; Mon, 20 Apr 2026
 14:36:21 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:36:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e69c55.050a0220.24bfd3.0029.GAE@google.com>
Subject: [syzbot] [i2c?] [usb?] WARNING: ODEBUG bug in i2c_device_remove (2)
From: syzbot <syzbot+019ced393ab913002b75@syzkaller.appspotmail.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c7275b05bc42 Add linux-next specific files for 20260417
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1782f4ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10db2bdce6adb49e
dashboard link: https://syzkaller.appspot.com/bug?extid=019ced393ab913002b75
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b79906580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16688cf2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ffefe34549f8/disk-c7275b05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f679e5d59c0c/vmlinux-c7275b05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/714f96953b57/bzImage-c7275b05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+019ced393ab913002b75@syzkaller.appspotmail.com

usb 1-1: DVB: registering adapter 1 frontend 0 (Realtek RTL2832 (DVB-T))...
dvbdev: dvb_create_media_entity: media entity 'Realtek RTL2832 (DVB-T)' registered.
DVB: Unable to find symbol r820t_attach()
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff8880258626e8 object type: timer_list hint: rtl2832_i2c_gate_work+0x0/0x100 drivers/media/dvb-frontends/rtl2832.c:-1
WARNING: lib/debugobjects.c:632 at debug_print_object lib/debugobjects.c:629 [inline], CPU#1: kworker/1:2/821
WARNING: lib/debugobjects.c:632 at __debug_check_no_obj_freed lib/debugobjects.c:1116 [inline], CPU#1: kworker/1:2/821
WARNING: lib/debugobjects.c:632 at debug_check_no_obj_freed+0x405/0x550 lib/debugobjects.c:1146, CPU#1: kworker/1:2/821
Modules linked in:
CPU: 1 UID: 0 PID: 821 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object lib/debugobjects.c:629 [inline]
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:1116 [inline]
RIP: 0010:debug_check_no_obj_freed+0x44a/0x550 lib/debugobjects.c:1146
Code: 89 44 24 20 e8 87 40 6f fd 48 8b 44 24 20 4c 8b 4d 00 4c 89 ef 48 c7 c6 a0 61 ca 8b 48 c7 c2 20 67 ca 8b 8b 0c 24 4d 89 f8 50 <67> 48 0f b9 3a 48 83 c4 08 4c 8b 6c 24 18 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc90004fa67b8 EFLAGS: 00010246
RAX: ffffffff8767dab0 RBX: ffffffff99edac98 RCX: 0000000000000000
RDX: ffffffff8bca6720 RSI: ffffffff8bca61a0 RDI: ffffffff8fd9d990
RBP: ffffffff8b6f5560 R08: ffff8880258626e8 R09: ffffffff8b6f68e0
R10: dffffc0000000000 R11: ffffffff81b15270 R12: ffff888025862800
R13: ffffffff8fd9d990 R14: ffff888025862000 R15: ffff8880258626e8
FS:  0000000000000000(0000) GS:ffff888125b62000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ec609ae9c CR3: 000000003956c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 slab_free_hook mm/slub.c:2620 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x13e/0x6c0 mm/slub.c:6561
 i2c_device_remove+0x88/0x220 drivers/i2c/i2c-core-base.c:631
 device_remove drivers/base/dd.c:619 [inline]
 __device_release_driver drivers/base/dd.c:1352 [inline]
 device_release_driver_internal+0x46f/0x870 drivers/base/dd.c:1375
 bus_remove_device+0x45a/0x570 drivers/base/bus.c:657
 device_del+0x52b/0x900 drivers/base/core.c:3895
 device_unregister+0x21/0xf0 drivers/base/core.c:3936
 rtl28xxu_frontend_detach+0x168/0x210 drivers/media/usb/dvb-usb-v2/rtl28xxu.c:1105
 dvb_usbv2_adapter_frontend_exit drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:733 [inline]
 dvb_usbv2_adapter_exit drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:830 [inline]
 dvb_usbv2_exit+0x44c/0xb80 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:844
 dvb_usbv2_probe+0x4c0/0x3c20 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:994
 usb_probe_interface+0x659/0xc70 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 usb_new_device+0x9f8/0x16e0 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x2a49/0x4f60 drivers/usb/core/hub.c:5953
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 44 24 20          	mov    %eax,0x20(%rsp)
   4:	e8 87 40 6f fd       	call   0xfd6f4090
   9:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   e:	4c 8b 4d 00          	mov    0x0(%rbp),%r9
  12:	4c 89 ef             	mov    %r13,%rdi
  15:	48 c7 c6 a0 61 ca 8b 	mov    $0xffffffff8bca61a0,%rsi
  1c:	48 c7 c2 20 67 ca 8b 	mov    $0xffffffff8bca6720,%rdx
  23:	8b 0c 24             	mov    (%rsp),%ecx
  26:	4d 89 f8             	mov    %r15,%r8
  29:	50                   	push   %rax
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
  38:	48                   	rex.W
  39:	b9 00 00 00 00       	mov    $0x0,%ecx
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
