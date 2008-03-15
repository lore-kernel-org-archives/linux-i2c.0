From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Sat, 15 Mar 2008 14:47:17 +0200
Message-ID: <1205585237-21492-4-git-send-email-me@felipebalbi.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
	<1205585237-21492-3-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1205585237-21492-3-git-send-email-me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, David Brownell <david-b-ZKR15rr3LjGsTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Based on David Brownell's patch for tps65010, this patch
finish conversting isp1301_omap.c to new-style i2c driver.

Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
---
 arch/arm/mach-omap1/board-h2.c   |    1 +
 arch/arm/mach-omap1/board-h3.c   |    6 +
 arch/arm/mach-omap2/board-h4.c   |   12 +++
 drivers/i2c/chips/isp1301_omap.c |  198 +++++++------------------------------
 include/linux/i2c/isp1301_omap.h |   92 ++++++++++++++++++
 5 files changed, 149 insertions(+), 160 deletions(-)
 create mode 100644 include/linux/i2c/isp1301_omap.h

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 5079877..81a8c87 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -357,6 +357,7 @@ static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
 		.type		= "isp1301_omap",
 		.irq		= OMAP_GPIO_IRQ(2),
+		.irq_flags	= IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
 	},
 };
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index c3ef1ee..474921f 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -477,6 +477,12 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
                .type           = "tps65013",
                /* .irq         = OMAP_GPIO_IRQ(??), */
        },
+       {
+               I2C_BOARD_INFO("isp1301_omap", 0x2d),
+               .type		= "isp1301_omap",
+               .irq		= OMAP_GPIO_IRQ(14),
+	       .irq_flags	= IRQF_SAMPLE_RANDOM,
+       },
 };
 
 static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f125f43..6e57021 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -301,6 +301,15 @@ static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
