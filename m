From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/2] i2c-eg20t: Support new device LAPIS Semiconductor ML7831 IOH
Date: Fri, 28 Oct 2011 09:40:10 +0900
Message-ID: <1319762411-7174-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ML7831 is companion chip for Intel Atom E6xx series.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/Kconfig     |   14 +++++++-------
 drivers/i2c/busses/i2c-eg20t.c |    3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a3afac4..72509a0 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -682,19 +682,19 @@ config I2C_XILINX
 	  will be called xilinx_i2c.
 
 config I2C_EG20T
-	tristate "Intel EG20T PCH / OKI SEMICONDUCTOR IOH(ML7213/ML7223)"
+	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
 	depends on PCI
 	help
 	  This driver is for PCH(Platform controller Hub) I2C of EG20T which
 	  is an IOH(Input/Output Hub) for x86 embedded processor.
 	  This driver can access PCH I2C bus device.
 
-	  This driver also can be used for OKI SEMICONDUCTOR IOH(Input/
-	  Output Hub), ML7213 and ML7223.
-	  ML7213 IOH is for IVI(In-Vehicle Infotainment) use and ML7223 IOH is
-	  for MP(Media Phone) use.
-	  ML7213/ML7223 is companion chip for Intel Atom E6xx series.
-	  ML7213/ML7223 is completely compatible for Intel EG20T PCH.
+	  This driver also can be used for LAPIS Semiconductor IOH(Input/
+	  Output Hub), ML7213, ML7223 and ML7831.
+	  ML7213 IOH is for IVI(In-Vehicle Infotainment) use, ML7223 IOH is
+	  for MP(Media Phone) use and ML7831 IOH is for general purpose use.
+	  ML7213/ML7223/ML7831 is companion chip for Intel Atom E6xx series.
+	  ML7213/ML7223/ML7831 is completely compatible for Intel EG20T PCH.
 
 comment "External I2C/SMBus adapter drivers"
 
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index ce1a32b..62135bc 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -136,6 +136,7 @@
 Set the number of I2C instance max
 Intel EG20T PCH :		1ch
 OKI SEMICONDUCTOR ML7213 IOH :	2ch
+OKI SEMICONDUCTOR ML7831 IOH :	1ch
 */
 #define PCH_I2C_MAX_DEV			2
 
@@ -183,11 +184,13 @@ static DEFINE_MUTEX(pch_mutex);
 #define PCI_VENDOR_ID_ROHM		0x10DB
 #define PCI_DEVICE_ID_ML7213_I2C	0x802D
 #define PCI_DEVICE_ID_ML7223_I2C	0x8010
+#define PCI_DEVICE_ID_ML7831_I2C	0x8817
 
 static struct pci_device_id __devinitdata pch_pcidev_id[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH_I2C),   1, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_I2C), 2, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_I2C), 1, },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), 1, },
 	{0,}
 };
 
-- 
1.7.4.4
