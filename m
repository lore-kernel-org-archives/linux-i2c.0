From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 1/3] of/irq: Export of_irq_get()
Date: Thu, 30 Oct 2014 15:59:36 +0200
Message-ID: <1414677578-27412-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The function will be used by the I2C core which can be compiled as a
module.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1471e0a223a5..0d7765807f49 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -405,6 +405,7 @@ int of_irq_get(struct device_node *dev, int index)
 
 	return irq_create_of_mapping(&oirq);
 }
+EXPORT_SYMBOL_GPL(of_irq_get);
 
 /**
  * of_irq_get_byname - Decode a node's IRQ and return it as a Linux irq number
-- 
2.0.4
