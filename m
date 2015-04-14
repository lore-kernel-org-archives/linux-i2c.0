From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v1 i2c/for-next] i1c: i801: recover from hardware PEC errors
Date: Mon, 13 Apr 2015 17:11:59 -0700
Message-ID: <1428970319-32544-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jdelvare-l3A5Bk7waGM@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On a CRC error while using hardware-supported PEC, an additional
error bit is set in the auxiliary status register.  If this bit
isn't cleared, all subsequent operations will fail, essentially
hanging the controller.

The fix is simple: clear the bit at the same time we clear
the error bits in the main status register.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ecbb3f..7f3331e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -129,6 +129,10 @@
 #define SMBAUXCTL_CRC		1
 #define SMBAUXCTL_E32B		2
 
+/* Auxiliary status register bits, ICH4+ only */
+#define SMBAUXSTS_CRCE		1
+#define SMBAUXSTS_STCO		2
+
 /* Other settings */
 #define MAX_RETRIES		400
 
@@ -164,6 +168,8 @@
 #define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR | \
 				 STATUS_ERROR_FLAGS)
 
+#define AUXSTS_ERROR_FLAGS	SMBAUXSTS_CRCE
+
 /* Older devices have their ID defined in <linux/pci_ids.h> */
 #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
 #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
@@ -509,6 +515,21 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
 		i801_isr_byte_done(priv);
 
 	/*
+	 * Clear error condition in aux status that may have come from
+	 * a PEC error.  The main status register also should be showing
+	 * an error.  That should be sufficient for reporting purposes.
+	 */
+	if (priv->features & FEATURE_SMBUS_PEC) {
+		u8 auxsts = inb_p(SMBAUXSTS(priv));
+
+		if (auxsts & AUXSTS_ERROR_FLAGS) {
+			dev_dbg(&priv->pci_dev->dev, "irq: auxsts = %02x\n",
+				auxsts);
+			outb_p(auxsts & AUXSTS_ERROR_FLAGS, SMBAUXSTS(priv));
+		}
+	}
+
+	/*
 	 * Clear irq sources and report transaction result.
 	 * ->status must be cleared before the next transaction is started.
 	 */
-- 
1.7.10.4
