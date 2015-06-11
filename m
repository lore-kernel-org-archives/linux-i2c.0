From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH RFC] i2c: octeon: allow receiving of signals.
Date: Thu, 11 Jun 2015 15:23:52 +0200
Message-ID: <1434029032-8811-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Change wait_event_timeout() to wait_event_interruptible_timeout() allowing
signals to be received while waiting on event (task state set to 
TASK_INTERRUPTIBLE) as the dev_dbg() string indicates that signals
are expected to be possible. While at it fix the type to long (as returned
by schedule_timeout(). 

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

>From the dev_dbg string "wait interrupted" it seems that interrupts are
expected to be on - so most likely this should be
wait_event_interruptible_timeout() and not wait_event_timeout() as the
later return >= 0 always and sets the task state to TASK_UNINTERRUPTIBLE.
Someone that knows the details of this driver needs to confirm this though.

Patch was compile tested with cavium_octeon_defconfig
(implies CONFIG_I2C_OCTEON=y)

Patch is against 4.1-rc7 (localversion-next is -next-20150611)

 drivers/i2c/busses/i2c-octeon.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 6e75e01..e25e2b8 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -200,19 +200,19 @@ static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
-	int result;
+	long result;
 
 	octeon_i2c_int_enable(i2c);
 
-	result = wait_event_timeout(i2c->queue,
-					octeon_i2c_test_iflg(i2c),
-					i2c->adap.timeout);
+	result = wait_event_interruptible_timeout(i2c->queue,
+						  octeon_i2c_test_iflg(i2c),
+						  i2c->adap.timeout);
 
 	octeon_i2c_int_disable(i2c);
 
 	if (result < 0) {
 		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
-		return result;
+		return -ERESTARTSYS;
 	} else if (result == 0) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
-- 
1.7.10.4
