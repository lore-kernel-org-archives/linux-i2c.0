From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v2] i2c: riic: remove fixed clock restriction
Date: Fri, 29 Sep 2017 12:16:37 -0500
Message-ID: <20170929171637.121262-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-i2c@vger.kernel.org

Most systems with this i2c are going to have a clock of either 33.3MHz or
32MHz. That 4% difference is not reason enough to warrant that the driver
to completely fail.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
 * simplified error message.
---
 drivers/i2c/busses/i2c-riic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c811af4c8d81..b16b54c88e65 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -299,12 +299,12 @@ static int riic_init_hw(struct riic_dev *riic, u32 spd)
 
 	/*
 	 * TODO: Implement formula to calculate the timing values depending on
-	 * variable parent clock rate and arbitrary bus speed
+	 * variable parent clock rate and arbitrary bus speed.
+	 * For now, just use calculations based on a 33325000Hz clock.
 	 */
 	rate = clk_get_rate(riic->clk);
-	if (rate != 33325000) {
-		dev_err(&riic->adapter.dev,
-			"invalid parent clk (%lu). Must be 33325000Hz\n", rate);
+	if (!rate) {
+		dev_err(&riic->adapter.dev, "invalid parent clock rate of 0\n");
 		clk_disable_unprepare(riic->clk);
 		return -EINVAL;
 	}
-- 
2.14.1
