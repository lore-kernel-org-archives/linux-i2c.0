From: Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH v2] i2c-piix4: Add Hygon Dhyana SMBus support
Date: Sat, 27 Apr 2019 09:07:44 +0800
Message-ID: <1556327264-31730-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jdelvare@suse.com, bp@alien8.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-i2c@vger.kernel.org

The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
to the i2c-piix4 driver by using the code path of AMD.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
v1->v2:
  - Remove the revision number checking for Hygon SMBus device.
  - Document the new supported chipset in drivers/i2c/busses/Kconfig
    and Documentation/i2c/busses/i2c-piix4 as well as in the header
	comment of i2c-piix4.c.

 Documentation/i2c/busses/i2c-piix4 |  2 ++
 drivers/i2c/busses/Kconfig         |  1 +
 drivers/i2c/busses/i2c-piix4.c     | 15 +++++++++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index aa959fd..2703bc3 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -15,6 +15,8 @@ Supported adapters:
     http://support.amd.com/us/Embedded_TechDocs/44413.pdf
   * AMD Hudson-2, ML, CZ
     Datasheet: Not publicly available
+  * Hygon CZ
+    Datasheet: Not publicly available
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f8979ab..50ec2e4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -176,6 +176,7 @@ config I2C_PIIX4
 	    AMD Hudson-2
 	    AMD ML
 	    AMD CZ
+	    Hygon CZ
 	    Serverworks OSB4
 	    Serverworks CSB5
 	    Serverworks CSB6
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 90946a8..e9a0514 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -19,6 +19,7 @@
 	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
 	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
 	AMD Hudson-2, ML, CZ
+	Hygon CZ
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one or more
@@ -289,7 +290,9 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	     PIIX4_dev->revision >= 0x41) ||
 	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
 	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
-	     PIIX4_dev->revision >= 0x49))
+	     PIIX4_dev->revision >= 0x49) ||
+	    (PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON &&
+	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS))
 		smb_en = 0x00;
 	else
 		smb_en = (aux) ? 0x28 : 0x2c;
@@ -361,7 +364,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 		 piix4_smba, i2ccfg >> 4);
 
 	/* Find which register is used for port selection */
-	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
+	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD ||
+	    PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON) {
 		switch (PIIX4_dev->device) {
 		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
@@ -794,6 +798,7 @@ static const struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
 		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
@@ -904,11 +909,13 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
-	    dev->vendor == PCI_VENDOR_ID_AMD) {
+	    dev->vendor == PCI_VENDOR_ID_AMD ||
+	    dev->vendor == PCI_VENDOR_ID_HYGON) {
 		bool notify_imc = false;
 		is_sb800 = true;
 
-		if (dev->vendor == PCI_VENDOR_ID_AMD &&
+		if ((dev->vendor == PCI_VENDOR_ID_AMD ||
+		     dev->vendor == PCI_VENDOR_ID_HYGON) &&
 		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
 			u8 imc;
 
-- 
2.7.4
