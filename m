From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Let the user specify PCI driver data through
	new_id
Date: Thu, 17 Jan 2008 14:09:37 +0100
Message-ID: <20080117140937.6fd37183@hyperion.delvare>
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-amd756 and i2c-viapro drivers make use of the driver_data
field of the PCI device ID. When adding device IDs dynamically (by
writing to the new_id sysfs file) you cannot set the value of this
field by default. It has to be allowed explicitly. Do that, and
check the value so that the user can't crash the kernel accidentally.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-amd756.c |    5 +++++
 drivers/i2c/busses/i2c-viapro.c |    5 +++++
 2 files changed, 10 insertions(+)

--- linux-2.6.24-rc8.orig/drivers/i2c/busses/i2c-amd756.c	2008-01-17 13:47:47.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/busses/i2c-amd756.c	2008-01-17 14:00:06.000000000 +0100
@@ -334,6 +334,10 @@ static int __devinit amd756_probe(struct
 	int error;
 	u8 temp;
 	
+	/* driver_data might come from user-space, so check it */
+	if (id->driver_data > ARRAY_SIZE(chipname))
+		return -EINVAL;
+
 	if (amd756_ioport) {
 		dev_err(&pdev->dev, "Only one device supported "
 		       "(you have a strange motherboard, btw)\n");
@@ -405,6 +409,7 @@ static struct pci_driver amd756_driver =
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
 	.remove		= __devexit_p(amd756_remove),
+	.dynids.use_driver_data = 1,
 };
 
 static int __init amd756_init(void)
--- linux-2.6.24-rc8.orig/drivers/i2c/busses/i2c-viapro.c	2008-01-17 13:47:47.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/busses/i2c-viapro.c	2008-01-17 13:59:34.000000000 +0100
@@ -318,6 +318,10 @@ static int __devinit vt596_probe(struct 
 	unsigned char temp;
 	int error = -ENODEV;
 
+	/* driver_data might come from user-space, so check it */
+	if (id->driver_data & 1 || id->driver_data > 0xff)
+		return -EINVAL;
+
 	/* Determine the address of the SMBus areas */
 	if (force_addr) {
 		vt596_smba = force_addr & 0xfff0;
@@ -455,6 +459,7 @@ static struct pci_driver vt596_driver = 
 	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
+	.dynids.use_driver_data = 1,
 };
 
 static int __init i2c_vt596_init(void)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
