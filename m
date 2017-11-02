From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 4/5] i2c: sh_mobile: use direct writes when accessing ICE bit
Date: Thu,  2 Nov 2017 13:47:30 +0100
Message-ID: <20171102124731.10484-5-wsa+renesas@sang-engineering.com>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

ICE bit is for resetting the module. Other bits don't matter then, so we
don't need to use the iic_set_clr() function but can use iic_wr().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index cdd7a746b9d1ed..1701f193d94acf 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -620,10 +620,10 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
 
 	if (do_init) {
 		/* Initialize channel registers */
-		iic_set_clr(pd, ICCR, 0, ICCR_ICE);
+		iic_wr(pd, ICCR, 0);
 
 		/* Enable channel and configure rx ack */
-		iic_set_clr(pd, ICCR, ICCR_ICE, 0);
+		iic_wr(pd, ICCR, ICCR_ICE);
 
 		/* Set the clock */
 		iic_wr(pd, ICCL, pd->iccl & 0xff);
@@ -740,7 +740,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	}
 
 	/* Disable channel */
-	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
+	iic_wr(pd, ICCR, 0);
 
 	/* Disable clock and mark device as idle */
 	clk_disable_unprepare(pd->clk);
-- 
2.11.0
