Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112C33F58D
	for <linux-i2c@vger.kernel.org>; Sat,  8 Aug 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209579; cv=none; b=DynN9x8lIroeD8/0HhOrqAJh5QzelyMSzc0Rn3FcAZAuTCiiX9FX3xHRLe8kI6O6aHSc3Z4VoftrPYKNnwu9Y51Drtn6nkVyeze9dMDKUoN3kiV9iRxgKKcbaZulHR1Hy8tiTDZ2tK4bIqZ6hWK8tVA2GFIYuYT2Z7UaMWEF0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209579; c=relaxed/simple;
	bh=ZusuPtUeLvPKRfy2boqe9zfZ0PDQDrcHrZmJCsXzxg4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ocEpTT5XvnLCFWBEWQZsHQB5OwpHR6PG2JonS1TQJM1UkYVQiaBt/zLaiOzmCgVi/2JlICubIRJtxWQgKT+Sh2lv71IQPu40M8a70zyoX0DNqWT9exFHWZrNPkUpS/WJLwYLrIY+s9g3iGnU249AqKs02d61Uiz/KCs/GSHup/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b1a69b1188so562627b6e.1
        for <linux-i2c@vger.kernel.org>; Sat, 08 Aug 2026 10:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786209577; x=1786814377;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NMtzi1gKqOwfX9n9OcTv5GNQZwL3+goR+VH0iASvKwI=;
        b=L/WAFru8BmfQmU+vWASXbAwJJx9bRJrfGcD5/0Mv80ALXoVtfNvUUvMqjSdkC3EZSO
         c1XqioQfk4P92jyIQOFqMwObktxqJSGj1Pzl3SefGwg0/aExBrlHV6339HKdP7kW2oIR
         8g4MvEex4hLFtGTiiEEfPd7RvuCjTDIzUpSMMwWUr2B3njBsZCETevUn0GbLKqQCBHe7
         RDEP3o0QW/sq+NzfZx+f24wHILPdmLypeHY3K8MzUZniMG2/H33dAEOuXGx8Ppt4lCS8
         rWrQSZKFOKMme77Xzj6nFxzFParqPEqgF1UfUiFJ9VkUQYi+cVyKJKi+CpqsRe3w+I8U
         R2Jg==
X-Forwarded-Encrypted: i=1; AHgh+RqnRkho5/iBkJ6+LVv9aGJar4xqL8nEFYonYlSPmCWAG6UPdo0qW9FecfsDUb3IbJgheY8mPgnA1/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDu0bGQwQ6UYlhj2MNWblgJAszH0RMyCDu4cIIPpKsHIpup9j
	JYaYvPIjw/FDdpw3OLXYUFMuzaPDe2VDSRFpoEwvemiykDwDI+oaJj2H3yTYOrEtsHiDVl+kRnF
	tnjstyFpT+ZoeVpxn+YAlEQFuni4xZsajtynwoBQSJczemvEPE5H6B7nVxAg=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a8:b0:4aa:d5f:123e with SMTP id
 5614622812f47-4afadfb6a86mr19227238b6e.9.1786209576818; Sat, 08 Aug 2026
 10:19:36 -0700 (PDT)
Date: Sat, 08 Aug 2026 10:19:36 -0700
In-Reply-To: <6a6e88da.13bfb6d0.1ecdd5.0269.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a776528.01d0871a.3a0d52.0064.GAE@google.com>
Subject: Re: [syzbot] [i2c?] KASAN: slab-use-after-free Read in i2c_adapter_lock_bus
From: syzbot <syzbot+450abcfc7906fe1a1e16@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a7c7074b58d2 Merge tag 'fbdev-for-7.2-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0bfb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65b94396067a4182
dashboard link: https://syzkaller.appspot.com/bug?extid=450abcfc7906fe1a1e16
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ce6132580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+450abcfc7906fe1a1e16@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in i2c_adapter_depth drivers/i2c/i2c-core-base.c:1243 [inline]
BUG: KASAN: slab-use-after-free in i2c_adapter_lock_bus+0x5e/0xf0 drivers/i2c/i2c-core-base.c:849
Read of size 8 at addr ffff888029a0d108 by task syz-executor130/5941

