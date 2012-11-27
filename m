From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 10/16] i2c: pca: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:47 -0500
Message-ID: <1354049993-12718-11-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pca-isa.c      | 8 ++++----
 drivers/i2c/busses/i2c-pca-platform.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 29933f8..323f061 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -119,7 +119,7 @@ static struct i2c_adapter pca_isa_ops = {
 	.timeout	= HZ,
 };
 
-static int __devinit pca_isa_match(struct device *dev, unsigned int id)
+static int pca_isa_match(struct device *dev, unsigned int id)
 {
 	int match = base != 0;
 
@@ -132,7 +132,7 @@ static int __devinit pca_isa_match(struct device *dev, unsigned int id)
 	return match;
 }
 
-static int __devinit pca_isa_probe(struct device *dev, unsigned int id)
+static int pca_isa_probe(struct device *dev, unsigned int id)
 {
 	init_waitqueue_head(&pca_wait);
 
@@ -174,7 +174,7 @@ static int __devinit pca_isa_probe(struct device *dev, unsigned int id)
 	return -ENODEV;
 }
 
-static int __devexit pca_isa_remove(struct device *dev, unsigned int id)
+static int pca_isa_remove(struct device *dev, unsigned int id)
 {
 	i2c_del_adapter(&pca_isa_ops);
 
@@ -190,7 +190,7 @@ static int __devexit pca_isa_remove(struct device *dev, unsigned int id)
 static struct isa_driver pca_isa_driver = {
 	.match		= pca_isa_match,
 	.probe		= pca_isa_probe,
-	.remove		= __devexit_p(pca_isa_remove),
+	.remove		= pca_isa_remove,
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER,
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 675878f..a30d2f6 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -131,7 +131,7 @@ static irqreturn_t i2c_pca_pf_handler(int this_irq, void *dev_id)
 }
 
 
-static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
+static int i2c_pca_pf_probe(struct platform_device *pdev)
 {
 	struct i2c_pca_pf_data *i2c;
 	struct resource *res;
@@ -257,7 +257,7 @@ e_print:
 	return ret;
 }
 
-static int __devexit i2c_pca_pf_remove(struct platform_device *pdev)
+static int i2c_pca_pf_remove(struct platform_device *pdev)
 {
 	struct i2c_pca_pf_data *i2c = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
@@ -279,7 +279,7 @@ static int __devexit i2c_pca_pf_remove(struct platform_device *pdev)
 
 static struct platform_driver i2c_pca_pf_driver = {
 	.probe = i2c_pca_pf_probe,
-	.remove = __devexit_p(i2c_pca_pf_remove),
+	.remove = i2c_pca_pf_remove,
 	.driver = {
 		.name = "i2c-pca-platform",
 		.owner = THIS_MODULE,
-- 
1.8.0.1
