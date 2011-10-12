From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 6/7 v4] i2c-eg20t: Fix flag setting issue
Date: Wed, 12 Oct 2011 13:13:05 +0900
Message-ID: <1318392786-23610-6-git-send-email-tomoya-linux__42901.9885873005$1318392849$gmane$org@dsn.lapis-semi.com>
References: <1318392786-23610-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318392786-23610-1-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently, in case occurring abnormal event,
internal flag variable(=pch_event_flag) is not reset.
This patch fixes the issue.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 116708d..e25b8eb 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -321,11 +321,13 @@ static s32 pch_i2c_wait_for_xfer_complete(struct i2c_algo_pch_data *adap)
 
 	if (ret == 0) {
 		pch_err(adap, "timeout: %x\n", adap->pch_event_flag);
+		adap->pch_event_flag = 0;
 		return -ETIMEDOUT;
 	}
 
 	if (adap->pch_event_flag & I2C_ERROR_MASK) {
 		pch_err(adap, "error bits set: %x\n", adap->pch_event_flag);
+		adap->pch_event_flag = 0;
 		return -EIO;
 	}
 
-- 
1.7.4.4
