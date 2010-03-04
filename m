From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: All newer devices have all the optional features
Date: Thu, 4 Mar 2010 11:54:04 +0100
Message-ID: <20100304115404.092b8183@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Only the oldest devices lack some of the features supported by this
driver. List them explicitly, and default to all features enabled for
all other chips, including the ones added through sysfs. This will
make future driver maintenance easier.

In the unlikely event of a not yet supported device not implementing
all the features, one can always use the disable_features module
parameter to prevent the driver from attempting to use them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Seth, what do you think? Does it make sense to you?

 drivers/i2c/busses/i2c-i801.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/i2c/busses/i2c-i801.c	2010-03-04 11:16:56.000000000 +0100
+++ linux-2.6.34-rc0/drivers/i2c/busses/i2c-i801.c	2010-03-04 11:27:09.000000000 +0100
@@ -711,23 +711,17 @@ static int __devinit i801_probe(struct p
 	I801_dev = dev;
 	i801_features = 0;
 	switch (dev->device) {
-	case PCI_DEVICE_ID_INTEL_82801EB_3:
-	case PCI_DEVICE_ID_INTEL_ESB_4:
-	case PCI_DEVICE_ID_INTEL_ICH6_16:
-	case PCI_DEVICE_ID_INTEL_ICH7_17:
-	case PCI_DEVICE_ID_INTEL_ESB2_17:
-	case PCI_DEVICE_ID_INTEL_ICH8_5:
-	case PCI_DEVICE_ID_INTEL_ICH9_6:
-	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
-	case PCI_DEVICE_ID_INTEL_ICH10_4:
-	case PCI_DEVICE_ID_INTEL_ICH10_5:
-	case PCI_DEVICE_ID_INTEL_PCH_SMBUS:
-	case PCI_DEVICE_ID_INTEL_CPT_SMBUS:
+	default:
 		i801_features |= FEATURE_I2C_BLOCK_READ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
 		i801_features |= FEATURE_SMBUS_PEC;
 		i801_features |= FEATURE_BLOCK_BUFFER;
+		/* fall through */
+	case PCI_DEVICE_ID_INTEL_82801CA_3:
+	case PCI_DEVICE_ID_INTEL_82801BA_2:
+	case PCI_DEVICE_ID_INTEL_82801AB_3:
+	case PCI_DEVICE_ID_INTEL_82801AA_3:
 		break;
 	}
 

-- 
Jean Delvare
