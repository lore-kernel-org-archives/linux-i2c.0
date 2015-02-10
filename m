From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v3] i2c: cadence: fixup wait_for_completion_timeout return handling
Date: Tue, 10 Feb 2015 11:55:10 -0500
Message-ID: <1423587310-18103-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. The
return variable is renamed to make the timeout condition clearly readable
and the type adjusted to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

v3: rename the variable to time_left as suggested by Sergei Shtylyov 
    <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> so that the timeout condition is
    clearly readable.
v2: int ret is an idiom not only a declaration - thus rather than just
    changing the type, rename the variable, as suggested by Wolfram Sang
    <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>.

Patch was only compile tested with multi_v7_defconfig
(implies CONFIG_I2C_CADENCE=y)

Patch is against 3.19.0 (localversion-next is -next-20150210)

 drivers/i2c/busses/i2c-cadence.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 7d7a14c..2ee78e0 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -475,7 +475,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter *adap)
 static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 		struct i2c_adapter *adap)
 {
-	int ret;
+	unsigned long time_left;
 	u32 reg;
 
 	id->p_msg = msg;
@@ -501,8 +501,8 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 		cdns_i2c_msend(id);
 
 	/* Wait for the signal of completion */
-	ret = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
-	if (!ret) {
+	time_left = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
+	if (time_left == 0) {
 		cdns_i2c_master_reset(adap);
 		dev_err(id->adap.dev.parent,
 				"timeout waiting on completion\n");
-- 
1.7.10.4
