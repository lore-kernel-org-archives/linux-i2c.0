From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/5] intel_mid_i2c: Do a bit of compaction and tidying
Date: Thu, 17 Jun 2010 15:06:06 +0100
Message-ID: <20100617140604.17861.23512.stgit@localhost.localdomain>
References: <20100617140352.17861.29664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100617140352.17861.29664.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Squash down the switches into tables, and use the PCI ident field. We
could perhaps take this further and put the platform and port numbr into
this.

Check the speed (which is now 0/1/2) is valid and ignore otherwise.

Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-mrst.c |  183 +++++++++++++----------------------------
 drivers/i2c/busses/i2c-mrst.h |    5 -
 2 files changed, 59 insertions(+), 129 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mrst.c b/drivers/i2c/busses/i2c-mrst.c
index 0b44ffd..9a8dfc8 100644
--- a/drivers/i2c/busses/i2c-mrst.c
+++ b/drivers/i2c/busses/i2c-mrst.c
@@ -45,6 +45,20 @@
 #define mrst_i2c_read(reg)		__raw_readl(reg)
 #define mrst_i2c_write(reg, val)	__raw_writel((val), (reg))
 
+/* Use defines not enumerations so that we can do this with tables */
+
+#define MOOESTOWN	0
+#define	MEDFIELD	1
+
+#define NUM_PLATFORMS	2
+
+#define STANDARD	0
+#define FAST		1
+#define HIGH		2
+
+#define NUM_SPEEDS	3
+
+
 static int speed_mode[6] = {
 	STANDARD,
 	STANDARD,
@@ -120,6 +134,14 @@ static int mrst_i2c_disable(struct i2c_adapter *adap)
 static int mrst_i2c_hwinit(struct mrst_i2c_private *i2c)
 {
 	int err = 0;
+	static const u16 hcnt[NUM_PLATFORMS][NUM_SPEEDS] = {
+		{ 0x75,  0x15, 0x07 },
+		{ 0x1EC, 0x70, 0x06 }
+	};
+	static const u16 lcnt[NUM_PLATFORMS][NUM_SPEEDS] = {
+		{ 0x7C,  0x21, 0x0E },
+		{ 0x1F3, 0x81, 0x0F }
+	};
 
 	/* Disable i2c first */
 	mrst_i2c_disable(i2c->adap);
@@ -134,46 +156,13 @@ static int mrst_i2c_hwinit(struct mrst_i2c_private *i2c)
 	 * enable master FSM, disable slave FSM,
 	 * use target address when initiating transfer
 	 */
-	switch (i2c->speed) {
-	case STANDARD:
-		mrst_i2c_write(i2c->base + IC_CON,
-			       SLV_DIS | RESTART | STANDARD_MODE | MASTER_EN);
-
-		if (i2c->platform == MEDFIELD) {
-			mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT, 0x1EC);
-			mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT, 0x1F3);
-		} else if (i2c->platform == MOORESTOWN) {
-			mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT, 0x75);
-			mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT, 0x7c);
-		}
-		break;
-	case FAST:
-		mrst_i2c_write(i2c->base + IC_CON,
-			       SLV_DIS | RESTART | FAST_MODE | MASTER_EN);
-
-		if (i2c->platform == MEDFIELD) {
-			mrst_i2c_write(i2c->base + IC_FS_SCL_HCNT, 0x70);
-			mrst_i2c_write(i2c->base + IC_FS_SCL_LCNT, 0x81);
-		} else if (i2c->platform == MOORESTOWN) {
-			mrst_i2c_write(i2c->base + IC_FS_SCL_HCNT, 0x15);
-			mrst_i2c_write(i2c->base + IC_FS_SCL_LCNT, 0x21);
-		}
-		break;
-	case HIGH:
-		mrst_i2c_write(i2c->base + IC_CON,
-			       SLV_DIS | RESTART | HIGH_MODE | MASTER_EN);
-
-		if (i2c->platform == MEDFIELD) {
-			mrst_i2c_write(i2c->base + IC_HS_SCL_HCNT, 0x6);
-			mrst_i2c_write(i2c->base + IC_HS_SCL_LCNT, 0xF);
-		} else if (i2c->platform == MOORESTOWN) {
-			mrst_i2c_write(i2c->base + IC_HS_SCL_HCNT, 0x7);
-			mrst_i2c_write(i2c->base + IC_HS_SCL_LCNT, 0xE);
-		}
-		break;
-	default:
-		;
-	}
+
+	mrst_i2c_write(i2c->base + IC_CON,
+		(i2c->speed + 1) << 1 | SLV_DIS | RESTART | MASTER_EN);
+	mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT,
+		hcnt[i2c->platform][i2c->speed]);
+	mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT,
+		lcnt[i2c->platform][i2c->speed]);
 
 	/* Set tranmit & receive FIFO threshold to zero */
 	mrst_i2c_write(i2c->base + IC_RX_TL, 0x0);
