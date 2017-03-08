From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 11/12] i2c: meson: improve and simplify interrupt handler
Date: Wed, 8 Mar 2017 07:49:41 +0100
Message-ID: <7038cb69-4c51-d101-88d6-9e60f8241cce@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33124 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755447AbdCHGuv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:50:51 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so2862176wrg.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:50:50 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

The preceding changes in this patch series now allow to simplify
the interrupt handler significantly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index c73bb57a..7b29f077 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -239,38 +239,21 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		goto out;
 	}
 
-	switch (i2c->state) {
-	case STATE_READ:
+	if (i2c->state == STATE_READ)
 		meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
-		i2c->pos += i2c->count;
 
-		if (i2c->pos >= i2c->msg->len) {
-			i2c->state = STATE_IDLE;
-			complete(&i2c->done);
-			break;
-		}
-
-		meson_i2c_prepare_xfer(i2c);
-		break;
-	case STATE_WRITE:
-		i2c->pos += i2c->count;
+	i2c->pos += i2c->count;
 
-		if (i2c->pos >= i2c->msg->len) {
-			i2c->state = STATE_IDLE;
-			complete(&i2c->done);
-			break;
-		}
-
-		meson_i2c_prepare_xfer(i2c);
-		break;
+	if (i2c->pos >= i2c->msg->len) {
+		i2c->state = STATE_IDLE;
+		complete(&i2c->done);
+		goto out;
 	}
 
+	/* Restart the processing */
+	meson_i2c_prepare_xfer(i2c);
+	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, REG_CTRL_START);
 out:
-	if (i2c->state != STATE_IDLE)
-		/* Restart the processing */
-		meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START,
-				   REG_CTRL_START);
-
 	spin_unlock(&i2c->lock);
 
 	return IRQ_HANDLED;
-- 
2.12.0
