From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Don't probe for slaves on IDF channels
Date: Tue, 10 May 2011 16:08:35 +0200
Message-ID: <20110510160835.37bea352@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I don't know if Fujitsu is ever going to produce Patsburg-based
machines, but if they do, I'd rather not probe the secondary (IDF)
SMBus channels. At least not until we have a good reason for doing so.

On a side note, I'm not even sure if it is right to enable detection
of HWMON and DDC devices on the IDF channels. Time will tell...

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CC: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Hans, David, what do you think?

 drivers/i2c/busses/i2c-i801.c |   45 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

--- linux-2.6.39-rc7.orig/drivers/i2c/busses/i2c-i801.c	2011-05-10 09:39:07.000000000 +0200
+++ linux-2.6.39-rc7/drivers/i2c/busses/i2c-i801.c	2011-05-10 15:03:52.000000000 +0200
@@ -158,6 +158,7 @@ static struct pci_driver i801_driver;
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
+#define FEATURE_IDF		(1 << 4)
 
 static const char *i801_feature_names[] = {
 	"SMBus PEC",
@@ -735,6 +736,29 @@ static void __devinit dmi_check_onboard_
 }
 #endif
 
+/* Register optional slaves */
+static void __devinit i801_probe_optional_slaves(struct i801_priv *priv)
+{
+	/* Only register slaves on main SMBus channel */
+	if (priv->features & FEATURE_IDF)
+		return;
+
+#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
+	if (apanel_addr) {
+		struct i2c_board_info info;
+
+		memset(&info, 0, sizeof(struct i2c_board_info));
+		info.addr = apanel_addr;
+		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
+		i2c_new_device(&priv->adapter, &info);
+	}
+#endif
+#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
+	if (dmi_name_in_vendors("FUJITSU"))
+		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
+#endif
+}
+
 static int __devinit i801_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
@@ -753,6 +777,11 @@ static int __devinit i801_probe(struct p
 
 	priv->pci_dev = dev;
 	switch (dev->device) {
+	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF0:
+	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF1:
+	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2:
+		priv->features |= FEATURE_IDF;
+		/* fall through */
 	default:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		/* fall through */
@@ -838,21 +867,7 @@ static int __devinit i801_probe(struct p
 		goto exit_release;
 	}
 
-	/* Register optional slaves */
-#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
-	if (apanel_addr) {
-		struct i2c_board_info info;
-
-		memset(&info, 0, sizeof(struct i2c_board_info));
-		info.addr = apanel_addr;
-		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
-		i2c_new_device(&priv->adapter, &info);
-	}
-#endif
-#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
-	if (dmi_name_in_vendors("FUJITSU"))
-		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
-#endif
+	i801_probe_optional_slaves(priv);
 
 	pci_set_drvdata(dev, priv);
 	return 0;


-- 
Jean Delvare
