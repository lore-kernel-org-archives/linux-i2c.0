Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC93594A
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432586; cv=none; b=tKlv1//vT/GpCZclhL31qDHza1gqeFmf0zxGomJgVf8aER1HrNlYM8XX3BVfFMsQS/5mv9RcAdOSDffgQ8RtogKZ8slxYoOqIi+WYNb8gW3KVzHW2hhlKSxNJ2BLBrAn9Md6DpZs0r1OPSXb8GwNRarCpeq7PIf4LxpnSd4J7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432586; c=relaxed/simple;
	bh=Abwyt8M9cQBIvpRjZslcVRG5ZlnzjoHnI7GfZ4Fgor0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pj8Q03adzd42jSE5ifUCTCHEKZoLI9wR44nSbLihM6byK8jyUCvvbiMCcCoNilR/sq2ougMn81/Kh3baSlyUQebVAH5El/M9RWle/KN9F/ihhjjAt+G9b0S8YF6MkoJbKxwYkpAMhDJsQLoVf+h0fRnAnObmfVWWytTrkh7NcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab260600easo5938678b6e.1
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787432583; x=1788037383;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n9w90V092WbqWJ/rWnf+d44UX4ovKOcEJ90i2PmRphA=;
        b=PAziIAr5keL+9TzyXLvJOdP0+pNLmCUZxaU4psZNp684LbWhBoG9oFf3oaeo0M1Nc4
         Ie9U3zhd6E2OsgX6+noGrTSmqD1sY3I0pJ1S42D593HLGZ7Jrh/XlZTw7oDT3cSZzcgP
         RilHGuVJ1Tmy4O1bs3OJgtzm9f6yxA42MPiXSQXLtlEvxoM4zGQ+Zm0Ll2wn3QuHvwK9
         Cy7HZA6TGxh5LBUadjLVRVwdAUWYTl9e6gJIio7ZkZ321O9bHV0fNq860HO4eTsVXP22
         T3VdGUGCWp90WmMNZMkHktvpH+pCe5+ToUsU16b2XTMngkHvGPCn6GHqjutvhGsAGPO9
         GQPg==
X-Forwarded-Encrypted: i=1; AHgh+RrL9+7vYIiGCZlwzufuEdGqQEkq+yFazrHuMfdnLWFaUwlemEGK9P2QIrw7uFiLIwN7MwNqm7W8FS0=@vger.kernel.org
X-Gm-Message-State: AFuF++mQCzwORqWuWh5iO5dUwfvtnPU+p9a+yA+rHNKkL18Qe9dEIiXL
	IseNP0QCmxDjq3Myy6tItVmUnCXg6PGYJQYuBVXb0DLvAH+c4RBzw6xScDgIRyArncoaQTW0r8D
	1rg9M0oWn9SpnACY39jFKcb1t9AF+Bh4RYtw1Yy1gJGvs8kGoZTY8gcOB0GI=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1f2:b0:4b2:6691:b019 with SMTP id
 5614622812f47-4b2cdabca39mr23199116b6e.3.1787432582996; Sat, 22 Aug 2026
 14:03:02 -0700 (PDT)
Date: Sat, 22 Aug 2026 14:03:02 -0700
In-Reply-To: <CALp66yHBUOH6R55KXP9kS4-XYZiOF6xb3CC6jcVjiUJ5mGQCKg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8a0e86.91706f20.16b6e3.02ba.GAE@google.com>
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

dvb-usb: bulk message failed: -22 (6/0)
dvb-usb: bulk message failed: -22 (5/0)
ucsi_ccg 1-0008: ucsi_ccg_init failed - -110
==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
Read of size 1 at addr ffff88803699f270 by task syz.4.58/6822

