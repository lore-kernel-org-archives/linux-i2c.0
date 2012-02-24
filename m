From: Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c multiplexer driver for Proliant microserver N36L
Date: Sat, 25 Feb 2012 06:04:59 +1100
Message-ID: <CAM5MpD5R4xde4Li1NCDoErisXs7oRMAgW7swuCwga80MkU3VMw@mail.gmail.com>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
	<20111127225514.GO19115@trinity.fluff.org>
	<CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
	<20111203162757.GA24302@ericsson.com>
	<CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
	<20111203180819.2ddbcb3a@endymion.delvare>
	<CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA@mail.gmail.com>
	<20111206093906.21dccf8d@endymion.delvare>
	<loom.20120215T165236-509@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20120215T165236-509-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here is the modified patch. As this is my first attempt at submitting
a patch while it obviously isn't ready for inclusion given the errors
any feedback on general style would be welcome.

Tom.

--- linux-3.2.1-gentoo-r2/drivers/i2c/busses/i2c-piix4.c	2012-01-05
10:55:44.000000000 +1100
+++ dev/drivers/i2c/busses/i2c-piix4.c	2012-02-25 04:53:04.743198258 +1100
@@ -25,7 +25,10 @@
 	AMD Hudson-2
 	SMSC Victory66

-   Note: we assume there can only be one device, with one SMBus interface.
+   Note: we assume there can only be one device.
+   The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
+   For devices supporting multiple ports the i2c_adapter should provide
+   an i2c_algorithm to access them.
 */

 #include <linux/module.h>
@@ -40,6 +43,7 @@
 #include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
+#include <linux/mutex.h>


 /* PIIX4 SMBus address offsets */
@@ -78,6 +82,9 @@
 #define PIIX4_WORD_DATA		0x0C
 #define PIIX4_BLOCK_DATA	0x14

