From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 02/10] i2c: i801: store and restore the SLVCMD register at load and unload
Date: Wed, 28 Sep 2016 10:15:41 +0200
Message-ID: <1475050549-25542-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbcI1IP4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 04:15:56 -0400
In-Reply-To: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Also do not override any other configuration in this register.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b494a85..7334831 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -240,6 +240,7 @@ struct i801_priv {
 	struct i2c_adapter adapter;
 	unsigned long smba;
 	unsigned char original_hstcfg;
+	unsigned char original_slvcmd;
 	struct pci_dev *pci_dev;
 	unsigned int features;
 
@@ -952,7 +953,12 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 	if (!priv->host_notify)
 		return -ENOMEM;
 
-	outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
+	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
+
+	if (!(SMBSLVCMD_HST_NTFY_INTREN & priv->original_slvcmd))
+		outb_p(SMBSLVCMD_HST_NTFY_INTREN | priv->original_slvcmd,
+		       SMBSLVCMD(priv));
+
 	/* clear Host Notify bit to allow a new notification */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 
@@ -961,12 +967,11 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 
 static void i801_disable_host_notify(struct i801_priv *priv)
 {
-
 	if (!(priv->features & FEATURE_HOST_NOTIFY))
 		return;
 
 	/* disable Host Notify... */
-	outb_p(0, SMBSLVCMD(priv));
+	outb_p(priv->original_slvcmd, SMBSLVCMD(priv));
 	/* ...and process the already queued notifications */
 	i2c_cancel_smbus_host_notify(priv->host_notify);
 }
-- 
2.7.4
