From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] i2c: rk3x: fix some typo
Date: Thu,  1 Nov 2018 11:37:49 -0400
Message-ID: <20181101153749.22935-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index b8a2728dd4b6..fe347e8e2a23 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
  *
  * @clk_rate: I2C input clock rate
  * @t: Known I2C timing information
- * @t_calc: Caculated rk3x private timings that would be written into regs
+ * @t_calc: Calculated rk3x private timings that would be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
@@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
  *
  * @clk_rate: I2C input clock rate
  * @t: Known I2C timing information
- * @t_calc: Caculated rk3x private timings that would be written into regs
+ * @t_calc: Calculated rk3x private timings that would be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
-- 
2.17.0
