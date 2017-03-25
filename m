From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 09/10] i2c: meson: remove meson_i2c_write_tokens
Date: Sat, 25 Mar 2017 14:12:04 +0100
Message-ID: <c5bd5830-1ae5-ffd6-978e-3aef9cd68146@gmail.com>
References: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35271 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdCYNOu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 25 Mar 2017 09:14:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so2145006wrb.2
        for <linux-i2c@vger.kernel.org>; Sat, 25 Mar 2017 06:14:49 -0700 (PDT)
In-Reply-To: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
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
v4:
- no changes
v5:
- no changes
---
 drivers/i2c/busses/i2c-meson.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 8a088d26..d3c33ee4 100644
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
@@ -210,6 +204,9 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 
 	if (i2c->last && i2c->pos + i2c->count >= i2c->msg->len)
 		meson_i2c_add_token(i2c, TOKEN_STOP);
+
+	writel(i2c->tokens[0], i2c->regs + REG_TOK_LIST0);
+	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
 }
 
 static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
@@ -275,12 +272,10 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
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
 
@@ -321,7 +316,6 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 
 	i2c->state = (msg->flags & I2C_M_RD) ? STATE_READ : STATE_WRITE;
 	meson_i2c_prepare_xfer(i2c);
-	meson_i2c_write_tokens(i2c);
 	reinit_completion(&i2c->done);
 
 	/* Start the transfer */
-- 
2.12.0
