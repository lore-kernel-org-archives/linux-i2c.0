From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Subject: [PATCH] drivers/i2c: Correct use of request_region/request_mem_region
Date: Sun, 9 Aug 2009 15:06:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0908091506160.16252@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>

request_mem_region should be used when ioremap is used subsequently.
release_region is then correspondingly replaced by release_mem_region.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression start,E;
@@

- request_region
+ request_mem_region
  (start,...)
... when != request_mem_region(start,...)
    when != start = E
ioremap(start,...)

@@
expression r.start;
@@

- release_region
+ release_mem_region
  (start,...)
// </smpl>

Signed-off-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>

---
 drivers/i2c/busses/i2c-pnx.c        |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index ec15cff..6ff6c20 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -586,7 +586,8 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	alg_data->mif.timer.data = (unsigned long)i2c_pnx->adapter;
 
 	/* Register I/O resource */
-	if (!request_region(alg_data->base, I2C_PNX_REGION_SIZE, pdev->name)) {
+	if (!request_mem_region(alg_data->base, I2C_PNX_REGION_SIZE,
+				pdev->name)) {
 		dev_err(&pdev->dev,
 		       "I/O region 0x%08x for I2C already in use.\n",
 		       alg_data->base);
@@ -650,7 +651,7 @@ out_clock:
 out_unmap:
 	iounmap((void *)alg_data->ioaddr);
 out_release:
-	release_region(alg_data->base, I2C_PNX_REGION_SIZE);
+	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 out_drvdata:
 	platform_set_drvdata(pdev, NULL);
 out:
@@ -667,7 +668,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 	i2c_del_adapter(adap);
 	i2c_pnx->set_clock_stop(pdev);
 	iounmap((void *)alg_data->ioaddr);
-	release_region(alg_data->base, I2C_PNX_REGION_SIZE);
+	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
