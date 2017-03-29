From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: [PATCH] watchdog/sp5100_tco: Coexist with i2c-piix
Date: Wed, 29 Mar 2017 14:19:24 +0200
Message-ID: <0b243679-8eed-a196-8d44-8eea06f17e9a@pr.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C0E17BD60E2C43C60B38D9EC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:36684 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755855AbdC2NAP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Mar 2017 09:00:15 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>

This is a multi-part message in MIME format.
--------------C0E17BD60E2C43C60B38D9EC
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


the attached patch fixes a long time regression in sp5100_tco caused by changes in i2c-piix4.

See:

https://bugzilla.redhat.com/show_bug.cgi?id=1406844

https://bugzilla.kernel.org/show_bug.cgi?id=170741

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=853122


Best regards,

Zolt�n B�sz�rm�nyi


--------------C0E17BD60E2C43C60B38D9EC
Content-Type: text/x-patch;
 name="i2c-piix4-coexist-with-sp5100_tco.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="i2c-piix4-coexist-with-sp5100_tco.patch"

From: Zoltán Böszörményi <zboszor@pr.hu>
Date: Tue Mar 28 14:53:07 2017 +0200
Subject: [PATCH] watchdog/sp5100_tco: Coexist with i2c-piix

Currently, the kernel says this when i2c-piix loads before sp5100_tco:

sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
sp5100_tco: I/O address 0x0cd6 already in use

Both i2c-piix4 and sp5100_tco uses a static request_region() call
so it depends on the load order which one wins.

i2c-piix4 uses a mutex to protect I/O port accesses to the pair of
I/O ports. Replace this mutex lock / unlock with request_muxed_region()
and release_region() around the I/O port accesses in i2c-piix4.

Add request_muxed_region() / release_region() pairs around the I/O
accesses in sp5100_tco.

This will act as a cross-driver mutex.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index c21ca7b..16befdd5 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -40,7 +40,6 @@
 #include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
-#include <linux/mutex.h>
 
 
 /* PIIX4 SMBus address offsets */
@@ -144,10 +143,9 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 
 /*
  * SB800 globals
- * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
- * of I/O ports at SB800_PIIX4_SMB_IDX.
+ * the pair of I/O ports at SB800_PIIX4_SMB_IDX are protected
+ * by request_muxed_region / release_region
  */
-static DEFINE_MUTEX(piix4_mutex_sb800);
 static u8 piix4_port_sel_sb800;
 static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
 	" port 0", " port 2", " port 3", " port 4"
@@ -157,8 +155,6 @@ static const char *piix4_aux_port_name_sb800 = " port 1";
 struct i2c_piix4_adapdata {
 	unsigned short smba;
 
-	/* SB800 */
-	bool sb800_main;
 	u8 port;		/* Port number, shifted */
 };
 
@@ -261,6 +257,14 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	return piix4_smba;
 }
 
+static inline void enter_sb800(void) {
+	request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx");
+}
+
+static inline void leave_sb800(void) {
+	release_region(SB800_PIIX4_SMB_IDX, 2);
+}
+
 static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 			     const struct pci_device_id *id, u8 aux)
 {
@@ -286,12 +290,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	else
 		smb_en = (aux) ? 0x28 : 0x2c;
 
-	mutex_lock(&piix4_mutex_sb800);
+	enter_sb800();
 	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
 	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
 	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
-	mutex_unlock(&piix4_mutex_sb800);
+	leave_sb800();
 
 	if (!smb_en) {
 		smb_en_status = smba_en_lo & 0x10;
@@ -349,13 +353,13 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
 		piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 	} else {
-		mutex_lock(&piix4_mutex_sb800);
+		enter_sb800();
 		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
 		port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
 		piix4_port_sel_sb800 = (port_sel & 0x01) ?
 				       SB800_PIIX4_PORT_IDX_ALT :
 				       SB800_PIIX4_PORT_IDX;
-		mutex_unlock(&piix4_mutex_sb800);
+		leave_sb800();
 	}
 
 	dev_info(&PIIX4_dev->dev,
@@ -592,7 +596,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	u8 port;
 	int retval;
 
-	mutex_lock(&piix4_mutex_sb800);
+	enter_sb800();
 
 	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
 	smbslvcnt  = inb_p(SMBSLVCNT);
@@ -608,7 +612,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	} while (--retries);
 	/* SMBus is still owned by the IMC, we give up */
 	if (!retries) {
-		mutex_unlock(&piix4_mutex_sb800);
+		leave_sb800();
 		return -EBUSY;
 	}
 
@@ -628,7 +632,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
 
-	mutex_unlock(&piix4_mutex_sb800);
+	leave_sb800();
 
 	return retval;
 }
@@ -705,7 +709,6 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	adapdata->smba = smba;
-	adapdata->sb800_main = sb800_main;
 	adapdata->port = port << 1;
 
 	/* set up the sysfs linkage to our parent device */
@@ -771,17 +774,9 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	    dev->vendor == PCI_VENDOR_ID_AMD) {
 		is_sb800 = true;
 
-		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
-			dev_err(&dev->dev,
-			"SMBus base address index region 0x%x already in use!\n",
-			SB800_PIIX4_SMB_IDX);
-			return -EBUSY;
-		}
-
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
 		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
 			return retval;
 		}
 
