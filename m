From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH] i2c-piix4: Add Hygon Dhyana SMBus support
Date: Wed, 17 Apr 2019 18:53:39 +0800
Message-ID: <1555498419-6136-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jdelvare@suse.com, bp@alien8.de
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-i2c@vger.kernel.org

The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
to the i2c-piix4 driver by using the code path of AMD.

Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/i2c/busses/i2c-piix4.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 90946a8..9db9d9d 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -289,6 +289,9 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	     PIIX4_dev->revision >= 0x41) ||
 	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
 	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
+	     PIIX4_dev->revision >= 0x49) ||
+	    (PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON &&
+	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	     PIIX4_dev->revision >= 0x49))
 		smb_en = 0x00;
 	else
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
