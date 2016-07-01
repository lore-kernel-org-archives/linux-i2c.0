From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 i2c/for-next] i2c: i801: recover from hardware PEC
 errors
Date: Fri, 1 Jul 2016 20:18:14 +0200
Message-ID: <20160701201814.28524160@endymion>
References: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
	<20150709165939.GB4744@katana>
	<20160701113028.7a47c236@endymion>
	<20160701154918.GB1372@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40594 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbcGASdp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 14:33:45 -0400
In-Reply-To: <20160701154918.GB1372@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, linux-i2c@vger.kernel.org

On Fri, 1 Jul 2016 17:49:19 +0200, Wolfram Sang wrote:
> 
> > Sorry, this one fell trough the cracks. The patch is good and still
> > needed. I have tested it successfully on several systems. Wolfram,
> > please apply it.
> > 
> > Tested-by: Jean Delvare <jdelvare@suse.de>
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
> Thanks, will do. Do you happen to have rebased it to latest
> i2c/for-next?

Here it is. I don't remember having anything to do to get it to apply
though, refreshing was trivial.

From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: i2c: i801: recover from hardware PEC errors

On a CRC error while using hardware-supported PEC, an additional
error bit is set in the auxiliary status register.  If this bit
isn't cleared, all subsequent operations will fail, essentially
hanging the controller.

The fix is simple: check, report, and clear the bit in
i801_check_post().  Also, in case the driver starts with the
hardware in that state, clear it in i801_check_pre() as well.

Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
Update: fix typos in commit message, otherwise the same as v2

This is essentially the patch from Jean Delvare, which handles
the polling case while my original version didn't.  (Thank you!
Please add appropriate attribution if you wish.)

I tested all the additional code paths by selectively commenting
out code: with interrupts, without interrupts, relying on check_pre()
to clear CRCE, no clearing of CRCE at all (baseline).
---
 drivers/i2c/busses/i2c-i801.c |   53 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

--- staging.orig/drivers/i2c/busses/i2c-i801.c	2016-07-01 20:15:52.738613909 +0200
+++ staging/drivers/i2c/busses/i2c-i801.c	2016-07-01 20:16:01.195694283 +0200
@@ -144,6 +144,10 @@
 /* TCO configuration bits for TCOCTL */
 #define TCOCTL_EN		0x0100
 
+/* Auxiliary status register bits, ICH4+ only */
+#define SMBAUXSTS_CRCE		1
+#define SMBAUXSTS_STCO		2
+
 /* Auxiliary control register bits, ICH4+ only */
 #define SMBAUXCTL_CRC		1
 #define SMBAUXCTL_E32B		2
@@ -305,6 +309,29 @@ static int i801_check_pre(struct i801_pr
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
 
@@ -348,8 +375,30 @@ static int i801_check_post(struct i801_p
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
Jean Delvare
SUSE L3 Support
