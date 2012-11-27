From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 11/16] i2c: puv3: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:48 -0500
Message-ID: <1354049993-12718-12-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
---
 drivers/i2c/busses/i2c-puv3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index d8515be..d7c512d 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -184,7 +184,7 @@ static struct i2c_algorithm puv3_i2c_algorithm = {
 /*
  * Main initialization routine.
  */
-static int __devinit puv3_i2c_probe(struct platform_device *pdev)
+static int puv3_i2c_probe(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter;
 	struct resource *mem;
@@ -231,7 +231,7 @@ fail_nomem:
 	return rc;
 }
 
-static int __devexit puv3_i2c_remove(struct platform_device *pdev)
+static int puv3_i2c_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
 	struct resource *mem;
@@ -276,7 +276,7 @@ static SIMPLE_DEV_PM_OPS(puv3_i2c_pm, puv3_i2c_suspend, NULL);
 
 static struct platform_driver puv3_i2c_driver = {
 	.probe		= puv3_i2c_probe,
-	.remove		= __devexit_p(puv3_i2c_remove),
+	.remove		= puv3_i2c_remove,
 	.driver		= {
 		.name	= "PKUnity-v3-I2C",
 		.owner	= THIS_MODULE,
-- 
1.8.0.1
