From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 1/5] i2c: sh_mobile: remove redundant initialization
Date: Thu,  2 Nov 2017 13:47:27 +0100
Message-ID: <20171102124731.10484-2-wsa+renesas@sang-engineering.com>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Following the documentation, we initialize the HW before each START in
start_ch(). No need to do the same in activate_ch().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 6f2aaeb7c4fa15..9d073e99c7e72d 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -303,16 +303,6 @@ static void activate_ch(struct sh_mobile_i2c_data *pd)
 	/* Wake up device and enable clock */
 	pm_runtime_get_sync(pd->dev);
 	clk_prepare_enable(pd->clk);
-
-	/* Enable channel and configure rx ack */
-	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
-
-	/* Mask all interrupts */
-	iic_wr(pd, ICIC, 0);
-
-	/* Set the clock */
-	iic_wr(pd, ICCL, pd->iccl & 0xff);
-	iic_wr(pd, ICCH, pd->icch & 0xff);
 }
 
 static void deactivate_ch(struct sh_mobile_i2c_data *pd)
-- 
2.11.0
