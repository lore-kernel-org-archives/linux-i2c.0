From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH 2/2] i2c: fix piix4 aux port number
Date: Thu, 23 Nov 2017 13:09:38 +1000
Message-ID: <5e47610fa40bb07b214d1409ae721a5d762eb888.1511391626.git.andrew.cooks@opengear.com>
References: <cover.1511391626.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511391626.git.andrew.cooks@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Andrew Cooks <andrew.cooks@opengear.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Let the aux port use port number one (not zero), to match the AMD
documentation and enable mapping ACPI _ADR to port number.

This fixes ACPI-based enumeration of I2C slave peripherals that are
defined for the aux SMBus port.

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 9260cfa..f980f0b 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -975,7 +975,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, false, 0, false,
+		piix4_add_adapter(dev, retval, false, 1, false,
 				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
 	}
-- 
2.7.4
