From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Tue, 3 Jun 2008 13:02:21 +0200
Message-ID: <20080603130221.1f819e64@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Let general purpose I2C/SMBus bus drivers add SPD to their class. Once
this is done, we will be able to tell the eeprom driver to only probe
for SPD EEPROMs and similar on these buses.

Note that I took a conservative approach here, adding I2C_CLASS_SPD to
all drivers that had I2C_CLASS_HWMON before. This is to make sure that
the eeprom driver doesn't stop probing buses where SPD EEPROMs live.
But the truth is that, for most of these, I simply have no idea whether
they can host SPD EEPROMs or not. So, bus driver maintainers and users
should feel free to remove the SPD class from drivers those buses never
have SPD EEPROMs or they don't want the eeprom driver to bind to them.
Likewise, feel free to add the SPD class to any bus driver I might have
missed.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-ali1535.c       |    2 +-
 drivers/i2c/busses/i2c-ali1563.c       |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c       |    2 +-
 drivers/i2c/busses/i2c-amd756.c        |    2 +-
 drivers/i2c/busses/i2c-amd8111.c       |    2 +-
 drivers/i2c/busses/i2c-at91.c          |    2 +-
 drivers/i2c/busses/i2c-cpm.c           |    2 +-
 drivers/i2c/busses/i2c-davinci.c       |    2 +-
 drivers/i2c/busses/i2c-elektor.c       |    2 +-
 drivers/i2c/busses/i2c-gpio.c          |    2 +-
 drivers/i2c/busses/i2c-i801.c          |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c       |    4 ++--
 drivers/i2c/busses/i2c-iop3xx.c        |    2 +-
 drivers/i2c/busses/i2c-isch.c          |    2 +-
 drivers/i2c/busses/i2c-mpc.c           |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c       |    2 +-
 drivers/i2c/busses/i2c-nforce2.c       |    2 +-
 drivers/i2c/busses/i2c-ocores.c        |    2 +-
 drivers/i2c/busses/i2c-omap.c          |    2 +-
 drivers/i2c/busses/i2c-parport-light.c |    2 +-
 drivers/i2c/busses/i2c-parport.c       |    2 +-
 drivers/i2c/busses/i2c-pasemi.c        |    2 +-
 drivers/i2c/busses/i2c-piix4.c         |    2 +-
 drivers/i2c/busses/i2c-pmcmsp.c        |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c       |    2 +-
 drivers/i2c/busses/i2c-sibyte.c        |    4 ++--
 drivers/i2c/busses/i2c-sis5595.c       |    2 +-
 drivers/i2c/busses/i2c-sis630.c        |    2 +-
 drivers/i2c/busses/i2c-sis96x.c        |    2 +-
 drivers/i2c/busses/i2c-stub.c          |    2 +-
 drivers/i2c/busses/i2c-tiny-usb.c      |    2 +-
 drivers/i2c/busses/i2c-via.c           |    2 +-
 drivers/i2c/busses/i2c-viapro.c        |    2 +-
 drivers/i2c/busses/scx200_acb.c        |    2 +-
 include/linux/i2c.h                    |    1 +
 35 files changed, 37 insertions(+), 36 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-ali1535.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-ali1535.c	2008-06-03 10:28:35.000000000 +0200
@@ -479,7 +479,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_ALI1535,
-	.class          = I2C_CLASS_HWMON,
+	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-ali1563.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-ali1563.c	2008-06-03 10:28:35.000000000 +0200
@@ -387,7 +387,7 @@ static const struct i2c_algorithm ali156
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
 	.id	= I2C_HW_SMBUS_ALI1563,
-	.class	= I2C_CLASS_HWMON,
+	.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo	= &ali1563_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-ali15x3.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-ali15x3.c	2008-06-03 10:28:35.000000000 +0200
@@ -476,7 +476,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_ALI15X3,
-	.class          = I2C_CLASS_HWMON,
+	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-amd756.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-amd756.c	2008-06-03 10:28:35.000000000 +0200
@@ -302,7 +302,7 @@ static const struct i2c_algorithm smbus_
 struct i2c_adapter amd756_smbus = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_AMD756,