@@ -416,6 +405,7 @@ static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
 	int err;
 	uint32_t reg_val;
 	uint32_t bit_mask;
+	uint32_t mode;
 
 	/* Disable device first */
 	err = mrst_i2c_disable(adap);
@@ -425,34 +415,13 @@ static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
 		return -ETIMEDOUT;
 	}
 
-	/* set the speed mode to standard */
+	mode = 1 + (i2c->speed << 1);
+	/* set the speed mode */
 	reg_val = mrst_i2c_read(i2c->base + IC_CON);
-	switch (i2c->speed) {
-	case STANDARD:
-		if ((reg_val & 0x6) != STANDARD_MODE) {
-			dev_dbg(&adap->dev, "set standard mode\n");
-			mrst_i2c_write(i2c->base + IC_CON,
-				       (reg_val & (~0x6)) | STANDARD_MODE);
-		}
-		break;
-	case FAST:
-		if ((reg_val & 0x6) != FAST_MODE) {
-			dev_dbg(&adap->dev, "set fast mode\n");
-			mrst_i2c_write(i2c->base + IC_CON,
-				       (reg_val & (~0x6)) | FAST_MODE);
-		}
-		break;
-	case HIGH:
-		if ((reg_val & 0x6) != HIGH_MODE) {
-			dev_dbg(&adap->dev, "set high mode\n");
-			mrst_i2c_write(i2c->base + IC_CON,
-				       (reg_val & (~0x6)) | HIGH_MODE);
-		}
-		break;
-	default:
-		dev_dbg(&adap->dev, "set standard mode\n");
+	if ((reg_val & 0x06) != mode) {
+		dev_dbg(&adap->dev, "set mode %d\n", i2c->speed);
 		mrst_i2c_write(i2c->base + IC_CON,
-			       (reg_val & (~0x6)) | STANDARD_MODE);
+			       (reg_val & (~0x6)) | mode);
 	}
 
 	reg_val = mrst_i2c_read(i2c->base + IC_CON);
@@ -469,7 +438,7 @@ static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
 			mrst_i2c_write(i2c->base + IC_CON, reg_val & (~(1<<4)));
 		}
 	}
-	/*enable restart conditions */
+	/* enable restart conditions */
 	reg_val = mrst_i2c_read(i2c->base + IC_CON);
 	if ((reg_val & (1<<5)) != 1<<5) {
 		dev_dbg(&adap->dev, "enable restart conditions\n");
@@ -714,15 +683,17 @@ err:
 }
 
 static struct pci_device_id mrst_i2c_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0802)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0803)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0804)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0817)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0818)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0819)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x082C)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x082D)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x082E)},
