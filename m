From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [i2c]  [PATCH 2/2] [resend] Add polling transfer for i2c-pxa
Date: Thu, 10 Jan 2008 14:16:06 +0200
Message-ID: <47860C86.5050801@compulab.co.il>
References: <476A7761.3050103@compulab.co.il>
	<20080110112413.3b379781@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-reply-to: <20080110112413.3b379781@hyperion.delvare>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jean Delvare <khali@linux-fr.org>
Cc: eric miao <eric.miao@marvell.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Mike,
> 
> On Thu, 20 Dec 2007 16:08:33 +0200, Mike Rapoport wrote:
>> The below patch adds polling I2C transfer implementation for PXA I2C.
> 
> This patch doesn't apply on top of my current stack, most probably due
> to a conflict with this patch by Eric Miao:
> 
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-pxa-use-cpu_is_pxa27x.patch
> 
> Can you please update your patch so that it applies cleanly on top of
> 2.6.24-rc7 + the patch above?

Hope this one will go...

> Thanks,

-- 
Sincerely yours,
Mike.


Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 arch/arm/mach-pxa/pxa27x.c     |    6 ++
 drivers/i2c/busses/i2c-pxa.c   |  133 ++++++++++++++++++++++++++++++++++++----
 include/asm-arm/arch-pxa/i2c.h |    6 ++
 3 files changed, 133 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 8e126e6..57efebd 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -24,6 +24,7 @@
 #include <asm/arch/ohci.h>
 #include <asm/arch/pm.h>
 #include <asm/arch/dma.h>
+#include <asm/arch/i2c.h>

 #include "generic.h"
 #include "devices.h"
@@ -423,6 +424,11 @@ struct platform_device pxa27x_device_i2c_power = {
 	.num_resources	= ARRAY_SIZE(i2c_power_resources),
 };

+void __init pxa_set_i2c_power_info(struct i2c_pxa_platform_data *info)
+{
+	pxa27x_device_i2c_power.dev.platform_data = info;
+}
+
 static struct platform_device *devices[] __initdata = {
 	&pxa_device_mci,
 	&pxa_device_udc,
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index da3ecf5..2598d29 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -65,6 +65,7 @@ struct pxa_i2c {
 	unsigned long		iosize;

 	int			irq;
+	int			use_pio;
 };

 #define _IBMR(i2c)	((i2c)->reg_base + 0)
@@ -163,6 +164,7 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 #define eedbg(lvl, x...) do { if ((lvl) < 1) { printk(KERN_DEBUG "" x); } } while(0)

 static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
+static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);

 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
@@ -554,6 +556,71 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
 	writel(icr, _ICR(i2c));
 }

+static int i2c_pxa_pio_set_master(struct pxa_i2c *i2c)
+{
+	/* make timeout the same as for interrupt based functions */
+	long timeout = 2 * DEF_TIMEOUT;
+
+	/*
+	 * Wait for the bus to become free.
+	 */
+	while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
+		udelay(1000);
+		show_state(i2c);
+	}
+
+	if (timeout <= 0) {
+		show_state(i2c);
+		dev_err(&i2c->adap.dev,
+			"i2c_pxa: timeout waiting for bus free\n");
+		return I2C_RETRY;
+	}
+
+	/*
+	 * Set master mode.
+	 */
+	writel(readl(_ICR(i2c)) | ICR_SCLE, _ICR(i2c));
+
+	return 0;
+}
+
+static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
+			       struct i2c_msg *msg, int num)
+{
+	unsigned long timeout = 500000; /* 5 seconds */
+	int ret = 0;
+
+	ret = i2c_pxa_pio_set_master(i2c);
+	if (ret)
+		goto out;
+
+	i2c->msg = msg;
+	i2c->msg_num = num;
+	i2c->msg_idx = 0;
+	i2c->msg_ptr = 0;
+	i2c->irqlogidx = 0;
+
+	i2c_pxa_start_message(i2c);
+
+	while (timeout-- && i2c->msg_num > 0) {
+		i2c_pxa_handler(0, i2c);
+		udelay(10);
+	}
+
+	i2c_pxa_stop_message(i2c);
+
+	/*
+	 * We place the return code in i2c->msg_idx.
+	 */
+	ret = i2c->msg_idx;
+
+out:
+	if (timeout == 0)
+		i2c_pxa_scream_blue_murder(i2c, "timeout");
+
+	return ret;
+}
+
 /*
  * We are protected by the adapter bus mutex.
  */
@@ -610,6 +677,35 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	return ret;
 }

