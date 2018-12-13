From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 39/41] i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode
Date: Wed, 12 Dec 2018 23:30:52 -0500
Message-ID: <20181213043054.75891-39-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit ece27a337d42a3197935711997f2880f0957ed7e ]

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index a403e8579b65..bc26ec822e26 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -470,9 +470,26 @@ static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv)
 
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
2.19.1
