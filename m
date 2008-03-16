From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Sun, 16 Mar 2008 12:56:18 +0200
Message-ID: <20080316105617.GA4503@kedavra.cpe.vivax.com.br>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
	<1205585237-21492-3-git-send-email-me@felipebalbi.com>
	<1205585237-21492-4-git-send-email-me@felipebalbi.com>
	<20080315124918.GA21547@kedavra.cpe.vivax.com.br>
	<20080315125458.GB21547@kedavra.cpe.vivax.com.br>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080315131309.GA24990-4vvIQG7NF+ITKvXZea5imILpUPVTGn5w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch uses set_irq_type as suggested by Dave.

============= CUT HERE =========

>From 293a73277794a1ca0f2307e7fe9d5ecd76d3ad06 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Date: Tue, 1 Jan 2008 23:00:18 -0500
Subject: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates, part 2

Based on David Brownell's patch for tps65010, this patch
finish conversting isp1301_omap.c to new-style i2c driver.

Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
---
 arch/arm/mach-omap1/board-h2.c   |    4 +
 arch/arm/mach-omap1/board-h3.c   |    8 ++
 arch/arm/mach-omap2/board-h4.c   |   14 ++++
 drivers/i2c/chips/isp1301_omap.c |  134 ++++++++++---------------------------
 4 files changed, 62 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 5079877..fd9567c 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -366,6 +368,8 @@ static void __init h2_init_irq(void)
 	omap_init_irq();
 	omap_gpio_init();
 	h2_init_smc91x();
+	set_irq_type(OMAP_GPIO_IRQ(2),
+			IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING);
 }
 
 static struct omap_usb_config h2_usb_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index c3ef1ee..c1180b6 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -19,6 +19,8 @@
 #include <linux/major.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <linux/workqueue.h>
 #include <linux/i2c.h>
@@ -477,6 +479,11 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
                .type           = "tps65013",
                /* .irq         = OMAP_GPIO_IRQ(??), */
        },
+       {
+               I2C_BOARD_INFO("isp1301_omap", 0x2d),
+               .type		= "isp1301_omap",
+               .irq		= OMAP_GPIO_IRQ(14),
+       },
 };
 
 static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
@@ -546,6 +553,7 @@ static void __init h3_init_irq(void)
 	omap_init_irq();
 	omap_gpio_init();
 	h3_init_smc91x();
