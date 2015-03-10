From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] i2c: mxs: match wait_for_completion_timeout return type
Date: Tue, 10 Mar 2015 14:08:13 -0400
Message-ID: <1426010893-8921-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Return type of wait_for_completion_timeout is unsigned long not int. 
An appropriately named unsigned long is added and the assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

Note that 4.0-rc3 does not compile for mxs_defcofnig due to a bug (typo)
in mxs-auart.c - the compile testing was done with the fixed up mxs-auart.

This was only compile tested for mxs_defconfig (implies CONFIG_I2C_MXS=y)

Patch is against 4.0-rc3 linux-next (localversion-next is -next-20150310)

 drivers/i2c/busses/i2c-mxs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index ff8b12c..56fceff 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -568,6 +568,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	int ret;
 	int flags;
 	int use_pio = 0;
+	unsigned long time_left;
 
 	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
 
@@ -599,9 +600,9 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		if (ret)
 			return ret;
 
-		ret = wait_for_completion_timeout(&i2c->cmd_complete,
+		time_left = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
-		if (ret == 0)
+		if (!time_left)
 			goto timeout;
 
 		ret = i2c->cmd_err;
-- 
1.7.10.4