+static struct i2c_board_info __initdata h4_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2d),
+		.type		= "isp1301_omap",
+		.irq		= OMAP_GPIO_IRQ(125),
+		.irq_flags	= IRQF_SAMPLE_RANDOM,
+	},
+};
+
 static void __init omap_h4_init(void)
 {
 	/*
@@ -321,6 +330,9 @@ static void __init omap_h4_init(void)
 	}
 #endif
 
+	i2c_register_board_info(1, h4_i2c_board_info,
+			ARRAY_SIZE(h4_i2c_board_info));
+
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index d094b99..f88f9ae 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -25,14 +25,9 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/usb/ch9.h>
-#include <linux/usb/gadget.h>
-#include <linux/usb.h>
-#include <linux/usb/otg.h>
 #include <linux/i2c.h>
+#include <linux/i2c/isp1301_omap.h>
 #include <linux/workqueue.h>
-
-#include <asm/irq.h>
 #include <asm/arch/usb.h>
 
 
@@ -50,12 +45,8 @@ MODULE_LICENSE("GPL");
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
 
@@ -140,13 +131,6 @@ static inline void notresponding(struct isp1301 *isp)
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
@@ -177,64 +161,6 @@ isp1301_clear_bits(struct isp1301 *isp, u8 reg, u8 bits)
 
 /*-------------------------------------------------------------------------*/
 
-/* identification */
-#define	ISP1301_VENDOR_ID		0x00	/* u16 read */
-#define	ISP1301_PRODUCT_ID		0x02	/* u16 read */
-#define	ISP1301_BCD_DEVICE		0x14	/* u16 read */
-
-#define	I2C_VENDOR_ID_PHILIPS		0x04cc
-#define	I2C_PRODUCT_ID_PHILIPS_1301	0x1301
-
-/* operational registers */
-#define	ISP1301_MODE_CONTROL_1		0x04	/* u8 read, set, +1 clear */
-#	define	MC1_SPEED_REG		(1 << 0)
-#	define	MC1_SUSPEND_REG		(1 << 1)
-#	define	MC1_DAT_SE0		(1 << 2)
-#	define	MC1_TRANSPARENT		(1 << 3)
-#	define	MC1_BDIS_ACON_EN	(1 << 4)
-#	define	MC1_OE_INT_EN		(1 << 5)
-#	define	MC1_UART_EN		(1 << 6)
-#	define	MC1_MASK		0x7f
-#define	ISP1301_MODE_CONTROL_2		0x12	/* u8 read, set, +1 clear */
-#	define	MC2_GLOBAL_PWR_DN	(1 << 0)
-#	define	MC2_SPD_SUSP_CTRL	(1 << 1)
-#	define	MC2_BI_DI		(1 << 2)
-#	define	MC2_TRANSP_BDIR0	(1 << 3)
-#	define	MC2_TRANSP_BDIR1	(1 << 4)
-#	define	MC2_AUDIO_EN		(1 << 5)
-#	define	MC2_PSW_EN		(1 << 6)
-#	define	MC2_EN2V7		(1 << 7)
-#define	ISP1301_OTG_CONTROL_1		0x06	/* u8 read, set, +1 clear */
-#	define	OTG1_DP_PULLUP		(1 << 0)
-#	define	OTG1_DM_PULLUP		(1 << 1)
-#	define	OTG1_DP_PULLDOWN	(1 << 2)
-#	define	OTG1_DM_PULLDOWN	(1 << 3)
-#	define	OTG1_ID_PULLDOWN	(1 << 4)
-#	define	OTG1_VBUS_DRV		(1 << 5)
-#	define	OTG1_VBUS_DISCHRG	(1 << 6)
-#	define	OTG1_VBUS_CHRG		(1 << 7)
-#define	ISP1301_OTG_STATUS		0x10	/* u8 readonly */
-#	define	OTG_B_SESS_END		(1 << 6)
-#	define	OTG_B_SESS_VLD		(1 << 7)
-
-#define	ISP1301_INTERRUPT_SOURCE	0x08	/* u8 read */
-#define	ISP1301_INTERRUPT_LATCH		0x0A	/* u8 read, set, +1 clear */
-
-#define	ISP1301_INTERRUPT_FALLING	0x0C	/* u8 read, set, +1 clear */
-#define	ISP1301_INTERRUPT_RISING	0x0E	/* u8 read, set, +1 clear */
-
-/* same bitfields in all interrupt registers */
-#	define	INTR_VBUS_VLD		(1 << 0)
-#	define	INTR_SESS_VLD		(1 << 1)
-#	define	INTR_DP_HI		(1 << 2)
-#	define	INTR_ID_GND		(1 << 3)
-#	define	INTR_DM_HI		(1 << 4)
-#	define	INTR_ID_FLOAT		(1 << 5)
-#	define	INTR_BDIS_ACON		(1 << 6)
-#	define	INTR_CR_INT		(1 << 7)
-
-/*-------------------------------------------------------------------------*/
-
 static const char *state_string(enum usb_otg_state state)
 {
 	switch (state) {
@@ -1190,9 +1116,7 @@ static void isp1301_timer(unsigned long _isp)
 
 static void isp1301_release(struct device *dev)
 {
-	struct isp1301	*isp;
-
-	isp = container_of(dev, struct isp1301, c.dev);
+	struct isp1301		*isp = dev_get_drvdata(dev);
 
 	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
 	if (isp->i2c_release)
@@ -1202,30 +1126,27 @@ static void isp1301_release(struct device *dev)
 
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
@@ -1295,9 +1216,6 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 
 	power_up(isp);
 
-	if (machine_is_omap_h2())
-		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
-
 	dev_info(&isp->client->dev, "A-Host sessions ok\n");
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
 		INTR_ID_GND);
@@ -1475,11 +1393,10 @@ isp1301_start_hnp(struct otg_transceiver *dev)
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
@@ -1492,45 +1409,29 @@ static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
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
@@ -1551,40 +1452,25 @@ fail1:
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
+		status = request_irq(client->irq, isp1301_irq,
+				client->irq_flags, DRIVER_NAME, isp);
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
@@ -1606,31 +1492,23 @@ fail2:
 
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
diff --git a/include/linux/i2c/isp1301_omap.h b/include/linux/i2c/isp1301_omap.h
new file mode 100644
index 0000000..de47460
--- /dev/null
+++ b/include/linux/i2c/isp1301_omap.h
@@ -0,0 +1,92 @@
+/* include/linux/i2c/isp1301_omap.h
+ *
+ * Copyright (C) 2008 Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __LINUX_I2C_ISP1301_OMAP_H
+#define __LINUX_I2C_ISP1301_OMAP_H
+
+/* identification */
+#define	ISP1301_VENDOR_ID		0x00	/* u16 read */
+#define	ISP1301_PRODUCT_ID		0x02	/* u16 read */
+#define	ISP1301_BCD_DEVICE		0x14	/* u16 read */
+
+#define	I2C_VENDOR_ID_PHILIPS		0x04cc
+#define	I2C_PRODUCT_ID_PHILIPS_1301	0x1301
+
+/* operational registers */
+#define	ISP1301_MODE_CONTROL_1		0x04	/* u8 read, set, +1 clear */
+#	define	MC1_SPEED_REG		(1 << 0)
+#	define	MC1_SUSPEND_REG		(1 << 1)
+#	define	MC1_DAT_SE0		(1 << 2)
+#	define	MC1_TRANSPARENT		(1 << 3)
+#	define	MC1_BDIS_ACON_EN	(1 << 4)
+#	define	MC1_OE_INT_EN		(1 << 5)
+#	define	MC1_UART_EN		(1 << 6)
+#	define	MC1_MASK		0x7f
+#define	ISP1301_MODE_CONTROL_2		0x12	/* u8 read, set, +1 clear */
+#	define	MC2_GLOBAL_PWR_DN	(1 << 0)
+#	define	MC2_SPD_SUSP_CTRL	(1 << 1)
+#	define	MC2_BI_DI		(1 << 2)
+#	define	MC2_TRANSP_BDIR0	(1 << 3)
+#	define	MC2_TRANSP_BDIR1	(1 << 4)
+#	define	MC2_AUDIO_EN		(1 << 5)
+#	define	MC2_PSW_EN		(1 << 6)
+#	define	MC2_EN2V7		(1 << 7)
+#define	ISP1301_OTG_CONTROL_1		0x06	/* u8 read, set, +1 clear */
+#	define	OTG1_DP_PULLUP		(1 << 0)
+#	define	OTG1_DM_PULLUP		(1 << 1)
+#	define	OTG1_DP_PULLDOWN	(1 << 2)
+#	define	OTG1_DM_PULLDOWN	(1 << 3)
+#	define	OTG1_ID_PULLDOWN	(1 << 4)
+#	define	OTG1_VBUS_DRV		(1 << 5)
+#	define	OTG1_VBUS_DISCHRG	(1 << 6)
+#	define	OTG1_VBUS_CHRG		(1 << 7)
+#define	ISP1301_OTG_STATUS		0x10	/* u8 readonly */
+#	define	OTG_B_SESS_END		(1 << 6)
+#	define	OTG_B_SESS_VLD		(1 << 7)
+
+#define	ISP1301_INTERRUPT_SOURCE	0x08	/* u8 read */
+#define	ISP1301_INTERRUPT_LATCH		0x0A	/* u8 read, set, +1 clear */
+
+#define	ISP1301_INTERRUPT_FALLING	0x0C	/* u8 read, set, +1 clear */
+#define	ISP1301_INTERRUPT_RISING	0x0E	/* u8 read, set, +1 clear */
+
+/* same bitfields in all interrupt registers */
+#	define	INTR_VBUS_VLD		(1 << 0)
+#	define	INTR_SESS_VLD		(1 << 1)
+#	define	INTR_DP_HI		(1 << 2)
+#	define	INTR_ID_GND		(1 << 3)
+#	define	INTR_DM_HI		(1 << 4)
+#	define	INTR_ID_FLOAT		(1 << 5)
+#	define	INTR_BDIS_ACON		(1 << 6)
+#	define	INTR_CR_INT		(1 << 7)
+
+struct isp1301_platform_data {
+	unsigned	irqflags;
+	unsigned	bit;
+
+};
+
+#endif /*  __LINUX_I2C_ISP1301_OMAP_H */
+
-- 
1.5.4.3.447.gc95b3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