+	set_irq_type(OMAP_GPIO_IRQ(14), IRQF_SAMPLE_RANDOM);
 }
 
 static void __init h3_map_io(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f125f43..cc815e6 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
@@ -275,6 +277,7 @@ static void __init omap_h4_init_irq(void)
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
+	set_irq_type(OMAP_GPIO_IRQ(125), IRQF_SAMPLE_RANDOM);
 }
 
 static struct omap_uart_config h4_uart_config __initdata = {
@@ -301,6 +304,14 @@ static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
+static struct i2c_board_info __initdata h4_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2d),
+		.type		= "isp1301_omap",
+		.irq		= OMAP_GPIO_IRQ(125),
+	},
+};
+
 static void __init omap_h4_init(void)
 {
 	/*
@@ -321,6 +332,9 @@ static void __init omap_h4_init(void)
 	}
 #endif
 
+	i2c_register_board_info(1, h4_i2c_board_info,
+			ARRAY_SIZE(h4_i2c_board_info));
+
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index d094b99..9f2ccaf 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -31,8 +31,6 @@
 #include <linux/usb/otg.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
-
-#include <asm/irq.h>
 #include <asm/arch/usb.h>
 
 
@@ -50,12 +48,8 @@ MODULE_LICENSE("GPL");
 struct isp1301 {
 	struct otg_transceiver	otg;
 	struct i2c_client	*client;
-	struct i2c_client	c;
 	void			(*i2c_release)(struct device *dev);
 
-	int			irq;
-	int			irq_type;
-
 	u32			last_otg_ctrl;
 	unsigned		working:1;
 
@@ -140,13 +134,6 @@ static inline void notresponding(struct isp1301 *isp)
 /*-------------------------------------------------------------------------*/
 
 /* only two addresses possible */
-#define	ISP_BASE		0x2c
-static unsigned short normal_i2c[] = {
-	ISP_BASE, ISP_BASE + 1,
-	I2C_CLIENT_END };
-
-I2C_CLIENT_INSMOD;
-
 static struct i2c_driver isp1301_driver;
 
 /* smbus apis are used for portability */
@@ -1190,9 +1177,7 @@ static void isp1301_timer(unsigned long _isp)
 
 static void isp1301_release(struct device *dev)
 {
-	struct isp1301	*isp;
-
-	isp = container_of(dev, struct isp1301, c.dev);
+	struct isp1301		*isp = dev_get_drvdata(dev);
 
 	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
 	if (isp->i2c_release)
@@ -1202,30 +1187,27 @@ static void isp1301_release(struct device *dev)
 
 static struct isp1301 *the_transceiver;
 
-static int isp1301_detach_client(struct i2c_client *i2c)
+static int __exit isp1301_remove(struct i2c_client *client)
 {
-	struct isp1301	*isp;
-
-	isp = container_of(i2c, struct isp1301, c);
+	struct isp1301	*isp = i2c_get_clientdata(client);
 
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_FALLING, ~0);
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
-	free_irq(isp->irq, isp);
+
+	if (client->irq > 0)
+		free_irq(client->irq, isp);
 #ifdef	CONFIG_USB_OTG
 	otg_unbind(isp);
 #endif
-	if (machine_is_omap_h2())
-		omap_free_gpio(2);
-
 	isp->timer.data = 0;
 	set_bit(WORK_STOP, &isp->todo);
 	del_timer_sync(&isp->timer);
 	flush_scheduled_work();
 
-	put_device(&i2c->dev);
+	put_device(&client->dev);
 	the_transceiver = 0;
 
-	return i2c_detach_client(i2c);
+	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1295,9 +1277,6 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 
 	power_up(isp);
 
-	if (machine_is_omap_h2())
-		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
-
 	dev_info(&isp->client->dev, "A-Host sessions ok\n");
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
 		INTR_ID_GND);
@@ -1475,11 +1454,10 @@ isp1301_start_hnp(struct otg_transceiver *dev)
 /*-------------------------------------------------------------------------*/
 
 /* no error returns, they'd just make bus scanning stop */
-static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
+static int __init isp1301_probe(struct i2c_client *client)
 {
 	int			status;
 	struct isp1301		*isp;
-	struct i2c_client	*i2c;
 
 	if (the_transceiver)
 		return 0;
@@ -1492,45 +1470,29 @@ static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
 	init_timer(&isp->timer);
 	isp->timer.function = isp1301_timer;
 	isp->timer.data = (unsigned long) isp;
-
-	isp->irq = -1;
-	isp->c.addr = address;
-	i2c_set_clientdata(&isp->c, isp);
-	isp->c.adapter = bus;
-	isp->c.driver = &isp1301_driver;
-	strlcpy(isp->c.name, DRIVER_NAME, I2C_NAME_SIZE);
-	isp->client = i2c = &isp->c;
+	isp->client = client;
 
 	/* if this is a true probe, verify the chip ... */
-	if (kind < 0) {
-		status = isp1301_get_u16(isp, ISP1301_VENDOR_ID);
-		if (status != I2C_VENDOR_ID_PHILIPS) {
-			dev_dbg(&bus->dev, "addr %d not philips id: %d\n",
-				address, status);
-			goto fail1;
-		}
-		status = isp1301_get_u16(isp, ISP1301_PRODUCT_ID);
-		if (status != I2C_PRODUCT_ID_PHILIPS_1301) {
-			dev_dbg(&bus->dev, "%d not isp1301, %d\n",
-				address, status);
-			goto fail1;
-		}
+	status = isp1301_get_u16(isp, ISP1301_VENDOR_ID);
+	if (status != I2C_VENDOR_ID_PHILIPS) {
+		dev_dbg(&client->dev, "not philips id: %d\n", status);
+		goto fail1;
+	}
+	status = isp1301_get_u16(isp, ISP1301_PRODUCT_ID);
+	if (status != I2C_PRODUCT_ID_PHILIPS_1301) {
+		dev_dbg(&client->dev, "not isp1301, %d\n", status);
+		goto fail1;
 	}
 
-	status = i2c_attach_client(i2c);
-	if (status < 0) {
-		dev_dbg(&bus->dev, "can't attach %s to device %d, err %d\n",
-				DRIVER_NAME, address, status);
 fail1:
 		kfree(isp);
 		return 0;
-	}
-	isp->i2c_release = i2c->dev.release;
-	i2c->dev.release = isp1301_release;
+
+	isp->i2c_release = client->dev.release = isp1301_release;
 
 	/* initial development used chiprev 2.00 */
-	status = i2c_smbus_read_word_data(i2c, ISP1301_BCD_DEVICE);
-	dev_info(&i2c->dev, "chiprev %x.%02x, driver " DRIVER_VERSION "\n",
+	status = i2c_smbus_read_word_data(client, ISP1301_BCD_DEVICE);
+	dev_info(&client->dev, "chiprev %x.%02x, driver " DRIVER_VERSION "\n",
 		status >> 8, status & 0xff);
 
 	/* make like power-on reset */
@@ -1551,40 +1513,24 @@ fail1:
 #ifdef	CONFIG_USB_OTG
 	status = otg_bind(isp);
 	if (status < 0) {
-		dev_dbg(&i2c->dev, "can't bind OTG\n");
+		dev_dbg(&client->dev, "can't bind OTG\n");
 		goto fail2;
 	}
 #endif
 
-	if (machine_is_omap_h2()) {
-		/* full speed signaling by default */
-		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1,
-			MC1_SPEED_REG);
-		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_2,
-			MC2_SPD_SUSP_CTRL);
-
-		/* IRQ wired at M14 */
-		omap_cfg_reg(M14_1510_GPIO2);
-		isp->irq = OMAP_GPIO_IRQ(2);
-		if (gpio_request(2, "isp1301") == 0)
-			gpio_direction_input(2);
-		isp->irq_type = IRQF_TRIGGER_FALLING;
-	}
-
-	isp->irq_type |= IRQF_SAMPLE_RANDOM;
-	status = request_irq(isp->irq, isp1301_irq,
-			isp->irq_type, DRIVER_NAME, isp);
-	if (status < 0) {
-		dev_dbg(&i2c->dev, "can't get IRQ %d, err %d\n",
-				isp->irq, status);
+	if (client->irq > 0) {
+		status = request_irq(client->irq, isp1301_irq, 0, DRIVER_NAME, isp);
+		if (status < 0) {
+			dev_dbg(&client->dev, "can't get IRQ %d, err %d\n",
+					client->irq, status);
 #ifdef	CONFIG_USB_OTG
 fail2:
 #endif
-		i2c_detach_client(i2c);
-		goto fail1;
+			goto fail1;
+		}
 	}
 
-	isp->otg.dev = &isp->client->dev;
+	isp->otg.dev = &client->dev;
 	isp->otg.label = DRIVER_NAME;
 
 	isp->otg.set_host = isp1301_set_host,
@@ -1606,31 +1552,23 @@ fail2:
 
 #ifdef	VERBOSE
 	mod_timer(&isp->timer, jiffies + TIMER_JIFFIES);
-	dev_dbg(&i2c->dev, "scheduled timer, %d min\n", TIMER_MINUTES);
+	dev_dbg(&client->dev, "scheduled timer, %d min\n", TIMER_MINUTES);
 #endif
 
 	status = otg_set_transceiver(&isp->otg);
 	if (status < 0)
-		dev_err(&i2c->dev, "can't register transceiver, %d\n",
+		dev_err(&client->dev, "can't register transceiver, %d\n",
 			status);
 
 	return 0;
 }
 
-static int isp1301_scan_bus(struct i2c_adapter *bus)
-{
-	if (!i2c_check_functionality(bus, I2C_FUNC_SMBUS_BYTE_DATA
-			| I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EINVAL;
-	return i2c_probe(bus, &addr_data, isp1301_probe);
-}
-
 static struct i2c_driver isp1301_driver = {
 	.driver = {
 		.name	= "isp1301_omap",
 	},
-	.attach_adapter	= isp1301_scan_bus,
-	.detach_client	= isp1301_detach_client,
+	.probe	= isp1301_probe,
+	.remove	= __exit_p(isp1301_remove),
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.5.4.3.447.gc95b3

-- 
Best Regards,

Felipe Balbi
me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
http://blog.felipebalbi.com

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
