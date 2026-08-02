Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0770809
	for <linux-i2c@vger.kernel.org>; Sun,  2 Aug 2026 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785628893; cv=none; b=jwzdW08opbRX/MmoH79Pno+4zVWKtrHsEFtIwF6wI1Izwl9sXtOnt7AoVd9kyBSxNBlFxTE2w+58alvsSxvf1p/Oyi7sHvlbbm7ZrK+jw7oIRwEh5tNfewG2nhdFaGjGTidEEIKZ3U4am9Q0r5OHYO79nLrHeqBGm16Hwk1vhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785628893; c=relaxed/simple;
	bh=IzqbXIBvWv7JQkFHHVPFrg8xud8vn0kJcnVD4XySjw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I2mWxWxX5uq9KuHsXlAqxDC7pyQYPK6iNgjrkDL47wfjkS5ALL2MNJsoBR0XMG5VAu/r/fQGy2pSxWEZjVllzjaq80JRJJQWj2Nao+0VrCcglWDGRSOzEP6ZfIrEx7kSKn/xm/zHf7i/q+qTto0Wlb2q4bfn2ybytVSmXMaSd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a43d32fa9fso3023682b6e.2
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 17:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785628890; x=1786233690;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlJvHSAGeR9qevN99zpCUkqHWR9w0yerCy0dukxk1EQ=;
        b=MlXqQOLEdOZB1mNOknp//l6mUGYQFTQ5BlN6KhxdzFDJLb6DXUR44dO2GojNmsOY3h
         fOI0HaHpV4kDmAEq57GOYPwVfY+QG8P4GeAvBUBHpIFYw9R7D/xl0YezuIJhdF7Nf0K8
         QsOoQxi6klGGq3Ekfvd5hYP3eHkxlRnUS375gX3oc78HPFVpgOcm0Y2k6cUIM3TNMj1o
         vUnSD3OoGiRDilBTB3rbRQCOPvGJWLtEscbKfl5FDAeXpoz4GXJW0uoUXPfBx2XIlT8n
         tSRE69FuQ305NTAW/7/lxsBxkSXkIBbTKZfGsKOy2eRcaRJx3B92w6lQ8d5qG+r5JBOU
         DZdw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2SitBWHhObFBw8xc9txx06xuOExnu1UiSzttmSbGXxGTNwCHEUTcfopGA1NQde+iDz2YNsWfFMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpvj/IgoBVq5DG3ezirpvEUI1axOopDi0Rx5LqMYnRtOfWQMa
	nTbp13WNrithHP9rn4FYaYXKwvUBJFeyfusokQ43Dn40BoAtlISs6FdFhvTJTukQuCEdS0fbZbV
	xTe6/JS91a9EjeEJKZ0vBzDYEfmoz1kMiGroa7NBqdhAjmtlkDZmsz+Lanlw=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6907:b0:4ab:3210:b31a with SMTP id
 5614622812f47-4af5e229f61mr8717783b6e.14.1785628890635; Sat, 01 Aug 2026
 17:01:30 -0700 (PDT)
Date: Sat, 01 Aug 2026 17:01:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6e88da.13bfb6d0.1ecdd5.0269.GAE@google.com>
Subject: [syzbot] [i2c?] KASAN: slab-use-after-free Read in i2c_adapter_lock_bus
From: syzbot <syzbot+450abcfc7906fe1a1e16@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0131b508c0e2 Merge tag 'ntfs-for-7.2-rc6' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1308cdb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=450abcfc7906fe1a1e16
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6e15ceb9f129/disk-0131b508.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/095800b9535a/vmlinux-0131b508.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79e67e7b28f1/bzImage-0131b508.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+450abcfc7906fe1a1e16@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in i2c_adapter_depth drivers/i2c/i2c-core-base.c:1243 [inline]
BUG: KASAN: slab-use-after-free in i2c_adapter_lock_bus+0x5e/0xf0 drivers/i2c/i2c-core-base.c:849
Read of size 8 at addr ffff88802ae7a108 by task syz.4.3958/16921

