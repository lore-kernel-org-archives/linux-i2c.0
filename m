From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 2/3] i2c: piix4: fix probing of reserved ports on AMD
Date: Wed, 31 Jan 2018 07:40:29 +1000
Message-ID: <970f151329b43cfa5f842dc0fe0604b03c5c1297.1517285239.git.andrew.cooks@opengear.com>
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

Prevent bus timeouts and resets on Family 16h Model 30h), by not
probing reserved Ports 3 and 4.

According to the AMD BIOS and Kernel Developer's Guides (BKDG), Port 3
and Port 4 are reserved on the following devices:
 - Family 15h Model 60h-6Fh,
 - Family 15h Model 70h-7Fh,
 - Family 16h Model 30h-3Fh,

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 5c90a44..01f1610 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -80,7 +80,8 @@
 #define PIIX4_BLOCK_DATA	0x14
 
 /* Multi-port constants */
-#define PIIX4_MAX_ADAPTERS 4
+#define PIIX4_MAX_ADAPTERS	4
+#define HUDSON2_MAIN_PORTS	2 /* HUDSON2, KERNCZ reserves ports 3, 4 */
 
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
@@ -800,6 +801,7 @@ MODULE_DEVICE_TABLE (pci, piix4_ids);
 
 static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
+static int piix4_adapter_count;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 			     bool sb800_main, u8 port, bool notify_imc,
@@ -849,6 +851,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	*padap = adap;
+	piix4_adapter_count++;
 	return 0;
 }
 
@@ -856,10 +859,17 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
 				    bool notify_imc)
 {
 	struct i2c_piix4_adapdata *adapdata;
-	int port;
+	int port, port_count;
 	int retval;
 
-	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
+	if (dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS ||
+	    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+		port_count = HUDSON2_MAIN_PORTS;
+	} else {
+		port_count = PIIX4_MAX_ADAPTERS;
+	}
+
+	for (port = 0; port < port_count; port++) {
 		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
@@ -889,6 +899,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
 	bool is_sb800 = false;
+	piix4_adapter_count = 0;
 
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
@@ -993,7 +1004,7 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	int port = PIIX4_MAX_ADAPTERS;
+	int port = piix4_adapter_count;
 
 	while (--port >= 0) {
 		if (piix4_main_adapters[port]) {
-- 
2.7.4
