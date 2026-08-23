Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0D17A586
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787456884; cv=none; b=brquXEgmnKSLFqjCWkM7y2XK9gT444deqlDn6f2laPrjEuqYB3xIps+6SKH9SHs4ST05T4BpTGnXivw2WZ9sJMJWTjVaZN4Y+QjO6IEnDYb4MqxXjUrA3UrPj2AaHdP1e0ROfmrObouRv0Cm0SMYyQ+09o1aWc++HR2A9IH0vG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787456884; c=relaxed/simple;
	bh=NXLfVczSF0THdoq7iM0Ci07TC48GkeRAvAHT2viYbZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=twRLe2U81L0K8LStrrRnVrTsFoffaUlViyPTlmrpLWmDP+TXX2ByLn4Gy2HOCxDxFYLsYhEok+1uy0alf1xCaesGHsLQyq5C/zQSsjs1IZ2bC/M1Qc8/innUKJNvmGspj23qK7wz/TxTYQ+tvtuvJjzvjTqaw4QXnhmYX/NlmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b28dafb8e1so3814193b6e.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 20:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787456882; x=1788061682;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vxB8/h/OMyC49FYh6cmhpeIo7NijusgOgzkdbjqRgPU=;
        b=BZTTc4Am9YxvVsl/NMwDREWi8q3dMbDAdKcfQ854dVkC/PxKXbhBsHcVqKUWwQXva1
         xinwp/KSan7XzKFuSXfjY83p8lAB5N2p+NueszdV0wNmSXuodjUOuSBcomKQ9s9jWgOj
         YuLwzl9kXq34d+rnsfTdcNMh7PK7E5/CVwp1DnARjGfTamGlYPX8Z5S9Nm34LFsYMkwy
         SUGoxnGGIt85R6bF/3Hw88vhw8JfY7/umVMugF5qwKg0g76Atunus704+m8Cu1uDPIva
         AacMTl3UX7B/VDDfDnsXzVUgYDHToUkwb1lXKqLfmJuJpVxs2qh12NjHTgJ3ZYUwzYtB
         WfkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9UYjkswffMD4MxhIi+cXS6LCHSxXSLEpZxl+UbOCKA3OCp6zw2DiSfctOvg1M1PeUZMfRbhDAJW0=@vger.kernel.org
X-Gm-Message-State: AFuF++leQPvjnw82lLNOYIJSf0pzE1plLVDEigI3HpfAGjH/gusX897A
	/3wOqTxPr8d/gMt9JP3ituFE149pZV7BiFPSTNHMDMcqtx5O6xyg/fo0KZR/hKNO37d6T7NV5Vk
	Zt2apnokDN8CAc/Ej3dWJDP1zAvXnwUYKFJJFJuAdDBaXq7z8oH5w0WKGFy0=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a02:b0:4b1:9f12:e2f6 with SMTP id
 5614622812f47-4b2ef4cb7ddmr18086189b6e.19.1787456881952; Sat, 22 Aug 2026
 20:48:01 -0700 (PDT)
Date: Sat, 22 Aug 2026 20:48:01 -0700
In-Reply-To: <CALp66yEv4MUw_a_LFtStaEpg55_bei6pbbyPBzSeDCy_je3jnA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8a6d71.dbb3a75c.13dd47.0042.GAE@google.com>
Subject: Re: [syzbot] [fs?] [usb?] KASAN: slab-use-after-free Read in
 lockref_get (2)
From: syzbot <syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, hdanton@sina.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafad900@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in lockref_get

dvb-usb: bulk message failed: -22 (5/0)
ucsi_ccg 1-0008: ucsi_ccg_init failed - -110
==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
Read of size 1 at addr ffff88805cdc3cb8 by task syz.0.61/6625

CPU: 1 UID: 0 PID: 6625 Comm: syz.0.61 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __kasan_check_byte+0x36/0x50 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5860 [inline]
 lock_acquire+0x132/0x370 kernel/locking/lockdep.c:5843
 __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
 spin_lock include/linux/spinlock.h:347 [inline]
 lockref_get+0x15/0x50 lib/lockref.c:50
 dget include/linux/dcache.h:364 [inline]
 __simple_recursive_removal+0x3d/0x5c0 fs/libfs.c:601
 debugfs_remove+0x5d/0x80 fs/debugfs/inode.c:781
 i2c_device_probe+0x6e2/0xd10 drivers/i2c/i2c-core-base.c:611
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1020
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1308
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6dc559de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6dc649b028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6dc5825fa0 RCX: 00007f6dc559de99
RDX: 000000000000000f RSI: 0000200000000700 RDI: 0000000000000004
RBP: 00007f6dc5633eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6dc5826038 R14: 00007f6dc5825fa0 R15: 00007ffdbbd8b238
 </TASK>

