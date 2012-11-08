From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 02/11] i2c: pxa: support pxa910 in id table
Date: Thu,  8 Nov 2012 22:17:55 +0800
Message-ID: <1352384284-15660-2-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Since it needs to adjust i2c standard and fast mode by customizing
LCR&WCR value for pxa910, so add pxa910 in the id table;

Change-Id: Ibe07f36758acf17e31845f264109fdd3d56b6bff
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 73a1404..063ba23 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -47,12 +47,15 @@ struct pxa_reg_layout {
 	u32 icr;
 	u32 isr;
 	u32 isar;
+	u32 ilcr;
+	u32 iwcr;
 };
 
 enum pxa_i2c_types {
 	REGS_PXA2XX,
 	REGS_PXA3XX,
 	REGS_CE4100,
+	REGS_PXA910,
 };
 
 /*
@@ -80,12 +83,22 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
 		.isr =	0x04,
 		/* no isar register */
 	},
+	[REGS_PXA910] = {
+		.ibmr = 0x00,
+		.idbr = 0x08,
+		.icr =	0x10,
+		.isr =	0x18,
+		.isar = 0x20,
+		.ilcr = 0x28,
+		.iwcr = 0x30,
+	},
 };
 
 static const struct platform_device_id i2c_pxa_id_table[] = {
 	{ "pxa2xx-i2c",		REGS_PXA2XX },
 	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
 	{ "ce4100-i2c",		REGS_CE4100 },
+	{ "pxa910-i2c",		REGS_PXA910 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
@@ -148,6 +161,8 @@ struct pxa_i2c {
 	void __iomem		*reg_icr;
 	void __iomem		*reg_isr;
 	void __iomem		*reg_isar;
+	void __iomem		*reg_ilcr;
+	void __iomem		*reg_iwcr;
 
 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -155,6 +170,8 @@ struct pxa_i2c {
 	int			irq;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
+	unsigned int		ilcr;
+	unsigned int		iwcr;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -162,6 +179,8 @@ struct pxa_i2c {
 #define _ICR(i2c)	((i2c)->reg_icr)
 #define _ISR(i2c)	((i2c)->reg_isr)
 #define _ISAR(i2c)	((i2c)->reg_isar)
+#define _ILCR(i2c)	((i2c)->reg_ilcr)
+#define _IWCR(i2c)	((i2c)->reg_iwcr)
 
 /*
  * I2C Slave mode address
@@ -460,6 +479,17 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	/* set control register values */
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
 
+	/* There are 2 multi-masters on the I2C bus - APPS and COMM
+	 * It is important both uses the standard frequency
+	 * Adjust clock by ILCR, IWCR is important
+	 */
+	if (i2c->ilcr)
+		writel(i2c->ilcr, _ILCR(i2c));
+	if (i2c->iwcr)
+		writel(i2c->iwcr, _IWCR(i2c));
+	udelay(2);
+
+
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
 	writel(readl(_ICR(i2c)) | ICR_SADIE | ICR_ALDIE | ICR_SSDIE, _ICR(i2c));
@@ -1146,6 +1176,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
 	if (i2c_type != REGS_CE4100)
 		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
+	i2c->reg_ilcr = i2c->reg_base + pxa_reg_layout[i2c_type].ilcr;
+	i2c->reg_iwcr = i2c->reg_base + pxa_reg_layout[i2c_type].iwcr;
 
 	i2c->iobase = res->start;
 	i2c->iosize = resource_size(res);
@@ -1163,6 +1195,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.hardware_lock = plat->hardware_lock;
 		i2c->adap.hardware_unlock = plat->hardware_unlock;
 		i2c->adap.hardware_trylock = plat->hardware_trylock;
+		i2c->ilcr = plat->ilcr;
+		i2c->iwcr = plat->iwcr;
 	}
 
 	clk_enable(i2c->clk);
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index eec9954..2a03e91 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -67,6 +67,8 @@ struct i2c_pxa_platform_data {
 	unsigned int		class;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
+	unsigned int		ilcr;
+	unsigned int		iwcr;
 	void			(*hardware_lock)(void);
 	void			(*hardware_unlock)(void);
 	int			(*hardware_trylock)(void);
-- 
1.7.5.4
