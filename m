From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/4] i2c-designware: add missing MODULE_LICENSE
Date: Thu, 17 Jan 2013 12:31:04 +0200
Message-ID: <1358418667-4533-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1358418667-4533-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358418667-4533-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The driver can also be built as a module so add MODULE_LICENSE for it. In
addition add MODULE_DESCRIPTION as well.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index cbba7db..f5258c2 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -34,6 +34,7 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include "i2c-designware-core.h"
 
 /*
@@ -725,3 +726,6 @@ u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev)
 	return dw_readl(dev, DW_IC_COMP_PARAM_1);
 }
 EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
+
+MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4
