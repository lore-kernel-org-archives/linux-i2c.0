From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] i2c-ibm_iic: Delete an error message for a failed memory
 allocation in iic_probe()
Date: Fri, 2 Feb 2018 17:45:06 +0100
Message-ID: <3c085530-c0d4-e2b2-8dcd-393ef7571243@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 17:24:57 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 961c5f42d956..1bd4d6dde0fe 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -702,10 +702,8 @@ static int iic_probe(struct platform_device *ofdev)
 	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&ofdev->dev, "failed to allocate device data\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(ofdev, dev);
 
-- 
2.16.1

