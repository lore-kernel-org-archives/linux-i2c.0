From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 10/10] i2c: meson: improve and simplify interrupt handler
Date: Tue, 14 Mar 2017 22:51:51 +0100
Message-ID: <d017b5be-941c-a749-6eb4-72c3e5c357db@gmail.com>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35541 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753125AbdCNVye (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 17:54:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id z63so1929407wmg.2
        for <linux-i2c@vger.kernel.org>; Tue, 14 Mar 2017 14:54:33 -0700 (PDT)
In-Reply-To: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

The preceding changes in this patch series now allow to simplify
the interrupt handler significantly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- no changes
v4:
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
