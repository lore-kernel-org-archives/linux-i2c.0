From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/4] i2c: i2c-mv64xxx: handle probe deferral for the clock
Date: Fri, 22 Apr 2016 15:19:52 +0200
Message-ID: <1461331194-27637-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39019 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752364AbcDVNUB (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Apr 2016 09:20:01 -0400
In-Reply-To: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

If a clock is registered by a platform driver and not by the
OF_CLK_DECLARE() mechanism, it might show up after the first attempt
to probe i2c-mv64xxx. In order to solve this, we need to handle
-EPROBE_PREFER as a special return value of devm_clk_get(), and return
the same error code from probe().

This gives us three situations:

 - There is no reference to a clock in the DT. In this case,
   devm_clk_get() returns an error that is not -EPROBE_DEFER
   (something like -ENODEV), and we continue the probing without
   enabling the clock.

 - There is a reference to the clock in the DT, and the clock is
   ready. devm_clk_get() returns a valid reference to the clock, and
   we prepare/enable it.

 - There is a reference to the clock in the DT, but the clock is not
   ready. devm_clk_get() returns -EPROBE_DEFER, and we exit from
   probe() with the same error code so that probe() is tried again
   later.

This is needed for Marvell Armada 7K/8K, where the clock driver is a
platform driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 43207f5..4c6282a 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -910,6 +910,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
 	drv_data->clk = devm_clk_get(&pd->dev, NULL);
+	if (IS_ERR(drv_data->clk) && PTR_ERR(drv_data->clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (!IS_ERR(drv_data->clk)) {
 		clk_prepare(drv_data->clk);
 		clk_enable(drv_data->clk);
-- 
2.6.4
