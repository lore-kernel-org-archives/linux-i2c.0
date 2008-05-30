From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
Subject: [PATCH] unhide smbus on Compaq Deskpro EN
Date: Fri, 30 May 2008 23:21:18 +0200
Message-ID: <20080530232118.1b0078ff.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: =?ISO-8859-2?Q?Rafa=B3_Ha=B3aduda?= <rh1985-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

This patch unhides the smbus on Compaq Deskpro EN
SFF P667 with the Intel 815E chipset. =

The patch was tested on Fedora Core 9 with 2.6.25.4 kernel.

Signed-off-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
Tested-by: Rafa=B3 Ha=B3aduda <rh1985-5tc4TXWwyLM@public.gmane.org>

---

No side effects were observed. The ACPI controlled fan
correctly with the patch applied. Tested with 667 and
1000 MHz CPUs.
The patch allows using the THMC51 sensor chip on
the motherboard.
The patch was done against the kernel 2.6.26-rc2-mm1

diff -urp linux-2.6.25/drivers/pci/quirks.c linux-new/drivers/pci/quirks.c
--- linux-2.6.25/drivers/pci/quirks.c	2008-05-27 21:58:34.380144607 +0200
+++ linux-new/drivers/pci/quirks.c	2008-05-30 23:12:57.510219450 +0200
@@ -1054,6 +1054,14 @@ static void __init asus_hides_smbus_host
 				 * its on-board VGA controller */
 				asus_hides_smbus =3D 1;
 			}
+		else if (dev->device =3D=3D PCI_DEVICE_ID_INTEL_82815_CGC)
+			switch (dev->subsystem_device) {
+			case 0x001A: /* Compaq Deskpro EN ENS/P667/e */
+				/* Motherboard doesn't have Host bridge
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
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
