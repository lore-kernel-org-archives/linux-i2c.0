From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 13/16] i2c: sirf: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:50 -0500
Message-ID: <1354049993-12718-14-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 5574a47..3f1818b 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -258,7 +258,7 @@ static const struct i2c_algorithm i2c_sirfsoc_algo = {
 	.functionality = i2c_sirfsoc_func,
 };
 
-static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
+static int i2c_sirfsoc_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_i2c *siic;
 	struct i2c_adapter *adap;
@@ -385,7 +385,7 @@ err_get_clk:
 	return err;
 }
 
-static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
+static int i2c_sirfsoc_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
 	struct sirfsoc_i2c *siic = adapter->algo_data;
@@ -433,7 +433,7 @@ static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
 };
 #endif
 
-static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
+static const struct of_device_id sirfsoc_i2c_of_match[] = {
 	{ .compatible = "sirf,prima2-i2c", },
 	{},
 };
@@ -449,7 +449,7 @@ static struct platform_driver i2c_sirfsoc_driver = {
 		.of_match_table = sirfsoc_i2c_of_match,
 	},
 	.probe = i2c_sirfsoc_probe,
-	.remove = __devexit_p(i2c_sirfsoc_remove),
+	.remove = i2c_sirfsoc_remove,
 };
 module_platform_driver(i2c_sirfsoc_driver);
 
-- 
1.8.0.1
