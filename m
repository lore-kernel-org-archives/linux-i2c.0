From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH 2/3] i2c: piix4: fix number of ports on Family 16h Model 30h
Date: Mon, 29 Jan 2018 13:54:19 +1000
Message-ID: <93dea47498cbd29e9d37edd234122cd49252374c.1517195327.git.andrew.cooks@opengear.com>
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

Prevent bus timeouts and resets on Family 16h Model 30h), by not
probing reserved Ports 3 and 4.

According to the AMD BIOS and Kernel Developer's Guides (BKDG), Port 3
and Port 4 are reserved on the following devices:
 - Family 15h Model 60h-6Fh,
 - Family 15h Model 70h-7Fh,
 - Family 16h Models 30h-3Fh,

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 89692f4..9763241 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -82,6 +82,13 @@
 /* Multi-port constants */
 #define PIIX4_MAX_ADAPTERS 4
 
+/*
+ * Main adapter port count. At least one (Port 0) plus up to 3 additional
+ * (Ports 2-4)
+ */
+#define SB800_MAIN_PORTS 4
+#define HUDSON2_MAIN_PORTS 2 /* HUDSON2, reserves Port 3 and Port 4 */
+
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
 
@@ -800,6 +807,7 @@ MODULE_DEVICE_TABLE (pci, piix4_ids);
 
 static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
+static int piix4_adapter_count;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 			     bool sb800_main, u8 port, bool notify_imc,
@@ -856,10 +864,17 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
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
+		port_count = SB800_MAIN_PORTS;
+	}
+
+	for (port = 0; port < port_count; port++) {
 		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
@@ -872,7 +887,7 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
 error:
 	dev_err(&dev->dev,
 		"Error setting up SB800 adapters. Unregistering!\n");
-	while (--port >= 0) {
+	while (--piix4_adapter_count >= 0) {
 		adapdata = i2c_get_adapdata(piix4_main_adapters[port]);
 		if (adapdata->smba) {
 			i2c_del_adapter(piix4_main_adapters[port]);
@@ -993,12 +1008,10 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	int port = PIIX4_MAX_ADAPTERS;
-
-	while (--port >= 0) {
-		if (piix4_main_adapters[port]) {
-			piix4_adap_remove(piix4_main_adapters[port]);
-			piix4_main_adapters[port] = NULL;
+	while (--piix4_adapter_count >= 0) {
+		if (piix4_main_adapters[piix4_adapter_count]) {
+			piix4_adap_remove(piix4_main_adapters[piix4_adapter_count]);
+			piix4_main_adapters[piix4_adapter_count] = NULL;
 		}
 	}
 
-- 
2.7.4
