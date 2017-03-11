From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 10/10] i2c: meson: improve and simplify interrupt handler
Date: Sat, 11 Mar 2017 19:24:26 +0100
Message-ID: <d2828280-d170-636e-3e46-e6afe6121f6d@gmail.com>
References: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34231 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933131AbdCKSY5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 11 Mar 2017 13:24:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id u132so3790480wmg.1
        for <linux-i2c@vger.kernel.org>; Sat, 11 Mar 2017 10:24:56 -0800 (PST)
In-Reply-To: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

The preceding changes in this patch series now allow to simplify
the interrupt handler significantly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- no changes
---
 drivers/i2c/busses/i2c-meson.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 23f25efa..590715ae 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -239,41 +239,21 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		goto out;
 	}
 
-	switch (i2c->state) {
-	case STATE_READ:
-		if (i2c->count > 0) {
-			meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos,
-					   i2c->count);
-			i2c->pos += i2c->count;
-		}
-
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
+	if (i2c->state == STATE_READ && i2c->count)
+		meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
 
-		if (i2c->pos >= i2c->msg->len) {
-			i2c->state = STATE_IDLE;
-			complete(&i2c->done);
-			break;
-		}
+	i2c->pos += i2c->count;
 
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
