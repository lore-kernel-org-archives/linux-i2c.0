From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 01/10] i2c: meson: use min instead of min_t where min_t
 isn't needed
Date: Sat, 11 Mar 2017 19:22:46 +0100
Message-ID: <e569f23d-2245-f4b6-4494-2e06b066242c@gmail.com>
References: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33036 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754943AbdCKSYn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 11 Mar 2017 13:24:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so3787744wma.0
        for <linux-i2c@vger.kernel.org>; Sat, 11 Mar 2017 10:24:42 -0800 (PST)
In-Reply-To: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

Use min instead of min_t where min_t isn't needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
v3:
- no changes
---
 drivers/i2c/busses/i2c-meson.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 73b97c71..40e5da9a 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -156,10 +156,10 @@ static void meson_i2c_get_data(struct meson_i2c *i2c, char *buf, int len)
 	dev_dbg(i2c->dev, "%s: data %08x %08x len %d\n", __func__,
 		rdata0, rdata1, len);
 
-	for (i = 0; i < min_t(int, 4, len); i++)
+	for (i = 0; i < min(4, len); i++)
 		*buf++ = (rdata0 >> i * 8) & 0xff;
 
-	for (i = 4; i < min_t(int, 8, len); i++)
+	for (i = 4; i < min(8, len); i++)
 		*buf++ = (rdata1 >> (i - 4) * 8) & 0xff;
 }
 
@@ -168,10 +168,10 @@ static void meson_i2c_put_data(struct meson_i2c *i2c, char *buf, int len)
 	u32 wdata0 = 0, wdata1 = 0;
 	int i;
 
-	for (i = 0; i < min_t(int, 4, len); i++)
+	for (i = 0; i < min(4, len); i++)
 		wdata0 |= *buf++ << (i * 8);
 
-	for (i = 4; i < min_t(int, 8, len); i++)
+	for (i = 4; i < min(8, len); i++)
 		wdata1 |= *buf++ << ((i - 4) * 8);
 
 	writel(wdata0, i2c->regs + REG_TOK_WDATA0);
@@ -186,7 +186,7 @@ static void meson_i2c_prepare_xfer(struct meson_i2c *i2c)
 	bool write = !(i2c->msg->flags & I2C_M_RD);
 	int i;
 
-	i2c->count = min_t(int, i2c->msg->len - i2c->pos, 8);
+	i2c->count = min(i2c->msg->len - i2c->pos, 8);
 
 	for (i = 0; i < i2c->count - 1; i++)
 		meson_i2c_add_token(i2c, TOKEN_DATA);
-- 
2.12.0
