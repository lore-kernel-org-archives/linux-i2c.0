From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 3/5] i2c: i2c-piix4: coding style fix - long comments blocks
Date: Tue, 11 Oct 2016 18:24:39 +0100
Message-ID: <20161011172441.7422-4-palminha@synopsys.com>
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
 drivers/i2c/busses/i2c-piix4.c | 94 ++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 5d6f637..85b1052 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -1,32 +1,32 @@
 /*
-    Copyright (c) 1998 - 2002 Frodo Looijaard <frodol@dds.nl> and
-    Philip Edelbrock <phil@netroedge.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-*/
+ *  Copyright (c) 1998 - 2002 Frodo Looijaard <frodol@dds.nl> and
+ *  Philip Edelbrock <phil@netroedge.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
 
 /*
-   Supports:
-	Intel PIIX4, 440MX
-	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
-	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
-	AMD Hudson-2, ML, CZ
-	SMSC Victory66
-
-   Note: we assume there can only be one device, with one or more
-   SMBus interfaces.
-   The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
-   For devices supporting multiple ports the i2c_adapter should provide
-   an i2c_algorithm to access them.
-*/
+ * Supports:
+ *	Intel PIIX4, 440MX
+ *	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
+ *	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
+ *	AMD Hudson-2, ML, CZ
+ *	SMSC Victory66
+ *
+ *  Note: we assume there can only be one device, with one or more
+ * SMBus interfaces.
+ * The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
+ * For devices supporting multiple ports the i2c_adapter should provide
+ * an i2c_algorithm to access them.
+ */
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -97,14 +97,18 @@
 
 /* insmod parameters */
 
-/* If force is set to anything different from 0, we forcibly enable the
-   PIIX4. DANGEROUS! */
+/*
+ * If force is set to anything different from 0, we forcibly enable the
+ * PIIX4. DANGEROUS!
+ */
 static int force;
 module_param (force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
-/* If force_addr is set to anything different from 0, we forcibly enable
-   the PIIX4 at the given address. VERY DANGEROUS! */
+/*
+ * If force_addr is set to anything different from 0, we forcibly enable
+ * the PIIX4 at the given address. VERY DANGEROUS!
+ */
 static int force_addr;
 module_param (force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
@@ -132,8 +136,10 @@ static const struct dmi_system_id piix4_dmi_blacklist[] = {
 	{ }
 };
 
-/* The IBM entry is in a separate table because we only check it
-   on Intel-based systems */
+/*
+ * The IBM entry is in a separate table because we only check it
+ * on Intel-based systems
+ */
 static const struct dmi_system_id piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
@@ -172,8 +178,10 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	    (PIIX4_dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5))
 		srvrworks_csb5_delay = 1;
 
-	/* On some motherboards, it was reported that accessing the SMBus
-	   caused severe hardware problems */
+	/*
+	 * On some motherboards, it was reported that accessing the SMBus
+	 * caused severe hardware problems
+	 */
 	if (dmi_check_system(piix4_dmi_blacklist)) {
 		dev_err(&PIIX4_dev->dev,
 			"Accessing the SMBus on this system is unsafe!\n");
@@ -215,8 +223,10 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
 
-	/* If force_addr is set, we program the new address here. Just to make
-	   sure, we disable the PIIX4 first. */
+	/*
+	 * If force_addr is set, we program the new address here. Just to make
+	 * sure, we disable the PIIX4 first.
+	 */
 	if (force_addr) {
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
@@ -369,8 +379,10 @@ static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 			   const struct pci_device_id *id,
 			   unsigned short base_reg_addr)
 {
-	/* Set up auxiliary SMBus controllers found on some
-	 * AMD chipsets e.g. SP5100 (SB700 derivative) */
+	/*
+	 * Set up auxiliary SMBus controllers found on some
+	 * AMD chipsets e.g. SP5100 (SB700 derivative)
+	 */
 
 	unsigned short piix4_smba;
 
@@ -804,8 +816,10 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	if (retval > 0) {
-		/* Try to add the aux adapter if it exists,
-		 * piix4_add_adapter will clean up if this fails */
+		/*
+		 * Try to add the aux adapter if it exists,
+		 * piix4_add_adapter will clean up if this fails
+		 */
 		piix4_add_adapter(dev, retval, false, 0,
 				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
-- 
2.9.3
