From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v9 3/8] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
Date: Thu, 12 May 2016 15:53:01 +0800
Message-ID: <1463039586-8134-4-git-send-email-david.wu@rock-chips.com>
References: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

rk3x_i2c_setup() gets called directly before rk3x_i2c_start(),
and the last thing in setup was to clean the IPD, so no reason
to do it at the beginning of start.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Change in v9:
- modify commit message

Change in v8:
- none

 drivers/i2c/busses/i2c-rk3x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 1e2677a..9eeb4e5 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -174,7 +174,6 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
 	u32 val;
 
-	rk3x_i2c_clean_ipd(i2c);
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
-- 
1.9.1
