From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: mv64xxx: remove unreachable signal case handling
Date: Thu, 11 Jun 2015 17:27:33 +0200
Message-ID: <1434036453-23336-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Chen-Yu Tsai <wens@csie.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-i2c@vger.kernel.org

'commit d295a86eab20 ("i2c: mv64xxx: work around signals causing I2C
transactions to be aborted")' removed the wait_event_interruptible_timeout 
to prevent half/mixed i2c messages from being sent/received but forgot to
drop the signal received cases in the return handling. This just removes
this dead code and simplifies the error message as "time_left" only can be 
0 here and thus it conveys no additional information.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was compile tested with multi_v7_defconfig 
(implies CONFIG_I2C_MV64XXX=y)

Patch is against 4.1-rc7 (localversion-next is -next-20150611)

 drivers/i2c/busses/i2c-mv64xxx.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 30059c1..a4f8ece 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -534,7 +534,6 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 {
 	long		time_left;
 	unsigned long	flags;
-	char		abort = 0;
 
 	time_left = wait_event_timeout(drv_data->waitq,
 		!drv_data->block, drv_data->adapter.timeout);
@@ -542,25 +541,17 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 	spin_lock_irqsave(&drv_data->lock, flags);
 	if (!time_left) { /* Timed out */
 		drv_data->rc = -ETIMEDOUT;
-		abort = 1;
-	} else if (time_left < 0) { /* Interrupted/Error */
-		drv_data->rc = time_left; /* errno value */
-		abort = 1;
-	}
-
-	if (abort && drv_data->block) {
 		drv_data->aborting = 1;
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 
 		time_left = wait_event_timeout(drv_data->waitq,
 			!drv_data->block, drv_data->adapter.timeout);
 
-		if ((time_left <= 0) && drv_data->block) {
+		if (time_left == 0) {
 			drv_data->state = MV64XXX_I2C_STATE_IDLE;
 			dev_err(&drv_data->adapter.dev,
-				"mv64xxx: I2C bus locked, block: %d, "
-				"time_left: %d\n", drv_data->block,
-				(int)time_left);
+				"mv64xxx: I2C bus locked, block: %d\n",
+				drv_data->block);
 			mv64xxx_i2c_hw_init(drv_data);
 		}
 	} else
-- 
1.7.10.4