+	/* Moorestown */
+	{PCI_VDEVICE(INTEL, 0x0802), 0 },
+	{PCI_VDEVICE(INTEL, 0x0803), 1 },
+	{PCI_VDEVICE(INTEL, 0x0804), 2 },
+	/* Medfield */
+	{PCI_VDEVICE(INTEL, 0x0817), 3,},
+	{PCI_VDEVICE(INTEL, 0x0818), 4 },
+	{PCI_VDEVICE(INTEL, 0x0819), 5 },
+	{PCI_VDEVICE(INTEL, 0x082C), 0 },
+	{PCI_VDEVICE(INTEL, 0x082D), 1 },
+	{PCI_VDEVICE(INTEL, 0x082E), 2 },
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, mrst_i2c_ids);
@@ -834,57 +805,21 @@ static int __devinit mrst_i2c_probe(struct pci_dev *dev,
 	pci_set_drvdata(dev, mrst);
 	i2c_set_adapdata(adap, mrst);
 
-	switch (id->device) {
-	case 0x0802:
-		dev_dbg(&dev->dev, KERN_INFO "I2C0\n");
-		adap->nr = busnum = 0;
-		mrst->platform = MOORESTOWN;
-		break;
-	case 0x0803:
-		dev_dbg(&dev->dev, KERN_INFO "I2C1\n");
-		adap->nr = busnum = 1;
+	adap->nr = busnum = id->driver_data;
+	if (dev->device <= 0x0804)
 		mrst->platform = MOORESTOWN;
-		break;
-	case 0x0804:
-		dev_dbg(&dev->dev, KERN_INFO "I2C2\n");
-		adap->nr = busnum = 2;
-		mrst->platform = MOORESTOWN;
-		break;
-	case 0x082C:
-		dev_dbg(&dev->dev, KERN_INFO "I2C0\n");
-		adap->nr = busnum = 0;
-		mrst->platform = MEDFIELD;
-		break;
-	case 0x082D:
-		dev_dbg(&dev->dev, KERN_INFO "I2C1\n");
-		adap->nr = busnum = 1;
-		mrst->platform = MEDFIELD;
-		break;
-	case 0x082E:
-		dev_dbg(&dev->dev, KERN_INFO "I2C2\n");
-		adap->nr = busnum = 2;
-		mrst->platform = MEDFIELD;
-		break;
-	case 0x0817:
-		dev_dbg(&dev->dev, KERN_INFO "I2C3\n");
-		adap->nr = busnum = 3;
-		mrst->platform = MEDFIELD;
-		break;
-	case 0x0818:
-		dev_dbg(&dev->dev, KERN_INFO "I2C4\n");
-		adap->nr = busnum = 4;
-		mrst->platform = MEDFIELD;
-		break;
-	case 0x0819:
-		dev_dbg(&dev->dev, KERN_INFO "I2C5\n");
-		adap->nr = busnum = 5;
+	else
 		mrst->platform = MEDFIELD;
-		break;
-	default:
-		;
+
+	dev_dbg(&dev->dev, "I2C%d\n", busnum);
+
+	if (ctl_num > busnum) {
+		if (speed_mode[busnum] < 0 || speed_mode[busnum] >= NUM_SPEEDS)
+			dev_warn(&dev->dev, "Invalid speed %d ignored.\n",
+							speed_mode[busnum]);
+		else
+			mrst->speed = speed_mode[busnum];
 	}
-	if (ctl_num > busnum)
-		mrst->speed = speed_mode[busnum];
 
 	/* Initialize i2c controller */
 	err = mrst_i2c_hwinit(mrst);
diff --git a/drivers/i2c/busses/i2c-mrst.h b/drivers/i2c/busses/i2c-mrst.h
index 441ff36..b0e4951 100644
--- a/drivers/i2c/busses/i2c-mrst.h
+++ b/drivers/i2c/busses/i2c-mrst.h
@@ -42,11 +42,6 @@ struct mrst_i2c_private {
 	spinlock_t	slock;
 };
 
-/* Speed mode macros */
-#define STANDARD	100
-#define FAST		25
-#define	HIGH		3
-
 #define ACTIVE		0
 #define STANDBY		1
 
