From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 4/4] i2c: eg20t: don't use strcpy but strlcpy
Date: Fri, 20 Apr 2012 22:45:17 +0200
Message-ID: <1334954717-13146-5-git-send-email-w.sang@pengutronix.de>
References: <1334954717-13146-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334954717-13146-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 5441e69..2f74ae8 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -813,7 +813,7 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 
 		pch_adap->owner = THIS_MODULE;
 		pch_adap->class = I2C_CLASS_HWMON;
-		strcpy(pch_adap->name, KBUILD_MODNAME);
+		strlcpy(pch_adap->name, KBUILD_MODNAME, sizeof(pch_adap->name));
 		pch_adap->algo = &pch_algorithm;
 		pch_adap->algo_data = &adap_info->pch_data[i];
 
-- 
1.7.10