@@ -791,7 +786,6 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		 */
 		retval = piix4_add_adapters_sb800(dev, retval);
 		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
 			return retval;
 		}
 	} else {
@@ -841,11 +835,8 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		if (adapdata->port == (0 << 1)) {
+		if (adapdata->port == (0 << 1))
 			release_region(adapdata->smba, SMBIOSIZE);
-			if (adapdata->sb800_main)
-				release_region(SB800_PIIX4_SMB_IDX, 2);
-		}
 		kfree(adapdata);
 		kfree(adap);
 	}
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 028618c..ff332a6 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -53,6 +53,7 @@ static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
 static unsigned long timer_alive;
 static char tco_expect_close;
 static struct pci_dev *sp5100_tco_pci;
+static const char *sp5100_tco_dev_name = NULL;
 
 /* the watchdog platform device */
 static struct platform_device *sp5100_tco_platform_device;
@@ -71,6 +72,20 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started."
 		" (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 /*
+ * Protect accessing the pair of I/O ports
+ * This relies on the fact that SB800_IO_PM_INDEX_REG and
+ * SP5100_IO_PM_INDEX_REG are the same value.
+ */
+static inline void enter_sp5100(void) {
+	request_muxed_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE,
+			(sp5100_tco_dev_name ? sp5100_tco_dev_name : "sp5100_tco") );
+}
+
+static inline void leave_sp5100(void) {
+	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
+}
+
+/*
  * Some TCO specific functions
  */
 
@@ -138,6 +153,8 @@ static void tco_timer_enable(void)
 
 	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		/* For SB800 or later */
+		enter_sp5100();
+
 		/* Set the Watchdog timer resolution to 1 sec */
 		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
@@ -150,6 +167,8 @@ static void tco_timer_enable(void)
 		val |= SB800_PCI_WATCHDOG_DECODE_EN;
 		val &= ~SB800_PM_WATCHDOG_DISABLE;
 		outb(val, SB800_IO_PM_DATA_REG);
+
+		leave_sp5100();
 	} else {
 		/* For SP5100 or SB7x0 */
 		/* Enable watchdog decode bit */
@@ -164,11 +183,13 @@ static void tco_timer_enable(void)
 				       val);
 
 		/* Enable Watchdog timer and set the resolution to 1 sec */
+		enter_sp5100();
 		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
 		val = inb(SP5100_IO_PM_DATA_REG);
 		val |= SP5100_PM_WATCHDOG_SECOND_RES;
 		val &= ~SP5100_PM_WATCHDOG_DISABLE;
 		outb(val, SP5100_IO_PM_DATA_REG);
+		leave_sp5100();
 	}
 }
 
@@ -327,7 +348,6 @@ MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
 static unsigned char sp5100_tco_setupdevice(void)
 {
 	struct pci_dev *dev = NULL;
-	const char *dev_name = NULL;
 	u32 val;
 	u32 index_reg, data_reg, base_addr;
 
@@ -350,27 +370,21 @@ static unsigned char sp5100_tco_setupdevice(void)
 	 * Determine type of southbridge chipset.
 	 */
 	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
-		dev_name = SP5100_DEVNAME;
+		sp5100_tco_dev_name = SP5100_DEVNAME;
 		index_reg = SP5100_IO_PM_INDEX_REG;
 		data_reg = SP5100_IO_PM_DATA_REG;
 		base_addr = SP5100_PM_WATCHDOG_BASE;
 	} else {
-		dev_name = SB800_DEVNAME;
+		sp5100_tco_dev_name = SB800_DEVNAME;
 		index_reg = SB800_IO_PM_INDEX_REG;
 		data_reg = SB800_IO_PM_DATA_REG;
 		base_addr = SB800_PM_WATCHDOG_BASE;
 	}
 
-	/* Request the IO ports used by this driver */
-	pm_iobase = SP5100_IO_PM_INDEX_REG;
-	if (!request_region(pm_iobase, SP5100_PM_IOPORTS_SIZE, dev_name)) {
-		pr_err("I/O address 0x%04x already in use\n", pm_iobase);
-		goto exit;
-	}
-
 	/*
 	 * First, Find the watchdog timer MMIO address from indirect I/O.
 	 */
+	enter_sp5100();
 	outb(base_addr+3, index_reg);
 	val = inb(data_reg);
 	outb(base_addr+2, index_reg);
@@ -380,12 +394,13 @@ static unsigned char sp5100_tco_setupdevice(void)
 	outb(base_addr+0, index_reg);
 	/* Low three bits of BASE are reserved */
 	val = val << 8 | (inb(data_reg) & 0xf8);
+	leave_sp5100();
 
 	pr_debug("Got 0x%04x from indirect I/O\n", val);
 
 	/* Check MMIO address conflict */
 	if (request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
-								dev_name))
+								sp5100_tco_dev_name))
 		goto setup_wdt;
 	else
 		pr_debug("MMIO address 0x%04x already in use\n", val);
@@ -400,6 +415,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
 	} else {
 		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
+		enter_sp5100();
 		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
@@ -408,6 +424,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
+		leave_sp5100();
 	}
 
 	/* The SBResource_MMIO is enabled and mapped memory space? */
@@ -419,7 +436,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val += SB800_PM_WDT_MMIO_OFFSET;
 		/* Check MMIO address conflict */
 		if (request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
-								   dev_name)) {
+								   sp5100_tco_dev_name)) {
 			pr_debug("Got 0x%04x from SBResource_MMIO register\n",
 				val);
 			goto setup_wdt;
@@ -429,7 +446,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
 
 	pr_notice("failed to find MMIO address, giving up.\n");
-	goto  unreg_region;
+	goto  exit;
 
 setup_wdt:
 	tcobase_phys = val;
@@ -469,8 +486,6 @@ static unsigned char sp5100_tco_setupdevice(void)
 
 unreg_mem_region:
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-unreg_region:
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 exit:
 	return 0;
 }

--------------C0E17BD60E2C43C60B38D9EC--
