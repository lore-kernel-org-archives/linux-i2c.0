From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 09/10] i2c: i801: check if Host Notify is available during interrupt
Date: Wed, 28 Sep 2016 10:15:48 +0200
Message-ID: <1475050549-25542-10-git-send-email-benjamin.tissoires@redhat.com>
References: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

There is a chance we get called while Host Notify is not available (yet),
so we need to clear the Host Notify bit in those rare case.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- renamed from "i2c: i801: warn on i2c_handle_smbus_host_notify() errors"
- removed the warnings and just kept the test
- added some comments on why the errors are not treated

no changes in v2 (comments addressed in the previous patches)

i2c: i2c-i801: remove warnings on the handle host notify

add a comment on i2c-i801
---
 drivers/i2c/busses/i2c-i801.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 422cce2..38e2421 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -580,11 +580,20 @@ static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
 	unsigned short addr;
 	unsigned int data;
 
+	if (unlikely(!priv->host_notify))
+		goto out;
+
 	addr = inb_p(SMBNTFDADD(priv)) >> 1;
 	data = inw_p(SMBNTFDDAT(priv));
 
+	/*
+	 * We don't notify about missed host notify events when the adapter
+	 * lags behind. The operation is still scheduled and will get
+	 * eventually processed.
+	 */
 	i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
 
+out:
 	/* clear Host Notify bit and return */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 	return IRQ_HANDLED;
-- 
2.7.4