CPU: 0 UID: 0 PID: 16921 Comm: syz.4.3958 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 i2c_adapter_depth drivers/i2c/i2c-core-base.c:1243 [inline]
 i2c_adapter_lock_bus+0x5e/0xf0 drivers/i2c/i2c-core-base.c:849
 i2c_lock_bus include/linux/i2c.h:809 [inline]
 __i2c_lock_bus_helper drivers/i2c/i2c-core.h:47 [inline]
 i2c_transfer+0xc8/0x2d0 drivers/i2c/i2c-core-base.c:2339
 i2c_transfer_buffer_flags+0x10d/0x1a0 drivers/i2c/i2c-core-base.c:2371
 i2c_master_send include/linux/i2c.h:109 [inline]
 i2cdev_write+0x113/0x1e0 drivers/i2c/i2c-dev.c:183
 do_loop_readv_writev fs/read_write.c:851 [inline]
 vfs_writev+0x4bb/0x990 fs/read_write.c:1060
 do_writev+0x154/0x2e0 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f438139e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f43822b7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f4381625fa0 RCX: 00007f438139e019
RDX: 0000000000000001 RSI: 0000200000000840 RDI: 0000000000000004
RBP: 00007f438143500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4381626038 R14: 00007f4381625fa0 R15: 00007ffe59417c98
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x32d/0x660 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 usb_alloc_dev+0x5f/0xf10 drivers/usb/core/usb.c:651
 usb_add_hcd+0x407/0xf80 drivers/usb/core/hcd.c:2880
 dummy_hcd_probe+0x134/0x270 drivers/usb/gadget/udc/dummy_hcd.c:2722
 platform_probe+0xf9/0x190 drivers/base/platform.c:1439
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 platform_device_add+0x4bd/0x860 drivers/base/platform.c:762
 dummy_hcd_init+0x667/0xd00 drivers/usb/gadget/udc/dummy_hcd.c:2873
 do_one_initcall+0x250/0x870 init/main.c:1347
 do_initcall_level+0x10a/0x1a0 init/main.c:1409
 do_initcalls+0x59/0xa0 init/main.c:1425
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
 kernel_init+0x1d/0x1d0 init/main.c:1548
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 16867:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6692
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 usb_put_invalidate_rhdev drivers/usb/core/hcd.c:2769 [inline]
 usb_remove_hcd+0x460/0x670 drivers/usb/core/hcd.c:3090
 dummy_hcd_remove+0xed/0x130 drivers/usb/gadget/udc/dummy_hcd.c:2761
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xcd8/0x10a0 kernel/workqueue.c:2401
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2452
 queue_work include/linux/workqueue.h:699 [inline]
 rpm_idle+0x511/0x980 drivers/base/power/runtime.c:537
 rpm_suspend+0x126f/0x17b0 drivers/base/power/runtime.c:729
 __pm_runtime_idle+0x12f/0x1a0 drivers/base/power/runtime.c:1129
 hub_event+0x471e/0x4d30 drivers/usb/core/hub.c:5995
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xcd8/0x10a0 kernel/workqueue.c:2401
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2452
 queue_work include/linux/workqueue.h:699 [inline]
 rpm_idle+0x511/0x980 drivers/base/power/runtime.c:537
 rpm_suspend+0x126f/0x17b0 drivers/base/power/runtime.c:729
 __pm_runtime_idle+0x12f/0x1a0 drivers/base/power/runtime.c:1129
 hub_event+0x471e/0x4d30 drivers/usb/core/hub.c:5995
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802ae7a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 264 bytes inside of
 freed 2048-byte region [ffff88802ae7a000, ffff88802ae7a800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802ae7e000 pfn:0x2ae78
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b002000 ffffea00014b9c10 ffffea0000d44210
raw: ffff88802ae7e000 0000000800080005 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801b002000 ffffea00014b9c10 ffffea0000d44210
head: ffff88802ae7e000 0000000800080005 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 11690201849, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __kmalloc_cache_noprof+0x3a7/0x660 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 device_create_groups_vargs drivers/base/core.c:4436 [inline]
 device_create+0x13d/0x300 drivers/base/core.c:4493
 mon_bin_add+0xb6/0x130 drivers/usb/mon/mon_bin.c:1371
 mon_bus_init+0x162/0x2a0 drivers/usb/mon/mon_main.c:291
 mon_bus_add drivers/usb/mon/mon_main.c:188 [inline]
 mon_notify+0x10c/0x3f0 drivers/usb/mon/mon_main.c:219
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
 usb_register_bus+0xcf/0x150 drivers/usb/core/hcd.c:904
 usb_add_hcd+0x3e6/0xf80 drivers/usb/core/hcd.c:2876
 dummy_hcd_probe+0x134/0x270 drivers/usb/gadget/udc/dummy_hcd.c:2722
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802ae7a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ae7a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802ae7a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88802ae7a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ae7a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
