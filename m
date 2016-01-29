From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 1/3] i2c-piix4: Support alternative port selection register
Date: Fri, 29 Jan 2016 10:44:52 +0100
Message-ID: <20160129104452.05e94c08@endymion.delvare>
References: <20160129104146.50f06562@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59232 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbcA2Joz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 04:44:55 -0500
In-Reply-To: <20160129104146.50f06562@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

The SB800 register reference guide says that the SMBus port selection
bits may not always be in register Smbus0En (0x2c) but could
alternatively be found in register Smbus0Sel (0x2e) depending on the
settings in register Smbus0SelEn (0x2f.) Add support for this
configuration.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christian Fetzer <fetzer.ch@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-piix4.c |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

--- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-26 18:25:38.487310421 +0100
+++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-29 07:54:35.135765313 +0100
@@ -85,8 +85,13 @@
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
 
-/* SB800 port is selected by bits 2:1 of the smb_en register (0x2c) */
+/*
+ * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
+ * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
+ */
 #define SB800_PIIX4_PORT_IDX		0x2c
+#define SB800_PIIX4_PORT_IDX_ALT	0x2e
+#define SB800_PIIX4_PORT_IDX_SEL	0x2f
 #define SB800_PIIX4_PORT_IDX_MASK	0x06
 
 /* insmod parameters */
@@ -136,8 +141,13 @@ static const struct dmi_system_id piix4_
 	{ },
 };
 
-/* SB800 globals */
+/*
+ * SB800 globals
+ * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
+ * of I/O ports at SB800_PIIX4_SMB_IDX.
+ */
 static DEFINE_MUTEX(piix4_mutex_sb800);
+static u8 piix4_port_sel_sb800;
 static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
 	" port 0", " port 2", " port 3", " port 4"
 };
@@ -254,7 +264,7 @@ static int piix4_setup_sb800(struct pci_
 			     const struct pci_device_id *id, u8 aux)
 {
 	unsigned short piix4_smba;
-	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
+	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status, port_sel;
 	u8 i2ccfg, i2ccfg_offset = 0x10;
 
 	/* SB800 and later SMBus does not support forcing address */
@@ -334,6 +344,18 @@ static int piix4_setup_sb800(struct pci_
 		 "SMBus Host Controller at 0x%x, revision %d\n",
 		 piix4_smba, i2ccfg >> 4);
 
+	/* Find which register is used for port selection */
+	mutex_lock(&piix4_mutex_sb800);
+	outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
+	port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
+	piix4_port_sel_sb800 = (port_sel & 0x01) ? SB800_PIIX4_PORT_IDX_ALT
+						 : SB800_PIIX4_PORT_IDX;
+	mutex_unlock(&piix4_mutex_sb800);
+
+	dev_info(&PIIX4_dev->dev,
+		 "Using register 0x%02x for SMBus port selection\n",
+		 (unsigned int)piix4_port_sel_sb800);
+
 	return piix4_smba;
 }
 
@@ -563,7 +585,7 @@ static s32 piix4_access_sb800(struct i2c
 
 	mutex_lock(&piix4_mutex_sb800);
 
-	outb_p(SB800_PIIX4_PORT_IDX, SB800_PIIX4_SMB_IDX);
+	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
 
 	port = adapdata->port;

-- 
Jean Delvare
SUSE L3 Support
