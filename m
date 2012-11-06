From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] i2c-i801: Enable interrupts for all post-ICH5 chips
Date: Tue, 6 Nov 2012 20:38:03 +0100
Message-ID: <20121106203803.6af84fc8@endymion.delvare>
References: <20121031120336.3229e1a2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121031120336.3229e1a2-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I did not receive a single bug report after interrupt support was
added for a limited number of chips. So I'd say the code is good and
should be enabled for all supported chips, that is: ICH5 and later.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
I was able to test on Patsburg IDF channels and although I couldn't
test all transaction types, interrupts seem to work the same as on the
main SMBus channel so let's enable interrupts there too.

 drivers/i2c/busses/i2c-i801.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- linux-3.7-rc4.orig/drivers/i2c/busses/i2c-i801.c	2012-11-05 16:55:23.271739149 +0100
+++ linux-3.7-rc4/drivers/i2c/busses/i2c-i801.c	2012-11-06 19:26:04.073280924 +0100
@@ -1109,6 +1109,7 @@ static int __devinit i801_probe(struct p
 		/* fall through */
 	default:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
+		priv->features |= FEATURE_IRQ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
 		priv->features |= FEATURE_SMBUS_PEC;
@@ -1121,16 +1122,6 @@ static int __devinit i801_probe(struct p
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