+static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
+			    struct i2c_msg msgs[], int num)
+{
+	struct pxa_i2c *i2c = adap->algo_data;
+	int ret, i;
+
+	/* If the I2C controller is disabled we need to reset it
+	  (probably due to a suspend/resume destroying state). We do
+	  this here as we can then avoid worrying about resuming the
+	  controller before its users. */
+	if (!(readl(_ICR(i2c)) & ICR_IUE))
+		i2c_pxa_reset(i2c);
+
+	for (i = adap->retries; i >= 0; i--) {
+		ret = i2c_pxa_do_pio_xfer(i2c, msgs, num);
+		if (ret != I2C_RETRY)
+			goto out;
+
+		if (i2c_debug)
+			dev_dbg(&adap->dev, "Retrying transmission\n");
+		udelay(100);
+	}
+	i2c_pxa_scream_blue_murder(i2c, "exhausted retries");
+	ret = -EREMOTEIO;
+ out:
+	i2c_pxa_set_slave(i2c, ret);
+	return ret;
+}
+
 /*
  * i2c_pxa_master_complete - complete the message and wake up.
  */
@@ -621,7 +717,8 @@ static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret)
 	i2c->msg_num = 0;
 	if (ret)
 		i2c->msg_idx = ret;
-	wake_up(&i2c->wait);
+	if (!i2c->use_pio)
+		wake_up(&i2c->wait);
 }

 static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
@@ -840,6 +937,11 @@ static const struct i2c_algorithm i2c_pxa_algorithm = {
 	.functionality	= i2c_pxa_functionality,
 };

+static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
+	.master_xfer	= i2c_pxa_pio_xfer,
+	.functionality	= i2c_pxa_functionality,
+};
+
 static void i2c_pxa_enable(struct platform_device *dev)
 {
 	if (cpu_is_pxa27x()) {
@@ -890,7 +992,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	}

 	i2c->adap.owner   = THIS_MODULE;
-	i2c->adap.algo    = &i2c_pxa_algorithm;
 	i2c->adap.retries = 5;

 	spin_lock_init(&i2c->lock);
@@ -927,20 +1028,26 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	clk_enable(i2c->clk);
 	i2c_pxa_enable(dev);

-	ret = request_irq(irq, i2c_pxa_handler, IRQF_DISABLED,
-			  i2c->adap.name, i2c);
-	if (ret)
-		goto ereqirq;
+	if (plat) {
+		i2c->adap.class = plat->class;
+		i2c->use_pio = plat->use_pio;
+	}
+
+	if (i2c->use_pio) {
+		i2c->adap.algo = &i2c_pxa_pio_algorithm;
+	} else {
+		i2c->adap.algo = &i2c_pxa_algorithm;
+		ret = request_irq(irq, i2c_pxa_handler, IRQF_DISABLED,
+				  i2c->adap.name, i2c);
+		if (ret)
+			goto ereqirq;
+	}

 	i2c_pxa_reset(i2c);

 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;

-	if (plat) {
-		i2c->adap.class = plat->class;
-	}
-
 	/*
 	 * If "dev->id" is negative we consider it as zero.
 	 * The reason to do so is to avoid sysfs names that only make
@@ -966,7 +1073,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	return 0;

 eadapt:
-	free_irq(irq, i2c);
+	if (!i2c->use_pio)
+		free_irq(irq, i2c);
 ereqirq:
 	clk_disable(i2c->clk);
 	i2c_pxa_disable(dev);
@@ -986,7 +1094,8 @@ static int i2c_pxa_remove(struct platform_device *dev)
 	platform_set_drvdata(dev, NULL);

 	i2c_del_adapter(&i2c->adap);
-	free_irq(i2c->irq, i2c);
+	if (!i2c->use_pio)
+		free_irq(i2c->irq, i2c);

 	clk_disable(i2c->clk);
 	clk_put(i2c->clk);
diff --git a/include/asm-arm/arch-pxa/i2c.h b/include/asm-arm/arch-pxa/i2c.h
index e404b23..80596b0 100644
--- a/include/asm-arm/arch-pxa/i2c.h
+++ b/include/asm-arm/arch-pxa/i2c.h
@@ -65,7 +65,13 @@ struct i2c_pxa_platform_data {
 	unsigned int		slave_addr;
 	struct i2c_slave_client	*slave;
 	unsigned int		class;
+	int			use_pio;
 };

 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
+
+#ifdef CONFIG_PXA27x
+extern void pxa_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+#endif
+
 #endif

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
