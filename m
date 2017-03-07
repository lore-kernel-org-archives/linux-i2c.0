From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] i2c: meson: fix wrong variable usage in meson_i2c_put_data
Date: Tue, 7 Mar 2017 21:06:38 +0100
Message-ID: <7ecc4542-a6ca-f266-5c34-057b3f5a33bf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35302 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdCGUHW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 7 Mar 2017 15:07:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so2794253wmg.2
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 12:06:48 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Most likely a copy & paste error.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 2aa61bbb..73b97c71 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -175,7 +175,7 @@ static void meson_i2c_put_data(struct meson_i2c *i2c, char *buf, int len)
 		wdata1 |= *buf++ << ((i - 4) * 8);
 
 	writel(wdata0, i2c->regs + REG_TOK_WDATA0);
-	writel(wdata0, i2c->regs + REG_TOK_WDATA1);
+	writel(wdata1, i2c->regs + REG_TOK_WDATA1);
 
 	dev_dbg(i2c->dev, "%s: data %08x %08x len %d\n", __func__,
 		wdata0, wdata1, len);
-- 
2.12.0
