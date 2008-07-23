From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/03] i2c-i801: Add basic interrupt support
Date: Wed, 23 Jul 2008 18:56:40 +0200
Message-ID: <488762C8.6090105@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010703060308060401020105"
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703060308060401020105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds basic interrupt support to the i2c-i801 driver.

Signed-off-by: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---


--------------010703060308060401020105
Content-Type: text/plain;
 name="patch1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1.diff"

--- i2c-i801.c.git	2008-07-03 15:47:32.000000000 +0200
+++ i2c-i801.c	2008-07-07 15:04:25.000000000 +0200
@@ -63,6 +63,7 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <asm/io.h>
 
@@ -100,6 +101,7 @@
 
 /* I801 command constants */
 #define I801_QUICK		0x00
+#define I801_HST_CNT_INTREN	0x01
 #define I801_BYTE		0x04
 #define I801_BYTE_DATA		0x08
 #define I801_WORD_DATA		0x0C
@@ -121,23 +123,65 @@
 #define SMBHSTSTS_INTR		0x02
 #define SMBHSTSTS_HOST_BUSY	0x01
 
+/* mask for events we normally handle */
+#define I801_HST_STS_MASK_NORM ( \
+		SMBHSTSTS_FAILED | \
+		SMBHSTSTS_BUS_ERR | \
+		SMBHSTSTS_DEV_ERR | \
+		SMBHSTSTS_INTR)
+
+/* mask for all events */
+#define I801_HST_STS_MASK_ALL ( \
+		SMBHSTSTS_BYTE_DONE | \
+		SMBHSTSTS_SMBALERT_STS | \
+		SMBHSTSTS_FAILED | \
+		SMBHSTSTS_BUS_ERR | \
+		SMBHSTSTS_DEV_ERR | \
+		SMBHSTSTS_INTR)
+
 static unsigned long i801_smba;
 static unsigned char i801_original_hstcfg;
+static struct i2c_adapter i801_adapter;
 static struct pci_driver i801_driver;
 static struct pci_dev *I801_dev;
 
+struct i2c_i801_algo_data {
+	spinlock_t lock;
+	wait_queue_head_t waitq;
+	int status; /* copy of h/w register */
+	int irq;
+};
+
+static struct i2c_i801_algo_data i801_algo_data;
+
 #define FEATURE_SMBUS_PEC	(1 << 0)
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 static unsigned int i801_features;
 
+/* fetch & consume host status out of algo_data */
+static inline int i801_get_status(struct i2c_i801_algo_data *algo_data)
+{
+	unsigned long flags;
+	int status;
+
+	spin_lock_irqsave(&algo_data->lock, flags);
+	status = algo_data->status;
+	algo_data->status = 0;
+	spin_unlock_irqrestore(&algo_data->lock, flags);
+
+	return status;
+}
+
 static int i801_transaction(int xact)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
+	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
+
 	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
@@ -159,6 +203,13 @@ static int i801_transaction(int xact)
 
 	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
 	 * INTREN, SMBSCMD are passed in xact */
+	if (algo_data->irq >= 0) {
+		outb_p(xact | I801_START | I801_HST_CNT_INTREN, SMBHSTCNT);
+
+		wait_event_interruptible_timeout(algo_data->waitq,
+					((temp = i801_get_status(algo_data))
+					& I801_HST_STS_MASK_NORM), HZ/2);
+	} else {
 	outb_p(xact | I801_START, SMBHSTCNT);
 
 	/* We will always wait for a fraction of a second! */
@@ -177,6 +228,7 @@ static int i801_transaction(int xact)
 		msleep(1);
 		outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL), SMBHSTCNT);
 	}
+	}
 
 	if (temp & SMBHSTSTS_FAILED) {
 		result = -1;
@@ -574,6 +626,7 @@ static struct i2c_adapter i801_adapter =
 	.id		= I2C_HW_SMBUS_I801,
 	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
+	.algo_data	= &i801_algo_data
 };
 
 static struct pci_device_id i801_ids[] = {
@@ -597,8 +650,38 @@ static struct pci_device_id i801_ids[] =
 
 MODULE_DEVICE_TABLE (pci, i801_ids);
 
+static irqreturn_t i801_isr(int irq, void *dev_id)
+{
+	u8 status = inb(SMBHSTSTS);
+
+	/* bail if it's not ours */
+	if (!(status & I801_HST_STS_MASK_ALL)) {
+		dev_dbg(&I801_dev->dev, "BAILING interrupt\n");
+		return IRQ_NONE;
+	}
+
+	dev_dbg(&I801_dev->dev, "INTERRUPT: IRQ status: 0x%02x\n", status);
+
+	/* ACK */
+	outb((status & I801_HST_STS_MASK_ALL), SMBHSTSTS);
+
+	if (status & I801_HST_STS_MASK_NORM) {
+		struct i2c_adapter *adap = dev_id;
+		struct i2c_i801_algo_data *algo_data = adap->algo_data;
+		unsigned long flags;
+
+		spin_lock_irqsave(&algo_data->lock, flags);
+		algo_data->status = status;
+		spin_unlock_irqrestore(&algo_data->lock, flags);
+		wake_up_interruptible(&algo_data->waitq);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
 	unsigned char temp;
 	int err;
 
@@ -656,10 +739,27 @@ static int __devinit i801_probe(struct p
 	}
 	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
 
-	if (temp & SMBHSTCFG_SMB_SMI_EN)
+	if (temp & SMBHSTCFG_SMB_SMI_EN) {
 		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
-	else
+		algo_data->irq = -1;
+	} else {
 		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
+		if ((request_irq(I801_dev->irq, i801_isr, IRQF_SHARED,
+				 i801_adapter.name, &i801_adapter))) {
+			dev_err(&dev->dev,
+				"request irq %d failed!\n", I801_dev->irq);
+			algo_data->irq = -1;
+		} else {
+			dev_dbg(&dev->dev,
+				"SMBus base address: 0x%04lx, IRQ: %d\n",
+				i801_smba, I801_dev->irq);
+
+			algo_data->irq = I801_dev->irq;
+			algo_data->status = 0;
+			init_waitqueue_head(&algo_data->waitq);
+			spin_lock_init(&algo_data->lock);
+		}
+	}
 
 	/* Clear special mode bits */
 	if (i801_features & (FEATURE_SMBUS_PEC | FEATURE_BLOCK_BUFFER))
@@ -686,6 +786,10 @@ exit:
 
 static void __devexit i801_remove(struct pci_dev *dev)
 {
+	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
+	if (algo_data->irq >= 0)
+		free_irq(dev->irq, &i801_adapter);
+
 	i2c_del_adapter(&i801_adapter);
 	pci_write_config_byte(I801_dev, SMBHSTCFG, i801_original_hstcfg);
 	pci_release_region(dev, SMBBAR);

--------------010703060308060401020105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------010703060308060401020105--
