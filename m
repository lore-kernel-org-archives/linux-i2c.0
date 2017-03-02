From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: thunderx: ACPI support for clock settings
Date: Thu,  2 Mar 2017 11:34:07 +0100
Message-ID: <20170302103407.24264-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34020 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdCBKoN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Mar 2017 05:44:13 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Add support for reading the system clock and the TWSI clock
frequency from ACPI DSDT.

TWSI clock was already covered by using device_property_read().

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index bba5b42..031e59f 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -85,17 +85,23 @@ static void thunder_i2c_clock_enable(struct device *dev, struct octeon_i2c *i2c)
 {
 	int ret;
 
-	i2c->clk = clk_get(dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		i2c->clk = NULL;
-		goto skip;
+	if (acpi_disabled) {
+		/* DT */
+		i2c->clk = clk_get(dev, NULL);
+		if (IS_ERR(i2c->clk)) {
+			i2c->clk = NULL;
+			goto skip;
+		}
+
+		ret = clk_prepare_enable(i2c->clk);
+		if (ret)
+			goto skip;
+		i2c->sys_freq = clk_get_rate(i2c->clk);
+	} else {
+		/* ACPI */
+		device_property_read_u32(dev, "sclk", &i2c->sys_freq);
 	}
 
-	ret = clk_prepare_enable(i2c->clk);
-	if (ret)
-		goto skip;
-	i2c->sys_freq = clk_get_rate(i2c->clk);
-
 skip:
 	if (!i2c->sys_freq)
 		i2c->sys_freq = SYS_FREQ_DEFAULT;
-- 
2.9.0.rc0.21.g7777322
