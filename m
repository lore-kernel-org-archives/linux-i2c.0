From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Enable interrupts for all post-ICH5 chips
Date: Wed, 31 Oct 2012 12:03:36 +0100
Message-ID: <20121031120336.3229e1a2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I did not receive a single bug report after interrupt support was
added for a limited number of chips. So I'd say the code is good and
should be enabled for all supported chips, that is: ICH5 and later.

For now the IDF channels are excluded as I have no idea if they
support interrupts too or not.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Would be great if someone could test interrupts on IDF channels and
report.

 drivers/i2c/busses/i2c-i801.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- linux-3.7-rc3.orig/drivers/i2c/busses/i2c-i801.c	2012-10-31 11:45:15.000000000 +0100
+++ linux-3.7-rc3/drivers/i2c/busses/i2c-i801.c	2012-10-31 11:49:01.064163932 +0100
@@ -1109,6 +1109,8 @@ static int __devinit i801_probe(struct p
 		/* fall through */
 	default:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
+		if (!(priv->features & FEATURE_IDF))
+			priv->features |= FEATURE_IRQ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
 		priv->features |= FEATURE_SMBUS_PEC;
@@ -1121,16 +1123,6 @@ static int __devinit i801_probe(struct p
 		break;
 	}
 
-	/* IRQ processing tested on CougarPoint PCH, ICH5, ICH7-M and ICH10 */
-	if (dev->device == PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS ||
-	    dev->device == PCI_DEVICE_ID_INTEL_82801EB_3 ||
-	    dev->device == PCI_DEVICE_ID_INTEL_ICH7_17 ||
-	    dev->device == PCI_DEVICE_ID_INTEL_ICH8_5 ||
-	    dev->device == PCI_DEVICE_ID_INTEL_ICH9_6 ||
-	    dev->device == PCI_DEVICE_ID_INTEL_ICH10_4 ||
-	    dev->device == PCI_DEVICE_ID_INTEL_ICH10_5)
-		priv->features |= FEATURE_IRQ;
-
 	/* Disable features on user request */
 	for (i = 0; i < ARRAY_SIZE(i801_feature_names); i++) {
 		if (priv->features & disable_features & (1 << i))


-- 
Jean Delvare
