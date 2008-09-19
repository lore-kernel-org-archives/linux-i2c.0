From: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Fri, 19 Sep 2008 11:22:47 -0300
Message-ID: <48D3B5B7.1060402@gamic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050604030708020907040203"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604030708020907040203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wolfram,

Here is the patch against 2.6.26.5.
Please tell me if I did something very wrong ;)

Regards,

Marco



--------------050604030708020907040203
Content-Type: text/x-patch;
 name="pca9665-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pca9665-support.patch"

diff -ur linux-2.6.26.5/drivers/i2c/algos/i2c-algo-pca.c linux-2.6.26.5-new/drivers/i2c/algos/i2c-algo-pca.c
--- linux-2.6.26.5/drivers/i2c/algos/i2c-algo-pca.c	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/algos/i2c-algo-pca.c	2008-09-19 10:29:33.000000000 -0300
@@ -43,6 +43,14 @@
 #define pca_wait(adap) adap->wait_for_completion(adap->data)
 #define pca_reset(adap) adap->reset_chip(adap->data)
 
+static void pca9665_reset(void *pd)
+{
+	struct i2c_algo_pca_data *adap = pd;
+	pca_outw(adap,I2C_PCA_INDPTR,I2C_PCA_IPRESET);
+	pca_outw(adap,I2C_PCA_IND,0xA5);
+	pca_outw(adap,I2C_PCA_IND,0x5A);
+}
+
 /*
  * Generate a start condition on the i2c bus.
  *
@@ -332,24 +340,132 @@
 
 static int pca_init(struct i2c_adapter *adap)
 {
-	static int freqs[] = {330,288,217,146,88,59,44,36};
-	int clock;
 	struct i2c_algo_pca_data *pca_data = adap->algo_data;
 
-	if (pca_data->i2c_clock > 7) {
-		printk(KERN_WARNING "%s: Invalid I2C clock speed selected. Trying default.\n",
-			adap->name);
-		pca_data->i2c_clock = I2C_PCA_CON_59kHz;
+	adap->algo = &pca_algo;
+	
+	if (pca_data->i2c_chip_type != I2C_PCA_CHIP_9564 && pca_data->i2c_chip_type != I2C_PCA_CHIP_9665 ) {
+		printk(KERN_WARNING "%s: Invalid chip selected. Assuming PCA9564.\n",
+					 adap->name);
+		pca_data->i2c_chip_type = I2C_PCA_CHIP_9564;
 	}
 
-	adap->algo = &pca_algo;
+	if (pca_data->i2c_chip_type == I2C_PCA_CHIP_9564) {
+		static int freqs[] = {330,288,217,146,88,59,44,36};
+		int clock;
+	
+		if (pca_data->i2c_clock > 7) {
+			switch (pca_data->i2c_clock) {
+				case 330000:
+					pca_data->i2c_clock = I2C_PCA_CON_330kHz;
+					break;
+				case 288000:
+					pca_data->i2c_clock = I2C_PCA_CON_288kHz;
+					break;
+				case 217000:
+					pca_data->i2c_clock = I2C_PCA_CON_217kHz;
+					break;
+				case 146000:
+					pca_data->i2c_clock = I2C_PCA_CON_146kHz;
+					break;
+				case 88000:
+					pca_data->i2c_clock = I2C_PCA_CON_88kHz;
+					break;
+				case 59000:
+					pca_data->i2c_clock = I2C_PCA_CON_59kHz;
+					break;
+				case 44000:
+					pca_data->i2c_clock = I2C_PCA_CON_44kHz;
+					break;
+				case 36000:
+					pca_data->i2c_clock = I2C_PCA_CON_36kHz;
+					break;
+				default:
+			printk(KERN_WARNING "%s: Invalid I2C clock speed selected. Trying default.\n",
+				adap->name);
+			pca_data->i2c_clock = I2C_PCA_CON_59kHz;
+			}
+		} else {
+			printk(KERN_WARNING "%s: Choosing the clock frequency based on index is deprecated. Use the nominal frequency.\n",
+						 adap->name);
+		}
+	
+		pca_reset(pca_data);
+	
+		clock = pca_clock(pca_data);
+		DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[clock]);
+	
+		pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
+	} else {
+		int clock;
+		int mode;
+		int tlow, thigh;
+		int minTLow, minTHi;
+		int tRaiseFall;
+	
+		struct i2c_algo_pca_data *pca_data = adap->algo_data;
+		
+		/* Ignore the reset function from the module, we can use the parallel bus reset */
+		pca_data->reset_chip = pca9665_reset;
+
+		if (pca_data->i2c_clock > 1265800) {
+			printk(KERN_WARNING "%s: I2C clock speed too high. Using 1265.8kHz.\n",
+						 adap->name);
+			pca_data->i2c_clock = 1265800;
+		}
+	
+		if (pca_data->i2c_clock < 60300) {
+			printk(KERN_WARNING "%s: I2C clock speed too low. Using 60.3kHz.\n",
+						 adap->name);
+			pca_data->i2c_clock = 60300;
+		}
+	
+		clock = pca_clock(pca_data)/100; /* Hz*100 */
+	
+
+		if (pca_data->i2c_clock > 10000) {
+			mode = I2C_PCA_MODE_TURBO;
+			minTLow = 14;
+			minTHi  = 5;
+			tRaiseFall = 22; /* Raise 11e-8s, Fall 11e-8s */
+		} else if (pca_data->i2c_clock > 4000) {
+			mode = I2C_PCA_MODE_FASTP;
+			minTLow = 17;
+			minTHi  = 9;
+			tRaiseFall = 22; /* Raise 11e-8s, Fall 11e-8s */
+		} else if (pca_data->i2c_clock > 1000) {
+			mode = I2C_PCA_MODE_FAST;
+			minTLow = 44;
+			minTHi  = 20;
+			tRaiseFall = 58; /* Raise 29e-8s, Fall 29e-8s */
+		} else {
+			mode = I2C_PCA_MODE_STD;
+			minTLow = 157;
+			minTHi  = 134;
+			tRaiseFall = 127; /* Raise 29e-8s, Fall 98e-8s */
+		}
 
