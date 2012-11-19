From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=20413/493=5D=20misc=3A=20remove=20use=20of=20=5F=5Fdevexit?=
Date: Mon, 19 Nov 2012 13:26:02 -0500
Message-ID: <1353349642-3677-413-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>=20
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=20
Cc: Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>=20
Cc: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
---
 drivers/misc/ad525x_dpot-i2c.c         | 2 +-
 drivers/misc/ad525x_dpot-spi.c         | 2 +-
 drivers/misc/apds9802als.c             | 2 +-
 drivers/misc/apds990x.c                | 2 +-
 drivers/misc/atmel-ssc.c               | 2 +-
 drivers/misc/bh1770glc.c               | 2 +-
 drivers/misc/bh1780gli.c               | 2 +-
 drivers/misc/cb710/core.c              | 2 +-
 drivers/misc/eeprom/at24.c             | 2 +-
 drivers/misc/eeprom/at25.c             | 2 +-
 drivers/misc/eeprom/eeprom_93xx46.c    | 2 +-
 drivers/misc/fsa9480.c                 | 2 +-
 drivers/misc/ibmasm/module.c           | 2 +-
 drivers/misc/ioc4.c                    | 2 +-
 drivers/misc/isl29003.c                | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c | 2 +-
 drivers/misc/mei/main.c                | 2 +-
 drivers/misc/pch_phub.c                | 2 +-
 drivers/misc/phantom.c                 | 2 +-
 drivers/misc/pti.c                     | 2 +-
 drivers/misc/spear13xx_pcie_gadget.c   | 2 +-
 drivers/misc/ti_dac7512.c              | 2 +-
 drivers/misc/tsl2550.c                 | 2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-=
i2c.c
index c7bc84d..705b881 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -68,7 +68,7 @@ static int ad_dpot_i2c_probe(struct i2c_client *clien=
t,
 	return ad_dpot_probe(&client->dev, &bdata, id->driver_data, id->name)=
;
 }
=20
-static int __devexit ad_dpot_i2c_remove(struct i2c_client *client)
+static int ad_dpot_i2c_remove(struct i2c_client *client)
 {
 	return ad_dpot_remove(&client->dev);
 }
diff --git a/drivers/misc/ad525x_dpot-spi.c b/drivers/misc/ad525x_dpot-=
spi.c
index 240c598..9da04ede 100644
--- a/drivers/misc/ad525x_dpot-spi.c
+++ b/drivers/misc/ad525x_dpot-spi.c
@@ -87,7 +87,7 @@ static int ad_dpot_spi_probe(struct spi_device *spi)
 			     spi_get_device_id(spi)->name);
 }
=20
-static int __devexit ad_dpot_spi_remove(struct spi_device *spi)
+static int ad_dpot_spi_remove(struct spi_device *spi)
 {
 	return ad_dpot_remove(&spi->dev);
 }
diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index 77f7cdc..92fca41 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -254,7 +254,7 @@ als_error1:
 	return res;
 }
=20
-static int __devexit apds9802als_remove(struct i2c_client *client)
+static int apds9802als_remove(struct i2c_client *client)
 {
 	struct als_data *data =3D i2c_get_clientdata(client);
=20
diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index b2aaf3f0..0e67f82 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1181,7 +1181,7 @@ fail1:
 	return err;
 }
