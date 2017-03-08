From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 09/12] i2c: meson: don't create separate token chain just for
 the stop command
Date: Wed, 8 Mar 2017 07:48:21 +0100
Message-ID: <0185ad19-b925-142e-6b2b-779bdae33d4b@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35074 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbdCHGut (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:50:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so4367808wmg.2
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:50:48 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

We can directly add the stop token to the token chain including the
last transfer chunk. This is more efficient than creating a separate
token chain just for the stop command.
And it allows us to get rid of state STATE_STOP completely.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 58414699..b11ecfdd 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -55,7 +55,6 @@ enum {
 	STATE_IDLE,
 	STATE_READ,
 	STATE_WRITE,
-	STATE_STOP,
 };
 
 /**
@@ -201,23 +200,13 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 	else
 		meson_i2c_add_token(i2c, TOKEN_DATA_LAST);
 
+	if (i2c->last && i2c->pos + i2c->count >= i2c->msg->len)
+		meson_i2c_add_token(i2c, TOKEN_STOP);
+
 	if (write)
 		meson_i2c_put_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
 }
 
-static void meson_i2c_stop(struct meson_i2c *i2c)
-{
-	dev_dbg(i2c->dev, "%s: last %d\n", __func__, i2c->last);
-
-	if (i2c->last) {
-		i2c->state = STATE_STOP;
-		meson_i2c_add_token(i2c, TOKEN_STOP);
-	} else {
-		i2c->state = STATE_IDLE;
-		complete(&i2c->done);
-	}
-}
-
 static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 {
 	struct meson_i2c *i2c = dev_id;
@@ -259,7 +248,8 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		i2c->pos += i2c->count;
 
 		if (i2c->pos >= i2c->msg->len) {
-			meson_i2c_stop(i2c);
+			i2c->state = STATE_IDLE;
+			complete(&i2c->done);
 			break;
 		}
 
@@ -269,16 +259,13 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		i2c->pos += i2c->count;
 
 		if (i2c->pos >= i2c->msg->len) {
-			meson_i2c_stop(i2c);
+			i2c->state = STATE_IDLE;
+			complete(&i2c->done);
 			break;
 		}
 
 		meson_i2c_prepare_xfer(i2c);
 		break;
-	case STATE_STOP:
-		i2c->state = STATE_IDLE;
-		complete(&i2c->done);
-		break;
 	}
 
 out:
-- 
2.12.0
