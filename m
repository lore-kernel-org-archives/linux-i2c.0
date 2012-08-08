From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [PATCH] i2c-i801: Add device tree support
Date: Wed,  8 Aug 2012 09:06:47 +0200
Message-ID: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This commit adds support for probing slave devices parsed from the
device tree.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 6f00785..b5311cf 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -80,6 +80,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/err.h>
+#include <linux/of_i2c.h>
 
 #if defined CONFIG_I2C_MUX || defined CONFIG_I2C_MUX_MODULE
 #include <linux/gpio.h>
@@ -1238,6 +1239,7 @@ static int __devinit i801_probe(struct pci_dev *dev,
 		goto exit_free_irq;
 	}
 
+	of_i2c_register_devices(&priv->adapter);
 	i801_probe_optional_slaves(priv);
 	/* We ignore errors - multiplexing is optional */
 	i801_add_mux(priv);
-- 
1.7.11.4
