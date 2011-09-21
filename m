From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: [PATCH 7/7] i2c-eg20t: Add initialize processing in case i2c-error occurs
Date: Wed, 21 Sep 2011 16:51:49 +0900
Message-ID: <1316591509-4433-7-git-send-email-tomoya-linux@dsn.okisemi.com>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316591509-4433-1-git-send-email-tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In case disconnecting physical connection,
need to initialize i2c device for retry access.
This patch adds initialize process in case bus-idle fails and Lost arbitration.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 6d6baf0..b594378 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -288,6 +288,7 @@ static s32 pch_i2c_wait_for_bus_idle(struct i2c_algo_pch_data *adap,
 
 	if (!ktime_lt(ktime_get(), ns_val)) {
 		pch_err(adap, "%s: Timeout Error.return%d\n", __func__, -ETIME);
+		pch_i2c_init(adap);
 		return -ETIME;
 	}
 
@@ -432,6 +433,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		pch_err(adap, "Lost Arbitration\n");
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
 		pch_i2c_stop(adap);
@@ -548,6 +550,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		pch_err(adap, "Lost Arbitration\n");
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMAL_BIT);
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
+		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
 		pch_i2c_stop(adap);
-- 
1.7.4.4
