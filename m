From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] i2c: remove __init from i2c_register_board_info()
Date: Tue,  7 Jun 2016 16:52:27 -0700
Message-ID: <1465343547-19974-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, feng.tang@intel.com, linux-next@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-i2c@vger.kernel.org

As of next-20160607 with allyesconfig we get this linker failure:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x21bc0d): Section mismatch in reference from
the function intel_scu_devices_create() to the function
.init.text:i2c_register_board_info()

This is caused by the fact that intel_scu_devices_create() calls
i2c_register_board_info() and intel_scu_devices_create() is not
annotated with __init. This typically involves manual code
inspection and if one is certain this is correct we would
just peg intel_scu_devices_create() with a __ref annotation.

In this case this would be wrong though as the
intel_scu_devices_create() call is exported, and used in
the ipc_probe() on drivers/platform/x86/intel_scu_ipc.c.
The issue is that even though builtin_pci_driver(ipc_driver)
is used this just exposes the probe routine, which can occur
at any point in time if this bus supports hotplug. A race
can happen between kernel_init_freeable() that calls the init
calls (in this case registeres the intel_scu_ipc.c driver, and
later free_initmem(), which would free the i2c_register_board_info().
If a probe happens later in boot i2c_register_board_info() would
not be present and we should get a page fault.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/i2c/i2c-boardinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index e33022e..77b1589 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(__i2c_first_dynamic_bus_num);
  * The board info passed can safely be __initdata, but be careful of embedded
  * pointers (for platform_data, functions, etc) since that won't be copied.
  */
-int __init
+int
 i2c_register_board_info(int busnum,
 	struct i2c_board_info const *info, unsigned len)
 {
-- 
2.8.1
