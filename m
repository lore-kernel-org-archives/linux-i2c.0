From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/4] i2c-i801: Use wait_event_timeout to wait for interrupts
Date: Mon, 10 Nov 2014 22:30:33 +0100
Message-ID: <20141110223033.0938cf4e@endymion.delvare>
References: <20141110222655.13660613@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141110222655.13660613-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some systems have been reported to have trouble with interrupts. Use
wait_event_timeout() instead of wait_event() so we don't get stuck in
that case, and log the problem.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--- linux-3.18-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:26:47.212135115 +0100
+++ linux-3.18-rc4/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:18.040417276 +0100
@@ -2,7 +2,7 @@
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, and Mark D. Studebaker
     <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2007 - 2012  Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
+    Copyright (C) 2007 - 2014  Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
     Copyright (C) 2010         Intel Corporation,
                                David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
 
@@ -373,6 +373,7 @@ static int i801_transaction(struct i801_
 {
 	int status;
 	int result;
+	const struct i2c_adapter *adap = &priv->adapter;
 
 	result = i801_check_pre(priv);
 	if (result < 0)
@@ -381,7 +382,14 @@ static int i801_transaction(struct i801_
 	if (priv->features & FEATURE_IRQ) {
 		outb_p(xact | SMBHSTCNT_INTREN | SMBHSTCNT_START,
 		       SMBHSTCNT(priv));
-		wait_event(priv->waitq, (status = priv->status));
+		result = wait_event_timeout(priv->waitq,
+					    (status = priv->status),
+					    adap->timeout);
+		if (!result) {
+			status = -ETIMEDOUT;
+			dev_warn(&priv->pci_dev->dev,
+				 "Timeout waiting for interrupt!\n");
+		}
 		priv->status = 0;
 		return i801_check_post(priv, status);
 	}
@@ -529,6 +537,7 @@ static int i801_block_transaction_byte_b
 	int smbcmd;
 	int status;
 	int result;
+	const struct i2c_adapter *adap = &priv->adapter;
 
 	result = i801_check_pre(priv);
 	if (result < 0)
@@ -557,7 +566,14 @@ static int i801_block_transaction_byte_b
 		priv->data = &data->block[1];
 
 		outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
-		wait_event(priv->waitq, (status = priv->status));
+		result = wait_event_timeout(priv->waitq,
+					    (status = priv->status),
+					    adap->timeout);
+		if (!result) {
+			status = -ETIMEDOUT;
+			dev_warn(&priv->pci_dev->dev,
+				 "Timeout waiting for interrupt!\n");
+		}
 		priv->status = 0;
 		return i801_check_post(priv, status);
 	}
@@ -1215,6 +1231,9 @@ static int i801_probe(struct pci_dev *de
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	/* Default timeout in interrupt mode: 200 ms */
+	priv->adapter.timeout = HZ / 5;
+
 	if (priv->features & FEATURE_IRQ) {
 		init_waitqueue_head(&priv->waitq);
 

-- 
Jean Delvare
SUSE L3 Support
