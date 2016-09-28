From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 10/10] i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0
Date: Wed, 28 Sep 2016 10:15:49 +0200
Message-ID: <1475050549-25542-11-git-send-email-benjamin.tissoires@redhat.com>
References: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbcI1IQI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 04:16:08 -0400
In-Reply-To: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On the platform tested, reading SMBNTFDDAT always returns 0 (using 1 read
of a word or 2 of 2 bytes). Given that we are not sure why and that we
don't need to rely on the data parameter in the current users of Host
Notify, remove this part of the code.

If someone wants to re-enable it, just revert this commit and data should
be available.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 38e2421..0e3aa44 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -117,7 +117,6 @@
 #define SMBSLVSTS(p)	(16 + (p)->smba)	/* ICH3 and later */
 #define SMBSLVCMD(p)	(17 + (p)->smba)	/* ICH3 and later */
 #define SMBNTFDADD(p)	(20 + (p)->smba)	/* ICH3 and later */
-#define SMBNTFDDAT(p)	(22 + (p)->smba)	/* ICH3 and later */
 
 /* PCI Address Constants */
 #define SMBBAR		4
@@ -578,20 +577,22 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
 {
 	unsigned short addr;
-	unsigned int data;
 
 	if (unlikely(!priv->host_notify))
 		goto out;
 
 	addr = inb_p(SMBNTFDADD(priv)) >> 1;
-	data = inw_p(SMBNTFDDAT(priv));
 
 	/*
+	 * With the tested platforms, reading SMBNTFDDAT (22 + (p)->smba)
+	 * always returns 0 and is safe to read.
+	 * We just use 0 given we have no use of the data right now.
+	 *
 	 * We don't notify about missed host notify events when the adapter
 	 * lags behind. The operation is still scheduled and will get
 	 * eventually processed.
 	 */
-	i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
+	i2c_handle_smbus_host_notify(priv->host_notify, addr, 0);
 
 out:
 	/* clear Host Notify bit and return */
-- 
2.7.4
