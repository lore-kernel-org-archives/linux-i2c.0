From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/4] i2c: eg20t: use NULL instead of 0
Date: Fri, 20 Apr 2012 22:45:14 +0200
Message-ID: <1334954717-13146-2-git-send-email-w.sang@pengutronix.de>
References: <1334954717-13146-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334954717-13146-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

sparse rightfully says:
drivers/i2c/busses/i2c-eg20t.c:990:59: warning: Using plain integer as NULL pointer

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 9da12ce..6e9e075 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -872,7 +872,7 @@ static void __devexit pch_i2c_remove(struct pci_dev *pdev)
 		pci_iounmap(pdev, adap_info->pch_data[0].pch_base_address);
 
 	for (i = 0; i < adap_info->ch_num; i++)
-		adap_info->pch_data[i].pch_base_address = 0;
+		adap_info->pch_data[i].pch_base_address = NULL;
 
 	pci_set_drvdata(pdev, NULL);
 
-- 
1.7.10
