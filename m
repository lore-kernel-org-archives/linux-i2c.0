From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: i2c-pca-platform: Change i2c adapter name
Date: Mon, 18 Oct 2010 12:24:30 +0900
Message-ID: <1287372270-12163-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In kernel which enableded this driver output The following warning,
because a slash (/) is in the i2c adapter name by the current driver.
This set another adapter name (i2c-pca-platform at 0x) what removed slash.

[    2.872000] PCA9564/PCA9665 at 0x06000000: Registering gpio failed!
[    2.876000] name 'PCA9564/PCA9665 at 0x06000000'
[    2.880000] ------------[ cut here ]------------
[    2.880000] WARNING: at fs/proc/generic.c:323
[    2.880000] Modules linked in:
[    2.880000]
[    2.880000] Pid : 1, Comm:           swapper
[    2.880000] CPU : 0                  Not tainted  (2.6.36-rc1-00238-g67e5b3a #261)
[    2.880000]
[    2.880000] PC is at __xlate_proc_name+0x88/0xa4
[    2.880000] PR is at __xlate_proc_name+0x88/0xa4
[    2.880000] PC  : 800b3bc4 SP  : 9fc41d34 SR  : 40008001 TEA : c0018000
[    2.880000] R0  : 00000037 R1  : 9fc40000 R2  : 9fc40000 R3  : 8049db48
[    2.880000] R4  : 00000001 R5  : 000000f0 R6  : ffffffff R7  : 8019e450
[    2.880000] R8  : 00000000 R9  : 9fc41d9c R10 : 00000007 R11 : 9fc41d9c
[    2.880000] R12 : 9fc41d80 R13 : 80167fce R14 : 9fc41d34
[    2.880000] MACH: 00000461 MACL: 00000000 GBR : 00000000 PR  : 800b3bc4
[    2.880000]
[    2.880000] Call trace:
[    2.880000]  [<800b4056>] __proc_create+0x46/0x110
[    2.880000]  [<80162b00>] strlen+0x0/0x58
[    2.880000]  [<800b4824>] proc_mkdir_mode+0x24/0x60
[    2.880000]  [<800b486e>] proc_mkdir+0xe/0x1c
[    2.880000]  [<8004740a>] register_handler_proc+0x9e/0xd4
[    2.880000]  [<80045ab2>] __setup_irq+0x226/0x2c0
[    2.880000]  [<80075d50>] kmem_cache_alloc+0x94/0xf0
[    2.880000]  [<80045bcc>] request_threaded_irq+0x80/0xdc
[    2.880000]  [<802041c0>] i2c_pca_pf_handler+0x0/0x3c
[    2.880000]  [<802ecb62>] i2c_pca_pf_probe+0x162/0x294
[    2.880000]  [<801a3b38>] platform_drv_probe+0x14/0x1c
[    2.880000]  [<802e52fc>] klist_next+0x0/0x98
[    2.880000]  [<801a2be4>] driver_probe_device+0x70/0x10c
[    2.880000]  [<801a2cca>] __driver_attach+0x4a/0x78
[    2.880000]  [<801a2470>] bus_for_each_dev+0x3c/0x78
[    2.880000]  [<801a2c80>] __driver_attach+0x0/0x78
[    2.880000]  [<801a2a6a>] driver_attach+0x12/0x24
[    2.880000]  [<801a1e18>] bus_add_driver+0x88/0x1e4
[    2.880000]  [<801649fc>] kset_find_obj+0x60/0x7c
[    2.880000]  [<801a2f7c>] driver_register+0x70/0x110
[    2.880000]  [<8047ee24>] i2c_pca_pf_init+0x0/0x1c
[    2.880000]  [<801a3d62>] platform_driver_register+0x2e/0x4c
[    2.880000]  [<8047ee24>] i2c_pca_pf_init+0x0/0x1c
[    2.880000]  [<8047ee30>] i2c_pca_pf_init+0xc/0x1c
[    2.880000]  [<8000221a>] do_one_initcall+0x9a/0x15c
[    2.880000]  [<8046e24a>] kernel_init+0x7a/0x14c
[    2.880000]  [<80002180>] do_one_initcall+0x0/0x15c
[    2.880000]  [<800040a0>] kernel_thread_helper+0x8/0x14
[    2.880000]  [<8046e1d0>] kernel_init+0x0/0x14c
[    2.880000]  [<80004098>] kernel_thread_helper+0x0/0x14
[    2.880000]
[    2.880000] Code:
[    2.880000]   800b3bbe:  mov.l     800b3bdc <__xlate_proc_name+0xa0/0xa4>, r4  ! 803cb578 <__func_>
[    2.880000]   800b3bc0:  jsr       @r0
[    2.880000]   800b3bc2:  mov       r11, r5
[    2.880000] ->800b3bc4:  trapa     #62
[    2.880000]   800b3bc6:  bra       800b3ba6
[    2.880000]   800b3bc8:  mov       #-2, r0
[    2.880000]   800b3bca:  nop
[    2.880000]   800b3bcc:  bsr       800b4518
[    2.880000]   800b3bce:  mov.b     r0, @(4,r4)
[    2.880000]
[    2.880000] ---[ end trace 8decc8541dd0eb29 ]---
[    3.160000] PCA9564/PCA9665 at 0x06000000: PCA9564 detected.
[    3.168000] PCA9564/PCA9665 at 0x06000000: Choosing the clock frequency based on index is deprecat.
[    3.176000] PCA9564/PCA9665 at 0x06000000: No reset-pin found. Chip may get stuck!
3.184000] PCA9564/PCA9665 at 0x06000000: Clock frequency is 330kHz

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
CC: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pca-platform.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index ef5c784..4cc3cdf 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -27,6 +27,8 @@
 
 #include <asm/irq.h>
 
+#define DRIVER_NAME "i2c-pca-platform"
+
 struct i2c_pca_pf_data {
 	void __iomem			*reg_base;
 	int				irq;	/* if 0, use polling */
@@ -171,7 +173,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
 	i2c->adap.owner = THIS_MODULE;
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
-		 "PCA9564/PCA9665 at 0x%08lx",
+		 DRIVER_NAME " at 0x%08lx",
 		 (unsigned long) res->start);
 	i2c->adap.algo_data = &i2c->algo_data;
 	i2c->adap.dev.parent = &pdev->dev;
@@ -250,7 +252,7 @@ e_remap:
 e_alloc:
 	release_mem_region(res->start, resource_size(res));
 e_print:
-	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
+	printk(KERN_ERR "Registering " DRIVER_NAME " FAILED! (%d)\n", ret);
 	return ret;
 }
 
@@ -278,7 +280,7 @@ static struct platform_driver i2c_pca_pf_driver = {
 	.probe = i2c_pca_pf_probe,
 	.remove = __devexit_p(i2c_pca_pf_remove),
 	.driver = {
-		.name = "i2c-pca-platform",
+		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
 	},
 };
-- 
1.7.1
