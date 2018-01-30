From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 1/3] i2c: piix4: Fix port selection for AMD Family 16h Model 30h
Date: Wed, 31 Jan 2018 07:40:28 +1000
Message-ID: <be68c29f603153cf047cd893c6b9d6423073632d.1517285239.git.andrew.cooks@opengear.com>
References: <cover.1517285239.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com ([104.47.37.49]:63584
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751755AbeA3VlM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 30 Jan 2018 16:41:12 -0500
In-Reply-To: <cover.1517285239.git.andrew.cooks@opengear.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Andrew Cooks <andrew.cooks@opengear.com>

Family 16h Model 30h SMBus controller has the same port selection
register as described and fixed in commit 0fe16195f891
("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")

commit 6befa3fde65fe ("i2c: piix4: Support alternative port selection
register") also fixed the port selection for Hudson2. Unfortunately the
AMD naming and PCI Device IDs aren't particularly helpful here.

The SMBus port selection register is common to the following Families
and models, as documented in AMD's publicly available BIOS and Kernel
Developer Guides:

 50742 - Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 55072 - Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 52740 - Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)

The Hudson2 PCI Device ID (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) is shared
between Bolton FCH and Family 16h Model 30h, but the location of the
SmBus0Sel port selection bits are different:

 51192 - Bolton Register Reference Guide

We distinguish between Bolton and Family 16h Model 30h using the PCI
Revision ID:

  Bolton is device 0x780b, revision 0x15
  Family 16h Model 30h is device 0x780b, revision 0x1F
  Family 15h Model 60h and 70h are both device 0x790b, revision 0x4A.

The following additional public AMD BKDG documents were checked and do
not share the same port selection register:

 42301 - Family 15h Model 00h-0Fh doesn't mention any
 42300 - Family 15h Model 10h-1Fh doesn't mention any
 49125 - Family 15h Model 30h-3Fh doesn't mention any

 48751 - Family 16h Model 00h-0Fh uses the previously supported
         index register SB800_PIIX4_PORT_IDX_ALT at 0x2e

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 174579d..5c90a44 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -99,7 +99,7 @@
 #define SB800_PIIX4_PORT_IDX_MASK	0x06
 #define SB800_PIIX4_PORT_IDX_SHIFT	1
 
-/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
+/* On kerncz and Hudson2, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
 #define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
 #define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
 #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
@@ -359,18 +359,16 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
 	/* Find which register is used for port selection */
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
-		switch (PIIX4_dev->device) {
-		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
+		if ((PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) ||
+		    (PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
+			   PIIX4_dev->revision >= 0x1F)) {
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK_KERNCZ;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ;
-			break;
-		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
-		default:
+		} else {
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
-			break;
 		}
 	} else {
 		mutex_lock(&piix4_mutex_sb800);
-- 
2.7.4
