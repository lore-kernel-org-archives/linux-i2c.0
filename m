From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Use usleep_range to wait for command completion
Date: Tue, 24 Jan 2012 17:54:08 +0100
Message-ID: <20120124175408.61797201@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use usleep_range instead of msleep when waiting for command
completion. Most SMBus commands complete in less than 2 jiffies so
this brings a pleasant performance boost.

Strongly inspired from a similar change by Olivier Sobrie to the
i2c-isch driver.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-3.3-rc1.orig/drivers/i2c/busses/i2c-i801.c	2012-01-24 16:55:37.734394612 +0100
+++ linux-3.3-rc1/drivers/i2c/busses/i2c-i801.c	2012-01-24 17:51:00.921443870 +0100
@@ -2,7 +2,7 @@
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, and Mark D. Studebaker
     <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2007, 2008   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2007 - 2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
     Copyright (C) 2010         Intel Corporation,
                                David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
 
@@ -106,7 +106,7 @@
 #define SMBHSTCNT_KILL		2
 
 /* Other settings */
-#define MAX_TIMEOUT		100
+#define MAX_RETRIES		400
 #define ENABLE_INT9		0	/* set to 0x01 to enable - untested */
 
 /* I801 command constants */
@@ -217,7 +217,7 @@ static int i801_check_post(struct i801_p
 		dev_dbg(&priv->pci_dev->dev, "Terminating the current operation\n");
 		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL,
 		       SMBHSTCNT(priv));
-		msleep(1);
+		usleep_range(1000, 2000);
 		outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL),
 		       SMBHSTCNT(priv));
 
@@ -274,11 +274,11 @@ static int i801_transaction(struct i801_
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		msleep(1);
+		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
-	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
+	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_RETRIES));
 
-	result = i801_check_post(priv, status, timeout > MAX_TIMEOUT);
+	result = i801_check_post(priv, status, timeout > MAX_RETRIES);
 	if (result < 0)
 		return result;
 
@@ -293,12 +293,12 @@ static void i801_wait_hwpec(struct i801_
 	int status;
 
 	do {
-		msleep(1);
+		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
 	} while ((!(status & SMBHSTSTS_INTR))
-		 && (timeout++ < MAX_TIMEOUT));
+		 && (timeout++ < MAX_RETRIES));
 
-	if (timeout > MAX_TIMEOUT)
+	if (timeout > MAX_RETRIES)
 		dev_dbg(&priv->pci_dev->dev, "PEC Timeout!\n");
 
 	outb_p(status, SMBHSTSTS(priv));
@@ -382,12 +382,12 @@ static int i801_block_transaction_byte_b
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
 		do {
-			msleep(1);
+			usleep_range(250, 500);
 			status = inb_p(SMBHSTSTS(priv));
 		} while ((!(status & SMBHSTSTS_BYTE_DONE))
-			 && (timeout++ < MAX_TIMEOUT));
+			 && (timeout++ < MAX_RETRIES));
 
-		result = i801_check_post(priv, status, timeout > MAX_TIMEOUT);
+		result = i801_check_post(priv, status, timeout > MAX_RETRIES);
 		if (result < 0)
 			return result;
 


-- 
Jean Delvare
