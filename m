From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] i2c-viapro: Add VIA VX900 device ID
Date: Mon, 1 Oct 2012 14:42:41 +0200
Message-ID: <20121001144241.0db334d5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The SMBus controller in the VIA VX900 appears to be compatible with
the VIA VX855, so just add the device ID.

This closes kernel bug #43096.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/busses/i2c-viapro |    6 +++++-
 drivers/i2c/busses/Kconfig          |    3 ++-
 drivers/i2c/busses/i2c-viapro.c     |    3 +++
 include/linux/pci_ids.h             |    1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

Changes since v1:
 * Documentation update
 * Kconfig update

--- linux-3.6.orig/drivers/i2c/busses/i2c-viapro.c	2012-07-21 22:58:29.=
000000000 +0200
+++ linux-3.6/drivers/i2c/busses/i2c-viapro.c	2012-10-01 13:04:20.88679=
1686 +0200
@@ -401,6 +401,7 @@ found:
 	case PCI_DEVICE_ID_VIA_CX700:
 	case PCI_DEVICE_ID_VIA_VX800:
 	case PCI_DEVICE_ID_VIA_VX855:
+	case PCI_DEVICE_ID_VIA_VX900:
 	case PCI_DEVICE_ID_VIA_8251:
 	case PCI_DEVICE_ID_VIA_8237:
 	case PCI_DEVICE_ID_VIA_8237A:
@@ -470,6 +471,8 @@ static DEFINE_PCI_DEVICE_TABLE(vt596_ids
 	  .driver_data =3D SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855),
 	  .driver_data =3D SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX900),
+	  .driver_data =3D SMBBA3 },
 	{ 0, }
 };
=20
--- linux-3.6.orig/include/linux/pci_ids.h	2012-10-01 09:22:40.00000000=
0 +0200
+++ linux-3.6/include/linux/pci_ids.h	2012-10-01 13:04:20.887791687 +02=
00
@@ -1426,6 +1426,7 @@
 #define PCI_DEVICE_ID_VIA_CX700_IDE	0x0581
 #define PCI_DEVICE_ID_VIA_VX800		0x8353
 #define PCI_DEVICE_ID_VIA_VX855		0x8409
+#define PCI_DEVICE_ID_VIA_VX900		0x8410
 #define PCI_DEVICE_ID_VIA_8371_1	0x8391
 #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
 #define PCI_DEVICE_ID_VIA_838X_1	0xB188
--- linux-3.6.orig/Documentation/i2c/busses/i2c-viapro	2012-07-21 22:58=
:29.000000000 +0200
+++ linux-3.6/Documentation/i2c/busses/i2c-viapro	2012-10-01 14:02:54.9=
98072457 +0200
@@ -20,7 +20,10 @@ Supported adapters:
     Datasheet: available on http://linux.via.com.tw
=20
   * VIA Technologies, Inc. VX855/VX875
-    Datasheet: Availability unknown
+    Datasheet: available on http://linux.via.com.tw
+
+  * VIA Technologies, Inc. VX900
+    Datasheet: available on http://linux.via.com.tw
=20
 Authors:
 	Ky=F6sti M=E4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>,
@@ -57,6 +60,7 @@ Your lspci -n listing must show one of t
  device 1106:8324   (CX700)
  device 1106:8353   (VX800/VX820)
  device 1106:8409   (VX855/VX875)
+ device 1106:8410   (VX900)
=20
 If none of these show up, you should look in the BIOS for settings lik=
e
 enable ACPI / SMBus or even USB.
--- linux-3.6.orig/drivers/i2c/busses/Kconfig	2012-10-01 14:02:08.00000=
0000 +0200
+++ linux-3.6/drivers/i2c/busses/Kconfig	2012-10-01 14:04:19.705089338 =
+0200
@@ -226,7 +226,7 @@ config I2C_VIA
 	  will be called i2c-via.
=20
 config I2C_VIAPRO
-	tristate "VIA VT82C596/82C686/82xx and CX700/VX8xx"
+	tristate "VIA VT82C596/82C686/82xx and CX700/VX8xx/VX900"
 	depends on PCI
 	help
 	  If you say yes to this option, support will be included for the VIA
@@ -242,6 +242,7 @@ config I2C_VIAPRO
 	    CX700
 	    VX800/VX820
 	    VX855/VX875
+	    VX900
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-viapro.


--=20
Jean Delvare
