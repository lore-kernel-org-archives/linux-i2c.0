From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 06/10] i2c: i801: do not report an error if FEATURE_HOST_NOTIFY is not set
Date: Wed, 28 Sep 2016 10:15:45 +0200
Message-ID: <1475050549-25542-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbcI1IQC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 04:16:02 -0400
In-Reply-To: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

we can skip one test when calling i801_enable_host_notify(). Given
that we call it all the time, it's better to consider the fact that
the adapter doesn't support Host Notify as not an error.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

no changes in v2
---
 drivers/i2c/busses/i2c-i801.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 55fa6e1..422cce2 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -944,12 +944,13 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
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
 
 	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
 
@@ -1638,7 +1639,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	 * is not used if i2c_add_adapter() fails.
 	 */
 	err = i801_enable_host_notify(&priv->adapter);
-	if (err && err != -ENOTSUPP)
+	if (err)
 		dev_warn(&dev->dev, "Unable to enable SMBus Host Notify\n");
 
 	i801_probe_optional_slaves(priv);
@@ -1693,7 +1694,7 @@ static int i801_resume(struct device *dev)
 	int err;
 
 	err = i801_enable_host_notify(&priv->adapter);
-	if (err && err != -ENOTSUPP)
+	if (err)
 		dev_warn(dev, "Unable to enable SMBus Host Notify\n");
 
 	return 0;
-- 
2.7.4
