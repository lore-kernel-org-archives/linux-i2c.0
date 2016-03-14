From: David Wu <wdc@rock-chips.com>
Subject: [PATCH v4 3/3] i2c: rk3x: support I2C Highspeed Mode for rk3399
Date: Tue, 15 Mar 2016 06:52:30 +0800
Message-ID: <1457995950-46710-4-git-send-email-wdc@rock-chips.com>
References: <1457995950-46710-1-git-send-email-wdc@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457995950-46710-1-git-send-email-wdc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com
List-Id: linux-i2c@vger.kernel.org

From: David Wu <david.wu@rock-chips.com>

The i2c controller of new version1 supports highspeed mode,
1.7M and 3.4M rate. It could be calculated clocks by the rules.

Note: The final divs would be effected a lot by hardware elements like
scl_rise_ns, scl_fall_ns and sda_rise_ns.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index c82c2f9..f1ea801 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -704,9 +704,9 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 
 	int ret = 0;
 
-	/* Support standard-mode and fast-mode */
-	if (WARN_ON(t->bus_freq_hz > 400000))
-		t->bus_freq_hz = 400000;
+	/* Support standard-mode, fast-mode and highspeed-mode */
+	if (WARN_ON(t->bus_freq_hz > 3400000))
+		t->bus_freq_hz = 3400000;
 
 	/* prevent scl_rate_khz from becoming 0 */
 	if (WARN_ON(t->bus_freq_hz < 1000))
@@ -736,6 +736,24 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 
 		spec_min_data_setup_ns = 100;
 		spec_max_data_hold_ns = 900;
+	} else if (t->bus_freq_hz <= 1700000) {
+		spec_min_low_ns = 320;
+		spec_min_high_ns = 120;
+
+		spec_min_setup_start_ns = 160;
+		spec_min_stop_setup_ns = 160;
+
+		spec_min_data_setup_ns = 10;
+		spec_max_data_hold_ns = 150;
+	} else {
+		spec_min_low_ns = 160;
+		spec_min_high_ns = 60;
+
+		spec_min_setup_start_ns = 160;
+		spec_min_stop_setup_ns = 160;
+
+		spec_min_data_setup_ns = 10;
+		spec_max_data_hold_ns = 70;
 	}
 
 	/* caculate min-divh and min-divl */
-- 
1.9.1
