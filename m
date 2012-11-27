From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 08/16] i2c: ocores: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:45 -0500
Message-ID: <1354049993-12718-9-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 9b35c9f..a873d0a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -343,7 +343,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 #define ocores_i2c_of_probe(pdev,i2c) -ENODEV
 #endif
 
-static int __devinit ocores_i2c_probe(struct platform_device *pdev)
+static int ocores_i2c_probe(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c;
 	struct ocores_i2c_platform_data *pdata;
@@ -441,7 +441,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ocores_i2c_remove(struct platform_device *pdev)
+static int ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
 
@@ -485,7 +485,7 @@ static SIMPLE_DEV_PM_OPS(ocores_i2c_pm, ocores_i2c_suspend, ocores_i2c_resume);
 
 static struct platform_driver ocores_i2c_driver = {
 	.probe   = ocores_i2c_probe,
-	.remove  = __devexit_p(ocores_i2c_remove),
+	.remove  = ocores_i2c_remove,
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = "ocores-i2c",
-- 
1.8.0.1