-	.class          = I2C_CLASS_HWMON,
+	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-amd8111.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-amd8111.c	2008-06-03 10:28:35.000000000 +0200
@@ -388,7 +388,7 @@ static int __devinit amd8111_probe(struc
 	snprintf(smbus->adapter.name, sizeof(smbus->adapter.name),
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_HW_SMBUS_AMD8111;
-	smbus->adapter.class = I2C_CLASS_HWMON;
+	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-at91.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-at91.c	2008-06-03 10:28:35.000000000 +0200
@@ -225,7 +225,7 @@ static int __devinit at91_i2c_probe(stru
 	}
 	sprintf(adapter->name, "AT91");
 	adapter->algo = &at91_algorithm;
-	adapter->class = I2C_CLASS_HWMON;
+	adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adapter->dev.parent = &pdev->dev;
 	/* adapter->id == 0 ... only one TWI controller for now */
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-cpm.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-cpm.c	2008-06-03 10:28:35.000000000 +0200
@@ -423,7 +423,7 @@ static const struct i2c_adapter cpm_ops 
 	.owner		= THIS_MODULE,
 	.name		= "i2c-cpm",
 	.algo		= &cpm_i2c_algo,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 };
 
 static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-davinci.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-davinci.c	2008-06-03 10:28:35.000000000 +0200
@@ -543,7 +543,7 @@ static int davinci_i2c_probe(struct plat
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	strlcpy(adap->name, "DaVinci I2C adapter", sizeof(adap->name));
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-elektor.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-elektor.c	2008-06-03 10:28:35.000000000 +0200
@@ -202,7 +202,7 @@ static struct i2c_algo_pcf_data pcf_isa_
 
 static struct i2c_adapter pcf_isa_ops = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.id		= I2C_HW_P_ELEK,
 	.algo_data	= &pcf_isa_data,
 	.name		= "i2c-elektor",
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-gpio.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-gpio.c	2008-06-03 10:28:35.000000000 +0200
@@ -140,7 +140,7 @@ static int __init i2c_gpio_probe(struct 
 	adap->owner = THIS_MODULE;
 	snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
 	adap->algo_data = bit_data;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->dev.parent = &pdev->dev;
 
 	/*
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-i801.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-i801.c	2008-06-03 10:28:35.000000000 +0200
@@ -574,7 +574,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_I801,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-ibm_iic.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-ibm_iic.c	2008-06-03 10:28:35.000000000 +0200
@@ -740,7 +740,7 @@ static int __devinit iic_probe(struct oc
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;
@@ -934,7 +934,7 @@ static int __devinit iic_probe(struct of
 	strlcpy(adap->name, "IBM IIC", sizeof(adap->name));
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo = &iic_algo;
 	adap->timeout = 1;
 	adap->nr = dev->idx;
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-iop3xx.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-iop3xx.c	2008-06-03 10:28:35.000000000 +0200
@@ -482,7 +482,7 @@ iop3xx_i2c_probe(struct platform_device 
 	memcpy(new_adapter->name, pdev->name, strlen(pdev->name));
 	new_adapter->id = I2C_HW_IOP3XX;
 	new_adapter->owner = THIS_MODULE;
-	new_adapter->class = I2C_CLASS_HWMON;
+	new_adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	new_adapter->dev.parent = &pdev->dev;
 	new_adapter->nr = pdev->id;
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-isch.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-isch.c	2008-06-03 10:28:35.000000000 +0200
@@ -252,7 +252,7 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter sch_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-mpc.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-mpc.c	2008-06-03 10:28:35.000000000 +0200
@@ -311,7 +311,7 @@ static struct i2c_adapter mpc_ops = {
 	.name = "MPC adapter",
 	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
-	.class = I2C_CLASS_HWMON,
+	.class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.timeout = 1,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-mv64xxx.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-mv64xxx.c	2008-06-03 10:28:35.000000000 +0200
@@ -530,7 +530,7 @@ mv64xxx_i2c_probe(struct platform_device
 	drv_data->adapter.id = I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
-	drv_data->adapter.class = I2C_CLASS_HWMON;
+	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	drv_data->adapter.timeout = pdata->timeout;
 	drv_data->adapter.nr = pd->id;
 	platform_set_drvdata(pd, drv_data);
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-nforce2.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-nforce2.c	2008-06-03 10:28:35.000000000 +0200
@@ -356,7 +356,7 @@ static int __devinit nforce2_probe_smb (
 	}
 	smbus->adapter.owner = THIS_MODULE;
 	smbus->adapter.id = I2C_HW_SMBUS_NFORCE2;
-	smbus->adapter.class = I2C_CLASS_HWMON;
+	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 	smbus->adapter.dev.parent = &dev->dev;
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-ocores.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-ocores.c	2008-06-03 10:28:35.000000000 +0200
@@ -205,7 +205,7 @@ static const struct i2c_algorithm ocores
 static struct i2c_adapter ocores_adapter = {
 	.owner		= THIS_MODULE,
 	.name		= "i2c-ocores",
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &ocores_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-omap.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-omap.c	2008-06-03 10:28:35.000000000 +0200
@@ -617,7 +617,7 @@ omap_i2c_probe(struct platform_device *p
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-parport-light.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-parport-light.c	2008-06-03 10:28:35.000000000 +0200
@@ -114,7 +114,7 @@ static struct i2c_algo_bit_data parport_
 
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.id		= I2C_HW_B_LP,
 	.algo_data	= &parport_algo_data,
 	.name		= "Parallel port adapter (light)",
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-parport.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-parport.c	2008-06-03 10:28:36.000000000 +0200
@@ -163,7 +163,7 @@ static void i2c_parport_attach (struct p
 
 	/* Fill the rest of the structure */
 	adapter->adapter.owner = THIS_MODULE;
-	adapter->adapter.class = I2C_CLASS_HWMON;
+	adapter->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adapter->adapter.id = I2C_HW_B_LP;
 	strlcpy(adapter->adapter.name, "Parallel port adapter",
 		sizeof(adapter->adapter.name));
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-pasemi.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-pasemi.c	2008-06-03 10:28:36.000000000 +0200
@@ -365,7 +365,7 @@ static int __devinit pasemi_smb_probe(st
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, sizeof(smbus->adapter.name),
 		 "PA Semi SMBus adapter at 0x%lx", smbus->base);
-	smbus->adapter.class = I2C_CLASS_HWMON;
+	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 	smbus->adapter.nr = PCI_FUNC(dev->devfn);
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-piix4.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-piix4.c	2008-06-03 10:28:36.000000000 +0200
@@ -406,7 +406,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_PIIX4,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-pmcmsp.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-pmcmsp.c	2008-06-03 10:28:36.000000000 +0200
@@ -622,7 +622,7 @@ static struct i2c_algorithm pmcmsptwi_al
 
 static struct i2c_adapter pmcmsptwi_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &pmcmsptwi_algo,
 	.name		= DRV_NAME,
 };
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-s3c2410.c	2008-06-03 10:28:36.000000000 +0200
@@ -596,7 +596,7 @@ static struct s3c24xx_i2c s3c24xx_i2c = 
 		.owner			= THIS_MODULE,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
-		.class			= I2C_CLASS_HWMON,
+		.class			= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	},
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-sibyte.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-sibyte.c	2008-06-03 10:28:36.000000000 +0200
@@ -156,7 +156,7 @@ static struct i2c_adapter sibyte_board_a
 	{
 		.owner		= THIS_MODULE,
 		.id		= I2C_HW_SIBYTE,
-		.class		= I2C_CLASS_HWMON,
+		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 		.algo		= NULL,
 		.algo_data	= &sibyte_board_data[0],
 		.name		= "SiByte SMBus 0",
@@ -164,7 +164,7 @@ static struct i2c_adapter sibyte_board_a
 	{
 		.owner		= THIS_MODULE,
 		.id		= I2C_HW_SIBYTE,
-		.class		= I2C_CLASS_HWMON,
+		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 		.algo		= NULL,
 		.algo_data	= &sibyte_board_data[1],
 		.name		= "SiByte SMBus 1",
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-sis5595.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-sis5595.c	2008-06-03 10:28:36.000000000 +0200
@@ -368,7 +368,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_SIS5595,
-	.class          = I2C_CLASS_HWMON,
+	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-sis630.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-sis630.c	2008-06-03 10:28:36.000000000 +0200
@@ -468,7 +468,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_SIS630,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-sis96x.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-sis96x.c	2008-06-03 10:28:36.000000000 +0200
@@ -245,7 +245,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_SIS96X,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-stub.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-stub.c	2008-06-03 10:28:36.000000000 +0200
@@ -140,7 +140,7 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter stub_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 	.name		= "SMBus stub driver",
 };
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-tiny-usb.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-tiny-usb.c	2008-06-03 10:28:36.000000000 +0200
@@ -209,7 +209,7 @@ static int i2c_tiny_usb_probe(struct usb
 
 	/* setup i2c adapter description */
 	dev->adapter.owner = THIS_MODULE;
-	dev->adapter.class = I2C_CLASS_HWMON;
+	dev->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	dev->adapter.algo = &usb_algorithm;
 	dev->adapter.algo_data = dev;
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-via.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-via.c	2008-06-03 10:28:36.000000000 +0200
@@ -87,7 +87,7 @@ static struct i2c_algo_bit_data bit_data
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_B_VIA,
-	.class          = I2C_CLASS_HWMON,
+	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-viapro.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-viapro.c	2008-06-03 10:28:36.000000000 +0200
@@ -312,7 +312,7 @@ static const struct i2c_algorithm smbus_
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_SMBUS_VIA2,
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
 
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/scx200_acb.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/busses/scx200_acb.c	2008-06-03 10:28:36.000000000 +0200
@@ -442,7 +442,7 @@ static __init struct scx200_acb_iface *s
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_HW_SMBUS_SCX200;
 	adapter->algo = &scx200_acb_algorithm;
-	adapter->class = I2C_CLASS_HWMON;
+	adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adapter->dev.parent = dev;
 
 	mutex_init(&iface->mutex);
--- linux-2.6.26-rc4.orig/include/linux/i2c.h	2008-06-03 10:03:37.000000000 +0200
+++ linux-2.6.26-rc4/include/linux/i2c.h	2008-06-03 10:32:20.000000000 +0200
@@ -353,6 +353,7 @@ static inline void i2c_set_adapdata (str
 #define I2C_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
 #define I2C_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
 #define I2C_CLASS_SOUND		(1<<6)	/* sound devices */
+#define I2C_CLASS_SPD		(1<<7)	/* SPD EEPROMs and similar */
 #define I2C_CLASS_ALL		(UINT_MAX) /* all of the above */
 
 /* i2c_client_address_data is the struct for holding default client


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