CPU: 0 UID: 0 PID: 5941 Comm: syz-executor130 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
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
 i2cdev_ioctl_rdwr+0x460/0x740 drivers/i2c/i2c-dev.c:306
 i2cdev_ioctl+0x6a5/0x880 drivers/i2c/i2c-dev.c:467
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3d34dcf35b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffdd493db60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3d34dcf35b
RDX: 00007ffdd493dbe0 RSI: 0000000000000707 RDI: 0000000000000004
RBP: 0000555578ce89c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffdd493db80 R11: 0000000000000246 R12: 0000000000001736
R13: 0000555578ce89e0 R14: 00007f3d34e51c80 R15: 0000000000000002
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

Freed by task 5941:
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
 __queue_work+0xcd8/0x1090 kernel/workqueue.c:2401
 queue_work_on+0x106/0x1c0 kernel/workqueue.c:2452
 queue_work include/linux/workqueue.h:699 [inline]
 rpm_idle+0x511/0x980 drivers/base/power/runtime.c:537
 rpm_suspend+0x126f/0x17b0 drivers/base/power/runtime.c:729
 __pm_runtime_idle+0x12f/0x1a0 drivers/base/power/runtime.c:1129
 pm_runtime_put_sync include/linux/pm_runtime.h:679 [inline]
 __device_release_driver drivers/base/dd.c:1347 [inline]
 device_release_driver_internal+0x3cf/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3961
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2345
 usb_remove_hcd+0x275/0x670 drivers/usb/core/hcd.c:3059
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

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xcd8/0x1090 kernel/workqueue.c:2401
 queue_work_on+0x106/0x1c0 kernel/workqueue.c:2452
 queue_work include/linux/workqueue.h:699 [inline]
 rpm_idle+0x511/0x980 drivers/base/power/runtime.c:537
 __pm_runtime_idle drivers/base/power/runtime.c:1129 [inline]
 pm_request_idle include/linux/pm_runtime.h:447 [inline]
 __pm_runtime_set_status+0x646/0xa60 drivers/base/power/runtime.c:1399
 pm_runtime_set_suspended include/linux/pm_runtime.h:768 [inline]
 pm_runtime_reinit drivers/base/power/runtime.c:1875 [inline]
 pm_runtime_remove+0xb4/0x1f0 drivers/base/power/runtime.c:1899
 device_pm_remove+0x1bc/0x310 drivers/base/power/main.c:179
 device_del+0x52c/0x8f0 drivers/base/core.c:3962
 usb_disconnect+0x630/0x9a0 drivers/usb/core/hub.c:2376
 hub_disconnect_children drivers/usb/core/hub.c:2294 [inline]
 usb_disconnect+0x2b6/0x9a0 drivers/usb/core/hub.c:2338
 usb_remove_hcd+0x275/0x670 drivers/usb/core/hcd.c:3059
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

The buggy address belongs to the object at ffff888029a0d000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 264 bytes inside of
 freed 2048-byte region [ffff888029a0d000, ffff888029a0d800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888029a0b000 pfn:0x29a08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88813fe40000 ffffea0001e4f610 ffffea0001db2c10
raw: ffff888029a0b000 0000000800080006 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88813fe40000 ffffea0001e4f610 ffffea0001db2c10
head: ffff888029a0b000 0000000800080006 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 136, tgid 136 (kworker/u8:5), ts 10281980212, free_ts 0
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
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x485/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 scsi_alloc_target+0x138/0xbd0 drivers/scsi/scsi_scan.c:505
 __scsi_scan_target+0x164/0xe10 drivers/scsi/scsi_scan.c:1780
 scsi_scan_channel drivers/scsi/scsi_scan.c:1885 [inline]
 scsi_scan_host_selected+0x3d3/0x7a0 drivers/scsi/scsi_scan.c:1914
 do_scsi_scan_host drivers/scsi/scsi_scan.c:2047 [inline]
 do_scan_async+0x10e/0x660 drivers/scsi/scsi_scan.c:2057
 async_run_entry_fn+0x9d/0x430 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0x92d/0xe10 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888029a0d000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029a0d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029a0d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888029a0d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029a0d200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
