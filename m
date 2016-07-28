From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/5] i2c: i801: warn on i2c_handle_smbus_host_notify() errors
Date: Thu, 28 Jul 2016 11:50:43 +0200
Message-ID: <1469699443-22129-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58684 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415AbcG1JvA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 05:51:00 -0400
In-Reply-To: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

i2c_handle_smbus_host_notify() returns 1 on success, something else on
errors.
There is a chance we get called while Host Notify is not available (yet),
so we need to clear the Host Notify bit in those rare case.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/i2c/busses/i2c-i801.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index a9b9bb4..f02b248 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -578,12 +578,20 @@ static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
 {
 	unsigned short addr;
 	unsigned int data;
+	int ret;
+
+	if (unlikely(!priv->host_notify))
+		goto out;
 
 	addr = inb_p(SMBNTFDADD(priv)) >> 1;
 	data = inw_p(SMBNTFDDAT(priv));
 
-	i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
+	ret = i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
+	if (ret < 0)
+		dev_warn(&priv->pci_dev->dev,
+			 "Host Notify handling failed: %d\n", ret);
 
+out:
 	/* clear Host Notify bit and return */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 	return IRQ_HANDLED;
-- 
2.5.5
