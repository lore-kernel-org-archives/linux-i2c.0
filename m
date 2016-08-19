From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 09/10] i2c: i801: warn on i2c_handle_smbus_host_notify() errors
Date: Fri, 19 Aug 2016 15:27:41 +0200
Message-ID: <1471613262-20682-10-git-send-email-benjamin.tissoires@redhat.com>
References: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754885AbcHSN27 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Aug 2016 09:28:59 -0400
In-Reply-To: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

There is a chance we get called while Host Notify is not available (yet),
so we need to clear the Host Notify bit in those rare case.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2 (comments addressed in the previous patches)
---
 drivers/i2c/busses/i2c-i801.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 74fb144..c5ed44c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -579,12 +579,21 @@ static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
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
 
+
+out:
 	/* clear Host Notify bit and return */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 	return IRQ_HANDLED;
-- 
2.5.5
