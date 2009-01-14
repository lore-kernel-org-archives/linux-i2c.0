From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Delete many unused adapter IDs
Date: Wed, 14 Jan 2009 16:26:34 +0100
Message-ID: <20090114162634.1055c062@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/gpu/drm/i915/intel_i2c.c       |    4 --
 drivers/i2c/busses/i2c-acorn.c         |    1 
 drivers/i2c/busses/i2c-ali1535.c       |    1 
 drivers/i2c/busses/i2c-ali1563.c       |    1 
 drivers/i2c/busses/i2c-ali15x3.c       |    1 
 drivers/i2c/busses/i2c-amd756.c        |    1 
 drivers/i2c/busses/i2c-amd8111.c       |    1 
 drivers/i2c/busses/i2c-au1550.c        |    1 
 drivers/i2c/busses/i2c-bfin-twi.c      |    1 
 drivers/i2c/busses/i2c-elektor.c       |    1 
 drivers/i2c/busses/i2c-hydra.c         |    1 
 drivers/i2c/busses/i2c-i801.c          |    1 
 drivers/i2c/busses/i2c-ibm_iic.c       |    1 
 drivers/i2c/busses/i2c-iop3xx.c        |    1 
 drivers/i2c/busses/i2c-ixp2000.c       |    1 
 drivers/i2c/busses/i2c-mpc.c           |    1 
 drivers/i2c/busses/i2c-mv64xxx.c       |    1 
 drivers/i2c/busses/i2c-nforce2.c       |    1 
 drivers/i2c/busses/i2c-parport-light.c |    1 
 drivers/i2c/busses/i2c-parport.c       |    1 
 drivers/i2c/busses/i2c-pca-isa.c       |    1 
 drivers/i2c/busses/i2c-piix4.c         |    1 
 drivers/i2c/busses/i2c-sibyte.c        |    2 -
 drivers/i2c/busses/i2c-sis5595.c       |    1 
 drivers/i2c/busses/i2c-sis630.c        |    1 
 drivers/i2c/busses/i2c-sis96x.c        |    1 
 drivers/i2c/busses/i2c-via.c           |    1 
 drivers/i2c/busses/i2c-viapro.c        |    1 
 drivers/i2c/busses/i2c-voodoo3.c       |    2 -
 drivers/i2c/busses/scx200_acb.c        |    1 
 drivers/i2c/busses/scx200_i2c.c        |    1 
 drivers/ieee1394/pcilynx.c             |    1 
 drivers/video/aty/radeon_i2c.c         |    1 
 drivers/video/i810/i810-i2c.c          |    1 
 drivers/video/intelfb/intelfb_i2c.c    |    1 
 drivers/video/nvidia/nv_i2c.c          |    1 
 drivers/video/savage/savagefb-i2c.c    |    1 
 include/linux/i2c-id.h                 |   51 --------------------------------
 38 files changed, 93 deletions(-)

--- linux-2.6.29-rc1.orig/drivers/gpu/drm/i915/intel_i2c.c	2009-01-11 10:57:17.000000000 +0100
+++ linux-2.6.29-rc1/drivers/gpu/drm/i915/intel_i2c.c	2009-01-14 11:09:20.000000000 +0100
@@ -137,10 +137,6 @@ struct intel_i2c_chan *intel_i2c_create(
 	chan->reg = reg;
 	snprintf(chan->adapter.name, I2C_NAME_SIZE, "intel drm %s", name);
 	chan->adapter.owner = THIS_MODULE;
-#ifndef I2C_HW_B_INTELFB
-#define I2C_HW_B_INTELFB I2C_HW_B_I810
-#endif
-	chan->adapter.id = I2C_HW_B_INTELFB;
 	chan->adapter.algo_data	= &chan->algo;
 	chan->adapter.dev.parent = &dev->pdev->dev;
 	chan->algo.setsda = set_data;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-acorn.c	2009-01-14 08:32:43.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-acorn.c	2009-01-14 08:32:57.000000000 +0100
@@ -83,7 +83,6 @@ static struct i2c_algo_bit_data ioc_data
 };
 
 static struct i2c_adapter ioc_ops = {
-	.id			= I2C_HW_B_IOC,
 	.algo_data		= &ioc_data,
 };
 
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-ali1535.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-ali1535.c	2009-01-14 10:50:22.000000000 +0100
@@ -476,7 +476,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_ALI1535,
 	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-ali1563.c	2009-01-11 10:57:18.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-ali1563.c	2009-01-14 10:52:44.000000000 +0100
