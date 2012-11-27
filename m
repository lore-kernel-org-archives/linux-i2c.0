From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 16/16] i2c: SMBus: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:53 -0500
Message-ID: <1354049993-12718-17-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-ali1535.c |  8 ++++----
 drivers/i2c/busses/i2c-ali15x3.c |  8 ++++----
 drivers/i2c/busses/i2c-amd756.c  |  6 +++---
 drivers/i2c/busses/i2c-amd8111.c |  6 +++---
 drivers/i2c/busses/i2c-i801.c    | 24 ++++++++++++------------
 drivers/i2c/busses/i2c-isch.c    |  6 +++---
 drivers/i2c/busses/i2c-nforce2.c | 10 +++++-----
 drivers/i2c/busses/i2c-piix4.c   | 20 ++++++++++----------
 drivers/i2c/busses/i2c-sis5595.c |  4 ++--
 drivers/i2c/busses/i2c-sis630.c  |  8 ++++----
 drivers/i2c/busses/i2c-via.c     |  6 +++---
 drivers/i2c/busses/i2c-viapro.c  |  2 +-
 12 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 125cd8e..3f49181 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -139,7 +139,7 @@ static unsigned short ali1535_offset;
    Note the differences between kernels with the old PCI BIOS interface and
    newer kernels with the real PCI interface. In compat.h some things are
    defined to make the transition easier. */
