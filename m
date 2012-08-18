From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mxs: Indicate that i2c driver was succesfully registered
Date: Sat, 18 Aug 2012 16:59:51 -0300
Message-ID: <1345319991-8660-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

It is useful information in dmesg to have a message indicating that the i2c
driver was succesfully registered.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
--
 drivers/i2c/busses/i2c-mxs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 088c5c1..619cbc8 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -447,6 +447,8 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 
 	of_i2c_register_devices(adap);
 
+	dev_info(dev, "MXS I2C adapter registered\n");
+
 	return 0;
 }
 
-- 
1.7.9.5
