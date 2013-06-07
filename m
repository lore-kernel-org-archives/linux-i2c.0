From: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: pxa: enable high speed mode for i2c bus
Date: Fri, 7 Jun 2013 14:38:17 +0800
Message-ID: <1370587097-21006-1-git-send-email-shangll@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

To enter high speed mode, following steps should be done:
1. When running in high speed mode, i2c clock rate is different
from standard mode. Clock rate must be set according to
specification first.
2. When i2c controller sends a master code and wins arbitration,
high speed mode is entered.

If you want to enable high speed mode, the following members of
platform data should be set to proper value:
1. "high_mode" should be set to "1".
2. "master_code" should be set to "8'b 0000_1xxx"(x is 0 or 1).
   If no master_code is set, set to default value 0xe.
3. "rate" should be set according to specification.

Signed-off-by: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   64 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/pxa-i2c.h  |    3 ++
 2 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ea6d45d..164324c 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -110,6 +110,8 @@ MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
 #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
 #define ICR_UR		(1 << 14)	   /* unit reset */
 #define ICR_FM		(1 << 15)	   /* fast mode */
+#define ICR_HS		(1 << 16)	   /* High Speed mode */
+#define ICR_GPIOEN	(1 << 19)	   /* enable GPIO mode for SCL in HS */
 
 #define ISR_RWM		(1 << 0)	   /* read/write mode */
 #define ISR_ACKNAK	(1 << 1)	   /* ack/nak status */
@@ -155,6 +157,10 @@ struct pxa_i2c {
 	int			irq;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
+	unsigned int		high_mode:1;
+	unsigned char		master_code;
+	unsigned long		rate;
+	bool			highmode_enter;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -459,6 +465,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 
 	/* set control register values */
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
+	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
@@ -680,6 +687,34 @@ static int i2c_pxa_pio_set_master(struct pxa_i2c *i2c)
 	return 0;
 }
 
+/*
+ * PXA I2C send master code
+ * 1. Load master code to IDBR and send it.
+ *    Note for HS mode, set ICR [GPIOEN].
+ * 2. Wait until win arbitration.
+ */
+static int i2c_pxa_send_mastercode(struct pxa_i2c *i2c)
+{
+	u32 icr;
+	long timeout;
+
+	spin_lock_irq(&i2c->lock);
+	i2c->highmode_enter = true;
+	writel(i2c->master_code, _IDBR(i2c));
+
+	icr = readl(_ICR(i2c)) & ~(ICR_STOP | ICR_ALDIE);
+	icr |= ICR_GPIOEN | ICR_START | ICR_TB | ICR_ITEIE;
+	writel(icr, _ICR(i2c));
+
+	spin_unlock_irq(&i2c->lock);
+	timeout = wait_event_timeout(i2c->wait,
+			i2c->highmode_enter == false, HZ * 1);
+
+	i2c->highmode_enter = false;
+
+	return (timeout == 0) ? I2C_RETRY : 0;
+}
+
 static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
 			       struct i2c_msg *msg, int num)
 {
@@ -743,6 +778,14 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 		goto out;
 	}
 
+	if (i2c->high_mode) {
+		ret = i2c_pxa_send_mastercode(i2c);
+		if (ret) {
+			dev_err(&i2c->adap.dev, "i2c_pxa_send_mastercode timeout\n");
+			goto out;
+			}
+	}
+
 	spin_lock_irq(&i2c->lock);
 
 	i2c->msg = msg;
@@ -990,11 +1033,14 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
 			i2c_pxa_slave_txempty(i2c, isr);
 		if (isr & ISR_IRF)
 			i2c_pxa_slave_rxfull(i2c, isr);
-	} else if (i2c->msg) {
+	} else if (i2c->msg && (!i2c->highmode_enter)) {
 		if (isr & ISR_ITE)
 			i2c_pxa_irq_txempty(i2c, isr);
 		if (isr & ISR_IRF)
 			i2c_pxa_irq_rxfull(i2c, isr);
+	} else if ((isr & ISR_ITE) && i2c->highmode_enter) {
+		i2c->highmode_enter = false;
+		wake_up(&i2c->wait);
 	} else {
 		i2c_pxa_scream_blue_murder(i2c, "spurious irq");
 	}
@@ -1079,6 +1125,11 @@ static int i2c_pxa_probe_pdata(struct platform_device *pdev,
 	if (plat) {
 		i2c->use_pio = plat->use_pio;
 		i2c->fast_mode = plat->fast_mode;
+		i2c->high_mode = plat->high_mode;
+		i2c->master_code = plat->master_code;
+		if (!i2c->master_code)
+			i2c->master_code = 0xe;
+		i2c->rate = plat->rate;
 	}
 	return 0;
 }
@@ -1151,6 +1202,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->irq = irq;
 
 	i2c->slave_addr = I2C_PXA_SLAVE_ADDR;
+	i2c->highmode_enter = false;
 
 	if (plat) {
 #ifdef CONFIG_I2C_PXA_SLAVE
@@ -1160,6 +1212,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.class = plat->class;
 	}
 
+	if (i2c->high_mode) {
+		if (i2c->rate) {
+			clk_set_rate(i2c->clk, i2c->rate);
+			pr_info("i2c: <%s> set rate to %ld\n",
+				i2c->adap.name, clk_get_rate(i2c->clk));
+		} else
+			pr_warn("i2c: <%s> clock rate not set\n",
+				i2c->adap.name);
+	}
+
 	clk_enable(i2c->clk);
 
 	if (i2c->use_pio) {
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 1a9f65e..53aab24 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -67,6 +67,9 @@ struct i2c_pxa_platform_data {
 	unsigned int		class;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
+	unsigned int		high_mode:1;
+	unsigned char		master_code;
+	unsigned long		rate;
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.7.4.1
