From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Date: Sun, 26 Jan 2014 16:05:34 +0000
Message-ID: <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390752337-22386-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The i2c-rcar driver currently prints an error message if the master_xfer
callback fails. However if the bus is being probed then lots of NAKs
will be generated, causing the output of a number of errors printed.

To solve this, disable the print if the error is not -EREMOTEIO.

An example of running i2cdetect:

10: i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- 12 i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15

Cc: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 2c2fd7c..0d25104 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -623,7 +623,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_put(dev);
 
-	if (ret < 0)
+	if (ret < 0 && ret != -EREMOTEIO)
 		dev_err(dev, "error %d : %x\n", ret, priv->flags);
 
 	return ret;
-- 
1.8.5.2
