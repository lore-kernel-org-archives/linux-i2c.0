From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 5/7] i2c/pxa2xx: check timeout correctly
Date: Wed, 24 Nov 2010 22:20:15 +0100
Message-ID: <1290633617-15311-6-git-send-email-bigeasy@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290633617-15311-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

timeout here maybe 0 if the event occured and a task with a higher
priority stole the cpu and we were sleeping longer than the timeout
value we specified.
In case of a real timeout I changed the error code to I2C_RETRY so we
retry the transfer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 7647361..bd4b885 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -719,8 +719,10 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	 */
 	ret = i2c->msg_idx;
 
-	if (timeout == 0)
+	if (!timeout && i2c->msg_num) {
 		i2c_pxa_scream_blue_murder(i2c, "timeout");
+		ret = I2C_RETRY;
+	}
 
  out:
 	return ret;
-- 
1.7.3.2
