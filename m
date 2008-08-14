From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [i2c] [RFC] PXA3xx: Add support for power i2c bus
Date: Thu, 14 Aug 2008 16:43:13 +0300
Message-ID: <48A43671.6000302@compulab.co.il>
References: <48A3F2EB.8030809@compulab.co.il>
	<20080814103956.GB4610@flint.arm.linux.org.uk>
	<48A41921.7020306@compulab.co.il>
	<20080814130709.GH2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080814130709.GH2716@fluff.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org


Ben Dooks wrote:
> On Thu, Aug 14, 2008 at 02:38:09PM +0300, Mike Rapoport wrote:
> 
> Not very nice, how about making the i2c structure have pointers
> to each of the registers which can be setup at probe time. Or even
> just have a multiplier in the structure, as these all look to be reg/2
> in the case of pxa3xx and adap.nr == 1... 
> 
> Note, adap.nr shouldn't really be used to differentiate, use the
> platform device number
> 
> +#define _IDBR(i2c)	((i2c)->reg_base + (0x4 << (i2c)->reg_shift))
> +#define _ICR(i2c)	((i2c)->reg_base + (0x8 << (i2c)->reg_shift))
> etc.
> 
> then do in the probe:
> 
> 	i2c->reg_shift = (cpu_is_pxa3xx() && <is_power_i2c>) ? 0 : 1;
> 

This is really much nicer. The fixed patch follows:

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 arch/arm/mach-pxa/devices.h          |    1 +
 arch/arm/mach-pxa/include/mach/i2c.h |    6 ++++-
 arch/arm/mach-pxa/pxa27x.c           |    2 +-
 arch/arm/mach-pxa/pxa3xx.c           |   45 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-pxa.c         |   12 +++++----
 5 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 887c738..bb04af4 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -32,5 +32,6 @@ extern struct platform_device pxa27x_device_pwm0;
 extern struct platform_device pxa27x_device_pwm1;

 extern struct platform_device pxa3xx_device_nand;
+extern struct platform_device pxa3xx_device_i2c_power;

 void __init pxa_register_device(struct platform_device *dev, void *data);
diff --git a/arch/arm/mach-pxa/include/mach/i2c.h b/arch/arm/mach-pxa/include/mach/i2c.h
index 80596b0..897e717 100644
--- a/arch/arm/mach-pxa/include/mach/i2c.h
+++ b/arch/arm/mach-pxa/include/mach/i2c.h
@@ -71,7 +71,11 @@ struct i2c_pxa_platform_data {
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);

 #ifdef CONFIG_PXA27x
-extern void pxa_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+#endif
+
+#ifdef CONFIG_PXA3xx
+extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
 #endif

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
index 03cbc38..b3cd5d0 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -203,6 +203,19 @@ static const struct clkops clk_pout_ops = {
 	.disable	= clk_pout_disable,
 };

+static void clk_dummy_enable(struct clk *clk)
+{
+}
+
+static void clk_dummy_disable(struct clk *clk)
+{
+}
+
+static const struct clkops clk_dummy_ops = {
+	.enable		= clk_dummy_enable,
+	.disable	= clk_dummy_disable,
+};
+
 static struct clk pxa3xx_clks[] = {
 	{
 		.name           = "CLK_POUT",
@@ -211,6 +224,13 @@ static struct clk pxa3xx_clks[] = {
 		.delay          = 70,
 	},

+	/* Power I2C clock is always on */
+	{
+		.name		= "I2CCLK",
+		.ops		= &clk_dummy_ops,
+		.dev		= &pxa3xx_device_i2c_power.dev,
+	},
+
 	PXA3xx_CK("LCDCLK",  LCD,    &clk_pxa3xx_hsio_ops, &pxa_device_fb.dev),
 	PXA3xx_CK("CAMCLK",  CAMERA, &clk_pxa3xx_hsio_ops, NULL),
 	PXA3xx_CK("AC97CLK", AC97,   &clk_pxa3xx_ac97_ops, NULL),
@@ -509,6 +529,30 @@ void __init pxa3xx_init_irq(void)
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
@@ -522,6 +566,7 @@ static struct platform_device *devices[] __initdata = {
 	&pxa3xx_device_ssp4,
 	&pxa27x_device_pwm0,
 	&pxa27x_device_pwm1,
+	&pxa3xx_device_i2c_power,
 };

 static struct sys_device pxa3xx_sysdev[] = {
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 44d8384..5d5fbc5 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -60,6 +60,7 @@ struct pxa_i2c {
 	u32			icrlog[32];

 	void __iomem		*reg_base;
+	unsigned int		reg_shift;

 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -68,11 +69,11 @@ struct pxa_i2c {
 	int			use_pio;
 };

-#define _IBMR(i2c)	((i2c)->reg_base + 0)
-#define _IDBR(i2c)	((i2c)->reg_base + 8)
-#define _ICR(i2c)	((i2c)->reg_base + 0x10)
-#define _ISR(i2c)	((i2c)->reg_base + 0x18)
-#define _ISAR(i2c)	((i2c)->reg_base + 0x20)
+#define _IBMR(i2c)	((i2c)->reg_base + (0x0 << (i2c)->reg_shift))
+#define _IDBR(i2c)	((i2c)->reg_base + (0x4 << (i2c)->reg_shift))
+#define _ICR(i2c)	((i2c)->reg_base + (0x8 << (i2c)->reg_shift))
+#define _ISR(i2c)	((i2c)->reg_base + (0xc << (i2c)->reg_shift))
+#define _ISAR(i2c)	((i2c)->reg_base + (0x10 << (i2c)->reg_shift))

 /*
  * I2C Slave mode address
@@ -993,6 +994,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		ret = -EIO;
 		goto eremap;
 	}
+	i2c->reg_shift = (cpu_is_pxa3xx() && (dev->id == 1)) ? 0 : 1;

 	i2c->iobase = res->start;
 	i2c->iosize = res_len(res);


-- 
Sincerely yours,
Mike.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
