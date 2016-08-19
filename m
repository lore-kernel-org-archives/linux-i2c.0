From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 02/10] i2c: i801: store and restore the SLVCMD register at load and unload
Date: Fri, 19 Aug 2016 15:27:34 +0200
Message-ID: <1471613262-20682-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Also do not override any other configuration in this register.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 84eabb1..179e387 100644
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
2.5.5
