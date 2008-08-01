From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: [PATCH] i2c-pxa: fastmode support (with suggested fixes)
Date: Fri, 01 Aug 2008 11:08:15 +0100
Message-ID: <4892E08F.4000907@cam.ac.uk>
References: <4891E0C5.7020009@cam.ac.uk>
	<20080801094257.GK26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080801094257.GK26938-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM
bit appropriately when i2c_pxa_reset is called. Parameter called fast_mode
rather than frequency as this driver is also used for the i2c_pxa_pwr bus
which has different normal and fast frequencies.

Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

--
This is basically a repost of the original patch with use_pio and
fast_mode converted to bit fields as suggested / agreed by Eric Miao and
Ben Dooks.

 drivers/i2c/busses/i2c-pxa.c        |    6 ++++--
 include/asm-arm/arch-pxa/i2c.h      |    3 ++-
 include/asm-arm/arch-pxa/pxa-regs.h |    1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/i2c/busses/i2c-pxa.c	2008-07-31 12:02:42.000000000 +0100
+++ b/drivers/i2c/busses/i2c-pxa.c	2008-08-01 10:50:38.000000000 +0100
@@ -65,7 +65,8 @@ struct pxa_i2c {
 	unsigned long		iosize;
 
 	int			irq;
-	int			use_pio;
+	unsigned int		use_pio:1;
+	unsigned int		fast_mode:1;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_base + 0)
@@ -364,7 +365,7 @@ static void i2c_pxa_reset(struct pxa_i2c
 	writel(i2c->slave_addr, _ISAR(i2c));
 
 	/* set control register values */
-	writel(I2C_ICR_INIT, _ICR(i2c));
+	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
@@ -1013,6 +1014,7 @@ static int i2c_pxa_probe(struct platform
 	if (plat) {
 		i2c->adap.class = plat->class;
 		i2c->use_pio = plat->use_pio;
+		i2c->fast_mode = plat->fast_mode;
 	}
 
 	if (i2c->use_pio) {
--- a/include/asm-arm/arch-pxa/i2c.h	2008-07-31 12:00:05.000000000 +0100
+++ b/include/asm-arm/arch-pxa/i2c.h	2008-08-01 10:51:40.000000000 +0100
@@ -65,7 +65,8 @@ struct i2c_pxa_platform_data {
 	unsigned int		slave_addr;
 	struct i2c_slave_client	*slave;
 	unsigned int		class;
-	int			use_pio;
+	unsigned int		use_pio:1;
+	unsigned int		fast_mode:1;
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
--- a/include/asm-arm/arch-pxa/pxa-regs.h	2008-07-31 12:02:51.000000000 +0100
+++ b/include/asm-arm/arch-pxa/pxa-regs.h	2008-07-31 12:34:44.000000000 +0100
@@ -448,6 +448,7 @@
 #define ICR_ALDIE	(1 << 12)	   /* enable arbitration interrupt */
 #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
 #define ICR_UR		(1 << 14)	   /* unit reset */
+#define ICR_FM		(1 << 15)	   /* fast mode */
 
 #define ISR_RWM		(1 << 0)	   /* read/write mode */
 #define ISR_ACKNAK	(1 << 1)	   /* ack/nak status */

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
