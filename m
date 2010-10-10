From: Kris Rusocki <kszysiu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH][RFC] Support second PCA9556 on Tyan S4985
Date: Sat, 09 Oct 2010 20:28:00 -0600
Message-ID: <4CB124B0.40005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Tyan S4985 employs two PCA9556s that are used
to multiplex devices on nForce's SMBuses.

First one (multiplexes SPDs) has been supported
by Linux for a while now. Patch below (against
current git) adds support for the other one
(multiplexes three ADT7476).

This patch makes SPDs and HWMon chips accessible
on Tyan S4985.

As I'm occasional kernel hacker all comments are
welcome.


Thanks,
Kris


P.S.
Please Cc, not a subcriber


Signed-off-by: Kris Rusocki <kszysiu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-nforce2-s4985.c b/drivers/i2c/busses/i2c-nforce2-s4985.c
index 29015eb..681403b 100644
--- a/drivers/i2c/busses/i2c-nforce2-s4985.c
+++ b/drivers/i2c/busses/i2c-nforce2-s4985.c
@@ -19,8 +19,10 @@
  */
 
 /*
- * We select the channels by sending commands to the Philips
- * PCA9556 chip at I2C address 0x18. The main adapter is used for
+ * First SMBus
+ *
+ * We select channels by sending commands to the Philips PCA9556
+ * chip at I2C address 0x18. The main adapter is used for
  * the non-multiplexed part of the bus, and 4 virtual adapters
  * are defined for the multiplexed addresses: 0x50-0x53 (memory
  * module EEPROM) located on channels 1-4. We define one virtual
@@ -31,6 +33,16 @@
  *   CPU3: virtual adapter 4, channel 4
  */
 
+/*
+ * Second SMBus
+ *
+ * We select channels by sending commands to the Philips PCA9556
+ * chip at I2C address 0x19. The main adapter is used for
+ * the non-multiplexed part of the bus, and 4 virtual adapters
+ * are defined for the multiplexed address 0x2e (ADT7476)
+ * located on channels 1-3.
+ */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -38,179 +50,201 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 
-extern struct i2c_adapter *nforce2_smbus;
+extern struct i2c_adapter *nforce2_smbus[];
 
-static struct i2c_adapter *s4985_adapter;
-static struct i2c_algorithm *s4985_algo;
+static struct i2c_adapter *s4985_adapter[2];
+static struct i2c_algorithm *s4985_algo[2];
 
 /* Wrapper access functions for multiplexed SMBus */
 static DEFINE_MUTEX(nforce2_lock);
 