+/* Multi-port constants */
+#define PIIX4_MAX_ADAPTERS 4
+
 /* insmod parameters */

 /* If force is set to anything different from 0, we forcibly enable the
@@ -97,7 +104,15 @@ MODULE_PARM_DESC(force_addr,
 static unsigned short piix4_smba;
 static int srvrworks_csb5_delay;
 static struct pci_driver piix4_driver;
-static struct i2c_adapter piix4_adapter;
+static struct i2c_adapter *piix4_adapters[PIIX4_MAX_ADAPTERS];
+
+/* SB800 globals */
+DEFINE_MUTEX(piix4_mutex_sb800);
+static u8 piix4_adapter_ports_sb800[4];
+static u8 piix4_sel_port_sb800 = -1;
+static const char *piix4_port_names_sb800[4] = {
+	"SDA0", "SDA2", "SDA3", "SDA4"
+};

 static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
 	{
@@ -284,6 +299,8 @@ static int __devinit piix4_setup_sb800(s
 	else
 		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus.\n");

+	mutex_init(&piix4_mutex_sb800);
+
 	dev_info(&PIIX4_dev->dev,
 		 "SMBus Host Controller at 0x%x, revision %d\n",
 		 piix4_smba, i2ccfg >> 4);
@@ -291,27 +308,27 @@ static int __devinit piix4_setup_sb800(s
 	return 0;
 }

-static int piix4_transaction(void)
+static int piix4_transaction(struct i2c_adapter *adap)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;

-	dev_dbg(&piix4_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
+	dev_dbg(&adap->dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
 		inb_p(SMBHSTDAT1));

 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		dev_dbg(&piix4_adapter.dev, "SMBus busy (%02x). "
+		dev_dbg(&adap->dev, "SMBus busy (%02x). "
 			"Resetting...\n", temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-			dev_err(&piix4_adapter.dev, "Failed! (%02x)\n", temp);
+			dev_err(&adap->dev, "Failed! (%02x)\n", temp);
 			return -EBUSY;
 		} else {
-			dev_dbg(&piix4_adapter.dev, "Successful!\n");
+			dev_dbg(&adap->dev, "Successful!\n");
 		}
 	}

@@ -330,35 +347,35 @@ static int piix4_transaction(void)

 	/* If the SMBus is still busy, we give up */
 	if (timeout == MAX_TIMEOUT) {
-		dev_err(&piix4_adapter.dev, "SMBus Timeout!\n");
+		dev_err(&adap->dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
 	}

 	if (temp & 0x10) {
 		result = -EIO;
-		dev_err(&piix4_adapter.dev, "Error: Failed bus transaction\n");
+		dev_err(&adap->dev, "Error: Failed bus transaction\n");
 	}

 	if (temp & 0x08) {
 		result = -EIO;
-		dev_dbg(&piix4_adapter.dev, "Bus collision! SMBus may be "
+		dev_dbg(&adap->dev, "Bus collision! SMBus may be "
 			"locked until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}

 	if (temp & 0x04) {
 		result = -ENXIO;
-		dev_dbg(&piix4_adapter.dev, "Error: no response!\n");
+		dev_dbg(&adap->dev, "Error: no response!\n");
 	}

 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);

 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		dev_err(&piix4_adapter.dev, "Failed reset at end of "
+		dev_err(&adap->dev, "Failed reset at end of "
 			"transaction (%02x)\n", temp);
 	}
-	dev_dbg(&piix4_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+	dev_dbg(&adap->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
 		inb_p(SMBHSTDAT1));
@@ -426,7 +443,7 @@ static s32 piix4_access(struct i2c_adapt

 	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);

-	status = piix4_transaction();
+	status = piix4_transaction(adap);
 	if (status)
 		return status;

@@ -454,6 +471,47 @@ static s32 piix4_access(struct i2c_adapt
 	return 0;
 }

+/* Handles access to multiple SMBus ports on the SB800.
+ * The port is selected by bits 2:1 of the smb_en register (0x2C).
+ * Return negative errno on error.
+ */
+static s32 piix4_access_sb800(struct i2c_adapter * adap, u16 addr,
+		 unsigned short flags, char read_write,
+		 u8 command, int size, union i2c_smbus_data * data)
+{
+	unsigned short smba_idx = 0xcd6;
+	u8 smba_en_lo, smb_en = 0x2c;
+	u8 port;
+	int retval;
+
+	mutex_lock(&piix4_mutex_sb800);
+
+	port = *((u8*)adap->algo_data);
+	if(port != piix4_sel_port_sb800) {
+		if (!request_region(smba_idx, 2, "smba_idx")) {
+			dev_err(&adap->dev, "SMBus base address index region "
+				"0x%x already in use!\n", smba_idx);
+			retval = -EBUSY;
+			goto ERROR;
+		}
+		outb_p(smb_en, smba_idx);
+		smba_en_lo = inb_p(smba_idx + 1);
+		smba_en_lo = (smba_en_lo & ~6) | (port << 1);
+		outb_p(smba_en_lo, smba_idx + 1);
+		release_region(smba_idx, 2);
+		piix4_sel_port_sb800 = port;
+		dev_dbg(&adap->dev, "SB800 SMBus port set to %s\n",
piix4_port_names_sb800[port]);
+		msleep(50);
+	}
+
+	retval = piix4_access(adap, addr, flags, read_write, command, size, data);
+
+	ERROR:
+	mutex_unlock(&piix4_mutex_sb800);
+
+	return retval;
+}
+
 static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -461,17 +519,95 @@ static u32 piix4_func(struct i2c_adapter
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }

-static const struct i2c_algorithm smbus_algorithm = {
+static const struct i2c_algorithm piix4_smbus_algorithm = {
 	.smbus_xfer	= piix4_access,
 	.functionality	= piix4_func,
 };

-static struct i2c_adapter piix4_adapter = {
-	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.algo		= &smbus_algorithm,
+static const struct i2c_algorithm piix4_smbus_algorithm_sb800 = {
+	.smbus_xfer	= piix4_access_sb800,
+	.functionality	= piix4_func,
 };

+static int __devinit piix4_setup_adapters(struct pci_dev *dev)
+{
+	int retval;
+
+	if (!(piix4_adapters[0] = kzalloc(sizeof(**piix4_adapters), GFP_KERNEL)))
+		return -ENOMEM;
+
+	piix4_adapters[0]->owner = THIS_MODULE;
+	piix4_adapters[0]->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	piix4_adapters[0]->algo  = &piix4_smbus_algorithm;
+
+	/* set up the sysfs linkage to our parent device */
+	piix4_adapters[0]->dev.parent = &dev->dev;
+
+	snprintf(piix4_adapters[0]->name, sizeof(piix4_adapters[0]->name),
+		"SMBus PIIX4 adapter at %04x", piix4_smba);
+
+	if ((retval = i2c_add_adapter(piix4_adapters[0]))) {
+		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		kfree(piix4_adapters[0]);
+		piix4_adapters[0] = NULL;
+	}
+
+	return retval;
+}
+
+static int __devinit piix4_setup_adapters_sb800(struct pci_dev *dev)
+{
+	int i, retval;
+
+	dev_dbg(&dev->dev, "piix4_setup_adapters_sb800");
+
+	/* Register 4 adapters */
+	for (i = 0; i < 4; i++) {
+		if (!(piix4_adapters[i] = kzalloc(sizeof(**piix4_adapters), GFP_KERNEL))) {
+			dev_err(&dev->dev, "Out of memory!\n");
+			retval = -ENOMEM;
+			goto ERROR;
+
+		}
+		piix4_adapters[i]->owner = THIS_MODULE;
+		piix4_adapters[i]->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+		piix4_adapters[i]->algo  = &piix4_smbus_algorithm_sb800;
+
+		piix4_adapter_ports_sb800[i] = i;
+		piix4_adapters[i]->algo_data = &(piix4_adapter_ports_sb800[i]);
+
+		/* set up the sysfs linkage to our parent device */
+		piix4_adapters[i]->dev.parent = &dev->dev;
+
+		dev_dbg(&dev->dev, "sizeof(piix4_adapters[%d]->name) = %ld\n", i,
sizeof(piix4_adapters[i]->name));
+
+		snprintf(piix4_adapters[i]->name, sizeof(piix4_adapters[i]->name),
+			"SB800 SMBus adapter %s at %04x",
+			piix4_port_names_sb800[i], piix4_smba);
+		dev_dbg(&dev->dev, "piix4_adapters[%d]->name = \"%s\" (%ld)\n", i,
piix4_adapters[i]->name, strlen(piix4_adapters[i]->name));
+
+		if ((retval = i2c_add_adapter(piix4_adapters[i]))) {
+			dev_err(&dev->dev, "Couldn't register SB800 adapter %s (%d)!\n",
+					piix4_port_names_sb800[i], retval);
+			kfree(piix4_adapters[i]);
+			piix4_adapters[i] = NULL;
+			goto ERROR;
+		}
+	}
+
+	return retval;
+
+	ERROR:
+	dev_err(&dev->dev,
+			"Error setting up SB800 adapters. Unregistering all adapters!\n");
+	for (i--; i >= 0; i--) {
+		i2c_del_adapter(piix4_adapters[i]);
+		kfree(piix4_adapters[i]);
+		piix4_adapters[i] = NULL;
+	}
+	return retval;
+}
+
 static const struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3) },
@@ -501,26 +637,25 @@ static int __devinit piix4_probe(struct
 {
 	int retval;

+	dev_dbg(&dev->dev, "piix4_probe: vendor: %d; device: %d; Rev: %d",
+			dev->vendor, dev->device, dev->revision);
+
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
-	    dev->vendor == PCI_VENDOR_ID_AMD)
-		/* base address location etc changed in SB800 */
-		retval = piix4_setup_sb800(dev, id);
-	else
-		retval = piix4_setup(dev, id);
-
-	if (retval)
-		return retval;
-
-	/* set up the sysfs linkage to our parent device */
-	piix4_adapter.dev.parent = &dev->dev;
-
-	snprintf(piix4_adapter.name, sizeof(piix4_adapter.name),
-		"SMBus PIIX4 adapter at %04x", piix4_smba);
+	    dev->vendor == PCI_VENDOR_ID_AMD) {
+		dev_dbg(&dev->dev, "piix4_probe: SB800 detected");
+		/* SB800 uses a different base address and has 4 SMBus ports */
+		if ((retval = piix4_setup_sb800(dev, id)))
+			return retval;
+		retval = piix4_setup_adapters_sb800(dev);
+	} else {
+		if ((retval = piix4_setup(dev, id)))
+			return retval;
+		retval = piix4_setup_adapters(dev);
+	}

-	if ((retval = i2c_add_adapter(&piix4_adapter))) {
-		dev_err(&dev->dev, "Couldn't register adapter!\n");
+	if (retval) {
 		release_region(piix4_smba, SMBIOSIZE);
 		piix4_smba = 0;
 	}
@@ -530,8 +665,16 @@ static int __devinit piix4_probe(struct

 static void __devexit piix4_remove(struct pci_dev *dev)
 {
+	int i;
+
+	for (i = 0; i < PIIX4_MAX_ADAPTERS; i++) {
+		if (piix4_adapters[i]) {
+			i2c_del_adapter(piix4_adapters[i]);
+			kfree(piix4_adapters[i]);
+			piix4_adapters[i] = NULL;
+		}
+	}
 	if (piix4_smba) {
-		i2c_del_adapter(&piix4_adapter);
 		release_region(piix4_smba, SMBIOSIZE);
 		piix4_smba = 0;
 	}
