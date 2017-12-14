From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v2 3/3] i2c: add ACPI support for i2c-piix4
Date: Thu, 14 Dec 2017 13:11:46 +1000
Message-ID: <fbd6aa2d081baec604b08841be6efa8432f7afd3.1513215039.git.andrew.cooks@opengear.com>
References: <cover.1513215039.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0079.outbound.protection.outlook.com ([104.47.34.79]:7309
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751914AbdLNDMV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 22:12:21 -0500
In-Reply-To: <cover.1513215039.git.andrew.cooks@opengear.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, linux-i2c@vger.kernel.org
Cc: platypus-sw@opengear.com, Andrew Cooks <andrew.cooks@opengear.com>, Wolfram Sang <wsa@the-dreams.de>, open list <linux-kernel@vger.kernel.org>

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
index cc38dc3..65e6390 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -845,6 +845,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
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
