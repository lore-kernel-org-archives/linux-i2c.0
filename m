From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH] i2c: immediately mark ourselves as registered
Date: Tue, 15 Mar 2016 00:26:09 +0100
Message-ID: <87h9g8ej5a.fsf@gmail.com>
References: <1457949206-7226-1-git-send-email-wsa@the-dreams.de>
	<20160314141903.GB5699@sudip-laptop> <20160314145850.GA15426@katana>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35857 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbcCNX0O (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 19:26:14 -0400
In-Reply-To: <20160314145850.GA15426@katana> (Wolfram Sang's message of "Mon,
	14 Mar 2016 15:58:51 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

Hi,

Wolfram Sang <wsa@the-dreams.de> writes:

>> @@ -2128,6 +2130,7 @@ class_err:
>>  bus_err:
>>  #endif
>>  	bus_unregister(&i2c_bus_type);
>> +	is_registered = false;
>
> Right. Fixed up locally, above the bus_unregister though. Thanks!

FYI, I don't know what the original issue was, but this patch fixes a
boot failure in linux-next-20160314 for me (see below).

Feel free to add a

  Tested-by: Nicolai Stange <nicstange@gmail.com>


  [    0.881976] ------------[ cut here ]------------
  [    0.886594] WARNING: CPU: 0 PID: 1 at /mnt/scratch/nic/linux-next/drivers/i2c/i2c-core.c:1930 i2c_register_driver+0xc3/0xd0
  [    0.897700] Modules linked in:
  [    0.900759] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc7-next-20160314 #1
  [    0.908141] Hardware name: Dell Inc. Latitude E6540/0725FP, BIOS A10 06/26/2014
  [    0.915434]  0000000000000297 00000000fa6aaf84 ffff880225357da0 ffffffff814cf126
  [    0.922852]  0000000000000000 0000000000000000 ffffffff81caf3b8 ffffffff817c7863
  [    0.930275]  ffff880225357de0 ffffffff810c2a2a 0000078a24bbb100 ffffffff81caf3b8
  [    0.937690] Call Trace:
  [    0.940130]  [<ffffffff814cf126>] dump_stack+0x83/0xbd
  [    0.945261]  [<ffffffff817c7863>] ? i2c_register_driver+0xc3/0xd0
  [    0.951341]  [<ffffffff810c2a2a>] __warn+0x11a/0x140
  [    0.956295]  [<ffffffff81fce689>] ? trace_event_define_fields_smbus_reply+0xba/0xba
  [    0.963936]  [<ffffffff810c2bc1>] warn_slowpath_null+0x31/0x40
  [    0.969757]  [<ffffffff817c7863>] i2c_register_driver+0xc3/0xd0
  [    0.975667]  [<ffffffff81fce70a>] i2c_init+0x81/0xc8
  [    0.980621]  [<ffffffff81002173>] do_one_initcall+0xe3/0x250
  [    0.986271]  [<ffffffff81f609a6>] ? set_debug_rodata+0x1f/0x1f
  [    0.992094]  [<ffffffff81f61441>] kernel_init_freeable+0x1bc/0x27b
  [    0.998264]  [<ffffffff819e1a98>] kernel_init+0x18/0x170
  [    1.003571]  [<ffffffff810f8b7f>] ? schedule_tail+0xf/0x60
  [    1.009050]  [<ffffffff819f1a82>] ret_from_fork+0x22/0x40
  [    1.014435]  [<ffffffff819e1a80>] ? rest_init+0x80/0x80
  [    1.019652] ---[ end trace f90677dafc216081 ]---
  
  ... Many more i2c failers here
  
  [    7.498788] BUG: unable to handle kernel paging request at ffffffffffffffd8
  [    7.498791] IP: [<ffffffff810eb8fb>] kthread_data+0x1b/0x20
  [    7.498796] PGD 1e09067 PUD 1e0b067 PMD 0 
  [    7.498797] Oops: 0000 [#2] SMP 
  [    7.498808] Modules linked in: amdkfd(+) amd_iommu_v2 radeon(+) i915(+) 8021q garp stp llc mrp e1000e i2c_algo_bit ttm crc32c_intel ptp drm_kms_helper serio_raw sdhci_pci sdhci_acpi pps_core sdhci mmc_core drm video fjes
  [    7.498810] CPU: 3 PID: 147 Comm: kworker/u16:5 Tainted: G      D W       4.5.0-rc7-next-20160314 #1
  [    7.498811] Hardware name: Dell Inc. Latitude E6540/0725FP, BIOS A10 06/26/2014
  [    7.498821] task: ffff88021ce75880 ti: ffff88021cfc4000 task.ti: ffff88021cfc4000
  [    7.498824] RIP: 0010:[<ffffffff810eb8fb>]  [<ffffffff810eb8fb>] kthread_data+0x1b/0x20
  [    7.498825] RSP: 0018:ffff88021cfc7718  EFLAGS: 00010097
  [    7.498828] RAX: 0000000000000000 RBX: ffff88021ce75880 RCX: 0000000000000003
  [    7.498830] RDX: 0000000000000000 RSI: ffff88021ce75900 RDI: ffff88021ce75880
  [    7.498831] RBP: ffff88021cfc7728 R08: ffff88021ce75928 R09: 0000000000003c00
  [    7.498832] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88021ce75e38
  [    7.498833] R13: ffff88021ce75880 R14: ffff88022ead7f00 R15: 0000000000017f00
  [    7.498835] FS:  0000000000000000(0000) GS:ffff88022eac0000(0000) knlGS:0000000000000000
  [    7.498836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    7.498839] CR2: 0000000000000028 CR3: 0000000001e06000 CR4: 00000000001406e0
  [    7.498839] Stack:
  [    7.498842]  ffffffff810e5cda ffff88022ead7f00 ffff88021cfc7778 ffffffff819ecf77
  [    7.498844]  00ffffff81661c09 ffff88021ce75d18 ffff88021ce75880 ffff88021cfc8000
  [    7.498849]  0000000000000000 ffff88021cfc7318 ffff88021cfc7318 0000000000000097
  [    7.498850] Call Trace:
  [    7.498853]  [<ffffffff810e5cda>] ? wq_worker_sleeping+0x1a/0xd0
  [    7.498855]  [<ffffffff819ecf77>] __schedule+0x647/0xa10
  [    7.498857]  [<ffffffff819ed375>] schedule+0x35/0x80
  [    7.498860]  [<ffffffff810c7ed2>] do_exit+0xaa2/0xea0
  [    7.498866]  [<ffffffff8103e9bc>] oops_end+0x9c/0xd0
  [    7.498869]  [<ffffffff8107d09d>] no_context+0x17d/0x450
  [    7.498872]  [<ffffffff8129632e>] ? page_poisoning_enabled+0xe/0x20
  [    7.498876]  [<ffffffff8107d428>] __bad_area_nosemaphore+0xb8/0x290
  [    7.498878]  [<ffffffff8107d638>] bad_area_nosemaphore+0x38/0x50
  [    7.498881]  [<ffffffff8107db0f>] __do_page_fault+0xff/0x680
  [    7.498883]  [<ffffffff81103c37>] ? dequeue_entity+0x457/0xac0
  [    7.498886]  [<ffffffff8121d6d0>] ? __rmqueue+0xa0/0x600
  [    7.498888]  [<ffffffff8107e0d0>] do_page_fault+0x40/0xa0
  [    7.498893]  [<ffffffff819f3a28>] page_fault+0x28/0x30
  [    7.498896]  [<ffffffff817c7f50>] ? i2c_transfer+0x20/0xe0
  [    7.498898]  [<ffffffff817c7f4c>] ? i2c_transfer+0x1c/0xe0
  [    7.498909]  [<ffffffffa010cbd6>] drm_do_probe_ddc_edid+0xf6/0x1b0 [drm]
  [    7.498920]  [<ffffffffa0110793>] drm_get_edid+0x43/0x4d0 [drm]
  [    7.498945]  [<ffffffffa02c5ad4>] intel_crt_get_edid+0x24/0xb0 [i915]
  [    7.498971]  [<ffffffffa02c5cbc>] intel_crt_detect_ddc+0x4c/0x110 [i915]
  [    7.498995]  [<ffffffffa02c6020>] intel_crt_detect+0x2a0/0xd10 [i915]
  [    7.498998]  [<ffffffff81044e59>] ? sched_clock+0x9/0x10
  [    7.499001]  [<ffffffff810fcf99>] ? sched_clock_cpu+0x99/0xb0
  [    7.499004]  [<ffffffff81101d33>] ? update_curr+0xf3/0x180
  [    7.499009]  [<ffffffffa0070eac>] drm_helper_probe_single_connector_modes+0x45c/0x6f0 [drm_kms_helper]
  [    7.499013]  [<ffffffff810f8ae0>] ? wake_up_new_task+0x120/0x1b0
  [    7.499019]  [<ffffffffa00818e8>] drm_fb_helper_initial_config+0xc8/0x550 [drm_kms_helper]
  [    7.499021]  [<ffffffff81104347>] ? dequeue_task_fair+0xa7/0x960
  [    7.499047]  [<ffffffffa02c1834>] intel_fbdev_initial_config+0x24/0x40 [i915]
  [    7.499050]  [<ffffffff810eea5a>] async_run_entry_fn+0x6a/0x190
  [    7.499054]  [<ffffffff810e35ad>] process_one_work+0x1fd/0x570
  [    7.499057]  [<ffffffff810e3978>] worker_thread+0x58/0x5b0
  [    7.499060]  [<ffffffff810e3920>] ? process_one_work+0x570/0x570
  [    7.499063]  [<ffffffff810eb096>] kthread+0x106/0x130
  [    7.499067]  [<ffffffff819f1a82>] ret_from_fork+0x22/0x40
  [    7.499069]  [<ffffffff810eaf90>] ? kthread_worker_fn+0x1d0/0x1d0
  [    7.499099] Code: 90 00 e9 34 ff ff ff e8 54 6d fd ff 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 8e 4a 0a 00 48 8b 83 38 05 00 00 5b 5d <48> 8b 40 d8 c3 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb 48 83 ec 
  [    7.499102] RIP  [<ffffffff810eb8fb>] kthread_data+0x1b/0x20
  [    7.499103]  RSP <ffff88021cfc7718>
  [    7.499104] CR2: ffffffffffffffd8
  [    7.499105] ---[ end trace f90677dafc21608c ]---
  [    7.499106] Fixing recursive fault but reboot is needed!


Thanks,

Nicolai
