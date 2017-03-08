From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 10/12] i2c: meson: remove meson_i2c_write_tokens
Date: Wed, 8 Mar 2017 07:49:00 +0100
Message-ID: <1c649a35-d90d-f9ef-e63d-f8502877fd9d@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35080 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756786AbdCHGuu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:50:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so4367876wmg.2
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:50:49 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

meson_i2c_write_tokens is always called directly after
meson_i2c_prepare_xfer (and only then). So we can simplify the code by
removing meson_i2c_write_tokens and moving the two statements of
meson_i2c_write_tokens to the end of meson_i2c_prepare_xfer. 

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index b11ecfdd..c73bb57a 100644
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
@@ -205,6 +199,9 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 
 	if (write)
 		meson_i2c_put_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
+
+	writel(i2c->tokens[0], i2c->regs + REG_TOK_LIST0);
+	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
 }
 
 static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
@@ -269,12 +266,10 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
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
 
@@ -315,7 +310,6 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 
 	i2c->state = (msg->flags & I2C_M_RD) ? STATE_READ : STATE_WRITE;
 	meson_i2c_prepare_xfer(i2c);
-	meson_i2c_write_tokens(i2c);
 	reinit_completion(&i2c->done);
 
 	/* Start the transfer */
-- 
2.12.0
