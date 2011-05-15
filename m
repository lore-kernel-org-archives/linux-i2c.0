From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 2/2] i2c-i801: Don't depend on other kernel driver config
 options
Date: Sun, 15 May 2011 22:14:07 +0200
Message-ID: <20110515221407.06761823@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Woodhouse <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Don't let other driver config options influence us, as it makes the
code more complex and fragile for a small benefit. There's nothing
wrong with instantiating I2C devices even if they don't have a driver.
And we're talking about 835 extra bytes in the binary on x86-64,
that's hardly worth arguing about.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Woodhouse <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes since v1:
* Make the optional code depend on CONFIG_DMI too.
* Exclude i801_probe_optional_slaves() completely if the optional code
  is missing, result is the same and this makes the code clearer.

 drivers/i2c/busses/i2c-i801.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- linux-2.6.39-rc7.orig/drivers/i2c/busses/i2c-i801.c	2011-05-15 21:31:42.000000000 +0200
+++ linux-2.6.39-rc7/drivers/i2c/busses/i2c-i801.c	2011-05-15 22:07:58.000000000 +0200
@@ -638,7 +638,7 @@ static const struct pci_device_id i801_i
 
 MODULE_DEVICE_TABLE(pci, i801_ids);
 
-#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
+#if defined CONFIG_X86 && defined CONFIG_DMI
 static unsigned char apanel_addr;
 
 /* Scan the system ROM for the signature "FJKEYINF" */
@@ -668,11 +668,7 @@ static void __init input_apanel_init(voi
 	}
 	iounmap(bios);
 }
-#else
-static void __init input_apanel_init(void) {}
-#endif
 
-#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
 struct dmi_onboard_device_info {
 	const char *name;
 	u8 type;
@@ -738,7 +734,6 @@ static void __devinit dmi_check_onboard_
 		dmi_check_onboard_device(type, name, adap);
 	}
 }
-#endif
 
 /* Register optional slaves */
 static void __devinit i801_probe_optional_slaves(struct i801_priv *priv)
@@ -747,7 +742,6 @@ static void __devinit i801_probe_optiona
 	if (priv->features & FEATURE_IDF)
 		return;
 
-#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
 	if (apanel_addr) {
 		struct i2c_board_info info;
 
@@ -756,12 +750,14 @@ static void __devinit i801_probe_optiona
 		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
 		i2c_new_device(&priv->adapter, &info);
 	}
-#endif
-#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
+
 	if (dmi_name_in_vendors("FUJITSU"))
 		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
-#endif
 }
+#else
+static void __init input_apanel_init(void) {}
+static void __devinit i801_probe_optional_slaves(struct i801_priv *priv) {}
+#endif	/* CONFIG_X86 && CONFIG_DMI */
 
 static int __devinit i801_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)


-- 
Jean Delvare
