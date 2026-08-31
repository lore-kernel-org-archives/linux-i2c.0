Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD884393DF5
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211064; cv=none; b=UaX+HaQemdEGIq26GLlsAfDcazMXuUEK7gYN0FcFMsMNnPpIBqOxFGV/RjX78YWRRTiWXbUjWMN3d+yj2QlxacyL77hVKXYQLplONGaoEYoQuyPE0EsXepW+tYJa2g41hN7SB/lwjoByqlON5ca+EN0/nRTYpG0XR/3Ark8GNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211064; c=relaxed/simple;
	bh=PBthaGqrwgMCY6KjQok+0WKbvRX8c4uy7DFThX/ixDw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ge486G4Pk/NMJ4/vTZVySwP8yrBQfPjqwBuTyhmmm2h96QS0lpV5M8fb5gtB3+ys2mbwWqMaNBkZp7qZSgd+6Ov+47BN+LosvRuZ97ZArAqBO+tnTmEbPBets8u22s7x/moNYZCfe5JA//fGRelWVs2JvDM3XnHBd/0fq5gZWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6b173742296so366183eaf.0
        for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 14:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211060; x=1788815860;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzKJl+jAZzWzqQaJuU3opchmm9TMZRwkBGCBYrBdkHw=;
        b=fljj96J+6vYuhZmZ7tub3MYlrfc+WEw5+wuGi3HuMLo7y8yYhXh/y3zvhgZR62wHnw
         gYXkrH8QAn2bdkblDZvnZh9TRJK4J4zmwxSDgINsJYLoftMAvhvUeNwSq2+dIjefFxor
         wLIVjvfLt6ZC+Xc/eRSemY8aPIwulB7a4WCKeEX4HLIHh5bkmxhxQPs1aFVk2iA1hdYW
         iZEZvI5OmTluYEYbkUAKf02dMdlZr0A1+kIwJWE2shpKac5Xb8BRMVgTguSdPnELJSRP
         WxAsggcDKZjImmm39+wyYSssXewR2CdRZTD2D58Svz2tefIHheVrgnCn3+waJhPFmoyN
         YyDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTN+Hn8kRE6YUie2FnBLTIrhUaJg5edwA3KczF0835HXpRD9h0Vaqy4EVoZgytzT69XBpczOEyccM=@vger.kernel.org
X-Gm-Message-State: AFuF++kYBCqNjWHZ366p9dNNxDCTrQf99KkcoU6zZ42oBtGohDXHJx/P
	N2MwUAIgYqC1fR5w4guKLfD0G8UCmMH4DqvPkElh2cdMYmt3NWoLdLIA0p/+aSFyrzGJCYkgQil
	C6MHxbdW/Z3HjapWAAB4nBlJaJ5Cc2XKK2OsLus6YBaWaCdn4Ktf2CtTvJA4=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f023:b0:6b1:51f3:abf with SMTP id
 006d021491bc7-6b3786e9f9dmr924181eaf.15.1788211060388; Mon, 31 Aug 2026
 14:17:40 -0700 (PDT)
Date: Mon, 31 Aug 2026 14:17:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a95ef74.764875ec.b345.0003.GAE@google.com>
Subject: [syzbot] [i2c?] [usb?] INFO: task hung in em28xx_i2c_unregister
From: syzbot <syzbot+f669f02a0fcc5b2148f2@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a23cbb05744b Merge tag 'timers-urgent-2026-08-30' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12a6d379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=f669f02a0fcc5b2148f2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1f379580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eed599d932fb/disk-a23cbb05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74e8c268c325/vmlinux-a23cbb05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa91aebf1baf/bzImage-a23cbb05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f669f02a0fcc5b2148f2@syzkaller.appspotmail.com

INFO: task kworker/1:3:1865 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:22152 pid:1865  tgid:1865  ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 i2c_del_adapter+0x281/0x430 drivers/i2c/i2c-core-base.c:1841
 em28xx_i2c_unregister+0x4b/0x60 drivers/media/usb/em28xx/em28xx-i2c.c:1029
 em28xx_release_resources+0x14c/0x240 drivers/media/usb/em28xx/em28xx-cards.c:3764
 em28xx_usb_disconnect+0x19f/0x2f0 drivers/media/usb/em28xx/em28xx-cards.c:4455
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
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.4.136:6293 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.136       state:D stack:27896 pid:6293  tgid:6293  ppid:5809   task_flags:0x400040 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd16879e159
RSP: 002b:00007fd168b4fba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fd168b4fc90 RCX: 00007fd16879e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000004d940 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2e620000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd168a25fac R14: 00007fd168a25fa8 R15: 00007fd168a25fa0
 </TASK>
INFO: task syz.2.135:6294 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.135       state:D stack:27096 pid:6294  tgid:6294  ppid:5785   task_flags:0x400040 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1b3299e159
RSP: 002b:00007f1b32d4fba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f1b32d4fc90 RCX: 00007f1b3299e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000004d997 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2d220000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1b32c25fac R14: 00007f1b32c25fa8 R15: 00007f1b32c25fa0
 </TASK>