-static s32 nforce2_access_virt0(struct i2c_adapter *adap, u16 addr,
-				unsigned short flags, char read_write,
-				u8 command, int size,
-				union i2c_smbus_data *data)
-{
-	int error;
-
-	/* We exclude the multiplexed addresses */
-	if ((addr & 0xfc) == 0x50 || (addr & 0xfc) == 0x30
-	 || addr == 0x18)
-		return -ENXIO;
+static u16 mplx_addr[] = { 0x18, 0x19 };
 
-	mutex_lock(&nforce2_lock);
-	error = nforce2_smbus->algo->smbus_xfer(adap, addr, flags, read_write,
-						command, size, data);
-	mutex_unlock(&nforce2_lock);
+static inline int nforce2_is_multiplexed(int bus, u16 addr)
+{
+	switch (bus) {
+		case 0:
+			if ((addr & 0xfc) == 0x50 || (addr & 0xfc) == 0x30)
+				return 1;
+			break;
+		case 1:
+			if (addr == 0x2e)
+				return 1;
+			break;
+	}
+	return 0;
+}
 
-	return error;
+#define nforce2_access_virt0(_BUS) nforce2_access_virt0_bus##_BUS
+#define nforce2_access_virt0_def(_BUS) \
+static s32 nforce2_access_virt0(_BUS)(struct i2c_adapter *adap, u16 addr, \
+				unsigned short flags, char read_write, \
+				u8 command, int size, \
+				union i2c_smbus_data *data) \
+{ \
+	int error; \
+\
+	/* We exclude multiplexed addresses and multiplexer's address */ \
+	if (nforce2_is_multiplexed(_BUS, addr) || addr == mplx_addr[_BUS]) \
+		return -ENXIO; \
+\
+	mutex_lock(&nforce2_lock); \
+	error = nforce2_smbus[_BUS]->algo->smbus_xfer(adap, addr, flags, \
+						read_write, command, size, \
+						data); \
+	mutex_unlock(&nforce2_lock); \
+\
+	return error; \
 }
 
+nforce2_access_virt0_def(0);
+nforce2_access_virt0_def(1);
+
 /* We remember the last used channels combination so as to only switch
    channels when it is really needed. This greatly reduces the SMBus
    overhead, but also assumes that nobody will be writing to the PCA9556
-   in our back. */
-static u8 last_channels;
+   behind our back. */
+static u8 last_channels[2];
 
 static inline s32 nforce2_access_channel(struct i2c_adapter *adap, u16 addr,
 					 unsigned short flags, char read_write,
 					 u8 command, int size,
 					 union i2c_smbus_data *data,
-					 u8 channels)
+					 u8 channels, int bus)
 {
 	int error;
 
 	/* We exclude the non-multiplexed addresses */
-	if ((addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
+	if (!nforce2_is_multiplexed(bus, addr))
 		return -ENXIO;
 
 	mutex_lock(&nforce2_lock);
-	if (last_channels != channels) {
+	if (last_channels[bus] != channels) {
 		union i2c_smbus_data mplxdata;
 		mplxdata.byte = channels;
 
-		error = nforce2_smbus->algo->smbus_xfer(adap, 0x18, 0,
+		error = nforce2_smbus[bus]->algo->smbus_xfer(adap,
+							mplx_addr[bus], 0,
 							I2C_SMBUS_WRITE, 0x01,
 							I2C_SMBUS_BYTE_DATA,
 							&mplxdata);
 		if (error)
 			goto UNLOCK;
-		last_channels = channels;
+		last_channels[bus] = channels;
 	}
-	error = nforce2_smbus->algo->smbus_xfer(adap, addr, flags, read_write,
-						command, size, data);
+	error = nforce2_smbus[bus]->algo->smbus_xfer(adap, addr, flags,
+						read_write, command, size,
+						data);
 
 UNLOCK:
 	mutex_unlock(&nforce2_lock);
 	return error;
 }
 
-static s32 nforce2_access_virt1(struct i2c_adapter *adap, u16 addr,
-				unsigned short flags, char read_write,
-				u8 command, int size,
-				union i2c_smbus_data *data)
-{
-	/* CPU0: channel 1 enabled */
-	return nforce2_access_channel(adap, addr, flags, read_write, command,
-				      size, data, 0x02);
-}
-
-static s32 nforce2_access_virt2(struct i2c_adapter *adap, u16 addr,
-				unsigned short flags, char read_write,
-				u8 command, int size,
-				union i2c_smbus_data *data)
-{
-	/* CPU1: channel 2 enabled */
-	return nforce2_access_channel(adap, addr, flags, read_write, command,
-				      size, data, 0x04);
+#define nforce2_access_virt(_BUS, _SUB) nforce2_access_virt##_SUB##_bus##_BUS
+#define nforce2_access_virt_def(_BUS, _SUB) \
+static s32 nforce2_access_virt(_BUS, _SUB)(struct i2c_adapter *adap, \
+					   u16 addr, unsigned short flags, \
+					   char read_write, u8 command, \
+					   int size, \
+					   union i2c_smbus_data *data) \
+{ \
+	return nforce2_access_channel(adap, addr, flags, read_write, command, \
+				      size, data, 1 << _SUB, \
+				      _BUS); \
 }
 
-static s32 nforce2_access_virt3(struct i2c_adapter *adap, u16 addr,
-				unsigned short flags, char read_write,
-				u8 command, int size,
-				union i2c_smbus_data *data)
-{
-	/* CPU2: channel 3 enabled */
-	return nforce2_access_channel(adap, addr, flags, read_write, command,
-				      size, data, 0x08);
-}
+nforce2_access_virt_def(0, 1);
+nforce2_access_virt_def(0, 2);
+nforce2_access_virt_def(0, 3);
+nforce2_access_virt_def(0, 4);
+nforce2_access_virt_def(1, 1);
+nforce2_access_virt_def(1, 2);
+nforce2_access_virt_def(1, 3);
+nforce2_access_virt_def(1, 4);
 
-static s32 nforce2_access_virt4(struct i2c_adapter *adap, u16 addr,
-				unsigned short flags, char read_write,
-				u8 command, int size,
-				union i2c_smbus_data *data)
-{
-	/* CPU3: channel 4 enabled */
-	return nforce2_access_channel(adap, addr, flags, read_write, command,
-				      size, data, 0x10);
-}
-
-static int __init nforce2_s4985_init(void)
+static int __init nforce2_s4985_init_one(int bus)
 {
 	int i, error;
 	union i2c_smbus_data ioconfig;
 
-	if (!nforce2_smbus)
-		return -ENODEV;
-
 	/* Configure the PCA9556 multiplexer */
 	ioconfig.byte = 0x00; /* All I/O to output mode */
-	error = i2c_smbus_xfer(nforce2_smbus, 0x18, 0, I2C_SMBUS_WRITE, 0x03,
-			       I2C_SMBUS_BYTE_DATA, &ioconfig);
+	error = i2c_smbus_xfer(nforce2_smbus[bus], mplx_addr[bus], 0,
+			       I2C_SMBUS_WRITE, 0x03, I2C_SMBUS_BYTE_DATA,
+			       &ioconfig);
 	if (error) {
-		dev_err(&nforce2_smbus->dev, "PCA9556 configuration failed\n");
+		dev_err(&nforce2_smbus[bus]->dev,
+			"PCA9556 (bus %d) configuration failed\n", bus);
 		error = -EIO;
 		goto ERROR0;
 	}
 
 	/* Unregister physical bus */
-	error = i2c_del_adapter(nforce2_smbus);
+	error = i2c_del_adapter(nforce2_smbus[bus]);
 	if (error) {
-		dev_err(&nforce2_smbus->dev, "Physical bus removal failed\n");
+		dev_err(&nforce2_smbus[bus]->dev, 
+			"Physical bus %d removal failed\n", bus);
 		goto ERROR0;
 	}
 
-	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4985\n");
+	printk(KERN_INFO "Enabling SMBus %d multiplexing for Tyan S4985\n",
+	       bus);
 	/* Define the 5 virtual adapters and algorithms structures */
-	s4985_adapter = kzalloc(5 * sizeof(struct i2c_adapter), GFP_KERNEL);
-	if (!s4985_adapter) {
+	s4985_adapter[bus] = kzalloc(5 * sizeof(struct i2c_adapter),
+				     GFP_KERNEL);
+	if (!s4985_adapter[bus]) {
 		error = -ENOMEM;
 		goto ERROR1;
 	}
-	s4985_algo = kzalloc(5 * sizeof(struct i2c_algorithm), GFP_KERNEL);
-	if (!s4985_algo) {
+	s4985_algo[bus] = kzalloc(5 * sizeof(struct i2c_algorithm),
+				  GFP_KERNEL);
+	if (!s4985_algo[bus]) {
 		error = -ENOMEM;
 		goto ERROR2;
 	}
 
 	/* Fill in the new structures */
-	s4985_algo[0] = *(nforce2_smbus->algo);
-	s4985_algo[0].smbus_xfer = nforce2_access_virt0;
-	s4985_adapter[0] = *nforce2_smbus;
-	s4985_adapter[0].algo = s4985_algo;
-	s4985_adapter[0].dev.parent = nforce2_smbus->dev.parent;
+	s4985_algo[bus][0] = *(nforce2_smbus[bus]->algo);
+	if (bus == 0) {
+		s4985_algo[bus][0].smbus_xfer = nforce2_access_virt0(0);
+	} else if (bus == 1) {
+		s4985_algo[bus][0].smbus_xfer = nforce2_access_virt0(1);
+	}
+	s4985_adapter[bus][0] = *nforce2_smbus[bus];
+	s4985_adapter[bus][0].algo = s4985_algo[bus];
+	s4985_adapter[bus][0].dev.parent = nforce2_smbus[bus]->dev.parent;
 	for (i = 1; i < 5; i++) {
-		s4985_algo[i] = *(nforce2_smbus->algo);
-		s4985_adapter[i] = *nforce2_smbus;
-		snprintf(s4985_adapter[i].name, sizeof(s4985_adapter[i].name),
-			 "SMBus nForce2 adapter (CPU%d)", i - 1);
-		s4985_adapter[i].algo = s4985_algo + i;
-		s4985_adapter[i].dev.parent = nforce2_smbus->dev.parent;
+		s4985_algo[bus][i] = *(nforce2_smbus[bus]->algo);
+		s4985_adapter[bus][i] = *nforce2_smbus[bus];
+		snprintf(s4985_adapter[bus][i].name,
+			 sizeof(s4985_adapter[bus][i].name),
+			 "SMBus nForce2 adapter (Bus %d) (Sub %d)", bus,
+			 i - 1);
+		s4985_adapter[bus][i].algo = s4985_algo[bus] + i;
+		s4985_adapter[bus][i].dev.parent = nforce2_smbus[bus]->dev.parent;
+	}
+	if (bus == 0) {
+		s4985_algo[bus][1].smbus_xfer = nforce2_access_virt(0, 1);
+		s4985_algo[bus][2].smbus_xfer = nforce2_access_virt(0, 2);
+		s4985_algo[bus][3].smbus_xfer = nforce2_access_virt(0, 3);
+		s4985_algo[bus][4].smbus_xfer = nforce2_access_virt(0, 4);
+	} else if (bus == 1) {
+		s4985_algo[bus][1].smbus_xfer = nforce2_access_virt(1, 1);
+		s4985_algo[bus][2].smbus_xfer = nforce2_access_virt(1, 2);
+		s4985_algo[bus][3].smbus_xfer = nforce2_access_virt(1, 3);
+		s4985_algo[bus][4].smbus_xfer = nforce2_access_virt(1, 4);
 	}
-	s4985_algo[1].smbus_xfer = nforce2_access_virt1;
-	s4985_algo[2].smbus_xfer = nforce2_access_virt2;
-	s4985_algo[3].smbus_xfer = nforce2_access_virt3;
-	s4985_algo[4].smbus_xfer = nforce2_access_virt4;
 
 	/* Register virtual adapters */
 	for (i = 0; i < 5; i++) {
-		error = i2c_add_adapter(s4985_adapter + i);
+		error = i2c_add_adapter(s4985_adapter[bus] + i);
 		if (error) {
 			printk(KERN_ERR "i2c-nforce2-s4985: "
-			       "Virtual adapter %d registration "
-			       "failed, module not inserted\n", i);
+			       "Virtual adapter %d registration on bus %d "
+			       "failed, module not inserted\n", bus, i);
 			for (i--; i >= 0; i--)
-				i2c_del_adapter(s4985_adapter + i);
+				i2c_del_adapter(s4985_adapter[bus] + i);
 			goto ERROR3;
 		}
 	}
@@ -218,35 +252,74 @@ static int __init nforce2_s4985_init(void)
 	return 0;
 
 ERROR3:
-	kfree(s4985_algo);
-	s4985_algo = NULL;
+	kfree(s4985_algo[bus]);
+	s4985_algo[bus] = NULL;
 ERROR2:
-	kfree(s4985_adapter);
-	s4985_adapter = NULL;
+	kfree(s4985_adapter[bus]);
+	s4985_adapter[bus] = NULL;
 ERROR1:
 	/* Restore physical bus */
-	i2c_add_adapter(nforce2_smbus);
+	i2c_add_adapter(nforce2_smbus[bus]);
 ERROR0:
 	return error;
 }
 
-static void __exit nforce2_s4985_exit(void)
+static int __init nforce2_s4985_init(void)
 {
-	if (s4985_adapter) {
-		int i;
+	int error1 = -ENODEV;
+	int error2 = -ENODEV;
+
+	if (nforce2_smbus[0]) {
+		error1 = nforce2_s4985_init_one(0);
+	}
 
-		for (i = 0; i < 5; i++)
-			i2c_del_adapter(s4985_adapter+i);
-		kfree(s4985_adapter);
-		s4985_adapter = NULL;
+	if (nforce2_smbus[1]) {
+		error2 = nforce2_s4985_init_one(1);
+	}
+	
+	if (error1 && error2) {
+		/* Best effort */
+		return error1;
 	}
-	kfree(s4985_algo);
-	s4985_algo = NULL;
+	
+	return 0;
+}
+
+static void __exit nforce_s4985_exit_one(int bus)
+{
+	int i;
+	union i2c_smbus_data outputconfig;
+
+	for (i = 0; i < 5; i++)
+		i2c_del_adapter(s4985_adapter[bus]+i);
+	kfree(s4985_adapter[bus]);
+	s4985_adapter[bus] = NULL;
+
+	kfree(s4985_algo[bus]);
+	s4985_algo[bus] = NULL;
 
 	/* Restore physical bus */
-	if (i2c_add_adapter(nforce2_smbus))
+	if (i2c_add_adapter(nforce2_smbus[bus]))
 		printk(KERN_ERR "i2c-nforce2-s4985: "
-		       "Physical bus restoration failed\n");
+		       "Physical bus %d restoration failed\n", bus);
+
+	outputconfig.byte = 0x00;
+	if (i2c_smbus_xfer(nforce2_smbus[bus], mplx_addr[bus], 0,
+			       I2C_SMBUS_WRITE, 0x01, I2C_SMBUS_BYTE_DATA,
+			       &outputconfig)) {
+		dev_err(&nforce2_smbus[bus]->dev,
+			"PCA9556 (bus %d) deconfiguration failed\n", bus);
+	}
+}
+
+static void __exit nforce2_s4985_exit(void)
+{
+	if (s4985_adapter[0]) {
+		nforce_s4985_exit_one(0);
+	}
+	if (s4985_adapter[1]) {
+		nforce_s4985_exit_one(1);
+	}
 }
 
 MODULE_AUTHOR("Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>");
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index a605a50..580722a 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -130,18 +130,24 @@ static struct dmi_system_id __devinitdata nforce2_dmi_blacklist2[] = {
 
 static struct pci_driver nforce2_driver;
 
-/* For multiplexing support, we need a global reference to the 1st
-   SMBus channel */
+/* For multiplexing support, we need a global reference to both
+   SMBus channels */
 #if defined CONFIG_I2C_NFORCE2_S4985 || defined CONFIG_I2C_NFORCE2_S4985_MODULE
-struct i2c_adapter *nforce2_smbus;
+struct i2c_adapter *nforce2_smbus[2];
 EXPORT_SYMBOL_GPL(nforce2_smbus);
 
-static void nforce2_set_reference(struct i2c_adapter *adap)
+static void nforce2_set_reference_0(struct i2c_adapter *adap)
 {
-	nforce2_smbus = adap;
+	nforce2_smbus[0] = adap;
+}
+
+static void nforce2_set_reference_1(struct i2c_adapter *adap)
+{
+	nforce2_smbus[1] = adap;
 }
 #else
-static inline void nforce2_set_reference(struct i2c_adapter *adap) { }
+static inline void nforce2_set_reference_0(struct i2c_adapter *adap) { }
+static inline void nforce2_set_reference_1(struct i2c_adapter *adap) { }
 #endif
 
 static void nforce2_abort(struct i2c_adapter *adap)
@@ -425,7 +431,8 @@ static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_
 		return -ENODEV;
 	}
 
-	nforce2_set_reference(&smbuses[0].adapter);
+	nforce2_set_reference_0(&smbuses[0].adapter);
+	nforce2_set_reference_1(&smbuses[1].adapter);
 	return 0;
 }
 
@@ -434,7 +441,8 @@ static void __devexit nforce2_remove(struct pci_dev *dev)
 {
 	struct nforce2_smbus *smbuses = (void*) pci_get_drvdata(dev);
 
-	nforce2_set_reference(NULL);
+	nforce2_set_reference_1(NULL);
+	nforce2_set_reference_0(NULL);
 	if (smbuses[0].base) {
 		i2c_del_adapter(&smbuses[0].adapter);
 		release_region(smbuses[0].base, smbuses[0].size);
