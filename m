From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/4 v2] i2c-i801: Check if interrupts are disabled
Date: Wed, 12 Nov 2014 10:25:37 +0100
Message-ID: <20141112102537.654bb894@endymion.delvare>
References: <20141112101931.5f8c196a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141112101931.5f8c196a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is a control bit in the PCI configuration space which disables
interrupts. If this bit is set, the driver should not try to make use
of interrupts, it won't receive any.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
Changes since v1:
 * Turned warning message into info message and made it shorter.

 drivers/i2c/busses/i2c-i801.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- linux-3.18-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-11-11 14:56:35.777941563 +0100
+++ linux-3.18-rc4/drivers/i2c/busses/i2c-i801.c	2014-11-11 15:32:30.128418755 +0100
@@ -110,12 +110,16 @@
 
 /* PCI Address Constants */
 #define SMBBAR		4
+#define SMBPCICTL	0x004
 #define SMBPCISTS	0x006
 #define SMBHSTCFG	0x040
 
 /* Host status bits for SMBPCISTS */
 #define SMBPCISTS_INTS		0x08
 
+/* Control bits for SMBPCICTL */
+#define SMBPCICTL_INTDIS	0x0400
+
 /* Host configuration bits for SMBHSTCFG */
 #define SMBHSTCFG_HST_EN	1
 #define SMBHSTCFG_SMB_SMI_EN	2
@@ -1235,6 +1239,22 @@ static int i801_probe(struct pci_dev *de
 	priv->adapter.timeout = HZ / 5;
 
 	if (priv->features & FEATURE_IRQ) {
+		u16 pcictl, pcists;
+
+		/* Complain if an interrupt is already pending */
+		pci_read_config_word(priv->pci_dev, SMBPCISTS, &pcists);
+		if (pcists & SMBPCISTS_INTS)
+			dev_warn(&dev->dev, "An interrupt is pending!\n");
+
+		/* Check if interrupts have been disabled */
+		pci_read_config_word(priv->pci_dev, SMBPCICTL, &pcictl);
+		if (pcictl & SMBPCICTL_INTDIS) {
+			dev_info(&dev->dev, "Interrupts are disabled\n");
+			priv->features &= ~FEATURE_IRQ;
+		}
+	}
+
+	if (priv->features & FEATURE_IRQ) {
 		init_waitqueue_head(&priv->waitq);
 
 		err = request_irq(dev->irq, i801_isr, IRQF_SHARED,

-- 
Jean Delvare
SUSE L3 Support
