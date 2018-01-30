From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 3/3] i2c: piix4: add ACPI support
Date: Wed, 31 Jan 2018 07:40:30 +1000
Message-ID: <d197d95d77afa2054ff1b2c593dae7939030e24b.1517285239.git.andrew.cooks@opengear.com>
References: <cover.1517285239.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1517285239.git.andrew.cooks@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Andrew Cooks <andrew.cooks@opengear.com>
List-Id: linux-i2c@vger.kernel.org

Enable the i2c-piix4 SMBus controller driver to enumerate I2C slave
devices using ACPI. It builds on the related I2C mux device work
in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")

In the i2c-piix4 driver the adapters are enumerated as:
 Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)

However, in the AMD BKDG documentation[1], the implied order of ports is:
 Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...

This ordering difference is unfortunate, and we assume that ACPI
developers will use the Linux ordering, as follows:

Device(SBUS) {
        Name(_ADR, 0x00140000)
        Name(_HID, "SMB0001")

        Device(CH00) {
                Name(_ADR, 0) // main SMBus adapter, Port 0
                Name (_STR, Unicode ("Main SMBus adapter, Port 0"))
        }

        Device(CH01) {
                Name(_ADR, 1) // main SMBus Port 2 (Port 1 label is undefined)
                Name (_STR, Unicode ("Main SMBus adapter, Port 2"))
        }

        Device (CH02) {
                Name(_ADR, 2) // ASF adapter (what Linux calls 'aux port')
                Name (_STR, Unicode ("AUX / ASF SMBus adapter"))
        }
}

[1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
Models 30h-3Fh Processors

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 01f1610..9a6cdc8 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -837,6 +837,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
 
+	if (has_acpi_companion(&dev->dev)) {
+		acpi_preset_companion(&adap->dev,
+				ACPI_COMPANION(&dev->dev),
+				piix4_adapter_count);
+	}
+
 	snprintf(adap->name, sizeof(adap->name),
 		"SMBus PIIX4 adapter%s at %04x", name, smba);
 
-- 
2.7.4
