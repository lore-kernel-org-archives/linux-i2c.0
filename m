From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 5/7 v4] i2c-eg20t: add stop sequence in case wait-event timeout occurs
Date: Wed, 12 Oct 2011 13:13:04 +0900
Message-ID: <1318392786-23610-5-git-send-email-tomoya-linux__5892.65722451291$1318392870$gmane$org@dsn.lapis-semi.com>
References: <1318392786-23610-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318392786-23610-1-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

add stop sequence in case wait-event timeout in write processing.
(read processing already had it)

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 0693246..116708d 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -459,6 +459,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_i2c_stop(adap);
 		return -ETIME;
 	}
 
@@ -479,6 +480,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
 				   I2CMIF_BIT);
 		} else { /* wait-event timeout */
+			pch_i2c_stop(adap);
 			return -ETIME;
 		}
 	}
@@ -635,6 +637,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_i2c_stop(adap);
 		return -ETIME;
 	}
 
-- 
1.7.4.4
