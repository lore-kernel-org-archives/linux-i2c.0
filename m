From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:22:40 +0900
Message-ID: <002501ce579f$745d4810$5d17d830$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Jochen Friedrich' <jochen-NIgtFMG+Po8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-cpm.c     |    4 ++--
 drivers/i2c/busses/i2c-ibm_iic.c |    4 ++--
 drivers/i2c/busses/i2c-mpc.c     |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 3823623..eccf5c2 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -646,7 +646,7 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 
 	cpm->ofdev = ofdev;
 
-	dev_set_drvdata(&ofdev->dev, cpm);
+	platform_set_drvdata(ofdev, cpm);
 
 	cpm->adap = cpm_ops;
 	i2c_set_adapdata(&cpm->adap, cpm);
@@ -689,7 +689,7 @@ out_free:
 
 static int cpm_i2c_remove(struct platform_device *ofdev)
 {
-	struct cpm_i2c *cpm = dev_get_drvdata(&ofdev->dev);
+	struct cpm_i2c *cpm = platform_get_drvdata(ofdev);
 
 	i2c_del_adapter(&cpm->adap);
 
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 405a2e2..973f516 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -705,7 +705,7 @@ static int iic_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 	}
 
-	dev_set_drvdata(&ofdev->dev, dev);
+	platform_set_drvdata(ofdev, dev);
 
 	dev->vaddr = of_iomap(np, 0);
 	if (dev->vaddr == NULL) {
@@ -782,7 +782,7 @@ error_cleanup:
  */
 static int iic_remove(struct platform_device *ofdev)
 {
-	struct ibm_iic_private *dev = dev_get_drvdata(&ofdev->dev);
+	struct ibm_iic_private *dev = platform_get_drvdata(ofdev);
 
 	i2c_del_adapter(&dev->adap);
 
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 5e705ee..7607dc0 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -679,7 +679,7 @@ static int fsl_i2c_probe(struct platform_device *op)
 	}
 	dev_info(i2c->dev, "timeout %u us\n", mpc_ops.timeout * 1000000 / HZ);
 
-	dev_set_drvdata(&op->dev, i2c);
+	platform_set_drvdata(op, i2c);
 
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
@@ -707,7 +707,7 @@ static int fsl_i2c_probe(struct platform_device *op)
 
 static int fsl_i2c_remove(struct platform_device *op)
 {
-	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
+	struct mpc_i2c *i2c = platform_get_drvdata(op);
 
 	i2c_del_adapter(&i2c->adap);
 
-- 
1.7.10.4
