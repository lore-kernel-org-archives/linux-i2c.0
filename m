From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 2/5] i2c: sh_mobile: remove redundant deinitialization
Date: Thu,  2 Nov 2017 13:47:28 +0100
Message-ID: <20171102124731.10484-3-wsa+renesas@sang-engineering.com>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

No need to clear the interrupt registers because right after that we
disable the IP core which will reload registers with their initial
values anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9d073e99c7e72d..a1253df9574594 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -307,10 +307,6 @@ static void activate_ch(struct sh_mobile_i2c_data *pd)
 
 static void deactivate_ch(struct sh_mobile_i2c_data *pd)
 {
-	/* Clear/disable interrupts */
-	iic_wr(pd, ICSR, 0);
-	iic_wr(pd, ICIC, 0);
-
 	/* Disable channel */
 	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
 
-- 
2.11.0
