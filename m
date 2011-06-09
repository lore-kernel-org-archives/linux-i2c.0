From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: [PATCH] i2c-eg20t : Support Combined R/W transfer mode
Date: Thu,  9 Jun 2011 11:29:29 +0900
Message-ID: <1307586569-14050-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently, Combined R/W transfer mode is not supported.
This patch enables Combined R/W transfer mode.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 838c21f..b2f94dc 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -672,25 +672,26 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
 	/* transfer not completed */
 	adap->pch_i2c_xfer_in_progress = true;
 
-	pmsg = &msgs[0];
-	pmsg->flags |= adap->pch_buff_mode_en;
-	status = pmsg->flags;
-	pch_dbg(adap,
-		"After invoking I2C_MODE_SEL :flag= 0x%x\n", status);
-	/* calculate sub address length and message length */
-	/* these are applicable only for buffer mode */
-	subaddrlen = pmsg->buf[0];
-	/* calculate actual message length excluding
-	 * the sub address fields */
-	msglen = (pmsg->len) - (subaddrlen + 1);
-	if (status & (I2C_M_RD)) {
-		pch_dbg(adap, "invoking pch_i2c_readbytes\n");
-		ret = pch_i2c_readbytes(i2c_adap, pmsg, (i + 1 == num),
-				   (i == 0));
-	} else {
-		pch_dbg(adap, "invoking pch_i2c_writebytes\n");
-		ret = pch_i2c_writebytes(i2c_adap, pmsg, (i + 1 == num),
-				    (i == 0));
+	for (i = 0; i < num; i++) {
+		pmsg = &msgs[i];
+		pmsg->flags |= adap->pch_buff_mode_en;
+		status = pmsg->flags;
+		pch_dbg(adap,
+			"After invoking I2C_MODE_SEL :flag= 0x%x\n", status);
+		/* calculate sub address length and message length */
+		/* these are applicable only for buffer mode */
+		subaddrlen = pmsg->buf[0];
+		/* calculate actual message length excluding
+		 * the sub address fields */
+		msglen = (pmsg->len) - (subaddrlen + 1);
+
+		if ((status & (I2C_M_RD)) != false) {
+			ret = pch_i2c_readbytes(i2c_adap, pmsg, (i + 1 == num),
+						(i == 0));
+		} else {
+			ret = pch_i2c_writebytes(i2c_adap, pmsg, (i + 1 == num),
+						 (i == 0));
+		}
 	}
 
 	adap->pch_i2c_xfer_in_progress = false;	/* transfer completed */
-- 
1.7.4
