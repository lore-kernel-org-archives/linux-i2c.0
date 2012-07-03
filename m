From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Consolidate polling
Date: Tue, 3 Jul 2012 15:00:07 +0200
Message-ID: <20120703150007.02103384@endymion.delvare>
References: <20120703101927.63336e65@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120703101927.63336e65-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 3 Jul 2012 10:19:27 +0200, Jean Delvare wrote:
> It may be possible to combine i801_wait_intr() and
> i801_wait_byte_done() into a single function, as they do pretty much
> the same, but I'll only do that if it doesn't hurt readability. My
> first attempt was horrible.

This could look as follows, which also offers opportunities to further
simplify the code by either letting i801_check_post() call i801_wait(),
or even merging both functions together. Not sure yet if we want to do
either.

However this probably doesn't fit well with your suggested changes to
my initial patch, so I'll have to ponder the benefits of each cleanup.
You opinion is welcome in this respect as well.

---
 drivers/i2c/busses/i2c-i801.c |   46 +++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

--- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-i801.c	2012-07-03 10:07:42.000000000 +0200
+++ linux-3.5-rc5/drivers/i2c/busses/i2c-i801.c	2012-07-03 10:31:07.945245984 +0200
@@ -254,29 +254,15 @@ static int i801_check_post(struct i801_p
 	return result;
 }
 
-/* Wait for BUSY being cleared and either INTR or an error flag being set */
-static int i801_wait_intr(struct i801_priv *priv)
-{
-	int timeout = 0;
-	int status;
-
-	/* We will always wait for a fraction of a second! */
-	do {
-		usleep_range(250, 500);
-		status = inb_p(SMBHSTSTS(priv));
-	} while (((status & SMBHSTSTS_HOST_BUSY) ||
-		  !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))) &&
-		 (timeout++ < MAX_RETRIES));
-
-	if (timeout > MAX_RETRIES) {
-		dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
-		return -ETIMEDOUT;
-	}
-	return status;
-}
-
-/* Wait for either BYTE_DONE or an error flag being set */
-static int i801_wait_byte_done(struct i801_priv *priv)
+/*
+ * Wait for some status register bits being cleared and others being set.
+ * Typical usage:
+ *  - Wait for BUSY being cleared and either INTR or an error flag being set
+ *    (end of transaction)
+ *  - Wait for either BYTE_DONE or an error flag being set (step of
+ *    byte-by-byte block transaction)
+ */
+static int i801_wait(struct i801_priv *priv, int wait_cleared, int wait_set)
 {
 	int timeout = 0;
 	int status;
@@ -285,11 +271,13 @@ static int i801_wait_byte_done(struct i8
 	do {
 		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
-	} while (!(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_BYTE_DONE)) &&
+	} while (((status & wait_cleared) ||
+		  !(status & (STATUS_ERROR_FLAGS | wait_set))) &&
 		 (timeout++ < MAX_RETRIES));
 
-	if (timeout > MAX_RETRIES) {
-		dev_dbg(&priv->pci_dev->dev, "BYTE_DONE Timeout!\n");
+	if (unlikely(timeout > MAX_RETRIES)) {
+		dev_dbg(&priv->pci_dev->dev,
+			"Timeout waiting for %02x! (%02x)\n", wait_set, status);
 		return -ETIMEDOUT;
 	}
 	return status;
@@ -308,7 +296,7 @@ static int i801_transaction(struct i801_
 	 * SMBSCMD are passed in xact */
 	outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
 
-	status = i801_wait_intr(priv);
+	status = i801_wait(priv, SMBHSTSTS_HOST_BUSY, SMBHSTSTS_INTR);
 	return i801_check_post(priv, status);
 }
 
@@ -387,7 +375,7 @@ static int i801_block_transaction_byte_b
 			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
 			       SMBHSTCNT(priv));
 
-		status = i801_wait_byte_done(priv);
+		status = i801_wait(priv, 0, SMBHSTSTS_BYTE_DONE);
 		result = i801_check_post(priv, status);
 		if (result < 0)
 			return result;
@@ -420,7 +408,7 @@ static int i801_block_transaction_byte_b
 		outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
 	}
 
-	status = i801_wait_intr(priv);
+	status = i801_wait(priv, SMBHSTSTS_HOST_BUSY, SMBHSTSTS_INTR);
 	return i801_check_post(priv, status);
 }
 


-- 
Jean Delvare
