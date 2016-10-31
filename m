From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH] i2c: core: fix NULL pointer dereference under race condition
Date: Mon, 31 Oct 2016 21:46:24 +0200
Message-ID: <1477943184-3419-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:35095 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946100AbcJaTql (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 31 Oct 2016 15:46:41 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org

Race condition between registering an I2C device driver and
deregistering an I2C adapter device which is assumed to manage that
I2C device may lead to a NULL pointer dereference due to the
uninitialized list head of driver clients.

The root cause of the issue is that the I2C bus may know about the
registered device driver and thus it is matched by bus_for_each_drv(),
but the list of clients is not initialized and commonly it is NULL,
because I2C device drivers define struct i2c_driver as static and
clients field is expected to be initialized by I2C core:

  i2c_register_driver()             i2c_del_adapter()
    driver_register()                 ...
      bus_add_driver()                ...
        ...                           bus_for_each_drv(..., __process_removed_adapter)
      ...                               i2c_do_del_adapter()
    ...                                   list_for_each_entry_safe(..., &driver->clients, ...)
    INIT_LIST_HEAD(&driver->clients);

To solve the problem it is sufficient to do clients list head
initialization before calling driver_register().

The problem was found while using an I2C device driver with a sluggish
registration routine on a bus provided by a physically detachable I2C
master controller, but practically the oops may be reproduced under
the race between arbitraty I2C device driver registration and managing
I2C bus device removal e.g. by unbinding the latter over sysfs:

% echo 21a4000.i2c > /sys/bus/platform/drivers/imx-i2c/unbind
  Unable to handle kernel NULL pointer dereference at virtual address 00000000
  Internal error: Oops: 17 [#1] SMP ARM
  CPU: 2 PID: 533 Comm: sh Not tainted 4.9.0-rc3+ #61
  Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  task: e5ada400 task.stack: e4936000
  PC is at i2c_do_del_adapter+0x20/0xcc
  LR is at __process_removed_adapter+0x14/0x1c
  Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 10c5387d  Table: 35bd004a  DAC: 00000051
  Process sh (pid: 533, stack limit = 0xe4936210)
  Stack: (0xe4937d28 to 0xe4938000)
  Backtrace:
  [<c0667be0>] (i2c_do_del_adapter) from [<c0667cc0>] (__process_removed_adapter+0x14/0x1c)
  [<c0667cac>] (__process_removed_adapter) from [<c0516998>] (bus_for_each_drv+0x6c/0xa0)
  [<c051692c>] (bus_for_each_drv) from [<c06685ec>] (i2c_del_adapter+0xbc/0x284)
  [<c0668530>] (i2c_del_adapter) from [<bf0110ec>] (i2c_imx_remove+0x44/0x164 [i2c_imx])
  [<bf0110a8>] (i2c_imx_remove [i2c_imx]) from [<c051a838>] (platform_drv_remove+0x2c/0x44)
  [<c051a80c>] (platform_drv_remove) from [<c05183d8>] (__device_release_driver+0x90/0x12c)
  [<c0518348>] (__device_release_driver) from [<c051849c>] (device_release_driver+0x28/0x34)
  [<c0518474>] (device_release_driver) from [<c0517150>] (unbind_store+0x80/0x104)
  [<c05170d0>] (unbind_store) from [<c0516520>] (drv_attr_store+0x28/0x34)
  [<c05164f8>] (drv_attr_store) from [<c0298acc>] (sysfs_kf_write+0x50/0x54)
  [<c0298a7c>] (sysfs_kf_write) from [<c029801c>] (kernfs_fop_write+0x100/0x214)
  [<c0297f1c>] (kernfs_fop_write) from [<c0220130>] (__vfs_write+0x34/0x120)
  [<c02200fc>] (__vfs_write) from [<c0221088>] (vfs_write+0xa8/0x170)
  [<c0220fe0>] (vfs_write) from [<c0221e74>] (SyS_write+0x4c/0xa8)
  [<c0221e28>] (SyS_write) from [<c0108a20>] (ret_fast_syscall+0x0/0x1c)

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 1704fc84d647..b432b64e307a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2179,6 +2179,7 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = owner;
 	driver->driver.bus = &i2c_bus_type;
+	INIT_LIST_HEAD(&driver->clients);
 
 	/* When registration returns, the driver core
 	 * will have called probe() for all matching-but-unbound devices.
@@ -2189,7 +2190,6 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 
 	pr_debug("driver [%s] registered\n", driver->driver.name);
 
-	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
 	i2c_for_each_dev(driver, __process_new_driver);
 
-- 
2.8.1
