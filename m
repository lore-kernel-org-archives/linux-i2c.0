From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Regression: bd698d24b1b57: i2c: designware: Get selected speed mode
 sda-hold-time via ACPI
Date: Tue, 9 May 2017 15:07:20 +0100
Message-ID: <20170509140720.GA21122@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: chin.yew.tan@intel.com, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc: wsa@the-dreams.de, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Hi guys,

as a heads-up, with today mainline (commit 2868b2513aa7) I get the
following splat on AMD Seattle, reverting the $SUBJECT commit "solves"
the problem.

My I2C knowledge is a bit limited but I am not sure I understand why
we should be reading eg ss_hcnt/ss_lcnt depending on the dev->clk_freq
but then i2c_dw_init() _always_ requires those values to be set for
a given device. Again, I have no insights into I2C inner workings
so apologies for the silly assumption/question.

Please have a look into this, thanks.

Lorenzo

[    1.160597] ------------[ cut here ]------------
[    1.165207] WARNING: CPU: 0 PID: 1 at drivers/i2c/busses/i2c-designware-core.c:293 i2c_dw_clk_rate+0x20/0x30
[    1.175019] Modules linked in:
[    1.178065] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-11415-g98a1892 #17
[    1.185360] Hardware name: AMD Seattle/Seattle, BIOS 18:16:37 May  1 2017
[    1.192134] task: ffff8003ed8e0000 task.stack: ffff8003ed8e8000
[    1.198041] PC is at i2c_dw_clk_rate+0x20/0x30
[    1.202472] LR is at i2c_dw_init+0x104/0x3c0
[    1.206729] pc : [<ffff00000874bfc0>] lr : [<ffff00000874c8a4>] pstate: 60000045
[    1.214110] sp : ffff8003ed8ebb90
[    1.217412] x29: ffff8003ed8ebb90 x28: 0000000000000000 
[    1.222714] x27: ffff000008df5fd0 x26: ffff000008f1b000 
[    1.228014] x25: ffff000008d00454 x24: 000000000000012c 
[    1.233314] x23: 00000000000707ae x22: 000000000000012c 
[    1.238614] x21: ffff8003ed4c78b8 x20: 0000000000000000 
[    1.243915] x19: ffff8003ed4c7818 x18: 0000000000000000 
[    1.249214] x17: 00000000000017ff x16: 0000000000000003 
[    1.254515] x15: 0088000000000000 x14: 00000000452b2be8 
[    1.259815] x13: 0000000000000000 x12: 0000000000000018 
[    1.265114] x11: 0000000000000000 x10: 0101010101010101 
[    1.270415] x9 : 0000000000000000 x8 : ffff8003ed6e5900 
[    1.275714] x7 : 0000000000000000 x6 : 000000000000003f 
[    1.281014] x5 : 0000000000000008 x4 : 0000000000000000 
[    1.286314] x3 : ffff00000807806c x2 : 0000000000000000 
[    1.291613] x1 : 0000000000000000 x0 : ffff8003ed4c7818 
[    1.296915] ---[ end trace 11d80b7b3eea6126 ]---
[    1.301519] Call trace:
[    1.303953] Exception stack(0xffff8003ed8eb9c0 to 0xffff8003ed8ebaf0)
[    1.310381] b9c0: ffff8003ed4c7818 0001000000000000 ffff8003ed8ebb90 ffff00000874bfc0
[    1.318197] b9e0: ffff8003ed8eba40 ffff00000847468c 000000000000000f 0000000000000001
[    1.326013] ba00: ffff8003ef40dfc8 ffff8003ed6cc050 ffff000008f63000 ffff000008f63f66
[    1.333829] ba20: ffff8003ed8eba70 ffff00000845428c ffff8003ed595000 0000000000000000
[    1.341645] ba40: ffff8003ed8ebaa0 ffff000008481bd8 ffff8003ed8ebaa0 ffff00000845428c
[    1.349461] ba60: ffff8003ed4c7818 0000000000000000 0000000000000000 ffff00000807806c
[    1.357276] ba80: 0000000000000000 0000000000000008 000000000000003f 0000000000000000
[    1.365092] baa0: ffff8003ed6e5900 0000000000000000 0101010101010101 0000000000000000
[    1.372908] bac0: 0000000000000018 0000000000000000 00000000452b2be8 0088000000000000
[    1.380723] bae0: 0000000000000003 00000000000017ff
[    1.385588] [<ffff00000874bfc0>] i2c_dw_clk_rate+0x20/0x30
[    1.391061] [<ffff00000874cb98>] i2c_dw_probe+0x38/0x238
[    1.396360] [<ffff00000874d67c>] dw_i2c_plat_probe+0x2b4/0x558
[    1.402182] [<ffff0000085546c0>] platform_drv_probe+0x58/0xc0
[    1.407916] [<ffff000008552824>] driver_probe_device+0x21c/0x2c0
[    1.413909] [<ffff000008552974>] __driver_attach+0xac/0xb0
[    1.419382] [<ffff00000855099c>] bus_for_each_dev+0x64/0xa0
[    1.424941] [<ffff000008552138>] driver_attach+0x20/0x28
[    1.430241] [<ffff000008551c88>] bus_add_driver+0x110/0x230
[    1.435800] [<ffff0000085532f8>] driver_register+0x60/0xf8
[    1.441272] [<ffff0000085545f8>] __platform_driver_register+0x40/0x48
[    1.447702] [<ffff000008d44b98>] dw_i2c_init_driver+0x18/0x20
[    1.453437] [<ffff0000080830f8>] do_one_initcall+0x38/0x120
[    1.458997] [<ffff000008d00cf0>] kernel_init_freeable+0x198/0x238
[    1.465078] [<ffff000008906f38>] kernel_init+0x10/0x100
[    1.470289] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
[    1.475601] Call trace:
[    1.478035] Exception stack(0xffff8003ed8eb9c0 to 0xffff8003ed8ebaf0)
[    1.484462] b9c0: ffff8003ed4c7818 0001000000000000 ffff8003ed8ebb90 ffff00000874bfc0
[    1.492278] b9e0: ffff8003ed8eba40 ffff00000847468c 000000000000000f 0000000000000001
[    1.500094] ba00: ffff8003ef40dfc8 ffff8003ed6cc050 ffff000008f63000 ffff000008f63f66
[    1.507910] ba20: ffff8003ed8eba70 ffff00000845428c ffff8003ed595000 0000000000000000
[    1.515725] ba40: ffff8003ed8ebaa0 ffff000008481bd8 ffff8003ed8ebaa0 ffff00000845428c
[    1.523541] ba60: ffff8003ed4c7818 0000000000000000 0000000000000000 ffff00000807806c
[    1.531357] ba80: 0000000000000000 0000000000000008 000000000000003f 0000000000000000
[    1.539173] baa0: ffff8003ed6e5900 0000000000000000 0101010101010101 0000000000000000
[    1.546988] bac0: 0000000000000018 0000000000000000 00000000452b2be8 0088000000000000
[    1.554804] bae0: 0000000000000003 00000000000017ff
[    1.559669] [<ffff00000874bfc0>] i2c_dw_clk_rate+0x20/0x30
[    1.565141] [<ffff00000874cb98>] i2c_dw_probe+0x38/0x238
[    1.570440] [<ffff00000874d67c>] dw_i2c_plat_probe+0x2b4/0x558
[    1.576260] [<ffff0000085546c0>] platform_drv_probe+0x58/0xc0
[    1.581993] [<ffff000008552824>] driver_probe_device+0x21c/0x2c0
[    1.587986] [<ffff000008552974>] __driver_attach+0xac/0xb0
[    1.593459] [<ffff00000855099c>] bus_for_each_dev+0x64/0xa0
[    1.599018] [<ffff000008552138>] driver_attach+0x20/0x28
[    1.604316] [<ffff000008551c88>] bus_add_driver+0x110/0x230
[    1.609875] [<ffff0000085532f8>] driver_register+0x60/0xf8
[    1.615348] [<ffff0000085545f8>] __platform_driver_register+0x40/0x48
[    1.621775] [<ffff000008d44b98>] dw_i2c_init_driver+0x18/0x20
[    1.627508] [<ffff0000080830f8>] do_one_initcall+0x38/0x120
[    1.633067] [<ffff000008d00cf0>] kernel_init_freeable+0x198/0x238
[    1.639147] [<ffff000008906f38>] kernel_init+0x10/0x100
[    1.644359] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
[    1.649913] Call trace:
[    1.652349] Exception stack(0xffff8003ed8eb9c0 to 0xffff8003ed8ebaf0)
[    1.658776] b9c0: ffff8003ed728018 0001000000000000 ffff8003ed8ebb90 ffff00000874bfc0
[    1.666593] b9e0: ffff7e000fb5b880 ffff8003ef403c80 ffff8003ed8ebb00 ffff0000081d7f1c
[    1.674409] ba00: ffff7e000fb5b880 ffff8003ed6e2f80 ffff8003ed8ebb20 ffff0000081d7f1c
[    1.682225] ba20: ffff7e000fb5b880 ffff8003ed6e2a00 ffff8003ed8e0000 000000000008d9c0
[    1.690041] ba40: ffff8003ef403c80 ffff8003ed8e0000 ffff000008476ee4 ffff000008f1b000
[    1.697857] ba60: ffff8003ed728018 0000000000000000 0000000000000000 ffff00000807a06c
[    1.705673] ba80: 0000000000000000 0000000000000008 000000000000003f 0000000000000000
[    1.713489] baa0: ffff8003ed6e5080 0000000000000000 0101010101010101 0000000000000000
[    1.721305] bac0: 0000000000000018 0000000000000000 000000006255f330 0088000000000000
[    1.729120] bae0: 0000000000000003 00000000000017ff
[    1.733985] [<ffff00000874bfc0>] i2c_dw_clk_rate+0x20/0x30
[    1.739458] [<ffff00000874cb98>] i2c_dw_probe+0x38/0x238
[    1.744757] [<ffff00000874d67c>] dw_i2c_plat_probe+0x2b4/0x558
[    1.750577] [<ffff0000085546c0>] platform_drv_probe+0x58/0xc0
[    1.756310] [<ffff000008552824>] driver_probe_device+0x21c/0x2c0
[    1.762303] [<ffff000008552974>] __driver_attach+0xac/0xb0
[    1.767775] [<ffff00000855099c>] bus_for_each_dev+0x64/0xa0
[    1.773334] [<ffff000008552138>] driver_attach+0x20/0x28
[    1.778633] [<ffff000008551c88>] bus_add_driver+0x110/0x230
[    1.784192] [<ffff0000085532f8>] driver_register+0x60/0xf8
[    1.789665] [<ffff0000085545f8>] __platform_driver_register+0x40/0x48
[    1.796092] [<ffff000008d44b98>] dw_i2c_init_driver+0x18/0x20
[    1.801825] [<ffff0000080830f8>] do_one_initcall+0x38/0x120
[    1.807384] [<ffff000008d00cf0>] kernel_init_freeable+0x198/0x238
[    1.813463] [<ffff000008906f38>] kernel_init+0x10/0x100
[    1.818675] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
[    1.823986] Call trace:
[    1.826420] Exception stack(0xffff8003ed8eb9c0 to 0xffff8003ed8ebaf0)
[    1.832848] b9c0: ffff8003ed728018 0001000000000000 ffff8003ed8ebb90 ffff00000874bfc0
[    1.840664] b9e0: ffff7e000fb5b880 ffff8003ef403c80 ffff8003ed8ebb00 ffff0000081d7f1c
[    1.848480] ba00: ffff7e000fb5b880 ffff8003ed6e2f80 ffff8003ed8ebb20 ffff0000081d7f1c
[    1.856295] ba20: ffff7e000fb5b880 ffff8003ed6e2a00 ffff8003ed8e0000 000000000008d9c0
[    1.864111] ba40: ffff8003ef403c80 ffff8003ed8e0000 ffff000008476ee4 ffff000008f1b000
[    1.871927] ba60: ffff8003ed728018 0000000000000000 0000000000000000 ffff00000807a06c
[    1.879743] ba80: 0000000000000000 0000000000000008 000000000000003f 0000000000000000
[    1.887559] baa0: ffff8003ed6e5080 0000000000000000 0101010101010101 0000000000000000
[    1.895374] bac0: 0000000000000018 0000000000000000 000000006255f330 0088000000000000
[    1.903190] bae0: 0000000000000003 00000000000017ff
[    1.908055] [<ffff00000874bfc0>] i2c_dw_clk_rate+0x20/0x30
[    1.913527] [<ffff00000874cb98>] i2c_dw_probe+0x38/0x238
[    1.918826] [<ffff00000874d67c>] dw_i2c_plat_probe+0x2b4/0x558
[    1.924646] [<ffff0000085546c0>] platform_drv_probe+0x58/0xc0
[    1.930379] [<ffff000008552824>] driver_probe_device+0x21c/0x2c0
[    1.936372] [<ffff000008552974>] __driver_attach+0xac/0xb0
[    1.941844] [<ffff00000855099c>] bus_for_each_dev+0x64/0xa0
[    1.947403] [<ffff000008552138>] driver_attach+0x20/0x28
[    1.952702] [<ffff000008551c88>] bus_add_driver+0x110/0x230
[    1.958261] [<ffff0000085532f8>] driver_register+0x60/0xf8
[    1.963734] [<ffff0000085545f8>] __platform_driver_register+0x40/0x48
[    1.970161] [<ffff000008d44b98>] dw_i2c_init_driver+0x18/0x20
[    1.975894] [<ffff0000080830f8>] do_one_initcall+0x38/0x120
[    1.981453] [<ffff000008d00cf0>] kernel_init_freeable+0x198/0x238
[    1.987533] [<ffff000008906f38>] kernel_init+0x10/0x100
[    1.992745] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
