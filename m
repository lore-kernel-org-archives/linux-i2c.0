From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/5] i2c: i801: do not report an error if FEATURE_HOST_NOTIFY is not set
Date: Thu, 28 Jul 2016 11:50:42 +0200
Message-ID: <1469699443-22129-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

we can skip one test when calling i801_enable_host_notify(). Given
that we call it all the time, it's better to consider the fact that
the adapter doesn't support Host Notify as not an error.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/i2c/busses/i2c-i801.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 3321956..a9b9bb4 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -943,12 +943,13 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 	struct i801_priv *priv = i2c_get_adapdata(adapter);
 
 	if (!(priv->features & FEATURE_HOST_NOTIFY))
-		return -ENOTSUPP;
+		return 0; /* not an error actually */
 
-	if (!priv->host_notify)
+	if (!priv->host_notify) {
 		priv->host_notify = i2c_setup_smbus_host_notify(adapter);
-	if (!priv->host_notify)
-		return -ENOMEM;
+		if (!priv->host_notify)
+			return -ENOMEM;
+	}
 
 	outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
 	/* clear Host Notify bit to allow a new notification */
@@ -1635,7 +1636,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	 * is not used if i2c_add_adapter() fails.
 	 */
 	err = i801_enable_host_notify(&priv->adapter);
-	if (err && err != -ENOTSUPP)
+	if (err)
 		dev_warn(&dev->dev, "Unable to enable SMBus Host Notify\n");
 
 	i801_probe_optional_slaves(priv);
@@ -1690,7 +1691,7 @@ static int i801_resume(struct device *dev)
 	int err;
 
 	err = i801_enable_host_notify(&priv->adapter);
-	if (err && err != -ENOTSUPP)
+	if (err)
 		dev_warn(dev, "Unable to enable SMBus Host Notify\n");
 
 	return 0;
-- 
2.5.5
