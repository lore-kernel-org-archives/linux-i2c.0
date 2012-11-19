From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=20134/493=5D=20drivers/misc=3A=20remove=20use=20of=20=5F=5Fdevexit=5Fp?=
Date: Mon, 19 Nov 2012 13:21:23 -0500
Message-ID: <1353349642-3677-134-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

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
 drivers/misc/bmp085-i2c.c              | 2 +-
 drivers/misc/bmp085-spi.c              | 2 +-
 drivers/misc/cb710/core.c              | 2 +-
 drivers/misc/eeprom/at24.c             | 2 +-
 drivers/misc/eeprom/at25.c             | 2 +-
 drivers/misc/eeprom/eeprom_93xx46.c    | 2 +-
 drivers/misc/fsa9480.c                 | 2 +-
 drivers/misc/hpilo.c                   | 2 +-
 drivers/misc/ibmasm/module.c           | 2 +-
 drivers/misc/ioc4.c                    | 2 +-
 drivers/misc/isl29003.c                | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c | 2 +-
 drivers/misc/pch_phub.c                | 2 +-
 drivers/misc/phantom.c                 | 2 +-
 drivers/misc/pti.c                     | 2 +-
 drivers/misc/ti_dac7512.c              | 2 +-
 drivers/misc/tsl2550.c                 | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-=
i2c.c
index 8208262..7254a98 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -109,7 +109,7 @@ static struct i2c_driver ad_dpot_i2c_driver =3D {
 		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D ad_dpot_i2c_probe,
-	.remove		=3D __devexit_p(ad_dpot_i2c_remove),
+	.remove		=3D ad_dpot_i2c_remove,
 	.id_table	=3D ad_dpot_id,
 };
=20
diff --git a/drivers/misc/ad525x_dpot-spi.c b/drivers/misc/ad525x_dpot-=
spi.c
index f623175..67e3073 100644
--- a/drivers/misc/ad525x_dpot-spi.c
+++ b/drivers/misc/ad525x_dpot-spi.c
@@ -131,7 +131,7 @@ static struct spi_driver ad_dpot_spi_driver =3D {
 		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D ad_dpot_spi_probe,
-	.remove		=3D __devexit_p(ad_dpot_spi_remove),
+	.remove		=3D ad_dpot_spi_remove,
 	.id_table	=3D ad_dpot_spi_id,
 };
=20
diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index 0314773..77f7cdc 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -326,7 +326,7 @@ static struct i2c_driver apds9802als_driver =3D {
 		.pm =3D APDS9802ALS_PM_OPS,
 	},
 	.probe =3D apds9802als_probe,
-	.remove =3D __devexit_p(apds9802als_remove),
+	.remove =3D apds9802als_remove,
 	.suspend =3D apds9802als_suspend,
 	.resume =3D apds9802als_resume,
 	.id_table =3D apds9802als_id,
diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index ee74244..f955d54 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1275,7 +1275,7 @@ static struct i2c_driver apds990x_driver =3D {
 		.pm	=3D &apds990x_pm_ops,
 	},
 	.probe	  =3D apds990x_probe,
-	.remove	  =3D __devexit_p(apds990x_remove),
+	.remove	  =3D apds990x_remove,
 	.id_table =3D apds990x_id,
 };
=20
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index a769719..bce3676 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -206,7 +206,7 @@ static struct platform_driver ssc_driver =3D {
 	},
 	.id_table	=3D atmel_ssc_devtypes,
 	.probe		=3D ssc_probe,
-	.remove		=3D __devexit_p(ssc_remove),
+	.remove		=3D ssc_remove,
 };
 module_platform_driver(ssc_driver);
=20
diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 3d56ae7..c4b65e2 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -1395,7 +1395,7 @@ static struct i2c_driver bh1770_driver =3D {
 		.pm	=3D &bh1770_pm_ops,
 	},
 	.probe	  =3D bh1770_probe,
-	.remove	  =3D __devexit_p(bh1770_remove),
+	.remove	  =3D bh1770_remove,
 	.id_table =3D bh1770_id,
 };
