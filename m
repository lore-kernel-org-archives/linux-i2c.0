From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 08/12] i2c: meson: explicitly ignore messages with length zero
Date: Wed, 8 Mar 2017 07:47:47 +0100
Message-ID: <11e16ab1-e3dd-56d0-55c5-1420576a9bb3@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34589 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756752AbdCHGus (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:50:48 -0500
Received: by mail-wr0-f196.google.com with SMTP id u48so2860041wrc.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:50:46 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

Explicitely ignore messages with length zero. This also allows to
remove some now unneeded checks during message processing.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index b3b881f9..58414699 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -196,12 +196,10 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 	for (i = 0; i < i2c->count - 1; i++)
 		meson_i2c_add_token(i2c, TOKEN_DATA);
 
-	if (i2c->count) {
-		if (write || i2c->pos + i2c->count < i2c->msg->len)
-			meson_i2c_add_token(i2c, TOKEN_DATA);
-		else
-			meson_i2c_add_token(i2c, TOKEN_DATA_LAST);
-	}
+	if (write || i2c->pos + i2c->count < i2c->msg->len)
+		meson_i2c_add_token(i2c, TOKEN_DATA);
+	else
+		meson_i2c_add_token(i2c, TOKEN_DATA_LAST);
 
 	if (write)
 		meson_i2c_put_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
@@ -257,11 +255,8 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 
 	switch (i2c->state) {
 	case STATE_READ:
-		if (i2c->count > 0) {
-			meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos,
-					   i2c->count);
-			i2c->pos += i2c->count;
-		}
+		meson_i2c_get_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
+		i2c->pos += i2c->count;
 
 		if (i2c->pos >= i2c->msg->len) {
 			meson_i2c_stop(i2c);
@@ -371,6 +366,9 @@ static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	clk_enable(i2c->clk);
 
 	for (i = 0; i < num; i++) {
+		/* ignore messages with length 0 */
+		if (!msgs[i].len)
+			continue;
 		ret = meson_i2c_xfer_msg(i2c, &msgs[i], i == num - 1);
 		if (ret)
 			break;
-- 
2.12.0
