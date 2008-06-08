From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
Subject: [lm-sensors] [PATCH] Unhide the SMBus on the Compaq Deskpro EN
Date: Sun, 8 Jun 2008 13:47:02 +0200
Message-ID: <20080608134702.401b9fb5.krzysztof.h1__10741.8444742963$1212937903$gmane$org@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Resent-To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Resent-Message-Id: <20080608150641.0A754B023F-TQbIPhKO3ozyTWYhgeVQUIc4+0ux1AK3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: rh1985-5tc4TXWwyLM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

This patch unhides the SMBus on Compaq Deskpro EN
SFF P667 with the Intel 815E chipset. Unhiding it reveals =

a THMC51 hardware monitoring chip.

Jean Delvare has checked that this machine has no ACPI
magic touching the SMBus nor the hardware monitoring chip,
so this should be safe.

The patch was tested on Fedora Core 9 with 2.6.25.4 kernel.

Signed-off-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
Tested-by: Rafa=B3 Ha=B3aduda <rh1985-5tc4TXWwyLM@public.gmane.org>
CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

---
If someone owns the Compaq Deskpro EN machine, please
test the patch as well.

diff -urp linux-2.6.25/drivers/pci/quirks.c linux-new/drivers/pci/quirks.c
--- linux-2.6.25/drivers/pci/quirks.c	2008-05-27 21:58:34.380144607 +0200
+++ linux-new/drivers/pci/quirks.c	2008-05-30 23:12:57.510219450 +0200
@@ -1054,6 +1054,14 @@ static void __init asus_hides_smbus_host
 				 * its on-board VGA controller */
 				asus_hides_smbus =3D 1;
 			}
+		else if (dev->device =3D=3D PCI_DEVICE_ID_INTEL_82815_CGC)
+			switch (dev->subsystem_device) {
+			case 0x001A: /* Compaq Deskpro EN SSF P667 815E */
+				/* Motherboard doesn't have host bridge
+				 * subvendor/subdevice IDs, therefore checking
+				 * its on-board VGA controller */
+				asus_hides_smbus =3D 1;
+			}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB=
,	asus_hides_smbus_hostbridge);
@@ -1068,6 +1076,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_=
HB, asus_hides_smbus_hostbridge);
 =

 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82810_IG=
3,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82815_CG=
C,	asus_hides_smbus_hostbridge);
 =

 static void asus_hides_smbus_lpc(struct pci_dev *dev)
 {


_______________________________________________
lm-sensors mailing list
lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