-	pca_reset(pca_data);
+		if (clock < 648) {
+			tlow = 255;
+			thigh = (1000000 - clock*tRaiseFall)/(3*clock)-tlow;
+		} else {
+			tlow = ((1000000 - clock*tRaiseFall)*minTLow)/(3*clock*(minTHi+minTLow));
+			thigh = tlow*minTHi/minTLow;
+		}
+
+		pca_reset(pca_data);
 
-	clock = pca_clock(pca_data);
-	DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[clock]);
+		DEB1(KERN_INFO "%s: Clock frequency is %dHz\n", adap->name, clock*100);
 
-	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
+		pca_outw(pca_data,I2C_PCA_INDPTR,I2C_PCA_IMODE);
+		pca_outw(pca_data,I2C_PCA_IND,mode);
+		pca_outw(pca_data,I2C_PCA_INDPTR,I2C_PCA_ISCLL);
+		pca_outw(pca_data,I2C_PCA_IND,tlow);
+		pca_outw(pca_data,I2C_PCA_INDPTR,I2C_PCA_ISCLH);
+		pca_outw(pca_data,I2C_PCA_IND,thigh);
+	
+		pca_set_con(pca_data, I2C_PCA_CON_ENSIO);
+	}
 	udelay(500); /* 500 us for oscilator to stabilise */
 
 	return 0;
@@ -384,7 +500,7 @@
 
 MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, "
 	"Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
-MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
+MODULE_DESCRIPTION("I2C-Bus PCA9564/PCA9665 algorithm");
 MODULE_LICENSE("GPL");
 
 module_param(i2c_debug, int, 0);
diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-isa.c linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-isa.c
--- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-isa.c	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-isa.c	2008-09-19 10:59:33.000000000 -0300
@@ -42,6 +42,7 @@
 /* Data sheet recommends 59kHz for 100kHz operation due to variation
  * in the actual clock rate */
 static int clock  = I2C_PCA_CON_59kHz;
+static int chip   = I2C_PCA_CHIP_9564;
 
 static wait_queue_head_t pca_wait;
 
@@ -103,7 +104,7 @@
 	.owner          = THIS_MODULE,
 	.id		= I2C_HW_A_ISA,
 	.algo_data	= &pca_isa_data,
-	.name		= "PCA9564 ISA Adapter",
+	.name		= "PCA9564/PCA9665 ISA Adapter",
 	.timeout	= 100,
 };
 
@@ -132,6 +133,7 @@
 		}
 	}
 
+	pca_isa_data.i2c_chip_type = chip;
 	pca_isa_data.i2c_clock = clock;
 	if (i2c_pca_add_bus(&pca_isa_ops) < 0) {
 		dev_err(dev, "Failed to add i2c bus\n");
@@ -182,7 +184,7 @@
 }
 
 MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>");
-MODULE_DESCRIPTION("ISA base PCA9564 driver");
+MODULE_DESCRIPTION("ISA base PCA9564/PCA9665 driver");
 MODULE_LICENSE("GPL");
 
 module_param(base, ulong, 0);
@@ -191,7 +193,11 @@
 module_param(irq, int, 0);
 MODULE_PARM_DESC(irq, "IRQ");
 module_param(clock, int, 0);
-MODULE_PARM_DESC(clock, "Clock rate as described in table 1 of PCA9564 datasheet");
+MODULE_PARM_DESC(clock, "Clock rate in hertz.\n\t\tFor PCA9564: 330000,288000,217000,146000,88000,59000,44000,36000\n"
+		"\t\tFor PCA9665:\tStandard: 60300 - 100099\n\t\t\t\tFast: 100100 - 400099\n\t\t\t\tFast+: 400100 - 10000099\n"
+		"\t\t\t\tTurbo: Up to 1265800");
+module_param(chip, int, 0);
+MODULE_PARM_DESC(chip, "Chip type: 0 = PCA9564; 1 - PCA9665");
 
 module_init(pca_isa_init);
 module_exit(pca_isa_exit);
diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-platform.c
--- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-platform.c	2008-09-19 10:11:02.000000000 -0300
@@ -172,7 +172,7 @@
 
 	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
 	i2c->adap.owner = THIS_MODULE;
-	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564/PCA9665 at 0x%08lx",
 		(unsigned long) res->start);
 	i2c->adap.algo_data = &i2c->algo_data;
 	i2c->adap.dev.parent = &pdev->dev;
@@ -246,7 +246,7 @@
 e_alloc:
 	release_mem_region(res->start, res_len(res));
 e_print:
-	printk(KERN_ERR "Registering PCA9564 FAILED! (%d)\n", ret);
+	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
 	return ret;
 }
 
@@ -290,7 +290,7 @@
 }
 
 MODULE_AUTHOR("Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
-MODULE_DESCRIPTION("I2C-PCA9564 platform driver");
+MODULE_DESCRIPTION("I2C-PCA9564/PCA9665 platform driver");
 MODULE_LICENSE("GPL");
 
 module_init(i2c_pca_pf_init);
diff -ur linux-2.6.26.5/drivers/i2c/busses/Kconfig linux-2.6.26.5-new/drivers/i2c/busses/Kconfig
--- linux-2.6.26.5/drivers/i2c/busses/Kconfig	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/busses/Kconfig	2008-09-19 10:33:35.000000000 -0300
@@ -630,7 +630,7 @@
 	  will be called i2c-voodoo3.
 
 config I2C_PCA_ISA
-	tristate "PCA9564 on an ISA bus"
+	tristate "PCA9564/PCA9665 on an ISA bus"
 	depends on ISA
 	select I2C_ALGOPCA
 	default n
@@ -647,7 +647,7 @@
 	  time).  If unsure, say N.
 
 config I2C_PCA_PLATFORM
-	tristate "PCA9564 as platform device"
+	tristate "PCA9564/PCA9665 as platform device"
 	select I2C_ALGOPCA
 	default n
 	help
diff -ur linux-2.6.26.5/include/linux/i2c-algo-pca.h linux-2.6.26.5-new/include/linux/i2c-algo-pca.h
--- linux-2.6.26.5/include/linux/i2c-algo-pca.h	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/include/linux/i2c-algo-pca.h	2008-09-19 11:13:21.000000000 -0300
@@ -1,7 +1,11 @@
 #ifndef _LINUX_I2C_ALGO_PCA_H
 #define _LINUX_I2C_ALGO_PCA_H
 
-/* Clock speeds for the bus */
+/* Chips known to the pca algo */
+#define I2C_PCA_CHIP_9564	0x00
+#define I2C_PCA_CHIP_9665	0x01
+
+/* Clock speeds for the bus for PCA9564*/
 #define I2C_PCA_CON_330kHz	0x00
 #define I2C_PCA_CON_288kHz	0x01
 #define I2C_PCA_CON_217kHz	0x02
@@ -18,6 +22,26 @@
 #define I2C_PCA_ADR		0x02 /* OWN ADR Read/Write */
 #define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
 
+/* PCA9665 registers */
+#define I2C_PCA_INDPTR          0x00 /* INDIRECT Pointer Write Only */
+#define I2C_PCA_IND             0x02 /* INDIRECT Read/Write */
+
+/* PCA9665 indirect registers */
+#define I2C_PCA_ICOUNT          0x00 /* Byte Count for buffered mode */
+#define I2C_PCA_IADR            0x01 /* OWN ADR */
+#define I2C_PCA_ISCLL           0x02 /* SCL LOW period */
+#define I2C_PCA_ISCLH           0x03 /* SCL HIGH period */
+#define I2C_PCA_ITO             0x04 /* TIMEOUT */
+#define I2C_PCA_IPRESET         0x05 /* Parallel bus reset */
+#define I2C_PCA_IMODE           0x06 /* I2C Bus mode */
+
+/* PCA9665 I2C bus mode */
+#define I2C_PCA_MODE_STD        0x00 /* Standard mode */
+#define I2C_PCA_MODE_FAST       0x01 /* Fast mode */
+#define I2C_PCA_MODE_FASTP      0x02 /* Fast Plus mode */
+#define I2C_PCA_MODE_TURBO      0x03 /* Turbo mode */
+
+
 #define I2C_PCA_CON_AA		0x80 /* Assert Acknowledge */
 #define I2C_PCA_CON_ENSIO	0x40 /* Enable */
 #define I2C_PCA_CON_STA		0x20 /* Start */
@@ -31,8 +55,11 @@
 	int  (*read_byte)		(void *data, int reg);
 	int  (*wait_for_completion)	(void *data);
 	void (*reset_chip)		(void *data);
-	/* i2c_clock values are defined in linux/i2c-algo-pca.h */
+	/* For PCA9964, use one of the predefined frequencies:
+	 * 330000, 288000, 217000, 146000, 88000, 59000, 44000, 36000
+	 * For PCA9665, use the frequency you want here. */
 	unsigned int			i2c_clock;
+	unsigned int			i2c_chip_type;
 };
 
 int i2c_pca_add_bus(struct i2c_adapter *);

--------------050604030708020907040203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------050604030708020907040203--
