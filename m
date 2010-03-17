From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c: Set SCL pin to gpio functionality before bus recovery
Date: Wed, 17 Mar 2010 16:51:56 +0530
Message-ID: <1268824916.4540.21.camel@localhost.localdomain>
Reply-To: pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Date: Wed, 17 Mar 2010 16:20:12 +0530
Subject: [PATCH] Set SCL pin to gpio functionality before bus recovery

Before using the SCL pin, set it to GPIO by conditionally
checking the i2c revision id for peripherals that match 0x05.
Clean up data structures along the way.

Signed-off-by: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c  |    1 -
 arch/arm/mach-davinci/board-dm644x-evm.c |    1 -
 arch/arm/mach-davinci/include/mach/i2c.h |    3 +--
 drivers/i2c/busses/i2c-davinci.c         |   19 ++++++++++++++++---
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index aa48e3f..f4cbf54 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -111,7 +111,6 @@ static struct platform_device davinci_nand_device = {
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 400	/* kHz */,
 	.bus_delay	= 0	/* usec */,
-	.sda_pin        = 15,
 	.scl_pin        = 14,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 976e11b..19508e3 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -629,7 +629,6 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 20 /* kHz */,
 	.bus_delay	= 100 /* usec */,
-	.sda_pin        = 44,
 	.scl_pin        = 43,
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/i2c.h b/arch/arm/mach-davinci/include/mach/i2c.h
index 39fdcea..95894ca 100644
--- a/arch/arm/mach-davinci/include/mach/i2c.h
+++ b/arch/arm/mach-davinci/include/mach/i2c.h
@@ -16,8 +16,7 @@
 struct davinci_i2c_platform_data {
 	unsigned int	bus_freq;	/* standard bus frequency (kHz) */
 	unsigned int	bus_delay;	/* post-transaction delay (usec) */
-	unsigned int    sda_pin;        /* GPIO pin ID to use for SDA */
-	unsigned int    scl_pin;        /* GPIO pin ID to use for SCL */
+	unsigned int	scl_pin;	/* GPIO pin ID to use for SCL */
 };
 
 /* for board setup code */
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 7a28e60..df909e3 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -64,6 +64,7 @@
 #define DAVINCI_I2C_IVR_REG	0x28
 #define DAVINCI_I2C_EMDR_REG	0x2c
 #define DAVINCI_I2C_PSC_REG	0x30
+#define DAVINCI_I2C_REVID2_REG	0x38
 
 #define DAVINCI_I2C_IVR_AAS	0x07
 #define DAVINCI_I2C_IVR_SCD	0x06
@@ -133,11 +134,21 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 }
 
 /* Generate a pulse on the i2c clock pin. */
-static void generic_i2c_clock_pulse(unsigned int scl_pin)
+static void generic_i2c_clock_pulse(unsigned int revid, unsigned int scl_pin)
 {
 	u16 i;
+	int ret;
 
 	if (scl_pin) {
+		if (revid == 0x05) {
+			ret = gpio_request(scl_pin, "SCL Pin\n");
+			if (ret) {
+				pr_warning("gpio request pin %d failed\n",
+					scl_pin);
+				return;
+			}
+			gpio_direction_output(scl_pin, 1);
+		}
 		/* Send high and low on the SCL line */
 		for (i = 0; i < 9; i++) {
 			gpio_set_value(scl_pin, 0);
@@ -162,8 +173,10 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	flag |=  DAVINCI_I2C_MDR_NACK;
 	/* write the data into mode register */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	if (pdata)
-		generic_i2c_clock_pulse(pdata->scl_pin);
+	if (pdata) {
+		flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_REVID2_REG);
+		generic_i2c_clock_pulse(flag, pdata->scl_pin);
+	}
 	/* Send STOP */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
 	flag |= DAVINCI_I2C_MDR_STP;
-- 
1.6.3.3.311.g7ec7
