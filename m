From: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] i2c: pxa: no need release_mem_region before request_mem_region
 successful
Date: Mon, 6 May 2013 21:11:21 +0800
Message-ID: <5187ABF9.4000903@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Li Zefan <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


move release_mem_region above kfree(i2c) && below clk_put(i2c->clk)

Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ea6d45d..3188cd0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1129,7 +1129,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(i2c->clk)) {
 		ret = PTR_ERR(i2c->clk);
-		goto eclk;
+		goto emm;
 	}

 	i2c->reg_base = ioremap(res->start, resource_size(res));
@@ -1206,10 +1206,11 @@ ereqirq:
 	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
+emm:
+	release_mem_region(res->start, resource_size(res));
 eclk:
 	kfree(i2c);
 emalloc:
-	release_mem_region(res->start, resource_size(res));
 	return ret;
 }

-- 
1.7.1
