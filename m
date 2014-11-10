From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/4] i2c-i801: Fallback to polling if request_irq() fails
Date: Mon, 10 Nov 2014 22:31:04 +0100
Message-ID: <20141110223104.6419229d@endymion.delvare>
References: <20141110222655.13660613@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141110222655.13660613-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-i801 driver can work without interrupts, so there is no reason
to make a request_irq failure fatal. Instead we can simply fallback
to polling.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-3.18-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:42.788955868 +0100
+++ linux-3.18-rc4/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:44.416991298 +0100
@@ -1242,9 +1242,11 @@ static int i801_probe(struct pci_dev *de
 		if (err) {
 			dev_err(&dev->dev, "Failed to allocate irq %d: %d\n",
 				dev->irq, err);
-			goto exit_release;
+			priv->features &= ~FEATURE_IRQ;
+			dev_info(&dev->dev, "SMBus using polling\n");
+		} else {
+			dev_info(&dev->dev, "SMBus using PCI interrupt\n");
 		}
-		dev_info(&dev->dev, "SMBus using PCI Interrupt\n");
 	}
 
 	/* set up the sysfs linkage to our parent device */
@@ -1272,7 +1274,6 @@ static int i801_probe(struct pci_dev *de
 exit_free_irq:
 	if (priv->features & FEATURE_IRQ)
 		free_irq(dev->irq, priv);
-exit_release:
 	pci_release_region(dev, SMBBAR);
 exit:
 	kfree(priv);

-- 
Jean Delvare
SUSE L3 Support
