From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v10 8/8] i2c: rk3x: support fast-mode plus for rk3399
Date: Mon, 16 May 2016 22:06:29 +0800
Message-ID: <1463407589-41520-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:59080 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbcEPOXF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 16 May 2016 10:23:05 -0400
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

Implement fast mode plus that allows bus speeds of up to 1MHz.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
Change in v10:
- none

Change in v9:
- add commit message

Change in v8:
- none

 drivers/i2c/busses/i2c-rk3x.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index a96b516..2938616 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -126,6 +126,17 @@ static const struct i2c_spec_values fast_mode_spec = {
 	.min_hold_buffer_ns = 1300,
 };
 
+static const struct i2c_spec_values fast_mode_plus_spec = {
+	.min_hold_start_ns = 260,
+	.min_low_ns = 500,
+	.min_high_ns = 260,
+	.min_setup_start_ns = 260,
+	.max_data_hold_ns = 400,
+	.min_data_setup_ns = 50,
+	.min_setup_stop_ns = 260,
+	.min_hold_buffer_ns = 500,
+};
+
 /**
  * struct rk3x_i2c_calced_timings:
  * @div_low: Divider output for low
@@ -532,8 +543,10 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
 {
 	if (speed <= 100000)
 		return &standard_mode_spec;
-	else
+	else if (speed <= 400000)
 		return &fast_mode_spec;
+	else
+		return &fast_mode_plus_spec;
 }
 
 /**
@@ -744,9 +757,9 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 	const struct i2c_spec_values *spec;
 	int ret = 0;
 
-	/* Support standard-mode and fast-mode */
-	if (WARN_ON(t->bus_freq_hz > 400000))
-		t->bus_freq_hz = 400000;
+	/* Support standard-mode, fast-mode and fast-mode plus */
+	if (WARN_ON(t->bus_freq_hz > 1000000))
+		t->bus_freq_hz = 1000000;
 
 	/* prevent scl_rate_khz from becoming 0 */
 	if (WARN_ON(t->bus_freq_hz < 1000))
-- 
1.9.1
