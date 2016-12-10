From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 5/5] i2c: designware-baytrail: Add support for cherrytrail
Date: Sat, 10 Dec 2016 15:19:08 +0100
Message-ID: <20161210141908.16470-5-hdegoede@redhat.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbcLJOTT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 09:19:19 -0500
In-Reply-To: <20161210141908.16470-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The cherrytrail punit has the pmic i2c bus access semaphore at a
different register address.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Takashi Iwai <tiwai@suse.de>
---
Changes in v2:
-Adjust for accessor_flags -> flags rename
-Add flags field to struct dw_pci_controller
-Add get_sem_addr() helper replacing MODEL_CHERRYTRAIL flag checking in
 PUNIT_SEMAPHORE macro
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 22 +++++++++++++++++-----
 drivers/i2c/busses/i2c-designware-core.h     |  1 +
 drivers/i2c/busses/i2c-designware-pcidrv.c   | 26 +++++++++++++++++++-------
 drivers/i2c/busses/i2c-designware-platdrv.c  |  2 +-
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 4f10ebb..16cfe16 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -24,13 +24,23 @@
 
 #define SEMAPHORE_TIMEOUT	100
 #define PUNIT_SEMAPHORE		0x7
+#define PUNIT_SEMAPHORE_CHV	0x10e
 #define PUNIT_SEMAPHORE_BIT	BIT(0)
 #define PUNIT_SEMAPHORE_ACQUIRE	BIT(1)
 
 static unsigned long acquired;
 
+static u32 get_sem_addr(struct dw_i2c_dev *dev)
+{
+	if (dev->flags & MODEL_CHERRYTRAIL)
+		return PUNIT_SEMAPHORE_CHV;
+	else
+		return PUNIT_SEMAPHORE;
+}
+
 static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
 {
+	u32 addr = get_sem_addr(dev);
 	u32 data;
 	int ret;
 
@@ -41,7 +51,7 @@ static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
 	 */
 	pm_qos_update_request(&dev->pm_qos, 0);
 
-	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, PUNIT_SEMAPHORE, &data);
+	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr, &data);
 	if (ret) {
 		dev_err(dev->dev, "iosf failed to read punit semaphore\n");
 		return ret;
@@ -54,15 +64,16 @@ static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
 
 static void reset_semaphore(struct dw_i2c_dev *dev)
 {
+	u32 addr = get_sem_addr(dev);
 	u32 data;
 
-	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, PUNIT_SEMAPHORE, &data)) {
+	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr, &data)) {
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during read\n");
 		return;
 	}
 
 	data &= ~PUNIT_SEMAPHORE_BIT;
-	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, PUNIT_SEMAPHORE, data))
+	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, addr, data))
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
 
 	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
@@ -70,6 +81,7 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
 
 static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 {
+	u32 addr = get_sem_addr(dev);
 	u32 sem = PUNIT_SEMAPHORE_ACQUIRE;
 	int ret;
 	unsigned long start, end;
@@ -83,7 +95,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 		return 0;
 
 	/* host driver writes to side band semaphore register */
-	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, PUNIT_SEMAPHORE, sem);
+	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, addr, sem);
 	if (ret) {
 		dev_err(dev->dev, "iosf punit semaphore request failed\n");
 		return ret;
@@ -107,7 +119,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	dev_err(dev->dev, "punit semaphore timed out, resetting\n");
 	reset_semaphore(dev);
 
-	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, PUNIT_SEMAPHORE, &sem);
+	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr, &sem);
 	if (ret)
 		dev_err(dev->dev, "iosf failed to read punit semaphore\n");
 	else
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 47d284c..735fc63 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -126,6 +126,7 @@ struct dw_i2c_dev {
 #define ACCESS_SWAP		0x00000001
 #define ACCESS_16BIT		0x00000002
 #define ACCESS_INTR_MASK	0x00000004
+#define MODEL_CHERRYTRAIL	0x00000008
 
 extern int i2c_dw_init(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 96f8230..4e53a9f 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -45,6 +45,7 @@ enum dw_pci_ctl_id_t {
 	medfield,
 	merrifield,
 	baytrail,
+	cherrytrail,
 	haswell,
 };
 
@@ -63,6 +64,7 @@ struct dw_pci_controller {
 	u32 rx_fifo_depth;
 	u32 clk_khz;
 	u32 functionality;
+	u32 flags;
 	struct dw_scl_sda_cfg *scl_sda_cfg;
 	int (*setup)(struct pci_dev *pdev, struct dw_pci_controller *c);
 };
@@ -174,6 +176,15 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 		.functionality = I2C_FUNC_10BIT_ADDR,
 		.scl_sda_cfg = &hsw_config,
 	},
+	[cherrytrail] = {
+		.bus_num = -1,
+		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
+		.tx_fifo_depth = 32,
+		.rx_fifo_depth = 32,
+		.functionality = I2C_FUNC_10BIT_ADDR,
+		.flags = MODEL_CHERRYTRAIL,
+		.scl_sda_cfg = &byt_config,
+	},
 };
 
 #ifdef CONFIG_PM
@@ -241,6 +252,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	dev->base = pcim_iomap_table(pdev)[0];
 	dev->dev = &pdev->dev;
 	dev->irq = pdev->irq;
+	dev->flags |= controller->flags;
 
 	if (controller->setup) {
 		r = controller->setup(pdev, controller);
@@ -321,13 +333,13 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
 	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
 	/* Braswell / Cherrytrail */
-	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C2), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C3), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C4), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C5), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C6), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C7), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C1), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C2), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C3), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C4), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C5), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C6), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C7), cherrytrail },
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6d72929..589f07e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -123,7 +123,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3432", 0 },
 	{ "INT3433", 0 },
 	{ "80860F41", 0 },
-	{ "808622C1", 0 },
+	{ "808622C1", MODEL_CHERRYTRAIL },
 	{ "AMD0010", ACCESS_INTR_MASK },
 	{ "AMDI0010", ACCESS_INTR_MASK },
 	{ "AMDI0510", 0 },
-- 
2.9.3
