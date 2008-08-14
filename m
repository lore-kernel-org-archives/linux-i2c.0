From: Mike Rapoport <mike@compulab.co.il>
Subject: [RFC] PXA3xx: Add support for power i2c bus
Date: Thu, 14 Aug 2008 11:55:07 +0300
Message-ID: <48A3F2EB.8030809@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: eric miao <eric.y.miao@gmail.com>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds support for power i2c bus on PXA3xx processor.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 arch/arm/mach-pxa/devices.c          |    9 ++++++
 arch/arm/mach-pxa/generic.h          |    7 ++++-
 arch/arm/mach-pxa/include/mach/i2c.h |    2 +-
 arch/arm/mach-pxa/pxa27x.c           |    2 +-
 arch/arm/mach-pxa/pxa3xx.c           |   25 ++++++++++++++++++
 drivers/i2c/busses/i2c-pxa.c         |   46 +++++++++++++++++++++++----------
 6 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 35736fc..9c72098 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -712,6 +712,15 @@ void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
 {
 	pxa_register_device(&pxa27x_device_camera, info);
 }
+
+void __init pxa_set_i2c_power_info(struct i2c_pxa_platform_data *info)
+{
+	if (cpu_is_pxa27x())
+		pxa27x_set_i2c_power_info(info);
+	else if (cpu_is_pxa3xx())
+		pxa3xx_set_i2c_power_info(info);
+
+}
 #endif /* CONFIG_PXA27x || CONFIG_PXA3xx */

 #ifdef CONFIG_PXA3xx
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 041c048..13a786d 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -9,9 +9,10 @@
  * published by the Free Software Foundation.
  */

-typedef int (*set_wake_t)(unsigned int, unsigned int);
+typedef int (*set_wake_t) (unsigned int, unsigned int);

 struct sys_timer;
+struct i2c_pxa_platform_data;

 extern struct sys_timer pxa_timer;
 extern void __init pxa_init_irq(int irq_nr, set_wake_t fn);
@@ -42,9 +43,11 @@ extern unsigned pxa25x_get_memclk_frequency_10khz(void);
 #ifdef CONFIG_PXA27x
 extern unsigned pxa27x_get_clk_frequency_khz(int);
 extern unsigned pxa27x_get_memclk_frequency_10khz(void);
+extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
 #else
 #define pxa27x_get_clk_frequency_khz(x)		(0)
 #define pxa27x_get_memclk_frequency_10khz()	(0)
+static inline void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info) {}
 #endif

 #if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
@@ -57,10 +60,12 @@ static inline void pxa2xx_clear_reset_status(unsigned int mask) {}
 extern unsigned pxa3xx_get_clk_frequency_khz(int);
 extern unsigned pxa3xx_get_memclk_frequency_10khz(void);
 extern void pxa3xx_clear_reset_status(unsigned int);
+extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
 #else
 #define pxa3xx_get_clk_frequency_khz(x)		(0)
 #define pxa3xx_get_memclk_frequency_10khz()	(0)
 static inline void pxa3xx_clear_reset_status(unsigned int mask) {}
+static inline void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info) {}
 #endif

 extern struct sysdev_class pxa_irq_sysclass;
diff --git a/arch/arm/mach-pxa/include/mach/i2c.h b/arch/arm/mach-pxa/include/mach/i2c.h
index 80596b0..c1ea8d8 100644
--- a/arch/arm/mach-pxa/include/mach/i2c.h
+++ b/arch/arm/mach-pxa/include/mach/i2c.h
@@ -70,7 +70,7 @@ struct i2c_pxa_platform_data {

 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);

-#ifdef CONFIG_PXA27x
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 extern void pxa_set_i2c_power_info(struct i2c_pxa_platform_data *info);
 #endif

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index f9f6a9c..c33cf6a 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -349,7 +349,7 @@ struct platform_device pxa27x_device_i2c_power = {
 	.num_resources	= ARRAY_SIZE(i2c_power_resources),
 };

