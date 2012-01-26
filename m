From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c-i801: utilize hardware semaphore
Date: Thu, 26 Jan 2012 15:53:13 -0600 (CST)
Message-ID: <381bf22a-6af1-48b6-ad2f-666fac2b6409@zimbra>
References: <4fdceda1-2fee-4c8e-a15b-5e1e62c0d82b@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4fdceda1-2fee-4c8e-a15b-5e1e62c0d82b@zimbra>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The i2c-i801 driver (along with 12 others) was modified to include a check
for ACPI resource conflicts by the following commit prior to 2.6.27
release:

    commit 54fb4a05af0a4b814e6716cfdf3fa97fc6be7a32
    i2c: Check for ACPI resource conflicts

The resource conflict check prevents a non-ACPI driver from accessing the
same hardware as an ACPI driver. However, the check is unnecessary for the
i2c-801 driver due to a previously unused semaphore provided by the
underlying hardware.

The INUSE_STS bit in the HST_STA/HST_STS register implements a hardware
semaphore that allows multiple drivers (BIOS/EFI, Linux non-ACPI, Linux
ACPI, etc.) to safely attempt to access the SMBus interface
simultaneously.

This commit adds a check to aquire the INUSE_STS semaphore before any
SMBus registers are altered and adds calls to release the semaphore
before returning in i801_access. It also removes the
acpi_check_resource_conflict call.

If any of the multiple possible drivers fails to properly utilize the
hardware semaphore (the INUSE_STS bit is not intentionally read and never
reset), then that driver will prevent the remaining drivers from gaining
the semaphore and no conflicting accesses will occur.

This corrects behavior seen on some hardware where an ACPI resource
conflict is detected, but the ASL methods defined in ACPI are
incompatible with the i2c-scmi driver. This results in no driver being
bound to the hardware, when both could safely be bound.

Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   55 ++++++++++++++++++++++++++++++++++------
 1 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ab26840..b87ca26 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -174,6 +174,36 @@ static unsigned int disable_features;
 module_param(disable_features, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(disable_features, "Disable selected driver features");
 
+/*
+ * Make sure that we get the hardware-provided semaphore so that any other
+ * driver knows that other software is accessing the SMBus registers.
+ * Return 0 if we get it, -EBUSY if not.
+ */
+static int i801_sem_get(struct i801_priv *priv)
+{
+	int status;
+	int timeout = 0;
+
+	status = inb_p(SMBHSTSTS(priv));
+	while ((status & SMBHSTSTS_INUSE_STS) && (timeout < MAX_TIMEOUT)) {
+		msleep(1);
+		status = inb_p(SMBHSTSTS(priv));
+		timeout++;
+	}
+
+	if (status & SMBHSTSTS_INUSE_STS) {
+		dev_err(&priv->pci_dev->dev, "SMBus is in use, can't use it!\n");
+		return -EBUSY;
+	}
+
+        return 0;
+}
+
+static void i801_sem_put(struct i801_priv *priv)
+{
+	outb_p(SMBHSTSTS_INUSE_STS, SMBHSTSTS(priv));
+}
+
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
 static int i801_check_pre(struct i801_priv *priv)
@@ -493,6 +523,10 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int ret, xact = 0;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
+	ret = i801_sem_get(priv);
+	if (ret < 0)
+		return ret;
+
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
 		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
@@ -549,6 +583,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	default:
 		dev_err(&priv->pci_dev->dev, "Unsupported transaction %d\n",
 			size);
+		i801_sem_put(priv);
 		return -EOPNOTSUPP;
 	}
 
@@ -571,12 +606,18 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
-	if (block)
+	if (block) {
+		i801_sem_put(priv);
 		return ret;
-	if (ret)
+	}
+	if (ret) {
+		i801_sem_put(priv);
 		return ret;
-	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
+	}
+	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK)) {
+		i801_sem_put(priv);
 		return 0;
+	}
 
 	switch (xact & 0x7f) {
 	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
@@ -588,6 +629,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 			     (inb_p(SMBHSTDAT1(priv)) << 8);
 		break;
 	}
+
+	i801_sem_put(priv);
 	return 0;
 }
 
@@ -820,12 +863,6 @@ static int __devinit i801_probe(struct pci_dev *dev,
 		goto exit;
 	}
 
-	err = acpi_check_resource_conflict(&dev->resource[SMBBAR]);
-	if (err) {
-		err = -ENODEV;
-		goto exit;
-	}
-
 	err = pci_request_region(dev, SMBBAR, i801_driver.name);
 	if (err) {
 		dev_err(&dev->dev, "Failed to request SMBus region "
-- 
1.7.0.4
