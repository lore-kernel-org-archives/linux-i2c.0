From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-nforce2-s4985: Load automatically as needed
Date: Tue, 19 Aug 2008 18:16:39 +0200
Message-ID: <20080819181639.6f6f5552@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ulrich Drepper <drepper-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Let the i2c-nforce2-s4985 module load automatically on the Tyan S4985.
We use the PCI sub-IDs for this.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Ulrich, can you please test this patch again, on top of Linus' latest
kernel tree? There have been a number of fixes done to the
i2c-nforce-s4985 driver meanwhile, so maybe this patch will work fine
now.

 drivers/i2c/busses/i2c-nforce2-s4985.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux-2.6.26-rc1.orig/drivers/i2c/busses/i2c-nforce2-s4985.c	2008-05-07 14:39:05.000000000 +0200
+++ linux-2.6.26-rc1/drivers/i2c/busses/i2c-nforce2-s4985.c	2008-05-07 21:00:10.000000000 +0200
@@ -37,6 +37,20 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/pci_ids.h>
+#include <linux/mod_devicetable.h>
+
+/* Let the driver autoload */
+static struct pci_device_id s4985_ids[] = {
+	{
+		.vendor 	= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS,
+		.subvendor	= 0x10f1,	/* Tyan Computer */
+		.subdevice	= 0x4985,	/* S4985 */
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, s4985_ids);
 
 extern struct i2c_adapter *nforce2_smbus;
 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
