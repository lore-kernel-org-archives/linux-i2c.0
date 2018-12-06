From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/4] i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode
Date: Thu,  6 Dec 2018 12:55:28 +0900
Message-ID: <1544068528-27657-5-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index d8a5db14..03da4a5 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -518,9 +518,26 @@ static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv)
 
 	uniphier_fi2c_reset(priv);
 
+	/*
+	 *  Standard-mode: tLOW + tHIGH = 10 us
+	 *  Fast-mode:     tLOW + tHIGH = 2.5 us
+	 */
 	writel(cyc, priv->membase + UNIPHIER_FI2C_CYC);
-	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_LCTL);
+	/*
+	 *  Standard-mode: tLOW = 4.7 us, tHIGH = 4.0 us, tBUF = 4.7 us
+	 *  Fast-mode:     tLOW = 1.3 us, tHIGH = 0.6 us, tBUF = 1.3 us
+	 * "tLow/tHIGH = 5/4" meets both.
+	 */
+	writel(cyc * 5 / 9, priv->membase + UNIPHIER_FI2C_LCTL);
+	/*
+	 *  Standard-mode: tHD;STA = 4.0 us, tSU;STA = 4.7 us, tSU;STO = 4.0 us
+	 *  Fast-mode:     tHD;STA = 0.6 us, tSU;STA = 0.6 us, tSU;STO = 0.6 us
+	 */
 	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_SSUT);
+	/*
+	 *  Standard-mode: tSU;DAT = 250 ns
+	 *  Fast-mode:     tSU;DAT = 100 ns
+	 */
 	writel(cyc / 16, priv->membase + UNIPHIER_FI2C_DSUT);
 
 	uniphier_fi2c_prepare_operation(priv);
-- 
2.7.4
