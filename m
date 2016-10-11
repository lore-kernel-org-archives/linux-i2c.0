From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 4/5] i2c: i2c-piix4: coding style fix - spaces with open parenthesis
Date: Tue, 11 Oct 2016 18:24:40 +0100
Message-ID: <20161011172441.7422-5-palminha@synopsys.com>
References: <20161011172441.7422-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011172441.7422-1-palminha@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, wsa@the-dreams.de, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/i2c/busses/i2c-piix4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 85b1052..5cc460a 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -102,7 +102,7 @@
  * PIIX4. DANGEROUS!
  */
 static int force;
-module_param (force, int, 0);
+module_param(force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
 /*
@@ -110,7 +110,7 @@ MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
  * the PIIX4 at the given address. VERY DANGEROUS!
  */
 static int force_addr;
-module_param (force_addr, int, 0);
+module_param(force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
@@ -204,7 +204,7 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	} else {
 		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
 		piix4_smba &= 0xfff0;
-		if(piix4_smba == 0) {
+		if (piix4_smba == 0) {
 			dev_err(&PIIX4_dev->dev, "SMBus base address "
 				"uninitialized - upgrade BIOS or use "
 				"force_addr=0xaddr\n");
@@ -664,7 +664,7 @@ static const struct pci_device_id piix4_ids[] = {
 	{ 0, }
 };
 
-MODULE_DEVICE_TABLE (pci, piix4_ids);
+MODULE_DEVICE_TABLE(pci, piix4_ids);
 
 static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
-- 
2.9.3
