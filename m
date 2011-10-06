From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 7/7 v3] i2c-eg20t: Add initialize processing in case i2c-error occurs
Date: Thu,  6 Oct 2011 15:56:32 +0900
Message-ID: <1317884192-10694-8-git-send-email-tomoya-linux__13596.5072353885$1317883924$gmane$org@dsn.lapis-semi.com>
References: <1317884192-10694-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1317884192-10694-1-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In case disconnecting physical connection,
need to initialize i2c device for retry access.
This patch adds initialize process in case bus-idle fails and Lost arbitration.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 20c0f34..d3b0f4f 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -290,6 +290,7 @@ static s32 pch_i2c_wait_for_bus_idle(struct i2c_algo_pch_data *adap,
 
 	pch_dbg(adap, "I2CSR = %x\n", ioread32(p + PCH_I2CSR));
 	pch_err(adap, "%s: Timeout Error.return%d\n", __func__, -ETIME);
+	pch_i2c_init(adap);
 
 	return -ETIME;
 }
@@ -455,6 +456,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		pch_err(adap, "Lost Arbitration\n");
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
 		pch_i2c_stop(adap);
@@ -572,6 +574,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		pch_err(adap, "Lost Arbitration\n");
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
 		pch_i2c_stop(adap);
-- 
1.7.4.4
