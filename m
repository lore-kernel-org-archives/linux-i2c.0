Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765A4B1D11
	for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596710; cv=none; b=r0FKLft+VjIwN1FN3T2zoe8eiMDRh1w2SXZtEdwsuzWSK36QbHodJjkZqBapna7IaWNRxVnhXaIEqWP+g89UsyHo54EzpOssl3Lykw1X7mQAga97wMhXXpqXWcbldhgBCn1Ecl3VDZhRRu+lVHLl2tXuPO9e48uM0Tp9hjEd+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596710; c=relaxed/simple;
	bh=1O3PxAFo3FfLIlYr/TdS/zrbc350A63udpmTM0P5zpo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WBWyBlLWJzLnSAJYv8IvL/hQTualdTaFK3eqiqxsi/qHE8PWzRWA6jVgAK1Z4yTSAjOncJflAIqOidDeu5/0RBMuM9SH2giU6uD8QeWUU2ycOmZRuB1K/RGt0jTy6nteCijuZT4MBOD2I8zmO9LB/fmiWZEmfBYEyYLi6xRIPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b38ea4c6acso3069996b6e.1
        for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 04:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596707; x=1791201507;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tD00Tn9PzpN11Ydf9Aruk6Tjr4xl8SEYjEbKTx3h+aw=;
        b=LsnBeHrHggjwxj1QM9KLvuvYcR5254kJJYCVlrzoK/GKzhrAdwahzzcVdxY5N8JsHl
         n/lYMYuAREFa56E9x1mqm2rNadBm6O7NdsPE5u/zjsY2eCERUPlMVAVS9iBAF0lAiAv9
         N0szpF5IOwNh04ZE+rB5pqwR8GnE/0XgERnXwvR6riS+zh0TWNuyXu8Bgzozc3Gby1Rk
         t9Tbe+2eEJfjtsAaBj0hPPU/iFS6J9GFHXa9wR7hz8LQUqzgQj+ms5aT94HtB6Q4rpx9
         7ZG5+jIVClDSLvhhHX1UgtxKAXBoMHAvTTwy48W1lsLkoOjeQQZ1j61AXdqRKR27uXGi
         SVxA==
X-Forwarded-Encrypted: i=1; AKwUvBxVo6mOdBQLqDHSiq4XTWOeWLhiWtd7MePIWrbOfy0r96koAdI5UveDqZSRLct717URqBXytiNAuPI=@vger.kernel.org
X-Gm-Message-State: AFuF++nmpHCJXDChNAyjCtXuPCNB7U+apG7ghP7nWIpQw0+0rQfUfild
	nzpjQZaEoa+cCar2bmKDLVeTVin5yahQXy4R5PFHXdTM9Zf5uXZSRxqva/32Y0AnqcEj2eIa7e5
	T4Uhslh3+6svlIx4O+hobeRYUdFlTUZbDFfTSWGsXapAuFUxVJfE7+zIgY1w=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a1:b0:4e6:76eb:b997 with SMTP id
 5614622812f47-4e676ebbb9amr6162017b6e.62.1790596707620; Mon, 28 Sep 2026
 04:58:27 -0700 (PDT)
Date: Mon, 28 Sep 2026 04:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aba5663.beeaa6a4.36f27f.0003.GAE@google.com>
Subject: [syzbot] [i2c?] INFO: task hung in ft260_remove
From: syzbot <syzbot+1dc44aa283d5af458c73@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62f4c998b297 Merge tag 'parisc-for-7.3-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b69c05580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=1dc44aa283d5af458c73
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1795a0bff93/disk-62f4c998.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec557749691d/vmlinux-62f4c998.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e2f8fa31746/bzImage-62f4c998.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1dc44aa283d5af458c73@syzkaller.appspotmail.com

INFO: task kworker/1:6:5715 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:21408 pid:5715  tgid:5715  ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 i2c_del_adapter+0x292/0x440 drivers/i2c/i2c-core-base.c:1847
 ft260_remove+0x5d/0x80 drivers/hid/hid-ft260.c:1104
 hid_device_remove+0xc5/0x1c0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
locks held by khungtaskd/31: 1, last CPU#1:
 #0: ffffffff8ed5c920 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c920 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c920 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by getty/5375: 2, on CPU#1:
 #0: ffff888034e030a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by kworker/1:6/5715: 6, on CPU#1:
 #0: ffff8880226e6140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880226e6140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880226e6140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff8880226e6140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004cbfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90004cbfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90004cbfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90004cbfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802979d1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802979d1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff88807aa121d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88807aa121d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff88802039c1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88802039c1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88802039c1a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
 #5: ffff88807e0e1a58 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #5: ffff88807e0e1a58 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #5: ffff88807e0e1a58 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 9c 88 02 e9 83 08 03 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e3 a1 23 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff8ea07ca0 EFLAGS: 00000242
RAX: 00000000004d2bf7 RBX: ffffffff819bbcb0 RCX: 8000000000000001
RDX: 0000000000000001 RSI: ffffffff8e414ba9 RDI: ffffffff8c6da780
RBP: ffffffff8ea07d78 R08: ffff8880b8633a1b R09: 1ffff110170c6743
R10: dffffc0000000000 R11: ffffed10170c6744 R12: 0000000000000000
R13: 1ffffffff1d51e00 R14: 1ffffffff1d40f9c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124ccb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559c5e26da38 CR3: 000000000eb48000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x2e0/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 rest_init+0x378/0x3a0 init/main.c:732
 start_kernel+0x392/0x3e0 init/main.c:1190
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x157
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
