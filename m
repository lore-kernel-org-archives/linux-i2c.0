From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v2 1/3] i2c: piix4: Fix SMBus port selection for AMD Family 16h chips
Date: Thu, 14 Dec 2017 13:11:44 +1000
Message-ID: <3f87f37117e6662661f16ea8fdbbdffff5d2e414.1513215039.git.andrew.cooks@opengear.com>
References: <cover.1513215039.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:17872
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751914AbdLNDMN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 22:12:13 -0500
In-Reply-To: <cover.1513215039.git.andrew.cooks@opengear.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, linux-i2c@vger.kernel.org
Cc: platypus-sw@opengear.com, Andrew Cooks <andrew.cooks@opengear.com>, Wolfram Sang <wsa@the-dreams.de>, open list <linux-kernel@vger.kernel.org>

HUDSON2 SMBus controller has the same port selection register as
described and fixed in commit 0fe16195f89173652cf111d7b384941b00c5aabd
("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")

The SMBus port selection register is common to multiple Families and
models, as documented in AMD's publicly available BIOS and Kernel
Developer Guides:

 - 50742 -- Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 - 55072 -- Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 - 52740 -- Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)

The following additional public AMD BKDG documents were checked and do
not share the same port selection register:

 - 42301 -- Family 15h Model 00h-0Fh doesn't mention any
 - 42300 -- Family 15h Model 10h-1Fh doesn't mention any
 - 49125 -- Family 15h Model 30h-3Fh doesn't mention any

 - 48751 -- Family 16h Model 00h-0Fh uses the previously supported
   index register SB800_PIIX4_PORT_IDX_ALT at 0x2e

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 462948e..b92ea5d 100644
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
@@ -360,12 +360,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	/* Find which register is used for port selection */
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
 		switch (PIIX4_dev->device) {
+		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
 		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK_KERNCZ;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ;
 			break;
-		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
 		default:
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
-- 
2.7.4
