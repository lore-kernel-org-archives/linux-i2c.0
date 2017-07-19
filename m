From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 029/102] i2c: sun6i-pw2i: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:33 +0200
Message-ID: <20170719152646.25903-30-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 7668e2e9b8fd2..68a4567ad974e 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -258,7 +258,7 @@ static int p2wi_probe(struct platform_device *pdev)
 
 	parent_clk_freq = clk_get_rate(p2wi->clk);
 
-	p2wi->rstc = devm_reset_control_get(dev, NULL);
+	p2wi->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(p2wi->rstc)) {
 		ret = PTR_ERR(p2wi->rstc);
 		dev_err(dev, "failed to retrieve reset controller: %d\n", ret);
-- 
2.11.0
