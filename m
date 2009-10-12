From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Modify code name SB900 to Hudson-2
Date: Mon, 12 Oct 2009 10:05:18 +0800
Message-ID: <20091012020518.GA19626@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,
We have changed the name of SB900 chip, and the source needs change also.
Please apply.
Thanks,
- Crane

---
Change SB900 to its formal code name Hudson-2.

Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
---
 Documentation/i2c/busses/i2c-piix4 |    2 +-
 drivers/i2c/busses/Kconfig         |    2 +-
 drivers/i2c/busses/i2c-piix4.c     |    4 ++--
 include/linux/pci_ids.h            |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index c5b37c5..ac540c7 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -8,7 +8,7 @@ Supported adapters:
     Datasheet: Only available via NDA from ServerWorks
   * ATI IXP200, IXP300, IXP400, SB600, SB700 and SB800 southbridges
     Datasheet: Not publicly available
-  * AMD SB900
+  * AMD Hudson-2
     Datasheet: Not publicly available
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 737335f..e8fe7f1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -128,7 +128,7 @@ config I2C_PIIX4
 	    ATI SB600
 	    ATI SB700
 	    ATI SB800
-	    AMD SB900
+	    AMD Hudson-2
 	    Serverworks OSB4
 	    Serverworks CSB5
 	    Serverworks CSB6
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index d26a972..b12dd8b 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -22,7 +22,7 @@
 	Intel PIIX4, 440MX
 	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
 	ATI IXP200, IXP300, IXP400, SB600, SB700, SB800
-	AMD SB900
+	AMD Hudson-2
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one SMBus interface.
@@ -480,7 +480,7 @@ static struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SB900_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON_2_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
 		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index da1fda8..db83a10 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -543,7 +543,7 @@
 #define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
 #define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
 #define PCI_DEVICE_ID_AMD_8132_BRIDGE	0x7458
-#define PCI_DEVICE_ID_AMD_SB900_SMBUS	0x780b
+#define PCI_DEVICE_ID_AMD_HUDSON_2_SMBUS	0x780b
 #define PCI_DEVICE_ID_AMD_CS5535_IDE    0x208F
 #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
 #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
-- 
1.6.0.4