-void __init pxa_set_i2c_power_info(struct i2c_pxa_platform_data *info)
+void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 {
 	local_irq_disable();
 	PCFR |= PCFR_PI2CEN;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 03cbc38..d5ba95a 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -509,6 +509,30 @@ void __init pxa3xx_init_irq(void)
  * device registration specific to PXA3xx.
  */

+static struct resource i2c_power_resources[] = {
+	{
+		.start  = 0x40f500c0,
+		.end    = 0x40f500d3,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PWRI2C,
+		.end	= IRQ_PWRI2C,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa3xx_device_i2c_power = {
+	.name		= "pxa2xx-i2c",
+	.id		= 1,
+	.resource	= i2c_power_resources,
+	.num_resources	= ARRAY_SIZE(i2c_power_resources),
+};
+
+void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
+{
+	pxa3xx_device_i2c_power.dev.platform_data = info;
+}
+
 static struct platform_device *devices[] __initdata = {
 /*	&pxa_device_udc,	The UDC driver is PXA25x only */
 	&pxa_device_ffuart,
@@ -522,6 +546,7 @@ static struct platform_device *devices[] __initdata = {
 	&pxa3xx_device_ssp4,
 	&pxa27x_device_pwm0,
 	&pxa27x_device_pwm1,
+	&pxa3xx_device_i2c_power,
 };

 static struct sys_device pxa3xx_sysdev[] = {
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 44d8384..c2a7c94 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -68,11 +68,21 @@ struct pxa_i2c {
 	int			use_pio;
 };

-#define _IBMR(i2c)	((i2c)->reg_base + 0)
-#define _IDBR(i2c)	((i2c)->reg_base + 8)
-#define _ICR(i2c)	((i2c)->reg_base + 0x10)
-#define _ISR(i2c)	((i2c)->reg_base + 0x18)
-#define _ISAR(i2c)	((i2c)->reg_base + 0x20)
+#define _IBMR(i2c)	\
+	((i2c)->reg_base + \
+	 ((cpu_is_pxa3xx() && ((i2c)->adap.nr == 1)) ? 0x0 : 0x0))
+#define _IDBR(i2c)	\
+	((i2c)->reg_base + \
+	 ((cpu_is_pxa3xx() && ((i2c)->adap.nr == 1)) ? 0x4 : 0x8))
+#define _ICR(i2c)	\
+	((i2c)->reg_base + \
+	 ((cpu_is_pxa3xx() && ((i2c)->adap.nr == 1)) ? 0x8 : 0x10))
+#define _ISR(i2c)	\
+	((i2c)->reg_base + \
+	 ((cpu_is_pxa3xx() && ((i2c)->adap.nr == 1)) ? 0xc : 0x18))
+#define _ISAR(i2c)	\
+	((i2c)->reg_base + \
+	 ((cpu_is_pxa3xx() && ((i2c)->adap.nr == 1)) ? 0x10 : 0x20))

 /*
  * I2C Slave mode address
@@ -982,10 +992,13 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
 		 i2c->adap.nr);

-	i2c->clk = clk_get(&dev->dev, "I2CCLK");
-	if (IS_ERR(i2c->clk)) {
-		ret = PTR_ERR(i2c->clk);
-		goto eclk;
+	/* PXA3xx has power I2C clock always on */
+	if (!(cpu_is_pxa3xx() && i2c->adap.nr == 1)) {
+		i2c->clk = clk_get(&dev->dev, "I2CCLK");
+		if (IS_ERR(i2c->clk)) {
+			ret = PTR_ERR(i2c->clk);
+			goto eclk;
+		}
 	}

 	i2c->reg_base = ioremap(res->start, res_len(res));
@@ -1008,7 +1021,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	}
 #endif

-	clk_enable(i2c->clk);
+	if (i2c->clk)
+		clk_enable(i2c->clk);

 	if (plat) {
 		i2c->adap.class = plat->class;
@@ -1051,10 +1065,12 @@ eadapt:
 	if (!i2c->use_pio)
 		free_irq(irq, i2c);
 ereqirq:
-	clk_disable(i2c->clk);
+	if (i2c->clk)
+		clk_disable(i2c->clk);
 	iounmap(i2c->reg_base);
 eremap:
-	clk_put(i2c->clk);
+	if (i2c->clk)
+		clk_put(i2c->clk);
 eclk:
 	kfree(i2c);
 emalloc:
@@ -1072,8 +1088,10 @@ static int __exit i2c_pxa_remove(struct platform_device *dev)
 	if (!i2c->use_pio)
 		free_irq(i2c->irq, i2c);

-	clk_disable(i2c->clk);
-	clk_put(i2c->clk);
+	if (i2c->clk) {
+		clk_disable(i2c->clk);
+		clk_put(i2c->clk);
+	}

 	iounmap(i2c->reg_base);
 	release_mem_region(i2c->iobase, i2c->iosize);



-- 
Sincerely yours,
Mike.



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
