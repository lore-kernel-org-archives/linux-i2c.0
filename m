From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] i2c: Drop probe, ignore and force module parameters
Date: Tue, 6 Oct 2009 18:04:36 +0200
Message-ID: <20091006180436.65281e4d@hyperion.delvare>
References: <20091006175611.46bf0dfa@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091006175611.46bf0dfa-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The legacy probe and force module parameters are obsolete now, the
same can be achieved using the new_device sysfs interface, which is
both more flexible and cheaper (it is implemented by i2c-core rather
than replicated in every driver module.)

The legacy ignore module parameters can be dropped as well. Ignoring
can be done by instantiating a "dummy" device at the problematic
address.

This is the first step of a huge cleanup to i2c-core's i2c_detect
function, i2c.h's I2C_CLIENT_INSMOD* macros, and all drivers that made
use of them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/old-module-parameters |   44 ++++++++++++++
 drivers/i2c/i2c-core.c                  |   65 ----------------------
 include/linux/i2c.h                     |   91 -------------------------------
 3 files changed, 46 insertions(+), 154 deletions(-)

--- linux-2.6.32-rc3.orig/include/linux/i2c.h	2009-10-05 12:57:41.000000000 +0200
+++ linux-2.6.32-rc3/include/linux/i2c.h	2009-10-05 21:17:14.000000000 +0200
@@ -110,7 +110,7 @@ extern s32 i2c_smbus_write_i2c_block_dat
  * @driver: Device driver model driver
  * @id_table: List of I2C devices supported by this driver
  * @detect: Callback for device detection
- * @address_data: The I2C addresses to probe, ignore or force (for detect)
+ * @address_data: The I2C addresses to probe (for detect)
  * @clients: List of detected clients we created (for i2c-core use only)
  *
  * The driver.owner field should be set to the module owner of this driver.
