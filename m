From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: i2c-imx: Fix format warning for dev_dbg
Date: Wed, 6 Aug 2014 10:54:45 +0800
Message-ID: <1407293685-7003-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

drivers/i2c/busses/i2c-imx.c: In function i2c_imx_probe()
drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
of type unsigned int, but argument 4 has type resource_size_t [-Wformat=]
  dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
  ^
drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
of type unsigned int, but argument 5 has type resource_size_t [-Wformat=]

drivers/i2c/busses/i2c-imx.c:691:2: warning: format %d expects argument
of type int, but argument 4 has type resource_size_t [-Wformat=]
  dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
  ^
drivers/i2c/busses/i2c-imx.c:691:2: warning: format 0x%x expects argument
of type unsigned int, but argument 5 has type resource_size_t [-Wformat=]

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1d7efa3..ba4ba32 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -687,9 +687,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
-		res->start, res->end);
+		(unsigned int)res->start, (unsigned int)res->end);
 	dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
-		resource_size(res), res->start);
+		(unsigned int)resource_size(res), (unsigned int)res->start);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
-- 
1.8.5