CPU: 0 UID: 0 PID: 6822 Comm: syz.4.58 Not tainted syzkaller #0 PREEMPT(full) 
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
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0x132/0x370 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
 spin_lock include/linux/spinlock.h:342 [inline]
 lockref_get+0x15/0x50 lib/lockref.c:50
 dget include/linux/dcache.h:364 [inline]
 __simple_recursive_removal+0x3d/0x5c0 fs/libfs.c:601
 debugfs_remove+0x5d/0x80 fs/debugfs/inode.c:781
 i2c_device_probe+0x6e2/0xd10 drivers/i2c/i2c-core-base.c:610
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
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe00579de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe006690028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe005a25fa0 RCX: 00007fe00579de99
RDX: 000000000000000f RSI: 0000200000000700 RDI: 0000000000000004
RBP: 00007fe005833eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe005a26038 R14: 00007fe005a25fa0 R15: 00007fffd311f6c8
 </TASK>

Allocated by task 6822:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4612 [inline]
 slab_alloc_node mm/slub.c:4945 [inline]
 kmem_cache_alloc_lru_noprof+0x267/0x6a0 mm/slub.c:4978
 __d_alloc+0x35/0xa50 fs/dcache.c:1902
 d_alloc+0x4a/0x1e0 fs/dcache.c:1981
 lookup_one_qstr_excl+0x171/0x250 fs/namei.c:1806
 __start_dirop fs/namei.c:2920 [inline]
 start_dirop+0x59/0xb0 fs/namei.c:2942
 simple_start_creating+0xf9/0x110 fs/libfs.c:2305
 debugfs_start_creating.part.0+0x82/0x170 fs/debugfs/inode.c:394
 debugfs_start_creating fs/debugfs/inode.c:371 [inline]
 debugfs_create_dir+0x72/0x440 fs/debugfs/inode.c:572
 i2c_device_probe+0x5f5/0xd10 drivers/i2c/i2c-core-base.c:588
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
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 slab_free mm/slub.c:6405 [inline]
 kmem_cache_free+0x127/0x6b0 mm/slub.c:6532
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3159
 dentry_free+0x145/0x2b0 fs/dcache.c:450
 dentry_kill+0x5e8/0xc20 fs/dcache.c:845
 finish_dput fs/dcache.c:1001 [inline]
 dput.part.0+0xd7/0x240 fs/dcache.c:1042
 dput+0x1f/0x30 fs/dcache.c:1037
 find_next_child+0x18f/0x280 fs/libfs.c:592
 __simple_recursive_removal+0x2ab/0x5c0 fs/libfs.c:609
 debugfs_remove+0x5d/0x80 fs/debugfs/inode.c:781
 i2c_del_adapter+0x17f/0x2d0 drivers/i2c/i2c-core-base.c:1829
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
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1c4f/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88803699f1a0
 which belongs to the cache dentry of size 312
The buggy address is located 208 bytes inside of
 freed 312-byte region [ffff88803699f1a0, ffff88803699f2d8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3699e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807ab3d501
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801d2dc140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800150015 00000000f5000000 ffff88807ab3d501
head: 00fff00000000040 ffff88801d2dc140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800150015 00000000f5000000 ffff88807ab3d501
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4985, tgid 4985 (udevd), ts 39556920182, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3294 [inline]
 allocate_slab mm/slub.c:3408 [inline]
 new_slab+0xa2/0x650 mm/slub.c:3454
 refill_objects+0xe3/0x410 mm/slub.c:7338
 refill_sheaf mm/slub.c:2832 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4703
 alloc_from_pcs mm/slub.c:4801 [inline]
 slab_alloc_node mm/slub.c:4933 [inline]
 kmem_cache_alloc_lru_noprof+0x46a/0x6a0 mm/slub.c:4978
 __d_alloc+0x35/0xa50 fs/dcache.c:1902
 d_alloc+0x4a/0x1e0 fs/dcache.c:1981
 lookup_one_qstr_excl+0x171/0x250 fs/namei.c:1806
 __start_renaming+0x1c9/0x520 fs/namei.c:3888
 filename_renameat2+0x538/0xa60 fs/namei.c:6167
 __do_sys_rename fs/namei.c:6236 [inline]
 __se_sys_rename fs/namei.c:6232 [inline]
 __x64_sys_rename+0x81/0xb0 fs/namei.c:6232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803699f100: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88803699f180: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
>ffff88803699f200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88803699f280: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
 ffff88803699f300: fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         48a5a7ab Merge tag 'v7.2-rc4-smb3-client-fixes' of git..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=108ef179580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