@@ -379,9 +379,6 @@ static inline void i2c_set_adapdata(stru
  */
 struct i2c_client_address_data {
 	const unsigned short *normal_i2c;
-	const unsigned short *probe;
-	const unsigned short *ignore;
-	const unsigned short * const *forces;
 };
 
 /* Internal numbers to terminate lists */
@@ -595,134 +592,48 @@ union i2c_smbus_data {
   module_param_array(var, short, &var##_num, 0); \
   MODULE_PARM_DESC(var, desc)
 
-#define I2C_CLIENT_MODULE_PARM_FORCE(name)				\
-I2C_CLIENT_MODULE_PARM(force_##name,					\
-		       "List of adapter,address pairs which are "	\
-		       "unquestionably assumed to contain a `"		\
-		       # name "' chip")
-
-
 #define I2C_CLIENT_INSMOD_COMMON					\
-I2C_CLIENT_MODULE_PARM(probe, "List of adapter,address pairs to scan "	\
-		       "additionally");					\
-I2C_CLIENT_MODULE_PARM(ignore, "List of adapter,address pairs not to "	\
-		       "scan");						\
 static const struct i2c_client_address_data addr_data = {		\
 	.normal_i2c	= normal_i2c,					\
-	.probe		= probe,					\
-	.ignore		= ignore,					\
-	.forces		= forces,					\
 }
 
-#define I2C_CLIENT_FORCE_TEXT \
-	"List of adapter,address pairs to boldly assume to be present"
-
 /* These are the ones you want to use in your own drivers. Pick the one
    which matches the number of devices the driver differenciates between. */
 #define I2C_CLIENT_INSMOD						\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-static const unsigned short * const forces[] = { force, NULL };		\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_1(chip1)					\
 enum chips { any_chip, chip1 };						\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-static const unsigned short * const forces[] =	{ force,		\
-	force_##chip1, NULL };						\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_2(chip1, chip2)				\
 enum chips { any_chip, chip1, chip2 };					\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-static const unsigned short * const forces[] =	{ force,		\
-	force_##chip1, force_##chip2, NULL };				\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_3(chip1, chip2, chip3)			\
 enum chips { any_chip, chip1, chip2, chip3 };				\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
-static const unsigned short * const forces[] =	{ force,		\
-	force_##chip1, force_##chip2, force_##chip3, NULL };		\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_4(chip1, chip2, chip3, chip4)			\
 enum chips { any_chip, chip1, chip2, chip3, chip4 };			\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
-static const unsigned short * const forces[] =	{ force,		\
-	force_##chip1, force_##chip2, force_##chip3,			\
-	force_##chip4, NULL};						\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_5(chip1, chip2, chip3, chip4, chip5)		\
 enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 };		\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
-static const unsigned short * const forces[] = { force,			\
-	force_##chip1, force_##chip2, force_##chip3,			\
-	force_##chip4, force_##chip5, NULL };				\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_6(chip1, chip2, chip3, chip4, chip5, chip6)	\
 enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 };	\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip6);					\
-static const unsigned short * const forces[] = { force,			\
-	force_##chip1, force_##chip2, force_##chip3,			\
-	force_##chip4, force_##chip5, force_##chip6, NULL };		\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_7(chip1, chip2, chip3, chip4, chip5, chip6, chip7) \
 enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
 	     chip7 };							\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip6);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip7);					\
-static const unsigned short * const forces[] = { force,			\
-	force_##chip1, force_##chip2, force_##chip3,			\
-	force_##chip4, force_##chip5, force_##chip6,			\
-	force_##chip7, NULL };						\
 I2C_CLIENT_INSMOD_COMMON
 
 #define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
 enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
 	     chip7, chip8 };						\
-I2C_CLIENT_MODULE_PARM(force, I2C_CLIENT_FORCE_TEXT);			\
-I2C_CLIENT_MODULE_PARM_FORCE(chip1);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip2);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip3);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip4);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip5);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip6);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip7);					\
-I2C_CLIENT_MODULE_PARM_FORCE(chip8);					\
-static const unsigned short * const forces[] = { force,			\
-	force_##chip1, force_##chip2, force_##chip3,			\
-	force_##chip4, force_##chip5, force_##chip6,			\
-	force_##chip7, force_##chip8, NULL };				\
 I2C_CLIENT_INSMOD_COMMON
 #endif /* __KERNEL__ */
 #endif /* _LINUX_I2C_H */
--- linux-2.6.32-rc3.orig/drivers/i2c/i2c-core.c	2009-10-05 12:57:41.000000000 +0200
+++ linux-2.6.32-rc3/drivers/i2c/i2c-core.c	2009-10-05 21:17:14.000000000 +0200
@@ -1248,40 +1248,13 @@ static int i2c_detect(struct i2c_adapter
 		return -ENOMEM;
 	temp_client->adapter = adapter;
 
-	/* Force entries are done first, and are not affected by ignore
-	   entries */
-	if (address_data->forces) {
-		const unsigned short * const *forces = address_data->forces;
-		int kind;
-
-		for (kind = 0; forces[kind]; kind++) {
-			for (i = 0; forces[kind][i] != I2C_CLIENT_END;
-			     i += 2) {
-				if (forces[kind][i] == adap_id
-				 || forces[kind][i] == ANY_I2C_BUS) {
-					dev_dbg(&adapter->dev, "found force "
-						"parameter for adapter %d, "
-						"addr 0x%02x, kind %d\n",
-						adap_id, forces[kind][i + 1],
-						kind);
-					temp_client->addr = forces[kind][i + 1];
-					err = i2c_detect_address(temp_client,
-						kind, driver);
-					if (err)
-						goto exit_free;
-				}
-			}
-		}
-	}
-
 	/* Stop here if the classes do not match */
 	if (!(adapter->class & driver->class))
 		goto exit_free;
 
 	/* Stop here if we can't use SMBUS_QUICK */
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
-		if (address_data->probe[0] == I2C_CLIENT_END
-		 && address_data->normal_i2c[0] == I2C_CLIENT_END)
+		if (address_data->normal_i2c[0] == I2C_CLIENT_END)
 			goto exit_free;
 
 		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
@@ -1290,43 +1263,7 @@ static int i2c_detect(struct i2c_adapter
 		goto exit_free;
 	}
 
-	/* Probe entries are done second, and are not affected by ignore
-	   entries either */
-	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {
-		if (address_data->probe[i] == adap_id
-		 || address_data->probe[i] == ANY_I2C_BUS) {
-			dev_dbg(&adapter->dev, "found probe parameter for "
-				"adapter %d, addr 0x%02x\n", adap_id,
-				address_data->probe[i + 1]);
-			temp_client->addr = address_data->probe[i + 1];
-			err = i2c_detect_address(temp_client, -1, driver);
-			if (err)
-				goto exit_free;
-		}
-	}
-
-	/* Normal entries are done last, unless shadowed by an ignore entry */
 	for (i = 0; address_data->normal_i2c[i] != I2C_CLIENT_END; i += 1) {
-		int j, ignore;
-
-		ignore = 0;
-		for (j = 0; address_data->ignore[j] != I2C_CLIENT_END;
-		     j += 2) {
-			if ((address_data->ignore[j] == adap_id ||
-			     address_data->ignore[j] == ANY_I2C_BUS)
-			 && address_data->ignore[j + 1]
-			    == address_data->normal_i2c[i]) {
-				dev_dbg(&adapter->dev, "found ignore "
-					"parameter for adapter %d, "
-					"addr 0x%02x\n", adap_id,
-					address_data->ignore[j + 1]);
-				ignore = 1;
-				break;
-			}
-		}
-		if (ignore)
-			continue;
-
 		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
 			"addr 0x%02x\n", adap_id,
 			address_data->normal_i2c[i]);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.32-rc3/Documentation/i2c/old-module-parameters	2009-10-05 21:17:14.000000000 +0200
@@ -0,0 +1,44 @@
+I2C device driver binding control from user-space
+=================================================
+
+Up to kernel 2.6.32, many i2c drivers used helper macros provided by
+<linux/i2c.h> which created standard module parameters to let the user
+control how the driver would probe i2c buses and attach to devices. These
+parameters were known as "probe" (to let the driver probe for an extra
+address), "force" (to forcibly attach the driver to a given device) and
+"ignore" (to prevent a driver from probing a given address).
+
+With the conversion of the i2c subsystem to the standard device driver
+binding model, it became clear that these per-module parameters were no
+longer needed, and that a centralized implementation was possible. The new,
+sysfs-based interface is described in the documentation file
+"instantiating-devices", section "Method 4: Instantiate from user-space".
+
+Below is a mapping from the old module parameters to the new interface.
+
+Attaching a driver to an I2C device
+-----------------------------------
+
+Old method (module parameters):
+# modprobe <driver> probe=1,0x2d
+# modprobe <driver> force=1,0x2d
+# modprobe <driver> force_<device>=1,0x2d
+
+New method (sysfs interface):
+# echo <device> 0x2d > /sys/bus/i2c/devices/i2c-1/new_device
+
+Preventing a driver from attaching to an I2C device
+---------------------------------------------------
+
+Old method (module parameters):
+# modprobe <driver> ignore=1,0x2f
+
+New method (sysfs interface):
+# echo dummy 0x2f > /sys/bus/i2c/devices/i2c-1/new_device
+# modprobe <driver>
+
+Of course, it is important to instantiate the "dummy" device before loading
+the driver. The dummy device will be handled by i2c-core itself, preventing
+other drivers from binding to it later on. If there is a real device at the
+problematic address, and you want another driver to bind to it, then simply
+pass the name of the device in question instead of "dummy".

-- 
Jean Delvare
