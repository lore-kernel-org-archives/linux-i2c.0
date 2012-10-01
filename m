From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-viapro: Add VIA VX900 device ID
Date: Mon, 1 Oct 2012 14:00:42 +0200
Message-ID: <20121001140042.5c5f8755@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The SMBus controller in the VIA VX900 appears to be compatible with
the VIA VX855, so just add the device ID.

This closes kernel bug #43096.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-viapro.c |    3 +++
 include/linux/pci_ids.h         |    1 +
 2 files changed, 4 insertions(+)

--- linux-3.6-rc7.orig/drivers/i2c/busses/i2c-viapro.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.6-rc7/drivers/i2c/busses/i2c-viapro.c	2012-10-01 09:06:59.975354890 +0200
@@ -401,6 +401,7 @@ found:
 	case PCI_DEVICE_ID_VIA_CX700:
 	case PCI_DEVICE_ID_VIA_VX800:
 	case PCI_DEVICE_ID_VIA_VX855:
+	case PCI_DEVICE_ID_VIA_VX900:
 	case PCI_DEVICE_ID_VIA_8251:
 	case PCI_DEVICE_ID_VIA_8237:
 	case PCI_DEVICE_ID_VIA_8237A:
@@ -470,6 +471,8 @@ static DEFINE_PCI_DEVICE_TABLE(vt596_ids
 	  .driver_data = SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855),
 	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX900),
+	  .driver_data = SMBBA3 },
 	{ 0, }
 };
 
--- linux-3.6-rc7.orig/include/linux/pci_ids.h	2012-09-10 09:31:24.000000000 +0200
+++ linux-3.6-rc7/include/linux/pci_ids.h	2012-10-01 09:05:40.816317835 +0200
@@ -1426,6 +1426,7 @@
 #define PCI_DEVICE_ID_VIA_CX700_IDE	0x0581
 #define PCI_DEVICE_ID_VIA_VX800		0x8353
 #define PCI_DEVICE_ID_VIA_VX855		0x8409
+#define PCI_DEVICE_ID_VIA_VX900		0x8410
 #define PCI_DEVICE_ID_VIA_8371_1	0x8391
 #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
 #define PCI_DEVICE_ID_VIA_838X_1	0xB188


-- 
Jean Delvare
