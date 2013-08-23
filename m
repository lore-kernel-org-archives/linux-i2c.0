From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-pnx: fix error return code in i2c_pnx_probe()
Date: Fri, 23 Aug 2013 10:55:51 +0800
Message-ID: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Fix to return a negative error code in the irq get error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 5f39c6d..d2f02b3 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -727,6 +727,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	alg_data->irq = platform_get_irq(pdev, 0);
 	if (alg_data->irq < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ from platform resource\n");
+		ret = alg_data->irq;
 		goto out_irq;
 	}
 	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
