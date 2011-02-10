From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: [PATCH] i2c-ocores: register devices on child nodes
Date: Thu, 10 Feb 2011 10:51:54 +0800
Message-ID: <1297306314-11483-1-git-send-email-thomas@wytron.com.tw>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch registers devices on the devicetree child nodes to the bus.
Also removes one trailing whitespace.

Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index ef3bcb1..c63838f 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -18,7 +18,7 @@
  * - interrupts      : interrupt number
  * - regstep         : size of device registers in bytes
  * - clock-frequency : frequency of bus clock in Hz
- * 
+ *
  * Example:
  *
  *  i2c0: ocores@a0000000 {
@@ -55,6 +55,7 @@
 #include <linux/i2c-ocores.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of_i2c.h>
 
 struct ocores_i2c {
 	void __iomem *base;
@@ -347,6 +348,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 			i2c_new_device(&i2c->adap, pdata->devices + i);
 	}
 
+	/* Now register all the child nodes */
+	of_i2c_register_devices(&i2c->adap);
+
 	return 0;
 }
 
-- 
1.7.4
