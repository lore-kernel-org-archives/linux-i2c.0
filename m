From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/2] i2c: mv64xxx: use platform_get_irq() instead of irq_of_parse_and_map()
Date: Tue, 16 May 2017 14:07:24 +0200
Message-ID: <1494936445-27331-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44682 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbdEPMHa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 May 2017 08:07:30 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

There is no reason to use platform_get_irq() for non-DT probing and
irq_of_parse_and_map() for DT probing. Indeed, platform_get_irq()
works fine for both.

In addition, using platform_get_irq() properly returns -EPROBE_DEFER
when the interrupt controller is not yet available.

Therefore, this commit moves the code filling drv_data->irq outside of
the non-DT vs. DT condition, and simply uses platform_get_irq().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a50bd68..f0a4d15 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -819,7 +819,6 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		rc = -EINVAL;
 		goto out;
 	}
-	drv_data->irq = irq_of_parse_and_map(np, 0);
 
 	drv_data->rstc = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(drv_data->rstc)) {
@@ -905,10 +904,11 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	if (!IS_ERR(drv_data->clk))
 		clk_prepare_enable(drv_data->clk);
 
+	drv_data->irq = platform_get_irq(pd, 0);
+
 	if (pdata) {
 		drv_data->freq_m = pdata->freq_m;
 		drv_data->freq_n = pdata->freq_n;
-		drv_data->irq = platform_get_irq(pd, 0);
 		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
 		drv_data->offload_enabled = false;
 		memcpy(&drv_data->reg_offsets, &mv64xxx_i2c_regs_mv64xxx, sizeof(drv_data->reg_offsets));
-- 
2.7.4
