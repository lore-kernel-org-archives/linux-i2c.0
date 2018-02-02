From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] i2c-bfin-twi: Delete an error message for a failed memory
 allocation in i2c_bfin_twi_probe()
Date: Fri, 2 Feb 2018 19:12:27 +0100
Message-ID: <cfd1ee7e-6f4d-7d05-b857-a509887a6bc4@users.sourceforge.net>
References: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:55:04 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-bfin-twi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index ff3343186a82..ed596fd56b8b 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -621,10 +621,8 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 
 	iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
 			GFP_KERNEL);
-	if (!iface) {
-		dev_err(&pdev->dev, "Cannot allocate memory\n");
+	if (!iface)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&(iface->lock));
 
-- 
2.16.1

