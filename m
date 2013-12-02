From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 11/39] i2c: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 03 Dec 2013 08:11:20 +0900
Message-ID: <002001ceefb3$cfb652e0$6f22f8a0$%han@samsung.com>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001501ceefb1$69c96820$3d5c3860$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Greg Kroah-Hartman' <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is not preferred.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ali1535.c           |    2 +-
 drivers/i2c/busses/i2c-ali1563.c           |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c           |    2 +-
 drivers/i2c/busses/i2c-amd756.c            |    2 +-
 drivers/i2c/busses/i2c-amd8111.c           |    2 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c |    2 +-
 drivers/i2c/busses/i2c-eg20t.c             |    2 +-
 drivers/i2c/busses/i2c-hydra.c             |    2 +-
 drivers/i2c/busses/i2c-i801.c              |    2 +-
 drivers/i2c/busses/i2c-ismt.c              |    2 +-
 drivers/i2c/busses/i2c-nforce2.c           |    2 +-
 drivers/i2c/busses/i2c-pasemi.c            |    2 +-
 drivers/i2c/busses/i2c-piix4.c             |    2 +-
 drivers/i2c/busses/i2c-pxa-pci.c           |    2 +-
 drivers/i2c/busses/i2c-sis5595.c           |    2 +-
 drivers/i2c/busses/i2c-sis630.c            |    2 +-
 drivers/i2c/busses/i2c-sis96x.c            |    2 +-
 drivers/i2c/busses/i2c-via.c               |    2 +-
 drivers/i2c/busses/i2c-viapro.c            |    2 +-
 drivers/i2c/busses/scx200_acb.c            |    2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 3f49181..00b5f00 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -495,7 +495,7 @@ static struct i2c_adapter ali1535_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(ali1535_ids) = {
+static const struct pci_device_id ali1535_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
 	{ },
 };
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index 84ccd94..5c8174e 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -417,7 +417,7 @@ static void ali1563_remove(struct pci_dev *dev)
 	ali1563_shutdown(dev);
 }
 
-static DEFINE_PCI_DEVICE_TABLE(ali1563_id_table) = {
+static const struct pci_device_id ali1563_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1563) },
 	{},
 };
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 26bcc61..735758b 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -477,7 +477,7 @@ static struct i2c_adapter ali15x3_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(ali15x3_ids) = {
+static const struct pci_device_id ali15x3_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index e13e2aa..99f6d98 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -308,7 +308,7 @@ static const char* chipname[] = {
 	"nVidia nForce", "AMD8111",
 };
 
-static DEFINE_PCI_DEVICE_TABLE(amd756_ids) = {
+static const struct pci_device_id amd756_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B),
 	  .driver_data = AMD756 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413),
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index a44e6e7..e82c258 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -415,7 +415,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 };
 
 
-static DEFINE_PCI_DEVICE_TABLE(amd8111_ids) = {
+static const struct pci_device_id amd8111_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS2) },
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f6ed06c..1d3b4eb 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -309,7 +309,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("i2c_designware-pci");
 
-static DEFINE_PCI_DEVICE_TABLE(i2_designware_pci_ids) = {
+static const struct pci_device_id i2_designware_pci_ids[] = {
 	/* Moorestown */
 	{ PCI_VDEVICE(INTEL, 0x0802), moorestown_0 },
 	{ PCI_VDEVICE(INTEL, 0x0803), moorestown_1 },
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index ff15ae9..675e040 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -187,7 +187,7 @@ static DEFINE_MUTEX(pch_mutex);
 #define PCI_DEVICE_ID_ML7223_I2C	0x8010
 #define PCI_DEVICE_ID_ML7831_I2C	0x8817
 
-static DEFINE_PCI_DEVICE_TABLE(pch_pcidev_id) = {
+static const struct pci_device_id pch_pcidev_id[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH_I2C),   1, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_I2C), 2, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_I2C), 1, },
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index 79c3d90..eef07b3 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -105,7 +105,7 @@ static struct i2c_adapter hydra_adap = {
 	.algo_data	= &hydra_bit_data,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(hydra_ids) = {
+static const struct pci_device_id hydra_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_HYDRA) },
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 737e298..9adae45 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -789,7 +789,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= i801_func,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(i801_ids) = {
+static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_2) },
diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 0043ede..cc271d9 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -183,7 +183,7 @@ struct ismt_priv {
 /**
  * ismt_ids - PCI device IDs supported by this driver
  */
-static DEFINE_PCI_DEVICE_TABLE(ismt_ids) = {
+static const struct pci_device_id ismt_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index ac88f40..caa5568 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -307,7 +307,7 @@ static struct i2c_algorithm smbus_algorithm = {
 };
 
 
-static DEFINE_PCI_DEVICE_TABLE(nforce2_ids) = {
+static const struct pci_device_id nforce2_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index 615f632..7a9dce4 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -401,7 +401,7 @@ static void pasemi_smb_remove(struct pci_dev *dev)
 	kfree(smbus);
 }
 
-static DEFINE_PCI_DEVICE_TABLE(pasemi_smb_ids) = {
+static const struct pci_device_id pasemi_smb_ids[] = {
 	{ PCI_DEVICE(0x1959, 0xa003) },
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index a028617..b0228a4 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -522,7 +522,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= piix4_func,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(piix4_ids) = {
+static const struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3) },
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 9639be8..417464e 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -148,7 +148,7 @@ static void ce4100_i2c_remove(struct pci_dev *dev)
 	kfree(sds);
 }
 
-static DEFINE_PCI_DEVICE_TABLE(ce4100_i2c_devices) = {
+static const struct pci_device_id ce4100_i2c_devices[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e68)},
 	{ },
 };
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index 79fd96a..ac9bc33 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -369,7 +369,7 @@ static struct i2c_adapter sis5595_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(sis5595_ids) = {
+static const struct pci_device_id sis5595_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) }, 
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 36a9556..d8adf96 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -511,7 +511,7 @@ static struct i2c_adapter sis630_adapter = {
 	.retries	= 3
 };
 
-static DEFINE_PCI_DEVICE_TABLE(sis630_ids) = {
+static const struct pci_device_id sis630_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_LPC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_964) },
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index b9faf9b..56c2443 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -245,7 +245,7 @@ static struct i2c_adapter sis96x_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(sis96x_ids) = {
+static const struct pci_device_id sis96x_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_SMBUS) },
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index be66251..9860c64 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -89,7 +89,7 @@ static struct i2c_adapter vt586b_adapter = {
 };
 
 
-static DEFINE_PCI_DEVICE_TABLE(vt586b_ids) = {
+static const struct pci_device_id vt586b_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3) },
 	{ 0, }
 };
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index b2d90e1..42aa27a 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -442,7 +442,7 @@ release_region:
 	return error;
 }
 
-static DEFINE_PCI_DEVICE_TABLE(vt596_ids) = {
+static const struct pci_device_id vt596_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596_3),
 	  .driver_data = SMBBA1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596B_3),
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 2d1d2c5..cb66f95 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -556,7 +556,7 @@ static struct platform_driver scx200_pci_driver = {
 	.remove = scx200_remove,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(scx200_isa) = {
+static const struct pci_device_id scx200_isa[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
 	{ 0, }
-- 
1.7.10.4
