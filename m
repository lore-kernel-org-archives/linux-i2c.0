From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 10/10] i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0
Date: Fri, 19 Aug 2016 15:27:42 +0200
Message-ID: <1471613262-20682-11-git-send-email-benjamin.tissoires@redhat.com>
References: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On the platform tested, reading SMBNTFDDAT always returns 0 (using 1 read
of a word or 2 of 2 bytes). Given that we are not sure why and that we
don't need to rely on the data parameter in the current users of Host
Notify, remove this part of the code.

If someone wants to re-enable it, just revert this commit and data should
be available.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c5ed44c..2ffebe6 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -117,7 +117,6 @@
 #define SMBSLVSTS(p)	(16 + (p)->smba)	/* ICH3 and later */
 #define SMBSLVCMD(p)	(17 + (p)->smba)	/* ICH3 and later */
 #define SMBNTFDADD(p)	(20 + (p)->smba)	/* ICH3 and later */
-#define SMBNTFDDAT(p)	(22 + (p)->smba)	/* ICH3 and later */
 
 /* PCI Address Constants */
 #define SMBBAR		4
@@ -578,16 +577,19 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
 {
 	unsigned short addr;
-	unsigned int data;
 	int ret;
 
 	if (unlikely(!priv->host_notify))
 		goto out;
 
 	addr = inb_p(SMBNTFDADD(priv)) >> 1;
-	data = inw_p(SMBNTFDDAT(priv));
 
-	ret = i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
+	/*
+	 * With the tested platforms, reading SMBNTFDDAT (22 + (p)->smba)
+	 * always returns 0 and is safe to read.
+	 * We just use 0 given we have no use of the data right now.
+	 */
+	ret = i2c_handle_smbus_host_notify(priv->host_notify, addr, 0);
 	if (ret < 0)
 		dev_warn(&priv->pci_dev->dev,
 			 "Host Notify handling failed: %d\n", ret);
-- 
2.5.5
