From: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Subject: [PATCH] Add VX800/VX820 support to i2c-viapro
Date: Sun, 10 Aug 2008 21:15:57 +0200
Message-ID: <489F3E6D.1010509@assembler.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080707090602030803030704"
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: bari <bari-LYzr9vXrEAJBDgjK7y7TUQ@public.gmane.org>, BruceChang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------080707090602030803030704
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thanks to new datasheets published on http://linux.via.com.tw we can now add 
support for VX800/VX820 chipsets.

If anyone has the hardware, please test the patch in attachment. Some simple 
test with i2cdump should be enough the hardware controller is same as on other 
chipsets.

Signed-off-by: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>

Thank you,

Thanks,
Rudolf

--------------080707090602030803030704
Content-Type: text/x-diff;
 name="i2c-vx800.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="i2c-vx800.patch"

Index: linux-2.6.27-rc2/Documentation/i2c/busses/i2c-viapro
===================================================================
--- linux-2.6.27-rc2.orig/Documentation/i2c/busses/i2c-viapro	2008-08-10 20:18:18.318417241 +0200
+++ linux-2.6.27-rc2/Documentation/i2c/busses/i2c-viapro	2008-08-10 21:07:53.473368491 +0200
@@ -16,6 +16,9 @@
   * VIA Technologies, Inc. CX700
     Datasheet: available on request and under NDA from VIA
 
+  * VIA Technologies, Inc. VX800/VX820
+    Datasheet: available on http://linux.via.com.tw
+
 Authors:
 	Kyösti Mälkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>,
 	Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
@@ -49,6 +52,7 @@
  device 1106:3372   (VT8237S)
  device 1106:3287   (VT8251)
  device 1106:8324   (CX700)
+ device 1106:8353   (VX800/VX820)
 
 If none of these show up, you should look in the BIOS for settings like
 enable ACPI / SMBus or even USB.
@@ -57,5 +61,5 @@
 VT8231), this driver supports I2C block transactions. Such transactions
 are mainly useful to read from and write to EEPROMs.
 
-The CX700 additionally appears to support SMBus PEC, although this driver
-doesn't implement it yet.
+The CX700/VX800/VX820 additionally appears to support SMBus PEC, although
+this driver doesn't implement it yet.
Index: linux-2.6.27-rc2/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6.27-rc2.orig/drivers/i2c/busses/Kconfig	2008-08-10 20:19:54.809322776 +0200
+++ linux-2.6.27-rc2/drivers/i2c/busses/Kconfig	2008-08-10 20:26:42.832574696 +0200
@@ -209,7 +209,7 @@
 	  will be called i2c-via.
 
 config I2C_VIAPRO
-	tristate "VIA VT82C596/82C686/82xx and CX700"
+	tristate "VIA VT82C596/82C686/82xx and CX700/VX800/VX820"
 	depends on PCI
 	help
 	  If you say yes to this option, support will be included for the VIA
@@ -223,6 +223,8 @@
 	    VT8237R/A/S
 	    VT8251
 	    CX700
+	    VX800
+	    VX820
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-viapro.
Index: linux-2.6.27-rc2/drivers/i2c/busses/i2c-viapro.c
===================================================================
--- linux-2.6.27-rc2.orig/drivers/i2c/busses/i2c-viapro.c	2008-08-10 20:20:08.310092141 +0200
+++ linux-2.6.27-rc2/drivers/i2c/busses/i2c-viapro.c	2008-08-10 20:31:30.348959321 +0200
@@ -36,6 +36,7 @@
    VT8237S            0x3372             yes
    VT8251             0x3287             yes
    CX700              0x8324             yes
+   VX800/VX820        0x8353             yes
 
    Note: we assume there can only be one device, with one SMBus interface.
 */
@@ -396,6 +397,7 @@
 
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_VIA_CX700:
+	case PCI_DEVICE_ID_VIA_VX800:
 	case PCI_DEVICE_ID_VIA_8251:
 	case PCI_DEVICE_ID_VIA_8237:
 	case PCI_DEVICE_ID_VIA_8237A:
@@ -459,6 +461,8 @@
 	  .driver_data = SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_CX700),
 	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800),
+	  .driver_data = SMBBA3 },
 	{ 0, }
 };
 

--------------080707090602030803030704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------080707090602030803030704--
