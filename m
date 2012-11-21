From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] i2c: mxs: Fix misuse init_completion
Date: Wed, 21 Nov 2012 06:19:06 +0100
Message-ID: <1353475146-28669-1-git-send-email-marex@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The init_completion() call does reinit not only the variable carrying
the flag that the completion finished, but also initialized the
waitqueue associated with the completion. On the contrary, the
INIT_COMPLETION() call only reinits the flag.

In case there was anything still stuck in the waitqueue, subsequent call
to init_completion() would be able to create possible race condition. This
patch uses the proper function and moves init_completion() into .probe() call
of the driver, to be issued only once.

Note that such scenario is impossible, since two threads can never enter the
mxs_i2c_xfer_msg(), since whole this section is protected by mutex in I2C core.
This by no means allows this issue to exit though.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 6ed53da..47d5d53 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -316,7 +316,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	if (msg->len == 0)
 		return -EINVAL;
 
-	init_completion(&i2c->cmd_complete);
+	INIT_COMPLETION(i2c->cmd_complete);
 	i2c->cmd_err = 0;
 
 	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
@@ -473,6 +473,8 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	i2c->dev = dev;
 	i2c->speed = &mxs_i2c_95kHz_config;
 
+	init_completion(&i2c->cmd_complete);
+
 	if (dev->of_node) {
 		err = mxs_i2c_get_ofdata(i2c);
 		if (err)
-- 
1.7.10.4
