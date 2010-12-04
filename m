From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [sodaville] [PATCH 1/6] i2c/pxa2xx: Don't touch ISAR on X86
Date: Sat, 4 Dec 2010 19:22:09 +0100
Message-ID: <20101204182209.GA23352@www.tglx.de>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de> <1291320589-31570-2-git-send-email-bigeasy@linutronix.de> <20101203014424.GG24979@trinity.fluff.org> <4CF93420.9010006@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CF93420.9010006-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Sebastian Andrzej Siewior | 2010-12-03 19:17:04 [+0100]:

>Ben Dooks wrote:
>>> +#ifndef CONFIG_X86
>>>  	writel(i2c->slave_addr, _ISAR(i2c));
>>> +#endif
>
>
>> I'd prefer some way of changing based on either the device name (see
>> some other drivers which bind on multiple names) to define things such
>> as this, as well as possibly changing the register layout.
>
>Do you want me to also change the register access? This would be a
>intrusive patch since I would have to touch every readl()/writel() line
>in this file.
I've been looking at the wrong code while writting this. Here are two
variants. -variant2 containts the size using this patch. variant1 uses

 #define _IBMR(i2c)     ((i2c)->reg_base + pxa_reg_layout[(i2c)->layout].ibmr)

for the access.

    text    data     bss     dec     hex filename
    3753      84       0    3837     efd i2c-pxa-org.o
    4017      84       0    4101    1005 i2c-pxa-variant1.o
    3525      84       0    3609     e19 i2c-pxa-variant2.o

Are you fine with this?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   64 +++++++++++++++++++++++++++++++----------
 1 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4c19a9..29ff876 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -38,17 +38,40 @@
 #include <asm/irq.h>
 #include <plat/i2c.h>
 
-/*
- * I2C register offsets will be shifted 0 or 1 bit left, depending on
- * different SoCs
- */
-#define REG_SHIFT_0	(0 << 0)
-#define REG_SHIFT_1	(1 << 0)
-#define REG_SHIFT(d)	((d) & 0x1)
+
+struct pxa_reg_layout {
+	u32 ibmr;
+	u32 idbr;
+	u32 icr;
+	u32 isr;
+	u32 isar;
+};
+
+enum pxa_i2c_types {
+	REGS_PXA2XX,
+	REGS_PXA3XX,
+};
+
+static struct pxa_reg_layout pxa_reg_layout[] = {
+	[REGS_PXA2XX] = {
+		.ibmr =	0x00,
+		.idbr =	0x10,
+		.icr =	0x20,
+		.isr =	0x30,
+		.isar =	0x40,
+
+	}, [REGS_PXA3XX] = {
+		.ibmr =	0x00,
+		.idbr =	0x08,
+		.icr =	0x10,
+		.isr =	0x18,
+		.isar =	0x20,
+	},
+};
 
 static const struct platform_device_id i2c_pxa_id_table[] = {
-	{ "pxa2xx-i2c",		REG_SHIFT_1 },
-	{ "pxa3xx-pwri2c",	REG_SHIFT_0 },
+	{ "pxa2xx-i2c",		REGS_PXA2XX },
+	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
@@ -111,7 +134,11 @@ struct pxa_i2c {
 	u32			icrlog[32];
 
 	void __iomem		*reg_base;
-	unsigned int		reg_shift;
+	void __iomem		*reg_ibmr;
+	void __iomem		*reg_idbr;
+	void __iomem		*reg_icr;
+	void __iomem		*reg_isr;
+	void __iomem		*reg_isar;
 
 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -121,11 +148,11 @@ struct pxa_i2c {
 	unsigned int		fast_mode :1;
 };
 
-#define _IBMR(i2c)	((i2c)->reg_base + (0x0 << (i2c)->reg_shift))
-#define _IDBR(i2c)	((i2c)->reg_base + (0x4 << (i2c)->reg_shift))
-#define _ICR(i2c)	((i2c)->reg_base + (0x8 << (i2c)->reg_shift))
-#define _ISR(i2c)	((i2c)->reg_base + (0xc << (i2c)->reg_shift))
-#define _ISAR(i2c)	((i2c)->reg_base + (0x10 << (i2c)->reg_shift))
+#define _IBMR(i2c)	((i2c)->reg_ibmr)
+#define _IDBR(i2c)	((i2c)->reg_idbr)
+#define _ICR(i2c)	((i2c)->reg_icr)
+#define _ISR(i2c)	((i2c)->reg_isr)
+#define _ISAR(i2c)	((i2c)->reg_isar)
 
 /*
  * I2C Slave mode address
@@ -1044,7 +1071,12 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		ret = -EIO;
 		goto eremap;
 	}
-	i2c->reg_shift = REG_SHIFT(id->driver_data);
+
+	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[id->driver_data].ibmr;
+	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[id->driver_data].idbr;
+	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[id->driver_data].icr;
+	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[id->driver_data].isr;
+	i2c->reg_isar = i2c->reg_base + pxa_reg_layout[id->driver_data].isar;
 
 	i2c->iobase = res->start;
 	i2c->iosize = resource_size(res);
-- 
1.7.3.2
