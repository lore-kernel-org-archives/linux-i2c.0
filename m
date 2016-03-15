From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: linux-next: Tree for Mar 14
Date: Tue, 15 Mar 2016 09:30:29 +0900
Message-ID: <20160315003029.GA2126@swordfish>
References: <20160314174037.0097df55@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160314174037.0097df55@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-i2c@vger.kernel.org

On (03/14/16 17:40), Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20160311:
> 
> The vfs tree gained a conflict against Linus' tree. I also applied a
> patch for a known runtime bug.
> 
> The tip tree gained a conflict against the mips tree.
> 
> The aio tree still had a build failure so I removed several commits
> from it.  It also gained a conflict against the vfs tree.
> 
> Non-merge commits (relative to Linus' tree): 11202
>  8646 files changed, 426680 insertions(+), 211740 deletions(-)


Hello,

I'm seeing a bunch of warnings and errors

[    0.697413] ------------[ cut here ]------------
[    0.697484] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.c:1533 i2c_register_adapter+0x37/0x367
[    0.697560] Modules linked in:
[    0.697654] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.5.0-rc7-next-20160314-dbg-00015-gd1f304e-dirty #271
[    0.697817]  0000000000000000 ffff8801330cf9e8 ffffffff8124795a 0000000000000000
[    0.698029]  0000000000000000 ffff8801330cfa28 ffffffff810444e4 000005fd330cf8d8
[    0.698239]  ffff8800bf4b50a8 0000000000000000 00000000fffffff5 ffffffff81426c47
[    0.698449] Call Trace:
[    0.698505]  [<ffffffff8124795a>] dump_stack+0x67/0x90
[    0.698565]  [<ffffffff810444e4>] __warn+0xc2/0xdd
[    0.698623]  [<ffffffff81426c47>] ? i2c_register_adapter+0x367/0x367
[    0.698683]  [<ffffffff810445bb>] warn_slowpath_null+0x1d/0x1f
[    0.698743]  [<ffffffff81426917>] i2c_register_adapter+0x37/0x367
[    0.698803]  [<ffffffff81426c47>] ? i2c_register_adapter+0x367/0x367
[    0.698863]  [<ffffffff81426ca7>] i2c_add_adapter+0x60/0x65
[    0.698922]  [<ffffffff814279e2>] __i2c_bit_add_bus+0x294/0x2f3
[    0.698981]  [<ffffffff81427a56>] i2c_bit_add_bus+0x15/0x17
[    0.699041]  [<ffffffff8136e5c3>] nvkm_i2c_bus_ctor+0x1bb/0x1dd
[    0.699100]  [<ffffffff8136eb1b>] nv50_i2c_bus_new+0xa6/0xd0
[    0.699160]  [<ffffffff8136d0c7>] nvkm_i2c_new_+0x220/0x57c
[    0.699219]  [<ffffffff8136bee1>] ? nvkm_gpio_new_+0x7b/0x86
[    0.699278]  [<ffffffff8136d639>] g94_i2c_new+0x1d/0x1f
[    0.699337]  [<ffffffff81382e24>] nvkm_device_ctor+0x100e/0x2211
[    0.699397]  [<ffffffff813846d4>] nvkm_device_pci_new+0x18c/0x19f
[    0.699457]  [<ffffffff813be1b6>] nouveau_drm_probe+0x194/0x1d7
[    0.699517]  [<ffffffff81271da3>] pci_device_probe+0x85/0xee
[    0.699578]  [<ffffffff813ed1c8>] driver_probe_device+0x118/0x261
[    0.699638]  [<ffffffff813ed384>] __driver_attach+0x73/0x95
[    0.699697]  [<ffffffff813ed311>] ? driver_probe_device+0x261/0x261
[    0.699757]  [<ffffffff813eb769>] bus_for_each_dev+0x6f/0x87
[    0.699815]  [<ffffffff813ecc69>] driver_attach+0x1e/0x20
[    0.699874]  [<ffffffff813ec839>] bus_add_driver+0xf2/0x1e4
[    0.699932]  [<ffffffff813edfaa>] driver_register+0x8a/0xc6
[    0.699991]  [<ffffffff81270e8d>] __pci_register_driver+0x60/0x63
[    0.700052]  [<ffffffff81316e58>] drm_pci_init+0x50/0xd1
[    0.700110]  [<ffffffff81b3c83d>] ? ttm_init+0x60/0x60
[    0.700168]  [<ffffffff81b3ca31>] nouveau_drm_init+0x1f4/0x1f6
[    0.700229]  [<ffffffff81000402>] do_one_initcall+0xe7/0x16c
[    0.700290]  [<ffffffff81b07fc1>] kernel_init_freeable+0x118/0x19e
[    0.700351]  [<ffffffff8151f56d>] kernel_init+0xe/0xf0
[    0.700409]  [<ffffffff81525942>] ret_from_fork+0x22/0x40
[    0.700513]  [<ffffffff8151f55f>] ? rest_init+0x136/0x136
[    0.700581] ---[ end trace e54473700ba2f16a ]---
[    0.700643] ------------[ cut here ]------------
[    0.700701] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.c:1533 i2c_register_adapter+0x37/0x367
[    0.700777] Modules linked in:
[    0.700869] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.5.0-rc7-next-20160314-dbg-00015-gd1f304e-dirty #271
[    0.701031]  0000000000000000 ffff8801330cf9e8 ffffffff8124795a 0000000000000000
[    0.701243]  0000000000000000 ffff8801330cfa28 ffffffff810444e4 000005fd330cfa78
[    0.701455]  ffff8800bf4b58a8 0000000000000000 00000000fffffff5 ffffffff81426c47
[    0.701667] Call Trace:
[    0.701721]  [<ffffffff8124795a>] dump_stack+0x67/0x90
[    0.701779]  [<ffffffff810444e4>] __warn+0xc2/0xdd
[    0.701837]  [<ffffffff81426c47>] ? i2c_register_adapter+0x367/0x367
[    0.701897]  [<ffffffff810445bb>] warn_slowpath_null+0x1d/0x1f
[    0.701956]  [<ffffffff81426917>] i2c_register_adapter+0x37/0x367
[    0.705165]  [<ffffffff81426c47>] ? i2c_register_adapter+0x367/0x367
[    0.705225]  [<ffffffff81426ca7>] i2c_add_adapter+0x60/0x65
[    0.705284]  [<ffffffff814279e2>] __i2c_bit_add_bus+0x294/0x2f3
[    0.705343]  [<ffffffff81427a56>] i2c_bit_add_bus+0x15/0x17
[    0.705402]  [<ffffffff8136e5c3>] nvkm_i2c_bus_ctor+0x1bb/0x1dd
[    0.705461]  [<ffffffff8136eb1b>] nv50_i2c_bus_new+0xa6/0xd0
[    0.705520]  [<ffffffff8136d0c7>] nvkm_i2c_new_+0x220/0x57c
[    0.705580]  [<ffffffff8136bee1>] ? nvkm_gpio_new_+0x7b/0x86
[    0.705639]  [<ffffffff8136d639>] g94_i2c_new+0x1d/0x1f
[    0.705698]  [<ffffffff81382e24>] nvkm_device_ctor+0x100e/0x2211
[    0.705757]  [<ffffffff813846d4>] nvkm_device_pci_new+0x18c/0x19f
[    0.705817]  [<ffffffff813be1b6>] nouveau_drm_probe+0x194/0x1d7
[    0.705876]  [<ffffffff81271da3>] pci_device_probe+0x85/0xee
[    0.705935]  [<ffffffff813ed1c8>] driver_probe_device+0x118/0x261
[    0.705995]  [<ffffffff813ed384>] __driver_attach+0x73/0x95
[    0.706053]  [<ffffffff813ed311>] ? driver_probe_device+0x261/0x261
[    0.706113]  [<ffffffff813eb769>] bus_for_each_dev+0x6f/0x87
[    0.706172]  [<ffffffff813ecc69>] driver_attach+0x1e/0x20
[    0.706230]  [<ffffffff813ec839>] bus_add_driver+0xf2/0x1e4
[    0.706289]  [<ffffffff813edfaa>] driver_register+0x8a/0xc6
[    0.706347]  [<ffffffff81270e8d>] __pci_register_driver+0x60/0x63
[    0.706407]  [<ffffffff81316e58>] drm_pci_init+0x50/0xd1
[    0.706486]  [<ffffffff81b3c83d>] ? ttm_init+0x60/0x60
[    0.706544]  [<ffffffff81b3ca31>] nouveau_drm_init+0x1f4/0x1f6
[    0.706603]  [<ffffffff81000402>] do_one_initcall+0xe7/0x16c
[    0.706663]  [<ffffffff81b07fc1>] kernel_init_freeable+0x118/0x19e
[    0.706722]  [<ffffffff8151f56d>] kernel_init+0xe/0xf0
[    0.706780]  [<ffffffff81525942>] ret_from_fork+0x22/0x40
[    0.706838]  [<ffffffff8151f55f>] ? rest_init+0x136/0x136
[    0.706906] ---[ end trace e54473700ba2f16b ]---


...

[   10.123423] ------------[ cut here ]------------
[   10.123443] Modules linked in: snd_hda_core(+) i2c_i801(+) r8169 coretemp hwmon crc32c_intel mii snd_pcm snd_timer snd lpc_ich soundcore acpi_cpufreq mfd_core processor sch_fq_codel hid_generic usbhid hid sd_mod ahci libahci ehci_pci libata ehci_hcd scsi_mod usbcore usb_common
[   10.123445] CPU: 3 PID: 189 Comm: systemd-udevd Tainted: G        W       4.5.0-rc7-next-20160314-dbg-00015-gd1f304e-dirty #271
[   10.123446] Hardware name: SAMSUNG ELECTRONICS CO.,LTD Samsung DeskTop System/Samsung DeskTop System, BIOS 05CC                   04/09/2010
[   10.123449]  0000000000000000 ffff8801325afa40 ffffffff8124795a 0000000000000000
[   10.123451]  0000000000000000 ffff8801325afa80 ffffffff810444e4 000005fd325afad0
[   10.123453]  ffff8800be5e4818 0000000000000000 00000000fffffff5 0000000000000000
[   10.123454] Call Trace:
[   10.123458]  [<ffffffff8124795a>] dump_stack+0x67/0x90
[   10.123461]  [<ffffffff810444e4>] __warn+0xc2/0xdd
[   10.123463]  [<ffffffff810445bb>] warn_slowpath_null+0x1d/0x1f
[   10.123464]  [<ffffffff81426917>] i2c_register_adapter+0x37/0x367
[   10.123466]  [<ffffffff81426ca7>] i2c_add_adapter+0x60/0x65
[   10.123468]  [<ffffffffa01ab77a>] i801_probe+0x406/0x4b5 [i2c_i801]
[   10.123471]  [<ffffffff81083a02>] ? trace_hardirqs_on+0xd/0xf
[   10.123475]  [<ffffffff813f71cf>] ? __pm_runtime_resume+0x76/0x83
[   10.123477]  [<ffffffff81271da3>] pci_device_probe+0x85/0xee
[   10.123480]  [<ffffffff813ed1c8>] driver_probe_device+0x118/0x261
[   10.123481]  [<ffffffff813ed384>] __driver_attach+0x73/0x95
[   10.123483]  [<ffffffff813ed311>] ? driver_probe_device+0x261/0x261
[   10.123485]  [<ffffffff813eb769>] bus_for_each_dev+0x6f/0x87
[   10.123486]  [<ffffffff813ecc69>] driver_attach+0x1e/0x20
[   10.123488]  [<ffffffff813ec839>] bus_add_driver+0xf2/0x1e4
[   10.123489]  [<ffffffffa0115000>] ? 0xffffffffa0115000
[   10.123491]  [<ffffffff813edfaa>] driver_register+0x8a/0xc6
[   10.123492]  [<ffffffffa0115000>] ? 0xffffffffa0115000
[   10.123493]  [<ffffffff81270e8d>] __pci_register_driver+0x60/0x63
[   10.123495]  [<ffffffffa01150a0>] i2c_i801_init+0xa0/0x1000 [i2c_i801]
[   10.123496]  [<ffffffffa0115000>] ? 0xffffffffa0115000
[   10.123497]  [<ffffffffa0115000>] ? 0xffffffffa0115000
[   10.123500]  [<ffffffff81000402>] do_one_initcall+0xe7/0x16c
[   10.123503]  [<ffffffff810f573e>] ? do_init_module+0x27/0x1d9
[   10.123506]  [<ffffffff81096465>] ? rcu_read_lock_sched_held+0x61/0x69
[   10.123508]  [<ffffffff8113decb>] ? kmem_cache_alloc_trace+0x158/0x1f8
[   10.123510]  [<ffffffff810f573e>] ? do_init_module+0x27/0x1d9
[   10.123512]  [<ffffffff810f5776>] do_init_module+0x5f/0x1d9
[   10.123514]  [<ffffffff810b6192>] load_module+0x19ff/0x1edd
[   10.123517]  [<ffffffff8112f1fe>] ? __vmalloc_node_range+0xda/0x1d4
[   10.123519]  [<ffffffff81085d59>] ? lock_acquire+0x12a/0x1be
[   10.123521]  [<ffffffff810b676f>] SyS_init_module+0xff/0x125
[   10.123522]  [<ffffffff810b676f>] ? SyS_init_module+0xff/0x125
[   10.123525]  [<ffffffff81525725>] entry_SYSCALL_64_fastpath+0x18/0xa8
[   10.123540] ---[ end trace e54473700ba2f177 ]---
[   10.123542] i801_smbus 0000:00:1f.3: Failed to add SMBus adapter


	-ss