INFO: task syz.5.133:6295 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.133       state:D stack:27096 pid:6295  tgid:6295  ppid:5796   task_flags:0x400040 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6b1f9e159
RSP: 002b:00007fe6b234fba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fe6b234fc90 RCX: 00007fe6b1f9e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000004d99d R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2dd20000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe6b2225fac R14: 00007fe6b2225fa8 R15: 00007fe6b2225fa0
 </TASK>
INFO: task syz.0.132:6296 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.132       state:D stack:27096 pid:6296  tgid:6296  ppid:5770   task_flags:0x400040 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0c859e159
RSP: 002b:00007fa0c894fba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fa0c894fc90 RCX: 00007fa0c859e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000004d9a7 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2c820000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa0c8825fac R14: 00007fa0c8825fa8 R15: 00007fa0c8825fa0
 </TASK>
INFO: task syz.1.134:6297 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.134       state:D stack:27592 pid:6297  tgid:6297  ppid:5775   task_flags:0x400040 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x4a0/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa70379e159
RSP: 002b:00007fa703b4fba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fa703b4fc90 RCX: 00007fa70379e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000004d9ba R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2cb20000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa703a25fac R14: 00007fa703a25fa8 R15: 00007fa703a25fa0
 </TASK>

Showing all locks held in the system:
locks held by pr/ttyS0/16: 2, last CPU#1:
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffffff9ad31098 (&port_lock_key){-...}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9ad31098 (&port_lock_key){-...}-{3:3}, at: univ8250_console_device_lock+0x67/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6837
locks held by kworker/1:3/1865: 6, on CPU#1:
 #0: ffff8880232e7140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880232e7140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880232e7140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff8880232e7140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc900063f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900063f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900063f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc900063f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #2: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff888024c051d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888024c051d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff88802b4031a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88802b4031a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88802b4031a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
 #5: ffff888058201cf0 (&dev->lock#3){+.+.}-{4:4}, at: em28xx_release_resources+0x75/0x240 drivers/media/usb/em28xx/em28xx-cards.c:3758
locks held by getty/5374: 2, on CPU#0:
 #0: ffff888036cae0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by udevd/6066: 4, on CPU#1:
 #0: ffff888035016f38 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xa4/0xca0 fs/seq_file.c:183
 #1: ffff888055824c80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x5d/0x420 fs/kernfs/file.c:165
 #2: ffff88807ff67a58 (kn->active#28){++++}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff88807ff67a58 (kn->active#28){++++}-{0:0}, at: kernfs_seq_start+0xb2/0x420 fs/kernfs/file.c:166
 #3: ffff888024c051d8 (&dev->mutex){....}-{4:4}, at: device_lock_interruptible include/linux/device.h:1109 [inline]
 #3: ffff888024c051d8 (&dev->mutex){....}-{4:4}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
locks held by syz.4.136/6293: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
locks held by syz.2.135/6294: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
locks held by syz.5.133/6295: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
locks held by syz.0.132/6296: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
locks held by syz.1.134/6297: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_release+0x80/0x780 drivers/usb/core/devio.c:1099
locks held by syz.6.137/6384: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.7.138/6385: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.8.139/6386: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.9.140/6387: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.3.141/6388: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.0.142/6484: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.1.143/6485: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.2.144/6486: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.4.146/6490: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.6.150/6564: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.7.151/6565: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.8.153/6566: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.9.154/6567: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.3.162/6643: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.0.163/6645: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.1.164/6646: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.2.166/6648: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.4.174/6724: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.7.176/6725: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.6.175/6726: 1, on CPU#1:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.8.178/6727: 1, on CPU#0:
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802a64a1d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 16 Comm: pr/ttyS0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 5e e2 55 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 af ab c5 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 1a e4 74 06 cc 44 89 f9 80 e1 07
RSP: 0018:ffffc900001578b8 EFLAGS: 00000002
RAX: 1ffffffff35a6200 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff8571d400 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff9ad310c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124dda000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe39d825fa4 CR3: 000000006a5fc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:128 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
 wait_for_lsr+0x184/0x2f0 drivers/tty/serial/8250/8250_port.c:2013
 serial8250_fifo_wait_for_lsr_thre drivers/tty/serial/8250/8250_port.c:3270 [inline]
 __serial8250_console_fifo_write+0x346/0x3e0 drivers/tty/serial/8250/8250_port.c:3372
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
 __serial8250_console_write drivers/tty/serial/8250/8250_port.c:3429 [inline]
 serial8250_console_write+0xaa1/0x1200 drivers/tty/serial/8250/8250_port.c:3493
 nbcon_emit_next_record+0xef5/0x1a90 kernel/printk/nbcon.c:-1
 nbcon_emit_one kernel/printk/nbcon.c:1157 [inline]
 nbcon_kthread_func+0x679/0x880 kernel/printk/nbcon.c:1271
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