Allocated by task 6625:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_lru_noprof+0x267/0x6a0 mm/slub.c:4950
 __d_alloc+0x35/0xa50 fs/dcache.c:1907
 d_alloc+0x4a/0x1e0 fs/dcache.c:1986
 lookup_one_qstr_excl+0x171/0x250 fs/namei.c:1806
 __start_dirop fs/namei.c:2920 [inline]
 start_dirop+0x59/0xb0 fs/namei.c:2942
 simple_start_creating+0xf9/0x110 fs/libfs.c:2308
 debugfs_start_creating.part.0+0x82/0x170 fs/debugfs/inode.c:394
 debugfs_start_creating fs/debugfs/inode.c:371 [inline]
 debugfs_create_dir+0x72/0x440 fs/debugfs/inode.c:572
 i2c_device_probe+0x5f5/0xd10 drivers/i2c/i2c-core-base.c:589
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1020
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1308
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kmem_cache_free+0x127/0x6b0 mm/slub.c:6504
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10e0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 run_ksoftirqd kernel/softirq.c:1108 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1100
 smpboot_thread_fn+0x3d3/0xab0 kernel/smpboot.c:160
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3159
 dentry_free+0x152/0x2c0 fs/dcache.c:450
 dentry_kill+0x5e8/0xc20 fs/dcache.c:845
 finish_dput fs/dcache.c:1001 [inline]
 dput.part.0+0xd7/0x240 fs/dcache.c:1042
 dput+0x1f/0x30 fs/dcache.c:1037
 find_next_child+0x18f/0x280 fs/libfs.c:592
 __simple_recursive_removal+0x2ab/0x5c0 fs/libfs.c:609
 debugfs_remove+0x5d/0x80 fs/debugfs/inode.c:781
 i2c_del_adapter+0x17f/0x2d0 drivers/i2c/i2c-core-base.c:1830
 dvb_usb_i2c_exit+0x9f/0xf0 drivers/media/usb/dvb-usb/dvb-usb-i2c.c:46
 dvb_usb_exit drivers/media/usb/dvb-usb/dvb-usb-init.c:144 [inline]
 dvb_usb_device_exit+0x313/0x520 drivers/media/usb/dvb-usb/dvb-usb-init.c:338
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:610
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1478
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5415 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x1bb1/0x4420 drivers/usb/core/hub.c:5961
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88805cdc3be8
 which belongs to the cache dentry of size 312
The buggy address is located 208 bytes inside of
 freed 312-byte region [ffff88805cdc3be8, ffff88805cdc3d20)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88805cdc3318 pfn:0x5cdc2
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88805cdc3ed9
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801da9b140 ffffea0001676490 ffffea0001736990
raw: ffff88805cdc3318 0000000800150013 00000000f5000000 ffff88805cdc3ed9
head: 00fff00000000240 ffff88801da9b140 ffffea0001676490 ffffea0001736990
head: ffff88805cdc3318 0000000800150013 00000000f5000000 ffff88805cdc3ed9
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6132, tgid 6132 (syz-executor), ts 121956208589, free_ts 78469627650
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf46/0x3500 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x660 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x372/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 kmem_cache_alloc_lru_noprof+0x46a/0x6a0 mm/slub.c:4950
 __d_alloc+0x35/0xa50 fs/dcache.c:1907
 d_alloc_pseudo+0x1c/0xc0 fs/dcache.c:2038
 alloc_path_pseudo fs/file_table.c:407 [inline]
 alloc_file_pseudo+0x118/0x290 fs/file_table.c:423
 sock_alloc_file+0x50/0x210 net/socket.c:557
 sock_map_fd net/socket.c:587 [inline]
 __sys_socket+0x1c0/0x260 net/socket.c:1827
 __do_sys_socket net/socket.c:1832 [inline]
 __se_sys_socket net/socket.c:1830 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1830
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5665 tgid 5665 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x586/0xd80 mm/page_alloc.c:1451
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:6897
 __free_contig_range mm/page_alloc.c:6942 [inline]
 free_pages_bulk+0xbd/0x200 mm/page_alloc.c:5257
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3461
 vfree mm/vmalloc.c:3510 [inline]
 vfree+0x108/0x730 mm/vmalloc.c:3484
 kcov_put kernel/kcov.c:447 [inline]
 kcov_put kernel/kcov.c:443 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:554
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1009
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1152
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3046
 arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x139/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805cdc3b80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fa fb fb
 ffff88805cdc3c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805cdc3c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88805cdc3d00: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
 ffff88805cdc3d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         abea5c34 Merge tag 'i2c-7.3-part1' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=15115549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17c15623c4feca72
dashboard link: https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
