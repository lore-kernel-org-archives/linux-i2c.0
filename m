From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c/scx200_acb: Make PCI device ids constant
Date: Wed, 3 Mar 2010 10:46:42 +0100
Message-ID: <20100303104642.39999e1f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: =?UTF-8?B?TcOhcnRvbiBOw6ltZXRo?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make PCI device ids constant as we just did for many other i2c bus
drivers already.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: M=C3=A1rton N=C3=A9meth <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
---
 drivers/i2c/busses/scx200_acb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.34-rc0.orig/drivers/i2c/busses/scx200_acb.c	2010-03-03 10=
:34:33.000000000 +0100
+++ linux-2.6.34-rc0/drivers/i2c/busses/scx200_acb.c	2010-03-03 10:36:2=
7.000000000 +0100
@@ -551,7 +551,7 @@ static int __init scx200_create_isa(cons
  * the name and the BAR where the I/O address resource is located.  IS=
A
  * devices are flagged with a bar value of -1 */
=20
-static struct pci_device_id scx200_pci[] =3D {
+static const struct pci_device_id scx200_pci[] __initconst =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE),
 	  .driver_data =3D 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE),


--=20
Jean Delvare
