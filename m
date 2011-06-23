From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: [PATCH] i2c-eg20t : Fix the issue of Combined R/W transfer mode
Date: Thu, 23 Jun 2011 16:17:10 +0900
Message-ID: <1308813430-2697-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

issue-1
In case combined transfer mode fails halfway, the processing must be stopped halfway.
However currently, the processing is continued.
This patch breaks the processing.

issue-2
Currently, pch_i2c_xfer returns read/write size at that time.
However pch_i2c_xfer must return the number of messages to be read/written.
This patch modifies correctly.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index b2f94dc..4bc272e 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -672,7 +672,7 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
 	/* transfer not completed */
 	adap->pch_i2c_xfer_in_progress = true;
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < num && ret >= 0; i++) {
 		pmsg = &msgs[i];
 		pmsg->flags |= adap->pch_buff_mode_en;
 		status = pmsg->flags;
@@ -698,7 +698,7 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	mutex_unlock(&pch_mutex);
 
-	return ret;
+	return (ret < 0) ? ret : num;
 }
 
 /**
-- 
1.7.4.4
