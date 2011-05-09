From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/13] i2c/i2c-nomadik: fix speed enumerator
Date: Mon,  9 May 2011 23:35:51 +0200
Message-ID: <1304976951-31479-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The I2C speed enumerators in the i2c-nomadik header file were in
the wrong order.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/plat-nomadik/include/plat/i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/i2c.h b/arch/arm/plat-nomadik/include/plat/i2c.h
index 4ed4e27..8ba70ff 100644
--- a/arch/arm/plat-nomadik/include/plat/i2c.h
+++ b/arch/arm/plat-nomadik/include/plat/i2c.h
@@ -11,8 +11,8 @@
 enum i2c_freq_mode {
 	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
 	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
+	I2C_FREQ_MODE_HIGH_SPEED,	/* up to 3.4 Mb/s */
 	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
-	I2C_FREQ_MODE_HIGH_SPEED	/* up to 3.4 Mb/s */
 };
 
 /**
-- 
1.7.5.1