=20
diff --git a/drivers/misc/bh1780gli.c b/drivers/misc/bh1780gli.c
index f1f9877..54f6f39 100644
--- a/drivers/misc/bh1780gli.c
+++ b/drivers/misc/bh1780gli.c
@@ -248,7 +248,7 @@ static const struct i2c_device_id bh1780_id[] =3D {
=20
 static struct i2c_driver bh1780_driver =3D {
 	.probe		=3D bh1780_probe,
-	.remove		=3D __devexit_p(bh1780_remove),
+	.remove		=3D bh1780_remove,
 	.id_table	=3D bh1780_id,
 	.driver =3D {
 		.name =3D "bh1780",
diff --git a/drivers/misc/bmp085-i2c.c b/drivers/misc/bmp085-i2c.c
index a4f33c9..08cd795 100644
--- a/drivers/misc/bmp085-i2c.c
+++ b/drivers/misc/bmp085-i2c.c
@@ -71,7 +71,7 @@ static struct i2c_driver bmp085_i2c_driver =3D {
 	},
 	.id_table	=3D bmp085_id,
 	.probe		=3D bmp085_i2c_probe,
-	.remove		=3D __devexit_p(bmp085_i2c_remove),
+	.remove		=3D bmp085_i2c_remove,
=20
 	.detect		=3D bmp085_i2c_detect,
 	.address_list	=3D normal_i2c
diff --git a/drivers/misc/bmp085-spi.c b/drivers/misc/bmp085-spi.c
index 5e982af..ed34885 100644
--- a/drivers/misc/bmp085-spi.c
+++ b/drivers/misc/bmp085-spi.c
@@ -70,7 +70,7 @@ static struct spi_driver bmp085_spi_driver =3D {
 	},
 	.id_table	=3D bmp085_id,
 	.probe		=3D bmp085_spi_probe,
-	.remove		=3D __devexit_p(bmp085_spi_remove)
+	.remove		=3D bmp085_spi_remove
 };
=20
 module_spi_driver(bmp085_spi_driver);
diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 9d5eed7..489c468 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -332,7 +332,7 @@ static struct pci_driver cb710_driver =3D {
 	.name =3D KBUILD_MODNAME,
 	.id_table =3D cb710_pci_tbl,
 	.probe =3D cb710_probe,
-	.remove =3D __devexit_p(cb710_remove_one),
+	.remove =3D cb710_remove_one,
 #ifdef CONFIG_PM
 	.suspend =3D cb710_suspend,
 	.resume =3D cb710_resume,
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ab1ad41..3c36997 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -680,7 +680,7 @@ static struct i2c_driver at24_driver =3D {
 		.owner =3D THIS_MODULE,
 	},
 	.probe =3D at24_probe,
-	.remove =3D __devexit_p(at24_remove),
+	.remove =3D at24_remove,
 	.id_table =3D at24_ids,
 };
=20
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 4ed93dd..fcb237e 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -477,7 +477,7 @@ static struct spi_driver at25_driver =3D {
 		.owner		=3D THIS_MODULE,
 	},
 	.probe		=3D at25_probe,
-	.remove		=3D __devexit_p(at25_remove),
+	.remove		=3D at25_remove,
 };
=20
 module_spi_driver(at25_driver);
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/=
eeprom_93xx46.c
index ce3fe36..3dc14ea 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -389,7 +389,7 @@ static struct spi_driver eeprom_93xx46_driver =3D {
 		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D eeprom_93xx46_probe,
-	.remove		=3D __devexit_p(eeprom_93xx46_remove),
+	.remove		=3D eeprom_93xx46_remove,
 };
=20
 module_spi_driver(eeprom_93xx46_driver);
diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
index ac96c3a..38b52b9 100644
--- a/drivers/misc/fsa9480.c
+++ b/drivers/misc/fsa9480.c
@@ -533,7 +533,7 @@ static struct i2c_driver fsa9480_i2c_driver =3D {
 		.name =3D "fsa9480",
 	},
 	.probe =3D fsa9480_probe,
-	.remove =3D __devexit_p(fsa9480_remove),
+	.remove =3D fsa9480_remove,
 	.resume =3D fsa9480_resume,
 	.suspend =3D fsa9480_suspend,
 	.id_table =3D fsa9480_id,
diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 12ccdf9..4a6b3b6 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -852,7 +852,7 @@ static struct pci_driver ilo_driver =3D {
 	.name 	  =3D ILO_NAME,
 	.id_table =3D ilo_devices,
 	.probe 	  =3D ilo_probe,
-	.remove   =3D __devexit_p(ilo_remove),
+	.remove   =3D ilo_remove,
 };
=20
 static int __init ilo_init(void)
diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.=
c
index 168d800..f34a92f 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -198,7 +198,7 @@ static struct pci_driver ibmasm_driver =3D {
 	.name		=3D DRIVER_NAME,
 	.id_table	=3D ibmasm_pci_table,
 	.probe		=3D ibmasm_init_one,
-	.remove		=3D __devexit_p(ibmasm_remove_one),
+	.remove		=3D ibmasm_remove_one,
 };
=20
 static void __exit ibmasm_exit (void)
diff --git a/drivers/misc/ioc4.c b/drivers/misc/ioc4.c
index 6a77106..794a7e0 100644
--- a/drivers/misc/ioc4.c
+++ b/drivers/misc/ioc4.c
@@ -466,7 +466,7 @@ static struct pci_driver ioc4_driver =3D {
 	.name =3D "IOC4",
 	.id_table =3D ioc4_id_table,
 	.probe =3D ioc4_probe,
-	.remove =3D __devexit_p(ioc4_remove),
+	.remove =3D ioc4_remove,
 };
=20
 MODULE_DEVICE_TABLE(pci, ioc4_id_table);
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index eb5de2e..bef5307 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -451,7 +451,7 @@ static struct i2c_driver isl29003_driver =3D {
 	.suspend =3D isl29003_suspend,
 	.resume	=3D isl29003_resume,
 	.probe	=3D isl29003_probe,
-	.remove	=3D __devexit_p(isl29003_remove),
+	.remove	=3D isl29003_remove,
 	.id_table =3D isl29003_id,
 };
=20
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3=
lv02d/lis3lv02d_i2c.c
index 60ec868..403804c 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -280,7 +280,7 @@ static struct i2c_driver lis3lv02d_i2c_driver =3D {
 		.of_match_table =3D of_match_ptr(lis3lv02d_i2c_dt_ids),
 	},
 	.probe	=3D lis3lv02d_i2c_probe,
-	.remove	=3D __devexit_p(lis3lv02d_i2c_remove),
+	.remove	=3D lis3lv02d_i2c_remove,
 	.id_table =3D lis3lv02d_id,
 };
