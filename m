From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-nforce2: Disable the second SMBus channel on the
 DFI Lanparty NF4 Expert
Date: Wed, 7 May 2008 14:00:00 +0200
Message-ID: <20080507140000.2dee027e@hyperion.delvare>
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
List-Id: linux-i2c@vger.kernel.org

There is a strange chip at 0x2e on the second SMBus channel of the
DFI Lanparty NF4 Expert motherboard. Accessing the chip reboots the
system. As there's nothing interesting on this SMBus channel, the
easiest and safest thing to do is to disable it on that board.

This is a better fix to bug #5889 than the it87 driver update that was
done originally:
http://bugzilla.kernel.org/show_bug.cgi?id=5889

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
If anyone with this board could test the patch, that would be great.

 drivers/i2c/busses/i2c-nforce2.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- linux-2.6.26-rc1.orig/drivers/i2c/busses/i2c-nforce2.c	2008-05-07 09:29:36.000000000 +0200
+++ linux-2.6.26-rc1/drivers/i2c/busses/i2c-nforce2.c	2008-05-07 13:52:44.000000000 +0200
@@ -50,6 +50,7 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 MODULE_LICENSE("GPL");
@@ -109,6 +110,18 @@ struct nforce2_smbus {
 /* Misc definitions */
 #define MAX_TIMEOUT	100
 
+/* We disable the second SMBus channel on these boards */
+static struct dmi_system_id __devinitdata nforce2_dmi_blacklist2[] = {
+	{
+		.ident = "DFI Lanparty NF4 Expert",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "DFI Corp,LTD"),
+			DMI_MATCH(DMI_BOARD_NAME, "LP UT NF4 Expert"),
+		},
+	},
+	{ }
+};
+
 static struct pci_driver nforce2_driver;
 
 static void nforce2_abort(struct i2c_adapter *adap)
@@ -367,10 +380,17 @@ static int __devinit nforce2_probe(struc
 		smbuses[0].base = 0;	/* to have a check value */
 	}
 	/* SMBus adapter 2 */
-	res2 = nforce2_probe_smb(dev, 5, NFORCE_PCI_SMB2, &smbuses[1], "SMB2");
-	if (res2 < 0) {
-		dev_err(&dev->dev, "Error probing SMB2.\n");
-		smbuses[1].base = 0;	/* to have a check value */
+	if (dmi_check_system(nforce2_dmi_blacklist2)) {
+		dev_err(&dev->dev, "Disabling SMB2 for safety reasons.\n");
+		res2 = -EPERM;
+		smbuses[1].base = 0;
+	} else {
+		res2 = nforce2_probe_smb(dev, 5, NFORCE_PCI_SMB2, &smbuses[1],
+					 "SMB2");
+		if (res2 < 0) {
+			dev_err(&dev->dev, "Error probing SMB2.\n");
+			smbuses[1].base = 0;	/* to have a check value */
+		}
 	}
 	if ((res1 < 0) && (res2 < 0)) {
 		/* we did not find even one of the SMBuses, so we give up */


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
