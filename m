From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 09/10] i2c: meson: remove meson_i2c_write_tokens
Date: Sat, 11 Mar 2017 19:24:18 +0100
Message-ID: <5f2c80cc-dfe8-cfe2-90a0-8f5c63522f2a@gmail.com>
References: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35403 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbdCKSYz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 11 Mar 2017 13:24:55 -0500
Received: by mail-wr0-f194.google.com with SMTP id u108so15281724wrb.2
        for <linux-i2c@vger.kernel.org>; Sat, 11 Mar 2017 10:24:54 -0800 (PST)
In-Reply-To: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

meson_i2c_write_tokens is always called directly after
meson_i2c_prepare_xfer (and only then). So we can simplify the code by
removing meson_i2c_write_tokens and moving the two statements of
meson_i2c_write_tokens to the end of meson_i2c_prepare_xfer. 

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
v3:
- no changes
---
 drivers/i2c/busses/i2c-meson.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 6c873ed8..23f25efa 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -123,12 +123,6 @@ static void meson_i2c_add_token(struct meson_i2c *i2c, int token)
 	i2c->num_tokens++;
 }
 
-static void meson_i2c_write_tokens(struct meson_i2c *i2c)
-{
-	writel(i2c->tokens[0], i2c->regs + REG_TOK_LIST0);
-	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
-}
-
 static void meson_i2c_set_clk_div(struct meson_i2c *i2c, unsigned int freq)
 {
 	unsigned long clk_rate = clk_get_rate(i2c->clk);
@@ -207,6 +201,9 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 
 	if (i2c->last && i2c->pos + i2c->count >= i2c->msg->len)
 		meson_i2c_add_token(i2c, TOKEN_STOP);
+
+	writel(i2c->tokens[0], i2c->regs + REG_TOK_LIST0);
+	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
 }
 
 static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
@@ -272,12 +269,10 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 	}
 
 out:
-	if (i2c->state != STATE_IDLE) {
+	if (i2c->state != STATE_IDLE)
 		/* Restart the processing */
-		meson_i2c_write_tokens(i2c);
 		meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START,
 				   REG_CTRL_START);
-	}
 
 	spin_unlock(&i2c->lock);
 
@@ -318,7 +313,6 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 
 	i2c->state = (msg->flags & I2C_M_RD) ? STATE_READ : STATE_WRITE;
 	meson_i2c_prepare_xfer(i2c);
-	meson_i2c_write_tokens(i2c);
 	reinit_completion(&i2c->done);
 
 	/* Start the transfer */
-- 
2.12.0