-static int __devinit ali1535_setup(struct pci_dev *dev)
+static int ali1535_setup(struct pci_dev *dev)
 {
 	int retval;
 	unsigned char temp;
@@ -502,7 +502,7 @@ static DEFINE_PCI_DEVICE_TABLE(ali1535_ids) = {
 
 MODULE_DEVICE_TABLE(pci, ali1535_ids);
 
-static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali1535_setup(dev)) {
 		dev_warn(&dev->dev,
@@ -518,7 +518,7 @@ static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_
 	return i2c_add_adapter(&ali1535_adapter);
 }
 
-static void __devexit ali1535_remove(struct pci_dev *dev)
+static void ali1535_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali1535_adapter);
 	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
@@ -528,7 +528,7 @@ static struct pci_driver ali1535_driver = {
 	.name		= "ali1535_smbus",
 	.id_table	= ali1535_ids,
 	.probe		= ali1535_probe,
-	.remove		= __devexit_p(ali1535_remove),
+	.remove		= ali1535_remove,
 };
 
 module_pci_driver(ali1535_driver);
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index ce8d26d..26bcc61 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -131,7 +131,7 @@ MODULE_PARM_DESC(force_addr,
 static struct pci_driver ali15x3_driver;
 static unsigned short ali15x3_smba;
 
-static int __devinit ali15x3_setup(struct pci_dev *ALI15X3_dev)
+static int ali15x3_setup(struct pci_dev *ALI15X3_dev)
 {
 	u16 a;
 	unsigned char temp;
@@ -484,7 +484,7 @@ static DEFINE_PCI_DEVICE_TABLE(ali15x3_ids) = {
 
 MODULE_DEVICE_TABLE (pci, ali15x3_ids);
 
-static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali15x3_setup(dev)) {
 		dev_err(&dev->dev,
@@ -500,7 +500,7 @@ static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_
 	return i2c_add_adapter(&ali15x3_adapter);
 }
 
-static void __devexit ali15x3_remove(struct pci_dev *dev)
+static void ali15x3_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali15x3_adapter);
 	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
@@ -510,7 +510,7 @@ static struct pci_driver ali15x3_driver = {
 	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
-	.remove		= __devexit_p(ali15x3_remove),
+	.remove		= ali15x3_remove,
 };
 
 module_pci_driver(ali15x3_driver);
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 304aa03..c98af91 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -324,7 +324,7 @@ static DEFINE_PCI_DEVICE_TABLE(amd756_ids) = {
 
 MODULE_DEVICE_TABLE (pci, amd756_ids);
 
-static int __devinit amd756_probe(struct pci_dev *pdev,
+static int amd756_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int nforce = (id->driver_data == NFORCE);
@@ -397,7 +397,7 @@ static int __devinit amd756_probe(struct pci_dev *pdev,
 	return error;
 }
 
-static void __devexit amd756_remove(struct pci_dev *dev)
+static void amd756_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&amd756_smbus);
 	release_region(amd756_ioport, SMB_IOSIZE);
@@ -407,7 +407,7 @@ static struct pci_driver amd756_driver = {
 	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
-	.remove		= __devexit_p(amd756_remove),
+	.remove		= amd756_remove,
 };
 
 module_pci_driver(amd756_driver);
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 0919ac1..b5c86c0 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -422,7 +422,7 @@ static DEFINE_PCI_DEVICE_TABLE(amd8111_ids) = {
 
 MODULE_DEVICE_TABLE (pci, amd8111_ids);
 
-static int __devinit amd8111_probe(struct pci_dev *dev,
+static int amd8111_probe(struct pci_dev *dev,
 		const struct pci_device_id *id)
 {
 	struct amd_smbus *smbus;
@@ -475,7 +475,7 @@ static int __devinit amd8111_probe(struct pci_dev *dev,
 	return error;
 }
 
-static void __devexit amd8111_remove(struct pci_dev *dev)
+static void amd8111_remove(struct pci_dev *dev)
 {
 	struct amd_smbus *smbus = pci_get_drvdata(dev);
 
@@ -488,7 +488,7 @@ static struct pci_driver amd8111_driver = {
 	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
-	.remove		= __devexit_p(amd8111_remove),
+	.remove		= amd8111_remove,
 };
 
 module_pci_driver(amd8111_driver);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 1e73638..6c5a732 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -841,13 +841,13 @@ struct dmi_onboard_device_info {
 	const char *i2c_type;
 };
 
-static struct dmi_onboard_device_info __devinitdata dmi_devices[] = {
+static struct dmi_onboard_device_info dmi_devices[] = {
 	{ "Syleus", DMI_DEV_TYPE_OTHER, 0x73, "fscsyl" },
 	{ "Hermes", DMI_DEV_TYPE_OTHER, 0x73, "fscher" },
 	{ "Hades",  DMI_DEV_TYPE_OTHER, 0x73, "fschds" },
 };
 
-static void __devinit dmi_check_onboard_device(u8 type, const char *name,
+static void dmi_check_onboard_device(u8 type, const char *name,
 					       struct i2c_adapter *adap)
 {
 	int i;
@@ -871,7 +871,7 @@ static void __devinit dmi_check_onboard_device(u8 type, const char *name,
 /* We use our own function to check for onboard devices instead of
    dmi_find_device() as some buggy BIOS's have the devices we are interested
    in marked as disabled */
-static void __devinit dmi_check_onboard_devices(const struct dmi_header *dm,
+static void dmi_check_onboard_devices(const struct dmi_header *dm,
 						void *adap)
 {
 	int i, count;
@@ -901,7 +901,7 @@ static void __devinit dmi_check_onboard_devices(const struct dmi_header *dm,
 }
 
 /* Register optional slaves */
-static void __devinit i801_probe_optional_slaves(struct i801_priv *priv)
+static void i801_probe_optional_slaves(struct i801_priv *priv)
 {
 	/* Only register slaves on main SMBus channel */
 	if (priv->features & FEATURE_IDF)
@@ -921,7 +921,7 @@ static void __devinit i801_probe_optional_slaves(struct i801_priv *priv)
 }
 #else
 static void __init input_apanel_init(void) {}
-static void __devinit i801_probe_optional_slaves(struct i801_priv *priv) {}
+static void i801_probe_optional_slaves(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
 #if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
@@ -944,7 +944,7 @@ static struct i801_mux_config i801_mux_config_asus_z8_d18 = {
 	.n_gpios = 2,
 };
 
-static struct dmi_system_id __devinitdata mux_dmi_table[] = {
+static struct dmi_system_id mux_dmi_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
@@ -1012,7 +1012,7 @@ static struct dmi_system_id __devinitdata mux_dmi_table[] = {
 };
 
 /* Setup multiplexing if needed */
-static int __devinit i801_add_mux(struct i801_priv *priv)
+static int i801_add_mux(struct i801_priv *priv)
 {
 	struct device *dev = &priv->adapter.dev;
 	const struct i801_mux_config *mux_config;
@@ -1048,13 +1048,13 @@ static int __devinit i801_add_mux(struct i801_priv *priv)
 	return 0;
 }
 
-static void __devexit i801_del_mux(struct i801_priv *priv)
+static void i801_del_mux(struct i801_priv *priv)
 {
 	if (priv->mux_pdev)
 		platform_device_unregister(priv->mux_pdev);
 }
 
-static unsigned int __devinit i801_get_adapter_class(struct i801_priv *priv)
+static unsigned int i801_get_adapter_class(struct i801_priv *priv)
 {
 	const struct dmi_system_id *id;
 	const struct i801_mux_config *mux_config;
@@ -1084,7 +1084,7 @@ static inline unsigned int i801_get_adapter_class(struct i801_priv *priv)
 }
 #endif
 
-static int __devinit i801_probe(struct pci_dev *dev,
+static int i801_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -1226,7 +1226,7 @@ exit:
 	return err;
 }
 
-static void __devexit i801_remove(struct pci_dev *dev)
+static void i801_remove(struct pci_dev *dev)
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
@@ -1272,7 +1272,7 @@ static struct pci_driver i801_driver = {
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
-	.remove		= __devexit_p(i801_remove),
+	.remove		= i801_remove,
 	.suspend	= i801_suspend,
 	.resume		= i801_resume,
 };
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index f90a605..4099f79 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -249,7 +249,7 @@ static struct i2c_adapter sch_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static int __devinit smbus_sch_probe(struct platform_device *dev)
+static int smbus_sch_probe(struct platform_device *dev)
 {
 	struct resource *res;
 	int retval;
@@ -284,7 +284,7 @@ static int __devinit smbus_sch_probe(struct platform_device *dev)
 	return retval;
 }
 
-static int __devexit smbus_sch_remove(struct platform_device *pdev)
+static int smbus_sch_remove(struct platform_device *pdev)
 {
 	struct resource *res;
 	if (sch_smba) {
@@ -303,7 +303,7 @@ static struct platform_driver smbus_sch_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= smbus_sch_probe,
-	.remove		= __devexit_p(smbus_sch_remove),
+	.remove		= smbus_sch_remove,
 };
 
 module_platform_driver(smbus_sch_driver);
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 392303b..fbea3cf 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -117,7 +117,7 @@ struct nforce2_smbus {
 #define MAX_TIMEOUT	100
 
 /* We disable the second SMBus channel on these boards */
-static struct dmi_system_id __devinitdata nforce2_dmi_blacklist2[] = {
+static struct dmi_system_id nforce2_dmi_blacklist2[] = {
 	{
 		.ident = "DFI Lanparty NF4 Expert",
 		.matches = {
@@ -330,7 +330,7 @@ static DEFINE_PCI_DEVICE_TABLE(nforce2_ids) = {
 MODULE_DEVICE_TABLE (pci, nforce2_ids);
 
 
-static int __devinit nforce2_probe_smb (struct pci_dev *dev, int bar,
+static int nforce2_probe_smb (struct pci_dev *dev, int bar,
 	int alt_reg, struct nforce2_smbus *smbus, const char *name)
 {
 	int error;
@@ -382,7 +382,7 @@ static int __devinit nforce2_probe_smb (struct pci_dev *dev, int bar,
 }
 
 
-static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int nforce2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct nforce2_smbus *smbuses;
 	int res1, res2;
@@ -430,7 +430,7 @@ static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_
 }
 
 
-static void __devexit nforce2_remove(struct pci_dev *dev)
+static void nforce2_remove(struct pci_dev *dev)
 {
 	struct nforce2_smbus *smbuses = pci_get_drvdata(dev);
 
@@ -450,7 +450,7 @@ static struct pci_driver nforce2_driver = {
 	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
-	.remove		= __devexit_p(nforce2_remove),
+	.remove		= nforce2_remove,
 };
 
 module_pci_driver(nforce2_driver);
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index f7216ed..80c5d9e 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -99,7 +99,7 @@ MODULE_PARM_DESC(force_addr,
 static int srvrworks_csb5_delay;
 static struct pci_driver piix4_driver;
 
-static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
+static struct dmi_system_id piix4_dmi_blacklist[] = {
 	{
 		.ident = "Sapphire AM2RD790",
 		.matches = {
@@ -119,7 +119,7 @@ static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
 
 /* The IBM entry is in a separate table because we only check it
    on Intel-based systems */
-static struct dmi_system_id __devinitdata piix4_dmi_ibm[] = {
+static struct dmi_system_id piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
 		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
@@ -131,7 +131,7 @@ struct i2c_piix4_adapdata {
 	unsigned short smba;
 };
 
-static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
+static int piix4_setup(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -230,7 +230,7 @@ static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
 	return piix4_smba;
 }
 
-static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
+static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id)
 {
 	unsigned short piix4_smba;
@@ -294,7 +294,7 @@ static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	return piix4_smba;
 }
 
-static int __devinit piix4_setup_aux(struct pci_dev *PIIX4_dev,
+static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id,
 				unsigned short base_reg_addr)
 {
@@ -540,7 +540,7 @@ MODULE_DEVICE_TABLE (pci, piix4_ids);
 static struct i2c_adapter *piix4_main_adapter;
 static struct i2c_adapter *piix4_aux_adapter;
 
-static int __devinit piix4_add_adapter(struct pci_dev *dev,
+static int piix4_add_adapter(struct pci_dev *dev,
 					unsigned short smba,
 					struct i2c_adapter **padap)
 {
@@ -588,7 +588,7 @@ static int __devinit piix4_add_adapter(struct pci_dev *dev,
 	return 0;
 }
 
-static int __devinit piix4_probe(struct pci_dev *dev,
+static int piix4_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	int retval;
@@ -626,7 +626,7 @@ static int __devinit piix4_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit piix4_adap_remove(struct i2c_adapter *adap)
+static void piix4_adap_remove(struct i2c_adapter *adap)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 
@@ -638,7 +638,7 @@ static void __devexit piix4_adap_remove(struct i2c_adapter *adap)
 	}
 }
 
-static void __devexit piix4_remove(struct pci_dev *dev)
+static void piix4_remove(struct pci_dev *dev)
 {
 	if (piix4_main_adapter) {
 		piix4_adap_remove(piix4_main_adapter);
@@ -655,7 +655,7 @@ static struct pci_driver piix4_driver = {
 	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
-	.remove		= __devexit_p(piix4_remove),
+	.remove		= piix4_remove,
 };
 
 module_pci_driver(piix4_driver);
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index 87e5126..79fd96a 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -142,7 +142,7 @@ static void sis5595_write(u8 reg, u8 data)
 	outb(data, sis5595_base + SMB_DAT);
 }
 
-static int __devinit sis5595_setup(struct pci_dev *SIS5595_dev)
+static int sis5595_setup(struct pci_dev *SIS5595_dev)
 {
 	u16 a;
 	u8 val;
@@ -376,7 +376,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis5595_ids) = {
 
 MODULE_DEVICE_TABLE (pci, sis5595_ids);
 
-static int __devinit sis5595_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int sis5595_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int err;
 
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 5d6723b..de6dddb 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -389,7 +389,7 @@ static u32 sis630_func(struct i2c_adapter *adapter)
 		I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static int __devinit sis630_setup(struct pci_dev *sis630_dev)
+static int sis630_setup(struct pci_dev *sis630_dev)
 {
 	unsigned char b;
 	struct pci_dev *dummy = NULL;
@@ -480,7 +480,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis630_ids) = {
 
 MODULE_DEVICE_TABLE (pci, sis630_ids);
 
-static int __devinit sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (sis630_setup(dev)) {
 		dev_err(&dev->dev, "SIS630 comp. bus not detected, module not inserted.\n");
@@ -496,7 +496,7 @@ static int __devinit sis630_probe(struct pci_dev *dev, const struct pci_device_i
 	return i2c_add_adapter(&sis630_adapter);
 }
 
-static void __devexit sis630_remove(struct pci_dev *dev)
+static void sis630_remove(struct pci_dev *dev)
 {
 	if (acpi_base) {
 		i2c_del_adapter(&sis630_adapter);
@@ -510,7 +510,7 @@ static struct pci_driver sis630_driver = {
 	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
-	.remove		= __devexit_p(sis630_remove),
+	.remove		= sis630_remove,
 };
 
 module_pci_driver(sis630_driver);
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 7ffee71..be66251 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -96,7 +96,7 @@ static DEFINE_PCI_DEVICE_TABLE(vt586b_ids) = {
 
 MODULE_DEVICE_TABLE (pci, vt586b_ids);
 
-static int __devinit vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	u16 base;
 	u8 rev;
@@ -146,7 +146,7 @@ static int __devinit vt586b_probe(struct pci_dev *dev, const struct pci_device_i
 	return 0;
 }
 
-static void __devexit vt586b_remove(struct pci_dev *dev)
+static void vt586b_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&vt586b_adapter);
 	release_region(I2C_DIR, IOSPACE);
@@ -158,7 +158,7 @@ static struct pci_driver vt586b_driver = {
 	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
-	.remove		= __devexit_p(vt586b_remove),
+	.remove		= vt586b_remove,
 };
 
 module_pci_driver(vt586b_driver);
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 271c9a2..3426196 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -320,7 +320,7 @@ static struct i2c_adapter vt596_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static int __devinit vt596_probe(struct pci_dev *pdev,
+static int vt596_probe(struct pci_dev *pdev,
 				 const struct pci_device_id *id)
 {
 	unsigned char temp;
-- 
1.8.0.1
