From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] i2c-sh7760: Delete an error message for a failed memory
 allocation in sh7760_i2c_probe()
Date: Fri, 2 Feb 2018 15:21:32 +0100
Message-ID: <737fe7c8-9ae3-7e19-100a-f2f3d9f2b83a@users.sourceforge.net>
References: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 11:46:02 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-sh7760.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index c2005c789d2b..4d2e4d10600b 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -445,7 +445,6 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 
 	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
 	if (!id) {
-		dev_err(&pdev->dev, "no mem for private data\n");
 		ret = -ENOMEM;
 		goto out0;
 	}
-- 
2.16.1

