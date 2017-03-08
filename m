From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 12/12] i2c: meson: use state in meson_i2c_prepare_xfer
Date: Wed, 8 Mar 2017 07:50:23 +0100
Message-ID: <c9ee2ea8-28d6-17ff-2bf4-2354d3e404a5@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34686 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933376AbdCHGux (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:50:53 -0500
Received: by mail-wm0-f66.google.com with SMTP id u132so4369493wmg.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:50:52 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

Let's use the state here to make meson_i2c_prepare_xfer more in line
with other parts of the driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 7b29f077..eacb6f3d 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -181,7 +181,6 @@ static void meson_i2c_put_data(struct meson_i2c *i2c, char *buf, int len)
 
 static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 {
-	bool write = !(i2c->msg->flags & I2C_M_RD);
 	int i;
 
 	i2c->count = min(i2c->msg->len - i2c->pos, 8);
@@ -189,7 +188,7 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 	for (i = 0; i < i2c->count - 1; i++)
 		meson_i2c_add_token(i2c, TOKEN_DATA);
 
-	if (write || i2c->pos + i2c->count < i2c->msg->len)
+	if (i2c->state == STATE_WRITE || i2c->pos + i2c->count < i2c->msg->len)
 		meson_i2c_add_token(i2c, TOKEN_DATA);
 	else
 		meson_i2c_add_token(i2c, TOKEN_DATA_LAST);
@@ -197,7 +196,7 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 	if (i2c->last && i2c->pos + i2c->count >= i2c->msg->len)
 		meson_i2c_add_token(i2c, TOKEN_STOP);
 
-	if (write)
+	if (i2c->state == STATE_WRITE)
 		meson_i2c_put_data(i2c, i2c->msg->buf + i2c->pos, i2c->count);
 
 	writel(i2c->tokens[0], i2c->regs + REG_TOK_LIST0);
-- 
2.12.0
