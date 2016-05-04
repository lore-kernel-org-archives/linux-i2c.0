From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v7 4/9] i2c: rk3x: Move setting STATE_START and add STATE_SETUP
Date: Wed,  4 May 2016 22:13:09 +0800
Message-ID: <1462371194-5809-5-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v7:
- none

 drivers/i2c/busses/i2c-rk3x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 9eeb4e5..0838fcf 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -87,6 +87,7 @@ struct rk3x_i2c_calced_timings {
 
 enum rk3x_i2c_state {
 	STATE_IDLE,
+	STATE_SETUP,
 	STATE_START,
 	STATE_READ,
 	STATE_WRITE,
@@ -174,6 +175,7 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
 	u32 val;
 
+	i2c->state = STATE_START;
 	i2c_writel(i2c, REG_INT_START, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
@@ -451,6 +453,7 @@ static irqreturn_t rk3x_i2c_irq(int irqno, void *dev_id)
 		rk3x_i2c_handle_stop(i2c, ipd);
 		break;
 	case STATE_IDLE:
+	case STATE_SETUP:
 		break;
 	}
 
@@ -781,7 +784,7 @@ static int rk3x_i2c_setup(struct rk3x_i2c *i2c, struct i2c_msg *msgs, int num)
 
 	i2c->addr = msgs[0].addr;
 	i2c->busy = true;
-	i2c->state = STATE_START;
+	i2c->state = STATE_SETUP;
 	i2c->processed = 0;
 	i2c->error = 0;
 
-- 
1.9.1
