From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] i2c-pxa: fastmode support
Date: Thu, 31 Jul 2008 16:56:53 +0100
Message-ID: <4891E0C5.7020009@cam.ac.uk>
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
To: linux-arm-kernel@lists.arm.linux.org.uk, i2c@lm-sensors.org
Cc: linux@arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
than frequency as this driver is also used for the i2c_pxa_pwr bus which has
different normal and fast frequencies.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
--
This is basically a repost of the original patch with use_pio and fast_mode converted
to bit fields as suggested / agreed by Eric Miao and Ben Dooks.

Patch is against 2.6.27-rc1

 drivers/i2c/busses/i2c-pxa.c        |    6 ++++--
 include/asm-arm/arch-pxa/i2c.h      |    3 ++-
 include/asm-arm/arch-pxa/pxa-regs.h |    1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff -uprN -X a/Documentation/dontdiff a/include/asm-arm/arch-pxa/pxa-regs.h b/include/asm-arm/arch-pxa/pxa-regs.h
--- a/include/asm-arm/arch-pxa/pxa-regs.h	2008-07-31 12:02:51.000000000 +0100
+++ b/include/asm-arm/arch-pxa/pxa-regs.h	2008-07-31 12:34:44.000000000 +0100
@@ -448,6 +448,7 @@
 #define ICR_ALDIE	(1 << 12)	   /* enable arbitration interrupt */
 #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
 #define ICR_UR		(1 << 14)	   /* unit reset */
+#define ICR_FM		(1 << 15)	   /* fast mode */
 
 #define ISR_RWM		(1 << 0)	   /* read/write mode */
 #define ISR_ACKNAK	(1 << 1)	   /* ack/nak status */
diff -uprN -X a/Documentation/dontdiff a/include/asm-arm/arch-pxa/i2c.h b/include/asm-arm/arch-pxa/i2c.h
--- a/include/asm-arm/arch-pxa/i2c.h	2008-07-31 12:00:05.000000000 +0100
+++ b/include/asm-arm/arch-pxa/i2c.h	2008-07-31 16:01:28.000000000 +0100
@@ -65,7 +65,8 @@ struct i2c_pxa_platform_data {
 	unsigned int		slave_addr;
 	struct i2c_slave_client	*slave;
 	unsigned int		class;
-	int			use_pio;
+	int			use_pio:1;
+	int			fast_mode:1;
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
diff -uprN -X a/Documentation/dontdiff a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
--- a/drivers/i2c/busses/i2c-pxa.c	2008-07-31 12:02:42.000000000 +0100
+++ b/drivers/i2c/busses/i2c-pxa.c	2008-07-31 16:10:43.000000000 +0100
@@ -65,7 +65,8 @@ struct pxa_i2c {
 	unsigned long		iosize;
 
 	int			irq;
-	int			use_pio;
+	int			use_pio:1;
+	int			fast_mode:1;
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

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
