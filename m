From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH] i2c: riic: remove fixed clock restriction
Date: Fri, 29 Sep 2017 10:32:59 -0500
Message-ID: <20170929153259.105408-1-chris.brandt@renesas.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:41659 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752123AbdI2PeH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Sep 2017 11:34:07 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Chris Brandt <chris.brandt@renesas.com>

Most systems with this i2c are going to have a clock of either 33.3MHz or
32MHz. That 4% difference is not reason enough to warrant that the driver
to completely fail.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c811af4c8d81..0a61beeb384a 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -299,12 +299,13 @@ static int riic_init_hw(struct riic_dev *riic, u32 spd)
 
 	/*
 	 * TODO: Implement formula to calculate the timing values depending on
-	 * variable parent clock rate and arbitrary bus speed
+	 * variable parent clock rate and arbitrary bus speed.
+	 * For now, just use calculations based on a 33325000Hz clock.
 	 */
 	rate = clk_get_rate(riic->clk);
-	if (rate != 33325000) {
+	if (!rate) {
 		dev_err(&riic->adapter.dev,
-			"invalid parent clk (%lu). Must be 33325000Hz\n", rate);
+			"invalid parent clk (%lu)\n", rate);
 		clk_disable_unprepare(riic->clk);
 		return -EINVAL;
 	}
-- 
2.14.1
