From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RESEND][PATCH v4 3/3] i2c: piix4: add ACPI support
Date: Wed, 24 Jul 2019 15:59:27 +0200
Message-ID: <20190724155927.17444ab3@endymion>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
        <d197d95d77afa2054ff1b2c593dae7939030e24b.1519601860.git.andrew.cooks@opengear.com>
        <20190724145516.342195ac@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724145516.342195ac@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org, platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>, Guenter Roeck <linux@roeck-us.net>, Will Wagner <willw@carallon.com>
List-Id: linux-i2c@vger.kernel.org

My attempt looks like that:

Based on earlier work by Andrew Cooks.

Enable the i2c-piix4 SMBus controller driver to enumerate I2C slave
devices using ACPI. It builds on the related I2C mux device work
in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")

In the i2c-piix4 driver the adapters are enumerated as:
 Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)

However, in the AMD BKDG documentation[1], the implied order of ports is:
 Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...

This ordering difference is unfortunate. We assume that ACPI
developers will use the AMD documentation ordering, so we have to
pass an extra parameter to piix4_add_adapter().

[1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
Models 30h-3Fh Processors

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/i2c/busses/i2c-piix4.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- linux-5.1.orig/drivers/i2c/busses/i2c-piix4.c	2019-07-24 11:29:49.836450493 +0200
+++ linux-5.1/drivers/i2c/busses/i2c-piix4.c	2019-07-24 15:21:20.166362730 +0200
@@ -819,7 +819,8 @@ static int piix4_adapter_count;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 			     bool sb800_main, u8 port, bool notify_imc,
-			     const char *name, struct i2c_adapter **padap)
+			     u8 hw_port_nr, const char *name,
+			     struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
 	struct i2c_piix4_adapdata *adapdata;
@@ -851,6 +852,12 @@ static int piix4_add_adapter(struct pci_
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
 
+	if (has_acpi_companion(&dev->dev)) {
+		acpi_preset_companion(&adap->dev,
+				ACPI_COMPANION(&dev->dev),
+				hw_port_nr);
+	}
+
 	snprintf(adap->name, sizeof(adap->name),
 		"SMBus PIIX4 adapter%s at %04x", name, smba);
 
@@ -883,7 +890,10 @@ static int piix4_add_adapters_sb800(stru
 	}
 
 	for (port = 0; port < piix4_adapter_count; port++) {
+		u8 hw_port_nr = port == 0 ? 0 : port + 1;
+
 		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
+					   hw_port_nr,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
 		if (retval < 0)
@@ -954,8 +964,8 @@ static int piix4_probe(struct pci_dev *d
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, false, 0, false, "",
-					   &piix4_main_adapters[0]);
+		retval = piix4_add_adapter(dev, retval, false, 0, false, 0,
+					   "", &piix4_main_adapters[0]);
 		if (retval < 0)
 			return retval;
 	}
@@ -981,7 +991,7 @@ static int piix4_probe(struct pci_dev *d
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, false, 0, false,
+		piix4_add_adapter(dev, retval, false, 0, false, 1,
 				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
 	}


-- 
Jean Delvare
SUSE L3 Support
