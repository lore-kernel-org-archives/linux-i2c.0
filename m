From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2 i2c/for-next] i1c: i801: recover from hardware PEC errors
Date: Mon,  4 May 2015 13:41:16 -0700
Message-ID: <1430772076-1151-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jdelvare-l3A5Bk7waGM@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On a CRC error while using hardware-supported PEC, an additional
error bit is set in the auxiliary status register.  If this bit
isn't cleared, all subsequent operations will fail, essentially
hanging the controller.

The fix is simple: check, report, and clear the bit in
i802_check_post().  Also, in case the driver starts with the
hardware in that state, clear it in i801_check_pre() as well.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
This is essentially the patch from Jean Delvare, which handles
the polling case while my original version didn't.  (Thank you!
Please add appropriate attribution if you wish.)

I tested all the additional code paths by selectively commenting
out code: with interrupts, without interrupts, relying on check_pre()
to clear CRCE, no clearing of CRCE at all (baseline).
---
 drivers/i2c/busses/i2c-i801.c |   53 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ecbb3f..fa50df0 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -125,6 +125,10 @@
 #define SMBHSTCFG_SMB_SMI_EN	2
 #define SMBHSTCFG_I2C_EN	4
 
+/* Auxiliary status register bits, ICH4+ only */
+#define SMBAUXSTS_CRCE		1
+#define SMBAUXSTS_STCO		2
+
 /* Auxiliary control register bits, ICH4+ only */
 #define SMBAUXCTL_CRC		1
 #define SMBAUXCTL_E32B		2
@@ -273,6 +277,29 @@ static int i801_check_pre(struct i801_priv *priv)
 		}
 	}
 
+	/*
+	 * Clear CRC status if needed.
+	 * During normal operation, i801_check_post() takes care
+	 * of it after every operation.  We do it here only in case
+	 * the hardware was already in this state when the driver
+	 * started.
+	 */
+	if (priv->features & FEATURE_SMBUS_PEC) {
+		status = inb_p(SMBAUXSTS(priv)) & SMBAUXSTS_CRCE;
+		if (status) {
+			dev_dbg(&priv->pci_dev->dev,
+				"Clearing aux status flags (%02x)\n", status);
+			outb_p(status, SMBAUXSTS(priv));
+			status = inb_p(SMBAUXSTS(priv)) & SMBAUXSTS_CRCE;
+			if (status) {
+				dev_err(&priv->pci_dev->dev,
+					"Failed clearing aux status flags (%02x)\n",
+					status);
+				return -EBUSY;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -316,8 +343,30 @@ static int i801_check_post(struct i801_priv *priv, int status)
 		dev_err(&priv->pci_dev->dev, "Transaction failed\n");
 	}
 	if (status & SMBHSTSTS_DEV_ERR) {
-		result = -ENXIO;
-		dev_dbg(&priv->pci_dev->dev, "No response\n");
+		/*
+		 * This may be a PEC error, check and clear it.
+		 *
+		 * AUXSTS is handled differently from HSTSTS.
+		 * For HSTSTS, i801_isr() or i801_wait_intr()
+		 * has already cleared the error bits in hardware,
+		 * and we are passed a copy of the original value
+		 * in "status".
+		 * For AUXSTS, the hardware register is left
+		 * for us to handle here.
+		 * This is asymmetric, slightly iffy, but safe,
+		 * since all this code is serialized and the CRCE
+		 * bit is harmless as long as it's cleared before
+		 * the next operation.
+		 */
+		if ((priv->features & FEATURE_SMBUS_PEC) &&
+		    (inb_p(SMBAUXSTS(priv)) & SMBAUXSTS_CRCE)) {
+			outb_p(SMBAUXSTS_CRCE, SMBAUXSTS(priv));
+			result = -EBADMSG;
+			dev_dbg(&priv->pci_dev->dev, "PEC error\n");
+		} else {
+			result = -ENXIO;
+			dev_dbg(&priv->pci_dev->dev, "No response\n");
+		}
 	}
 	if (status & SMBHSTSTS_BUS_ERR) {
 		result = -EAGAIN;
-- 
1.7.10.4
