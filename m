From: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/2] i2c-nomadik: release region when removed
Date: Tue, 27 Apr 2010 10:31:07 +0530
Message-ID: <1272344468-9411-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

So that the module can be loaded again after an unload.

Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a4f8d33..170dbd7 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -914,6 +914,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 
 static int __devexit nmk_i2c_remove(struct platform_device *pdev)
 {
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct nmk_i2c_dev *dev = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&dev->adap);
@@ -924,6 +925,8 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
 	free_irq(dev->irq, dev);
 	iounmap(dev->virtbase);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.0
