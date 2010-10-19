From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: i2c-pca-platform: Change device name of request_irq
Date: Tue, 19 Oct 2010 11:45:31 +0900
Message-ID: <1287456331-20207-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c->adap.name shouldn't be used in request_irq.
Instead the driver name "i2c-pca-platform" should be used.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
CC: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-pca-platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index ef5c784..38a6654 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -221,7 +221,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 
 	if (irq) {
 		ret = request_irq(irq, i2c_pca_pf_handler,
-			IRQF_TRIGGER_FALLING, i2c->adap.name, i2c);
+			IRQF_TRIGGER_FALLING, pdev->name, i2c);
 		if (ret)
 			goto e_reqirq;
 	}
-- 
1.7.1
