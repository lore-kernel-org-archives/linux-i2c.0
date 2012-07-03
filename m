From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Consolidate polling
Date: Tue, 3 Jul 2012 10:19:27 +0200
Message-ID: <20120703101927.63336e65@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Come up with a consistent, driver-wide strategy for event polling. For
intermediate steps of byte-by-byte block transactions, check for
BYTE_DONE or any error flag being set. At the end of every transaction,
check for both BUSY being cleared and INTR or any error flag being set.
This avoids having to wait twice for the same event.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Daniel, this is what I had in mind. This applies on top of your first 6
patches (i.e. all the preliminary cleanup patches, not the interrupt
patches.) It solves the performance regression problem and makes the
code look better IMHO. Tested OK on ICH10 and ICH3-M. What do you
think? Comments and suggestions for improvements are very welcome.

It may be possible to combine i801_wait_intr() and
i801_wait_byte_done() into a single function, as they do pretty much
the same, but I'll only do that if it doesn't hurt readability. My
first attempt was horrible.

 drivers/i2c/busses/i2c-i801.c |   88 ++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

--- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-i801.c	2012-07-02 18:09:59.000000000 +0200
+++ linux-3.5-rc5/drivers/i2c/busses/i2c-i801.c	2012-07-03 10:07:42.254632389 +0200
@@ -207,13 +207,13 @@ static int i801_check_pre(struct i801_pr
 }
 
 /* Convert the status register to an error code, and clear it. */
-static int i801_check_post(struct i801_priv *priv, int status, int timeout)
+static int i801_check_post(struct i801_priv *priv, int status)
 {
 	int result = 0;
+	int clear;
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout) {
-		dev_err(&priv->pci_dev->dev, "Transaction timeout\n");
+	if (unlikely(status < 0)) {
 		/* try to stop the current command */
 		dev_dbg(&priv->pci_dev->dev, "Terminating the current operation\n");
 		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL,
@@ -245,42 +245,60 @@ static int i801_check_post(struct i801_p
 		dev_dbg(&priv->pci_dev->dev, "Lost arbitration\n");
 	}
 
-	if (result) {
-		/* Clear error flags */
-		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
-		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
-		if (status) {
-			dev_warn(&priv->pci_dev->dev, "Failed clearing status "
-				 "flags at end of transaction (%02x)\n",
-				 status);
-		}
-	}
+	/* Clear status flags except BYTE_DONE, to be cleared by caller */
+	clear = STATUS_ERROR_FLAGS;
+	if (!(status & SMBHSTSTS_BYTE_DONE))
+		clear |= SMBHSTSTS_INTR;
+	outb_p(status & clear, SMBHSTSTS(priv));
 
 	return result;
 }
 
-/* wait for INTR bit as advised by Intel */
-static void i801_wait_intr(struct i801_priv *priv)
+/* Wait for BUSY being cleared and either INTR or an error flag being set */
+static int i801_wait_intr(struct i801_priv *priv)
 {
 	int timeout = 0;
 	int status;
 
+	/* We will always wait for a fraction of a second! */
 	do {
 		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
-	} while ((!(status & SMBHSTSTS_INTR)) && (timeout++ < MAX_RETRIES));
+	} while (((status & SMBHSTSTS_HOST_BUSY) ||
+		  !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))) &&
+		 (timeout++ < MAX_RETRIES));
 
-	if (timeout > MAX_RETRIES)
+	if (timeout > MAX_RETRIES) {
 		dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
+		return -ETIMEDOUT;
+	}
+	return status;
+}
 
-	outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
+/* Wait for either BYTE_DONE or an error flag being set */
+static int i801_wait_byte_done(struct i801_priv *priv)
+{
+	int timeout = 0;
+	int status;
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		usleep_range(250, 500);
+		status = inb_p(SMBHSTSTS(priv));
+	} while (!(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_BYTE_DONE)) &&
+		 (timeout++ < MAX_RETRIES));
+
+	if (timeout > MAX_RETRIES) {
+		dev_dbg(&priv->pci_dev->dev, "BYTE_DONE Timeout!\n");
+		return -ETIMEDOUT;
+	}
+	return status;
 }
 
 static int i801_transaction(struct i801_priv *priv, int xact)
 {
 	int status;
 	int result;
-	int timeout = 0;
 
 	result = i801_check_pre(priv);
 	if (result < 0)
@@ -290,19 +308,8 @@ static int i801_transaction(struct i801_
 	 * SMBSCMD are passed in xact */
 	outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
 
-	/* We will always wait for a fraction of a second! */
-	do {
-		usleep_range(250, 500);
-		status = inb_p(SMBHSTSTS(priv));
-	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_RETRIES));
-
-	result = i801_check_post(priv, status, timeout > MAX_RETRIES);
-	if (result < 0)
-		return result;
-
-	i801_wait_intr(priv);
-
-	return 0;
+	status = i801_wait_intr(priv);
+	return i801_check_post(priv, status);
 }
 
 static int i801_block_transaction_by_block(struct i801_priv *priv,
@@ -353,7 +360,6 @@ static int i801_block_transaction_byte_b
 	int smbcmd;
 	int status;
 	int result;
-	int timeout;
 
 	result = i801_check_pre(priv);
 	if (result < 0)
@@ -381,15 +387,8 @@ static int i801_block_transaction_byte_b
 			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
 			       SMBHSTCNT(priv));
 
-		/* We will always wait for a fraction of a second! */
-		timeout = 0;
-		do {
-			usleep_range(250, 500);
-			status = inb_p(SMBHSTSTS(priv));
-		} while (!(status & (SMBHSTSTS_BYTE_DONE | STATUS_ERROR_FLAGS))
-			 && (timeout++ < MAX_RETRIES));
-
-		result = i801_check_post(priv, status, timeout > MAX_RETRIES);
+		status = i801_wait_byte_done(priv);
+		result = i801_check_post(priv, status);
 		if (result < 0)
 			return result;
 
@@ -421,9 +420,8 @@ static int i801_block_transaction_byte_b
 		outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
 	}
 
-	i801_wait_intr(priv);
-
-	return 0;
+	status = i801_wait_intr(priv);
+	return i801_check_post(priv, status);
 }
 
 static int i801_set_block_buffer_mode(struct i801_priv *priv)


-- 
Jean Delvare