=20
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3=
lv02d/lis3lv02d_spi.c
index ccb6475..0e415c3 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -144,7 +144,7 @@ static struct spi_driver lis302dl_spi_driver =3D {
 		.of_match_table =3D of_match_ptr(lis302dl_spi_dt_ids),
 	},
 	.probe	=3D lis302dl_spi_probe,
-	.remove	=3D __devexit_p(lis302dl_spi_remove),
+	.remove	=3D lis302dl_spi_remove,
 };
=20
 module_spi_driver(lis302dl_spi_driver);
diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index c9f20da..5581774 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -888,7 +888,7 @@ static struct pci_driver pch_phub_driver =3D {
 	.name =3D "pch_phub",
 	.id_table =3D pch_phub_pcidev_id,
 	.probe =3D pch_phub_probe,
-	.remove =3D __devexit_p(pch_phub_remove),
+	.remove =3D pch_phub_remove,
 	.suspend =3D pch_phub_suspend,
 	.resume =3D pch_phub_resume
 };
diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index 21b28fc..79038e9 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -499,7 +499,7 @@ static struct pci_driver phantom_pci_driver =3D {
 	.name =3D "phantom",
 	.id_table =3D phantom_pci_tbl,
 	.probe =3D phantom_probe,
-	.remove =3D __devexit_p(phantom_remove),
+	.remove =3D phantom_remove,
 	.suspend =3D phantom_suspend,
 	.resume =3D phantom_resume
 };
diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 4999b34..3c5d746 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -901,7 +901,7 @@ static struct pci_driver pti_pci_driver =3D {
 	.name		=3D PCINAME,
 	.id_table	=3D pci_ids,
 	.probe		=3D pti_pci_probe,
-	.remove		=3D __devexit_p(pti_pci_remove),
+	.remove		=3D pti_pci_remove,
 };
=20
 /**
diff --git a/drivers/misc/ti_dac7512.c b/drivers/misc/ti_dac7512.c
index 5acbba1..85989ca 100644
--- a/drivers/misc/ti_dac7512.c
+++ b/drivers/misc/ti_dac7512.c
@@ -79,7 +79,7 @@ static struct spi_driver dac7512_driver =3D {
 		.owner	=3D THIS_MODULE,
 	},
 	.probe	=3D dac7512_probe,
-	.remove	=3D __devexit_p(dac7512_remove),
+	.remove	=3D dac7512_remove,
 };
=20
 module_spi_driver(dac7512_driver);
diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 0beb298..09ffb0b 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -450,7 +450,7 @@ static struct i2c_driver tsl2550_driver =3D {
 	.suspend =3D tsl2550_suspend,
 	.resume	=3D tsl2550_resume,
 	.probe	=3D tsl2550_probe,
-	.remove	=3D __devexit_p(tsl2550_remove),
+	.remove	=3D tsl2550_remove,
 	.id_table =3D tsl2550_id,
 };
=20
--=20
1.8.0