=20
-static int __devexit apds990x_remove(struct i2c_client *client)
+static int apds990x_remove(struct i2c_client *client)
 {
 	struct apds990x_chip *chip =3D i2c_get_clientdata(client);
=20
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index bce3676..96e6c5f 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -187,7 +187,7 @@ static int ssc_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int __devexit ssc_remove(struct platform_device *pdev)
+static int ssc_remove(struct platform_device *pdev)
 {
 	struct ssc_device *ssc =3D platform_get_drvdata(pdev);
=20
diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 003e8d9..2ed8fc3 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -1285,7 +1285,7 @@ fail1:
 	return err;
 }
=20
-static int __devexit bh1770_remove(struct i2c_client *client)
+static int bh1770_remove(struct i2c_client *client)
 {
 	struct bh1770_chip *chip =3D i2c_get_clientdata(client);
=20
diff --git a/drivers/misc/bh1780gli.c b/drivers/misc/bh1780gli.c
index 3004904..cf03d0a 100644
--- a/drivers/misc/bh1780gli.c
+++ b/drivers/misc/bh1780gli.c
@@ -185,7 +185,7 @@ err_op_failed:
 	return ret;
 }
=20
-static int __devexit bh1780_remove(struct i2c_client *client)
+static int bh1780_remove(struct i2c_client *client)
 {
 	struct bh1780_data *ddata;
=20
diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 4fc9c37..2e50f81 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -305,7 +305,7 @@ unreg_mmc:
 	return err;
 }
=20
-static void __devexit cb710_remove_one(struct pci_dev *pdev)
+static void cb710_remove_one(struct pci_dev *pdev)
 {
 	struct cb710_chip *chip =3D pci_get_drvdata(pdev);
 	unsigned long flags;
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 3c36997..2baeec5 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -656,7 +656,7 @@ err_out:
 	return err;
 }
=20
-static int __devexit at24_remove(struct i2c_client *client)
+static int at24_remove(struct i2c_client *client)
 {
 	struct at24_data *at24;
 	int i;
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index fcb237e..b08cf8a 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -459,7 +459,7 @@ fail:
 	return err;
 }
=20
-static int __devexit at25_remove(struct spi_device *spi)
+static int at25_remove(struct spi_device *spi)
 {
 	struct at25_data	*at25;
=20
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/=
eeprom_93xx46.c
index 3dd9005..a6b5d5e 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -370,7 +370,7 @@ fail:
 	return err;
 }
=20
-static int __devexit eeprom_93xx46_remove(struct spi_device *spi)
+static int eeprom_93xx46_remove(struct spi_device *spi)
 {
 	struct eeprom_93xx46_dev *edev =3D dev_get_drvdata(&spi->dev);
=20
diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
index 2baa52f..e8cbb1c 100644
--- a/drivers/misc/fsa9480.c
+++ b/drivers/misc/fsa9480.c
@@ -462,7 +462,7 @@ fail1:
 	return ret;
 }
=20
-static int __devexit fsa9480_remove(struct i2c_client *client)
+static int fsa9480_remove(struct i2c_client *client)
 {
 	struct fsa9480_usbsw *usbsw =3D i2c_get_clientdata(client);
 	if (client->irq)
diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.=
c
index 380e429..0346d87 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -163,7 +163,7 @@ error_resources:
 	return result;
 }
=20
-static void __devexit ibmasm_remove_one(struct pci_dev *pdev)
+static void ibmasm_remove_one(struct pci_dev *pdev)
 {
 	struct service_processor *sp =3D (struct service_processor *)pci_get_=
drvdata(pdev);
=20
diff --git a/drivers/misc/ioc4.c b/drivers/misc/ioc4.c
index 3ef92dc..06f6ad2 100644
--- a/drivers/misc/ioc4.c
+++ b/drivers/misc/ioc4.c
@@ -415,7 +415,7 @@ out:
 }
=20
 /* Removes a particular instance of an IOC4 card. */
-static void __devexit
+static void
 ioc4_remove(struct pci_dev *pdev)
 {
 	struct ioc4_submodule *is;
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index 9fd4c0c..29b306c 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -401,7 +401,7 @@ exit_kfree:
 	return err;
 }
=20
-static int __devexit isl29003_remove(struct i2c_client *client)
+static int isl29003_remove(struct i2c_client *client)
 {
 	sysfs_remove_group(&client->dev.kobj, &isl29003_attr_group);
 	isl29003_set_power_state(client, 0);
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3=
lv02d/lis3lv02d_i2c.c
index 66f0483..7c97550 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -191,7 +191,7 @@ fail:
 	return ret;
 }
=20
-static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
+static int lis3lv02d_i2c_remove(struct i2c_client *client)
 {
 	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
 	struct lis3lv02d_platform_data *pdata =3D client->dev.platform_data;
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3=
lv02d/lis3lv02d_spi.c
index 66a751d..9aa2bd2 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -100,7 +100,7 @@ static int lis302dl_spi_probe(struct spi_device *sp=
i)
 	return lis3lv02d_init_device(&lis3_dev);
 }
=20
-static int __devexit lis302dl_spi_remove(struct spi_device *spi)
+static int lis302dl_spi_remove(struct spi_device *spi)
 {
 	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
 	lis3lv02d_joystick_disable(lis3);
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 3cca356..b07df4a 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -993,7 +993,7 @@ end:
  * mei_remove is called by the PCI subsystem to alert the driver
  * that it should release a PCI device.
  */
-static void __devexit mei_remove(struct pci_dev *pdev)
+static void mei_remove(struct pci_dev *pdev)
 {
 	struct mei_device *dev;
=20
diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 3896cff..931e635 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -819,7 +819,7 @@ err_pci_enable_dev:
 	return ret;
 }
=20
-static void __devexit pch_phub_remove(struct pci_dev *pdev)
+static void pch_phub_remove(struct pci_dev *pdev)
 {
 	struct pch_phub_reg *chip =3D pci_get_drvdata(pdev);
=20
diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index 0357763..68b7c77 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -435,7 +435,7 @@ err:
 	return retval;
 }
=20
-static void __devexit phantom_remove(struct pci_dev *pdev)
+static void phantom_remove(struct pci_dev *pdev)
 {
 	struct phantom_device *pht =3D pci_get_drvdata(pdev);
 	unsigned int minor =3D MINOR(pht->cdev.dev);
diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 37d4b5e..7003031 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -879,7 +879,7 @@ err:
  *		   PCI bus.
  * @pdev: variable containing pci info of PTI.
  */
-static void __devexit pti_pci_remove(struct pci_dev *pdev)
+static void pti_pci_remove(struct pci_dev *pdev)
 {
 	struct pti_dev *drv_data =3D pci_get_drvdata(pdev);
=20
diff --git a/drivers/misc/spear13xx_pcie_gadget.c b/drivers/misc/spear1=
3xx_pcie_gadget.c
index 7850320..7deb25d 100644
--- a/drivers/misc/spear13xx_pcie_gadget.c
+++ b/drivers/misc/spear13xx_pcie_gadget.c
@@ -853,7 +853,7 @@ err_rel_res0:
 	return status;
 }
=20
-static int __devexit spear_pcie_gadget_remove(struct platform_device *=
pdev)
+static int spear_pcie_gadget_remove(struct platform_device *pdev)
 {
 	struct resource *res0, *res1;
 	static struct pcie_gadget_target *target;
diff --git a/drivers/misc/ti_dac7512.c b/drivers/misc/ti_dac7512.c
index 1222f86..1d86407 100644
--- a/drivers/misc/ti_dac7512.c
+++ b/drivers/misc/ti_dac7512.c
@@ -67,7 +67,7 @@ static int dac7512_probe(struct spi_device *spi)
 	return sysfs_create_group(&spi->dev.kobj, &dac7512_attr_group);
 }
=20
-static int __devexit dac7512_remove(struct spi_device *spi)
+static int dac7512_remove(struct spi_device *spi)
 {
 	sysfs_remove_group(&spi->dev.kobj, &dac7512_attr_group);
 	return 0;
diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 18bce70..1e7bc0e 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -405,7 +405,7 @@ exit:
 	return err;
 }
=20
-static int __devexit tsl2550_remove(struct i2c_client *client)
+static int tsl2550_remove(struct i2c_client *client)
 {
 	sysfs_remove_group(&client->dev.kobj, &tsl2550_attr_group);
=20
--=20
1.8.0
