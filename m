From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v2] i2c-iop3xx: add iomem annotation
Date: Mon, 29 Nov 2010 12:33:39 +0200
Message-ID: <1291026819-5003-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: aaro.koskinen-X3B1VOXEql0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Eliminate unnecessary casts and the following sparse warnings:

	drivers/i2c/busses/i2c-iop3xx.c:65:9: warning: incorrect type in argument 1 (different base types)
	drivers/i2c/busses/i2c-iop3xx.c:65:9:    expected void const volatile [noderef] <asn:2>*<noident>
	drivers/i2c/busses/i2c-iop3xx.c:65:9:    got unsigned int

	[ the previous warning is repeated 18 times ]

	drivers/i2c/busses/i2c-iop3xx.c:456:33: warning: cast removes address space of expression

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---

v2: Use void  __iomem * in struct i2c_algo_iop3xx_data.

 drivers/i2c/busses/i2c-iop3xx.c |    6 +++---
 drivers/i2c/busses/i2c-iop3xx.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 112c61f..f09c931 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -409,7 +409,7 @@ iop3xx_i2c_remove(struct platform_device *pdev)
 		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
 	__raw_writel(cr, adapter_data->ioaddr + CR_OFFSET);
 
-	iounmap((void __iomem*)adapter_data->ioaddr);
+	iounmap(adapter_data->ioaddr);
 	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
 	kfree(adapter_data);
 	kfree(padapter);
@@ -453,7 +453,7 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 	/* set the adapter enumeration # */
 	adapter_data->id = i2c_id++;
 
-	adapter_data->ioaddr = (u32)ioremap(res->start, IOP3XX_I2C_IO_SIZE);
+	adapter_data->ioaddr = ioremap(res->start, IOP3XX_I2C_IO_SIZE);
 	if (!adapter_data->ioaddr) {
 		ret = -ENOMEM;
 		goto release_region;
@@ -498,7 +498,7 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 unmap:
-	iounmap((void __iomem*)adapter_data->ioaddr);
+	iounmap(adapter_data->ioaddr);
 
 release_region:
 	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
diff --git a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-iop3xx.h
index 8485861..097e270 100644
--- a/drivers/i2c/busses/i2c-iop3xx.h
+++ b/drivers/i2c/busses/i2c-iop3xx.h
@@ -97,7 +97,7 @@
 #define	IOP3XX_I2C_IO_SIZE	0x18
 
 struct i2c_algo_iop3xx_data {
-	u32 ioaddr;
+	void __iomem *ioaddr;
 	wait_queue_head_t waitq;
 	spinlock_t lock;
 	u32 SR_enabled, SR_received;
-- 
1.5.6.5
