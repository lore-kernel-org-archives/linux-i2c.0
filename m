From: Joe Perches <joe@perches.com>
Subject: [PATCH -next 010/491] ARM/SAMSUNG EXYNOS ARM ARCHITECTURES: Use fallthrough;
Date: Tue, 10 Mar 2020 21:51:24 -0700
Message-ID: <1d569e023b6cb7b8d0da8d1bcccd92e97fe436c8.1583896348.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1583896344.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/clk/samsung/clk-s3c2443.c | 2 +-
 drivers/i2c/busses/i2c-s3c2410.c  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index 5f30fe7..c7aba1e 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -387,7 +387,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				ARRAY_SIZE(s3c2450_gates));
 		samsung_clk_register_alias(ctx, s3c2450_aliases,
 				ARRAY_SIZE(s3c2450_aliases));
-		/* fall through - as s3c2450 extends the s3c2416 clocks */
+		fallthrough;	/* as s3c2450 extends the s3c2416 clocks */
 	case S3C2416:
 		samsung_clk_register_div(ctx, s3c2416_dividers,
 				ARRAY_SIZE(s3c2416_dividers));
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index c98ef4c..dd1264 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -435,8 +435,7 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		 * fall through to the write state, as we will need to
 		 * send a byte as well
 		 */
-		/* Fall through */
-
+		fallthrough;
 	case STATE_WRITE:
 		/*
 		 * we are writing data to the device... check for the
-- 
2.24.0
