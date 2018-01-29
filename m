From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH 3/3] i2c: add ACPI support for i2c-piix4
Date: Mon, 29 Jan 2018 13:54:20 +1000
Message-ID: <f6b7e8e5dc31d294c08d1c218b59e1afce820b37.1517195327.git.andrew.cooks@opengear.com>
References: <cover.1517195327.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1517195327.git.andrew.cooks@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Andrew Cooks <andrew.cooks@opengear.com>
List-Id: linux-i2c@vger.kernel.org

This enables the i2c-piix4 SMBus controller driver to enumerate I2C
slave devices using ACPI. It builds on the related I2C mux device work
in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")

In the i2c-piix4 driver the adapters are enumerated as:
 Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)

However, in the AMD BKDG documentation[1], the implied order of ports is:
 Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...

This ordering difference is unfortunate, and we assume that ACPI
developers will use the Linux ordering.

[1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
Models 30h-3Fh Processors

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 9763241..97eb6ae 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -843,6 +843,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
 
+	if (has_acpi_companion(&dev->dev)) {
+		acpi_preset_companion(&adap->dev,
+				      ACPI_COMPANION(&dev->dev),
+				      piix4_adapter_count++);
+	}
+
 	snprintf(adap->name, sizeof(adap->name),
 		"SMBus PIIX4 adapter%s at %04x", name, smba);
 
-- 
2.7.4
