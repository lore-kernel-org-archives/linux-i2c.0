From: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Fri, 19 Sep 2008 12:37:50 -0300
Message-ID: <48D3C74E.1050801@gamic.com>
References: <48D3B5B7.1060402@gamic.com> <20080919145500.GH4307@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090101000306020705030301"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080919145500.GH4307-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
--------------090101000306020705030301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wolfram.

Wolfram Sang wrote:
> I'm just about to leave the office, so just the first notes. Will have a
> deeper look later this evening...
>   
I did the fixes you pointed out and run the script.
This is the result.


Regards,

Marco

--------------090101000306020705030301
Content-Type: text/x-patch;
 name="pca9665-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pca9665-support.patch"

diff -ur linux-2.6.26.5/drivers/i2c/algos/i2c-algo-pca.c linux-2.6.26.5-new/drivers/i2c/algos/i2c-algo-pca.c
--- linux-2.6.26.5/drivers/i2c/algos/i2c-algo-pca.c	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/algos/i2c-algo-pca.c	2008-09-19 12:33:48.000000000 -0300
@@ -43,6 +43,14 @@
 #define pca_wait(adap) adap->wait_for_completion(adap->data)
 #define pca_reset(adap) adap->reset_chip(adap->data)
 
+static void pca9665_reset(void *pd)
+{
+	struct i2c_algo_pca_data *adap = pd;
+	pca_outw(adap, I2C_PCA_INDPTR, I2C_PCA_IPRESET);
+	pca_outw(adap, I2C_PCA_IND, 0xA5);
+	pca_outw(adap, I2C_PCA_IND, 0x5A);
+}
+
 /*
  * Generate a start condition on the i2c bus.
  *
@@ -332,24 +340,140 @@
 
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
+	if (pca_data->i2c_chip_type > I2C_PCA_CHIP_9665) {
+		printk(KERN_WARNING "%s: Invalid chip selected."
+				"Assuming PCA9564.\n", adap->name);
+		pca_data->i2c_chip_type = I2C_PCA_CHIP_9564;
 	}
 
-	adap->algo = &pca_algo;
+	if (pca_data->i2c_chip_type == I2C_PCA_CHIP_9564) {
+		static int freqs[] = {330, 288, 217, 146, 88, 59, 44, 36};
+		int clock;
+
+		if (pca_data->i2c_clock > 7) {
+			switch (pca_data->i2c_clock) {
+			case 330000:
+				pca_data->i2c_clock = I2C_PCA_CON_330kHz;
+				break;
+			case 288000:
+				pca_data->i2c_clock = I2C_PCA_CON_288kHz;
+				break;
+			case 217000:
+				pca_data->i2c_clock = I2C_PCA_CON_217kHz;
+				break;
+			case 146000:
+				pca_data->i2c_clock = I2C_PCA_CON_146kHz;
+				break;
+			case 88000:
+				pca_data->i2c_clock = I2C_PCA_CON_88kHz;
+				break;
+			case 59000:
+				pca_data->i2c_clock = I2C_PCA_CON_59kHz;
+				break;
+			case 44000:
+				pca_data->i2c_clock = I2C_PCA_CON_44kHz;
+				break;
+			case 36000:
+				pca_data->i2c_clock = I2C_PCA_CON_36kHz;
+				break;
+			default:
+				printk(KERN_WARNING
+					"%s: Invalid I2C clock speed selected."
+					"Trying default.\n", adap->name);
+			pca_data->i2c_clock = I2C_PCA_CON_59kHz;
+			}
+		} else {
+			printk(KERN_WARNING "%s: "
+				"Choosing the clock frequency based on "
+				"index is deprecated."
+				" Use the nominal frequency.\n", adap->name);
+		}
+
+		pca_reset(pca_data);
+
+		clock = pca_clock(pca_data);
+		DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n",
+		     adap->name, freqs[clock]);
+
+		pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
+	} else {
+		int clock;
+		int mode;
+		int tlow, thigh;
+		int min_tlow, min_thigh;
+		int raise_fall_time;
+
+		struct i2c_algo_pca_data *pca_data = adap->algo_data;
+
+		/* Ignore the reset function from the module,
+		 * we can use the parallel bus reset
+		 */
+		pca_data->reset_chip = pca9665_reset;
+
+		if (pca_data->i2c_clock > 1265800) {
+			printk(KERN_WARNING "%s: I2C clock speed too high."
+				" Using 1265.8kHz.\n", adap->name);
+			pca_data->i2c_clock = 1265800;
+		}
+
+		if (pca_data->i2c_clock < 60300) {
+			printk(KERN_WARNING "%s: I2C clock speed too low."
+				" Using 60.3kHz.\n", adap->name);
+			pca_data->i2c_clock = 60300;
+		}
+
+		clock = pca_clock(pca_data)/100; /* Hz*100 */
 
