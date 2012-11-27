From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 03/16] i2c: pnx: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:40 -0500
Message-ID: <1354049993-12718-4-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 8488bdd..ce40970 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -619,7 +619,7 @@ static SIMPLE_DEV_PM_OPS(i2c_pnx_pm,
 #define PNX_I2C_PM	NULL
 #endif
 
-static int __devinit i2c_pnx_probe(struct platform_device *pdev)
+static int i2c_pnx_probe(struct platform_device *pdev)
 {
 	unsigned long tmp;
 	int ret = 0;
@@ -765,7 +765,7 @@ err_kzalloc:
 	return ret;
 }
 
-static int __devexit i2c_pnx_remove(struct platform_device *pdev)
+static int i2c_pnx_remove(struct platform_device *pdev)
 {
 	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
 
@@ -797,7 +797,7 @@ static struct platform_driver i2c_pnx_driver = {
 		.pm = PNX_I2C_PM,
 	},
 	.probe = i2c_pnx_probe,
-	.remove = __devexit_p(i2c_pnx_remove),
+	.remove = i2c_pnx_remove,
 };
 
 static int __init i2c_adap_pnx_init(void)
-- 
1.8.0.1
