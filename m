From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] i2c: rk3x: Give the tuning value 0 during rk3x_i2c_v0_calc_timings
Date: Sat, 22 Oct 2016 16:43:42 +0800
Message-ID: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We found a bug that i2c transfer sometimes failed on 3066a board with
stabel-4.8, the con register would be updated by uninitialized tuning
value, it made the i2c transfer failed.

So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/i2c/busses/i2c-rk3x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 50702c7..df22066 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -694,6 +694,8 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
 	t_calc->div_low--;
 	t_calc->div_high--;
 
+	/* Give the tuning value 0, that would not update con register */
+	t_calc->tuning = 0;
 	/* Maximum divider supported by hw is 0xffff */
 	if (t_calc->div_low > 0xffff) {
 		t_calc->div_low = 0xffff;
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