@@ -386,7 +386,6 @@ static const struct i2c_algorithm ali156
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.id	= I2C_HW_SMBUS_ALI1563,
 	.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo	= &ali1563_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-ali15x3.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-ali15x3.c	2009-01-14 10:13:04.000000000 +0100
@@ -473,7 +473,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_ALI15X3,
 	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-amd756.c	2009-01-11 10:57:18.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-amd756.c	2009-01-14 10:14:33.000000000 +0100
@@ -298,7 +298,6 @@ static const struct i2c_algorithm smbus_
 
 struct i2c_adapter amd756_smbus = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_AMD756,
 	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-amd8111.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-amd8111.c	2009-01-14 10:51:32.000000000 +0100
@@ -387,7 +387,6 @@ static int __devinit amd8111_probe(struc
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, sizeof(smbus->adapter.name),
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
-	smbus->adapter.id = I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-au1550.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-au1550.c	2009-01-14 09:57:55.000000000 +0100
@@ -400,7 +400,6 @@ i2c_au1550_probe(struct platform_device
 	priv->xfer_timeout = 200;
 	priv->ack_timeout = 200;
 
-	priv->adap.id = I2C_HW_AU1550_PSC;
 	priv->adap.nr = pdev->id;
 	priv->adap.algo = &au1550_algo;
 	priv->adap.algo_data = priv;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-bfin-twi.c	2009-01-11 10:57:18.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-bfin-twi.c	2009-01-14 10:54:17.000000000 +0100
@@ -651,7 +651,6 @@ static int i2c_bfin_twi_probe(struct pla
 	iface->timeout_timer.data = (unsigned long)iface;
 
 	p_adap = &iface->adap;
-	p_adap->id = I2C_HW_BLACKFIN;
 	p_adap->nr = pdev->id;
 	strlcpy(p_adap->name, pdev->name, sizeof(p_adap->name));
 	p_adap->algo = &bfin_twi_algorithm;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-elektor.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-elektor.c	2009-01-14 09:54:21.000000000 +0100
@@ -202,7 +202,6 @@ static struct i2c_algo_pcf_data pcf_isa_
 static struct i2c_adapter pcf_isa_ops = {
 	.owner		= THIS_MODULE,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.id		= I2C_HW_P_ELEK,
 	.algo_data	= &pcf_isa_data,
 	.name		= "i2c-elektor",
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-hydra.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-hydra.c	2009-01-14 08:15:34.000000000 +0100
@@ -102,7 +102,6 @@ static struct i2c_algo_bit_data hydra_bi
 static struct i2c_adapter hydra_adap = {
 	.owner		= THIS_MODULE,
 	.name		= "Hydra i2c",
-	.id		= I2C_HW_B_HYDRA,
 	.algo_data	= &hydra_bit_data,
 };
 
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-i801.c	2009-01-11 10:57:18.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-i801.c	2009-01-14 10:13:58.000000000 +0100
@@ -556,7 +556,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_I801,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-ibm_iic.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-ibm_iic.c	2009-01-14 09:55:57.000000000 +0100
@@ -746,7 +746,6 @@ static int __devinit iic_probe(struct of
 	adap->dev.parent = &ofdev->dev;
 	strlcpy(adap->name, "IBM IIC", sizeof(adap->name));
 	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_HW_OCP;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo = &iic_algo;
 	adap->timeout = 1;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-iop3xx.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-iop3xx.c	2009-01-14 09:57:09.000000000 +0100
@@ -480,7 +480,6 @@ iop3xx_i2c_probe(struct platform_device
 	}
 
 	memcpy(new_adapter->name, pdev->name, strlen(pdev->name));
-	new_adapter->id = I2C_HW_IOP3XX;
 	new_adapter->owner = THIS_MODULE;
 	new_adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	new_adapter->dev.parent = &pdev->dev;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-ixp2000.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-ixp2000.c	2009-01-14 08:19:11.000000000 +0100
@@ -116,7 +116,6 @@ static int ixp2000_i2c_probe(struct plat
 	drv_data->algo_data.udelay = 6;
 	drv_data->algo_data.timeout = 100;
 
-	drv_data->adapter.id = I2C_HW_B_IXP2000,
 	strlcpy(drv_data->adapter.name, plat_dev->dev.driver->name,
 		sizeof(drv_data->adapter.name));
 	drv_data->adapter.algo_data = &drv_data->algo_data,
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-mpc.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-mpc.c	2009-01-14 10:53:16.000000000 +0100
@@ -310,7 +310,6 @@ static const struct i2c_algorithm mpc_al
 static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
 	.name = "MPC adapter",
-	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
 	.timeout = 1,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-mv64xxx.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-mv64xxx.c	2009-01-14 10:53:52.000000000 +0100
@@ -527,7 +527,6 @@ mv64xxx_i2c_probe(struct platform_device
 		goto exit_unmap_regs;
 	}
 	drv_data->adapter.dev.parent = &pd->dev;
-	drv_data->adapter.id = I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
 	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-nforce2.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-nforce2.c	2009-01-14 10:52:21.000000000 +0100
@@ -355,7 +355,6 @@ static int __devinit nforce2_probe_smb (
 		return -EBUSY;
 	}
 	smbus->adapter.owner = THIS_MODULE;
-	smbus->adapter.id = I2C_HW_SMBUS_NFORCE2;
 	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-parport-light.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-parport-light.c	2009-01-14 11:07:30.000000000 +0100
@@ -115,7 +115,6 @@ static struct i2c_algo_bit_data parport_
 static struct i2c_adapter parport_adapter = {
 	.owner		= THIS_MODULE,
 	.class		= I2C_CLASS_HWMON,
-	.id		= I2C_HW_B_LP,
 	.algo_data	= &parport_algo_data,
 	.name		= "Parallel port adapter (light)",
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-parport.c	2009-01-12 18:43:22.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-parport.c	2009-01-14 11:07:26.000000000 +0100
@@ -164,7 +164,6 @@ static void i2c_parport_attach (struct p
 	/* Fill the rest of the structure */
 	adapter->adapter.owner = THIS_MODULE;
 	adapter->adapter.class = I2C_CLASS_HWMON;
-	adapter->adapter.id = I2C_HW_B_LP;
 	strlcpy(adapter->adapter.name, "Parallel port adapter",
 		sizeof(adapter->adapter.name));
 	adapter->algo_data = parport_algo_data;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-pca-isa.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-pca-isa.c	2009-01-14 09:54:50.000000000 +0100
@@ -101,7 +101,6 @@ static struct i2c_algo_pca_data pca_isa_
 
 static struct i2c_adapter pca_isa_ops = {
 	.owner          = THIS_MODULE,
-	.id		= I2C_HW_A_ISA,
 	.algo_data	= &pca_isa_data,
 	.name		= "PCA9564 ISA Adapter",
 	.timeout	= 100,
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-piix4.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-piix4.c	2009-01-14 09:58:48.000000000 +0100
@@ -403,7 +403,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_PIIX4,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-sibyte.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-sibyte.c	2009-01-14 09:56:37.000000000 +0100
@@ -155,7 +155,6 @@ static struct i2c_algo_sibyte_data sibyt
 static struct i2c_adapter sibyte_board_adapter[2] = {
 	{
 		.owner		= THIS_MODULE,
-		.id		= I2C_HW_SIBYTE,
 		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 		.algo		= NULL,
 		.algo_data	= &sibyte_board_data[0],
@@ -164,7 +163,6 @@ static struct i2c_adapter sibyte_board_a
 	},
 	{
 		.owner		= THIS_MODULE,
-		.id		= I2C_HW_SIBYTE,
 		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 		.algo		= NULL,
 		.algo_data	= &sibyte_board_data[1],
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-sis5595.c	2009-01-11 10:57:19.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-sis5595.c	2009-01-14 10:50:03.000000000 +0100
@@ -365,7 +365,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_SIS5595,
 	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-sis630.c	2009-01-11 10:57:19.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-sis630.c	2009-01-14 10:50:59.000000000 +0100
@@ -464,7 +464,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_SIS630,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-sis96x.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-sis96x.c	2009-01-14 10:51:03.000000000 +0100
@@ -241,7 +241,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_SIS96X,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-via.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-via.c	2009-01-14 08:14:57.000000000 +0100
@@ -83,7 +83,6 @@ static struct i2c_algo_bit_data bit_data
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_VIA,
 	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-viapro.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-viapro.c	2009-01-14 10:13:29.000000000 +0100
@@ -321,7 +321,6 @@ static const struct i2c_algorithm smbus_
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_SMBUS_VIA2,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &smbus_algorithm,
 };
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/i2c-voodoo3.c	2009-01-14 08:28:55.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/i2c-voodoo3.c	2009-01-14 08:29:06.000000000 +0100
@@ -163,7 +163,6 @@ static struct i2c_algo_bit_data voo_i2c_
 
 static struct i2c_adapter voodoo3_i2c_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_VOO,
 	.class		= I2C_CLASS_TV_ANALOG, 
 	.name		= "I2C Voodoo3/Banshee adapter",
 	.algo_data	= &voo_i2c_bit_data,
@@ -180,7 +179,6 @@ static struct i2c_algo_bit_data voo_ddc_
 
 static struct i2c_adapter voodoo3_ddc_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_VOO,
 	.class		= I2C_CLASS_DDC, 
 	.name		= "DDC Voodoo3/Banshee adapter",
 	.algo_data	= &voo_ddc_bit_data,
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/scx200_acb.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/scx200_acb.c	2009-01-14 10:52:00.000000000 +0100
@@ -440,7 +440,6 @@ static __init struct scx200_acb_iface *s
 	i2c_set_adapdata(adapter, iface);
 	snprintf(adapter->name, sizeof(adapter->name), "%s ACB%d", text, index);
 	adapter->owner = THIS_MODULE;
-	adapter->id = I2C_HW_SMBUS_SCX200;
 	adapter->algo = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adapter->dev.parent = dev;
--- linux-2.6.29-rc1.orig/drivers/i2c/busses/scx200_i2c.c	2009-01-14 08:31:06.000000000 +0100
+++ linux-2.6.29-rc1/drivers/i2c/busses/scx200_i2c.c	2009-01-14 08:31:16.000000000 +0100
@@ -82,7 +82,6 @@ static struct i2c_algo_bit_data scx200_i
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
 	.class             = I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.id		   = I2C_HW_B_SCX200,
 	.algo_data	   = &scx200_i2c_data,
 	.name	= "NatSemi SCx200 I2C",
 };
--- linux-2.6.29-rc1.orig/drivers/ieee1394/pcilynx.c	2009-01-11 10:57:20.000000000 +0100
+++ linux-2.6.29-rc1/drivers/ieee1394/pcilynx.c	2009-01-14 09:51:31.000000000 +0100
@@ -1419,7 +1419,6 @@ static int __devinit add_card(struct pci
 		i2c_ad = kzalloc(sizeof(*i2c_ad), GFP_KERNEL);
         	if (!i2c_ad) FAIL("failed to allocate I2C adapter memory");
 
-		i2c_ad->id = I2C_HW_B_PCILYNX;
 		strlcpy(i2c_ad->name, "PCILynx I2C", sizeof(i2c_ad->name));
                 i2c_adapter_data = bit_data;
                 i2c_ad->algo_data = &i2c_adapter_data;
--- linux-2.6.29-rc1.orig/drivers/video/aty/radeon_i2c.c	2009-01-06 20:25:15.000000000 +0100
+++ linux-2.6.29-rc1/drivers/video/aty/radeon_i2c.c	2009-01-14 09:53:30.000000000 +0100
@@ -72,7 +72,6 @@ static int radeon_setup_i2c_bus(struct r
 	snprintf(chan->adapter.name, sizeof(chan->adapter.name),
 		 "radeonfb %s", name);
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_HW_B_RADEON;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
 	chan->algo.setsda		= radeon_gpio_setsda;
--- linux-2.6.29-rc1.orig/drivers/video/i810/i810-i2c.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc1/drivers/video/i810/i810-i2c.c	2009-01-14 11:09:43.000000000 +0100
@@ -90,7 +90,6 @@ static int i810_setup_i2c_bus(struct i81
         chan->adapter.owner             = THIS_MODULE;
         chan->adapter.algo_data         = &chan->algo;
         chan->adapter.dev.parent        = &chan->par->dev->dev;
-	chan->adapter.id                = I2C_HW_B_I810;
 	chan->algo.setsda               = i810i2c_setsda;
 	chan->algo.setscl               = i810i2c_setscl;
 	chan->algo.getsda               = i810i2c_getsda;
--- linux-2.6.29-rc1.orig/drivers/video/intelfb/intelfb_i2c.c	2009-01-06 20:25:15.000000000 +0100
+++ linux-2.6.29-rc1/drivers/video/intelfb/intelfb_i2c.c	2009-01-14 11:09:28.000000000 +0100
@@ -111,7 +111,6 @@ static int intelfb_setup_i2c_bus(struct
 		 "intelfb %s", name);
 	chan->adapter.class		= class;
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_HW_B_INTELFB;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->dinfo->pdev->dev;
 	chan->algo.setsda		= intelfb_gpio_setsda;
--- linux-2.6.29-rc1.orig/drivers/video/nvidia/nv_i2c.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc1/drivers/video/nvidia/nv_i2c.c	2009-01-14 09:52:05.000000000 +0100
@@ -87,7 +87,6 @@ static int nvidia_setup_i2c_bus(struct n
 
 	strcpy(chan->adapter.name, name);
 	chan->adapter.owner = THIS_MODULE;
-	chan->adapter.id = I2C_HW_B_NVIDIA;
 	chan->adapter.class = i2c_class;
 	chan->adapter.algo_data = &chan->algo;
 	chan->adapter.dev.parent = &chan->par->pci_dev->dev;
--- linux-2.6.29-rc1.orig/drivers/video/savage/savagefb-i2c.c	2009-01-06 20:15:01.000000000 +0100
+++ linux-2.6.29-rc1/drivers/video/savage/savagefb-i2c.c	2009-01-14 09:52:32.000000000 +0100
@@ -137,7 +137,6 @@ static int savage_setup_i2c_bus(struct s
 	if (chan->par) {
 		strcpy(chan->adapter.name, name);
 		chan->adapter.owner		= THIS_MODULE;
-		chan->adapter.id		= I2C_HW_B_SAVAGE;
 		chan->adapter.algo_data		= &chan->algo;
 		chan->adapter.dev.parent	= &chan->par->pcidev->dev;
 		chan->algo.udelay		= 10;
--- linux-2.6.29-rc1.orig/include/linux/i2c-id.h	2009-01-13 17:09:20.000000000 +0100
+++ linux-2.6.29-rc1/include/linux/i2c-id.h	2009-01-14 11:09:02.000000000 +0100
@@ -79,74 +79,23 @@
  */
 
 /* --- Bit algorithm adapters						*/
-#define I2C_HW_B_LP		0x010000 /* Parallel port Philips style */
 #define I2C_HW_B_BT848		0x010005 /* BT848 video boards */
-#define I2C_HW_B_VIA		0x010007 /* Via vt82c586b */
-#define I2C_HW_B_HYDRA		0x010008 /* Apple Hydra Mac I/O */
-#define I2C_HW_B_I810		0x01000a /* Intel I810 */
-#define I2C_HW_B_VOO		0x01000b /* 3dfx Voodoo 3 / Banshee */
-#define I2C_HW_B_SCX200		0x01000e /* Nat'l Semi SCx200 I2C */
 #define I2C_HW_B_RIVA		0x010010 /* Riva based graphics cards */
-#define I2C_HW_B_IOC		0x010011 /* IOC bit-wiggling */
-#define I2C_HW_B_IXP2000	0x010016 /* GPIO on IXP2000 systems */
 #define I2C_HW_B_ZR36067	0x010019 /* Zoran-36057/36067 based boards */
-#define I2C_HW_B_PCILYNX	0x01001a /* TI PCILynx I2C adapter */
 #define I2C_HW_B_CX2388x	0x01001b /* connexant 2388x based tv cards */
-#define I2C_HW_B_NVIDIA		0x01001c /* nvidia framebuffer driver */
-#define I2C_HW_B_SAVAGE		0x01001d /* savage framebuffer driver */
-#define I2C_HW_B_RADEON		0x01001e /* radeon framebuffer driver */
 #define I2C_HW_B_EM28XX		0x01001f /* em28xx video capture cards */
 #define I2C_HW_B_CX2341X	0x010020 /* Conexant CX2341X MPEG encoder cards */
-#define I2C_HW_B_INTELFB	0x010021 /* intel framebuffer driver */
 #define I2C_HW_B_CX23885	0x010022 /* conexant 23885 based tv cards (bus1) */
 #define I2C_HW_B_AU0828		0x010023 /* auvitek au0828 usb bridge */
 
-/* --- PCF 8584 based algorithms					*/
-#define I2C_HW_P_ELEK		0x020002 /* Elektor ISA Bus inteface card */
-
-/* --- PCA 9564 based algorithms */
-#define I2C_HW_A_ISA		0x1a0000 /* generic ISA Bus interface card */
-
-/* --- PowerPC on-chip adapters						*/
-#define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
-
-/* --- Broadcom SiByte adapters						*/
-#define I2C_HW_SIBYTE		0x150000
-
 /* --- SGI adapters							*/
 #define I2C_HW_SGI_VINO		0x160000
 
-/* --- XSCALE on-chip adapters                          */
-#define I2C_HW_IOP3XX		0x140000
-
-/* --- Au1550 PSC adapters adapters					*/
-#define I2C_HW_AU1550_PSC	0x1b0000
-
 /* --- SMBus only adapters						*/
-#define I2C_HW_SMBUS_PIIX4	0x040000
-#define I2C_HW_SMBUS_ALI15X3	0x040001
-#define I2C_HW_SMBUS_VIA2	0x040002
-#define I2C_HW_SMBUS_I801	0x040004
-#define I2C_HW_SMBUS_AMD756	0x040005
-#define I2C_HW_SMBUS_SIS5595	0x040006
-#define I2C_HW_SMBUS_ALI1535	0x040007
-#define I2C_HW_SMBUS_SIS630	0x040008
-#define I2C_HW_SMBUS_SIS96X	0x040009
-#define I2C_HW_SMBUS_AMD8111	0x04000a
-#define I2C_HW_SMBUS_SCX200	0x04000b
-#define I2C_HW_SMBUS_NFORCE2	0x04000c
 #define I2C_HW_SMBUS_W9968CF	0x04000d
 #define I2C_HW_SMBUS_OV511	0x04000e /* OV511(+) USB 1.1 webcam ICs */
 #define I2C_HW_SMBUS_OV518	0x04000f /* OV518(+) USB 1.1 webcam ICs */
 #define I2C_HW_SMBUS_CAFE	0x040012 /* Marvell 88ALP01 "CAFE" cam  */
-#define I2C_HW_SMBUS_ALI1563	0x040013
-
-/* --- MCP107 adapter */
-#define I2C_HW_MPC107		0x0d0000
-
-/* --- Embedded adapters */
-#define I2C_HW_MV64XXX		0x190000
-#define I2C_HW_BLACKFIN		0x190001 /* ADI Blackfin I2C TWI driver */
 
 /* --- Miscellaneous adapters */
 #define I2C_HW_SAA7146		0x060000 /* SAA7146 video decoder bus */


-- 
Jean Delvare
