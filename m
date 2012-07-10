From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3 v4] i2c-i801: Enable interrupts on ICH5/7/8/9/10
Date: Tue, 10 Jul 2012 14:57:25 +0200
Message-ID: <20120710145725.43e2ae5e@endymion.delvare>
References: <20120710145156.306e611d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120710145156.306e611d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Enable interrupts on more devices. ICH5, ICH7(-M) and ICH10 have been
tested to work OK. ICH8 and ICH9 are expected to work just fine as
they are very close to ICH7 and ICH10.

Ultimately we want to enable this feature on at least every device
since the ICH5, but for now we limit the exposure. We'll enable it for
other devices if we don't get negative feedback.

As a bonus, let the user know when interrupts are used.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- linux-3.5-rc6.orig/drivers/i2c/busses/i2c-i801.c	2012-07-10 14:03:24.942225018 +0200
+++ linux-3.5-rc6/drivers/i2c/busses/i2c-i801.c	2012-07-10 14:05:39.764553569 +0200
@@ -862,8 +862,14 @@ static int __devinit i801_probe(struct p
 		break;
 	}
 
-	/* IRQ processing only tested on CougarPoint PCH */
-	if (dev->device == PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS)
+	/* IRQ processing tested on CougarPoint PCH, ICH5, ICH7-M and ICH10 */
+	if (dev->device == PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS ||
+	    dev->device == PCI_DEVICE_ID_INTEL_82801EB_3 ||
+	    dev->device == PCI_DEVICE_ID_INTEL_ICH7_17 ||
+	    dev->device == PCI_DEVICE_ID_INTEL_ICH8_5 ||
+	    dev->device == PCI_DEVICE_ID_INTEL_ICH9_6 ||
+	    dev->device == PCI_DEVICE_ID_INTEL_ICH10_4 ||
+	    dev->device == PCI_DEVICE_ID_INTEL_ICH10_5)
 		priv->features |= FEATURE_IRQ;
 
 	/* Disable features on user request */
@@ -917,8 +923,6 @@ static int __devinit i801_probe(struct p
 		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
 		/* Disable SMBus interrupt feature if SMBus using SMI# */
 		priv->features &= ~FEATURE_IRQ;
-	} else {
-		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
 	}
 
 	/* Clear special mode bits */
@@ -936,6 +940,7 @@ static int __devinit i801_probe(struct p
 				dev->irq, err);
 			goto exit_release;
 		}
+		dev_info(&dev->dev, "SMBus using PCI Interrupt\n");
 	}
 
 	/* set up the sysfs linkage to our parent device */

-- 
Jean Delvare
