From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 07/16] i2c: i2c-parport-light: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:44 -0500
Message-ID: <1354049993-12718-8-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport-light.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index 4b95f7a..aa95778 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -135,7 +135,7 @@ static struct lineop parport_ctrl_irq = {
 	.port		= PORT_CTRL,
 };
 
-static int __devinit i2c_parport_probe(struct platform_device *pdev)
+static int i2c_parport_probe(struct platform_device *pdev)
 {
 	int err;
 
@@ -169,7 +169,7 @@ static int __devinit i2c_parport_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit i2c_parport_remove(struct platform_device *pdev)
+static int i2c_parport_remove(struct platform_device *pdev)
 {
 	if (ara) {
 		line_set(0, &parport_ctrl_irq);
@@ -191,7 +191,7 @@ static struct platform_driver i2c_parport_driver = {
 		.name	= DRVNAME,
 	},
 	.probe		= i2c_parport_probe,
-	.remove		= __devexit_p(i2c_parport_remove),
+	.remove		= i2c_parport_remove,
 };
 
 static int __init i2c_parport_device_add(u16 address)
-- 
1.8.0.1