-	pca_reset(pca_data);
 
-	clock = pca_clock(pca_data);
-	DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[clock]);
+		if (pca_data->i2c_clock > 10000) {
+			mode = I2C_PCA_MODE_TURBO;
+			min_tlow = 14;
+			min_thigh  = 5;
+			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
+		} else if (pca_data->i2c_clock > 4000) {
+			mode = I2C_PCA_MODE_FASTP;
+			min_tlow = 17;
+			min_thigh  = 9;
+			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
+		} else if (pca_data->i2c_clock > 1000) {
+			mode = I2C_PCA_MODE_FAST;
+			min_tlow = 44;
+			min_thigh  = 20;
+			raise_fall_time = 58; /* Raise 29e-8s, Fall 29e-8s */
+		} else {
+			mode = I2C_PCA_MODE_STD;
+			min_tlow = 157;
+			min_thigh  = 134;
+			raise_fall_time = 127; /* Raise 29e-8s, Fall 98e-8s */
+		}
+
+		if (clock < 648) {
+			tlow = 255;
+			thigh = (1000000-clock*raise_fall_time)/(3*clock)-tlow;
+		} else {
+			tlow = ((1000000-clock*raise_fall_time)*min_tlow);
+			tlow /= (3*clock*(min_thigh+min_tlow));
+			thigh = tlow*min_thigh/min_tlow;
+		}
+
+		pca_reset(pca_data);
 
-	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
+		DEB1(KERN_INFO
+		     "%s: Clock frequency is %dHz\n", adap->name, clock*100);
+
+		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IMODE);
+		pca_outw(pca_data, I2C_PCA_IND, mode);
+		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLL);
+		pca_outw(pca_data, I2C_PCA_IND, tlow);
+		pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_ISCLH);
+		pca_outw(pca_data, I2C_PCA_IND, thigh);
+
+		pca_set_con(pca_data, I2C_PCA_CON_ENSIO);
+	}
 	udelay(500); /* 500 us for oscilator to stabilise */
 
 	return 0;
@@ -384,7 +508,7 @@
 
 MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, "
 	"Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
-MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
+MODULE_DESCRIPTION("I2C-Bus PCA9564/PCA9665 algorithm");
 MODULE_LICENSE("GPL");
 
 module_param(i2c_debug, int, 0);
diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-isa.c linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-isa.c
--- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-isa.c	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-isa.c	2008-09-19 12:27:51.000000000 -0300
@@ -41,7 +41,8 @@
 
 /* Data sheet recommends 59kHz for 100kHz operation due to variation
  * in the actual clock rate */
-static int clock  = I2C_PCA_CON_59kHz;
+static int clock  = 59000;
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
@@ -191,7 +193,15 @@
 module_param(irq, int, 0);
 MODULE_PARM_DESC(irq, "IRQ");
 module_param(clock, int, 0);
-MODULE_PARM_DESC(clock, "Clock rate as described in table 1 of PCA9564 datasheet");
+MODULE_PARM_DESC(clock, "Clock rate in hertz.\n\t\t"
+		"For PCA9564: 330000,288000,217000,146000,"
+		"88000,59000,44000,36000\n"
+		"\t\tFor PCA9665:\tStandard: 60300 - 100099\n"
+		"\t\t\t\tFast: 100100 - 400099\n"
+		"\t\t\t\tFast+: 400100 - 10000099\n"
+		"\t\t\t\tTurbo: Up to 1265800");
+module_param(chip, int, 0);
+MODULE_PARM_DESC(chip, "Chip type: 0 = PCA9564; 1 - PCA9665");
 
 module_init(pca_isa_init);
 module_exit(pca_isa_exit);
diff -ur linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-platform.c
--- linux-2.6.26.5/drivers/i2c/busses/i2c-pca-platform.c	2008-09-08 14:40:20.000000000 -0300
+++ linux-2.6.26.5-new/drivers/i2c/busses/i2c-pca-platform.c	2008-09-19 12:28:36.000000000 -0300
@@ -172,8 +172,9 @@
 
 	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
 	i2c->adap.owner = THIS_MODULE;
-	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
-		(unsigned long) res->start);
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
+		 "PCA9564/PCA9665 at 0x%08lx",
+		 (unsigned long) res->start);
 	i2c->adap.algo_data = &i2c->algo_data;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.timeout = platform_data->timeout;
@@ -246,7 +247,7 @@
 e_alloc:
 	release_mem_region(res->start, res_len(res));
 e_print:
-	printk(KERN_ERR "Registering PCA9564 FAILED! (%d)\n", ret);
+	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
 	return ret;
 }
 
@@ -290,7 +291,7 @@
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

--------------090101000306020705030301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------090101000306020705030301--
