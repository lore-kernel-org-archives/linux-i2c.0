From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] PCI: Unhide the SMBus on the Compaq Evo D510 USDT
Date: Tue, 28 Jul 2009 11:49:19 +0200
Message-ID: <20090728114919.211f48a3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nuzhna Pomoshch <nuzhna_pomoshch-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Subject: PCI: Unhide the SMBus on the Compaq Evo D510 USDT

One more form factor for Compaq Evo D510, which needs the same quirk
as the other form factors. Apparently there's no hardware monitoring
chip on that one, but SPD EEPROMs, so it's still worth unhiding the
SMBus.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Tested-by: Nuzhna Pomoshch <nuzhna_pomoshch-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
---
 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.31-rc4.orig/drivers/pci/quirks.c	2009-07-14 10:26:41.000000000 +0200
+++ linux-2.6.31-rc4/drivers/pci/quirks.c	2009-07-27 14:47:15.000000000 +0200
@@ -1201,6 +1201,7 @@ static void __init asus_hides_smbus_host
 			switch(dev->subsystem_device) {
 			case 0x00b8: /* Compaq Evo D510 CMT */
 			case 0x00b9: /* Compaq Evo D510 SFF */
+			case 0x00ba: /* Compaq Evo D510 USDT */
 				/* Motherboard doesn't have Host bridge
 				 * subvendor/subdevice IDs and on-board VGA
 				 * controller is disabled if an AGP card is


-- 
Jean Delvare
