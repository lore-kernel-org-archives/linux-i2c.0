From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH 2/2] i2c: rk3x: Fix variable 'min_total_ns' unused warning
Date: Thu, 22 Sep 2016 19:29:24 +0800
Message-ID: <1474543764-51135-3-git-send-email-david.wu@rock-chips.com>
References: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:46894 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756505AbcIVLaU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Sep 2016 07:30:20 -0400
In-Reply-To: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: dianders@chromium.org, huangtao@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

This patch fixs the following warning:
drivers/i2c/busses/i2c-rk3x.c: In function 'rk3x_i2c_v1_calc_timings':
drivers/i2c/busses/i2c-rk3x.c:745:41: warning: variable 'min_total_ns' set but not used [-Wunused-but-set-variable]

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 965477e..50702c7 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -742,7 +742,7 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 				    struct i2c_timings *t,
 				    struct rk3x_i2c_calced_timings *t_calc)
 {
-	unsigned long min_low_ns, min_high_ns, min_total_ns;
+	unsigned long min_low_ns, min_high_ns;
 	unsigned long min_setup_start_ns, min_setup_data_ns;
 	unsigned long min_setup_stop_ns, max_hold_data_ns;
 
@@ -793,7 +793,6 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 
 	/* These are the min dividers needed for min hold times. */
 	min_div_for_hold = (min_low_div + min_high_div);
-	min_total_ns = min_low_ns + min_high_ns;
 
 	/*
 	 * This is the maximum divider so we don't go over the maximum.
-- 
1.9.1
