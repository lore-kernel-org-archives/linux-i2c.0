From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] MAINTAINERS: i2c: 7 years, this is it
Date: Mon, 5 Nov 2012 17:05:54 +0100
Message-ID: <20121105170554.1972f3c2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I have been maintaining the i2c subsystem for 7 years now, it's about
time to let someone else take over. Just before I leave, I would like
to thank several individuals who made this possible at all:

* Greg Kroah-Hartman, for his faith in my potential subsystem
  maintainer skills. Greg, I hope I met your expectations.
* Late David Brownell, for helping me convert the i2c subsystem to the
  standard device driver model. Rest in peace David, we're missing you.
* Ben Dooks, for stepping in when I asked for someone to take care of
  the huge flow of new i2c adapter drivers for embedded systems.
* Wolfram Sang, for joining the crew when it became clear that there
  was more review work than Ben and myself could deal with.

I hope I did not forget anyone, please forgive me if I did.

Another big thank is due to Wolfram again, who quickly proposed to
take over as the main i2c subsystem maintainer. This will allow for a
smooth and fast transition.

Note that I will keep maintaining all I2C/SMBus controller drivers for
PC systems as well as a few others. I am hereby updating MAINTAINERS
accordingly. I'll also keep maintaining user-space i2c-tools.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 MAINTAINERS |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 9 deletions(-)

--- linux-3.7-rc4.orig/MAINTAINERS	2012-11-05 16:35:07.797419133 +0100
+++ linux-3.7-rc4/MAINTAINERS	2012-11-05 17:00:25.958721344 +0100
@@ -3598,6 +3598,49 @@ F:	drivers/hid/hid-hyperv.c
 F:	drivers/net/hyperv/
 F:	drivers/staging/hv/
 
+I2C OVER PARALLEL PORT
+M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	Documentation/i2c/busses/i2c-parport
+F:	Documentation/i2c/busses/i2c-parport-light
+F:	drivers/i2c/busses/i2c-parport.c
+F:	drivers/i2c/busses/i2c-parport-light.c
+
+I2C/SMBUS CONTROLLER DRIVERS FOR PC
+M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	Documentation/i2c/busses/i2c-ali1535
+F:	Documentation/i2c/busses/i2c-ali1563
+F:	Documentation/i2c/busses/i2c-ali15x3
+F:	Documentation/i2c/busses/i2c-amd756
+F:	Documentation/i2c/busses/i2c-amd8111
+F:	Documentation/i2c/busses/i2c-i801
+F:	Documentation/i2c/busses/i2c-nforce2
+F:	Documentation/i2c/busses/i2c-piix4
+F:	Documentation/i2c/busses/i2c-sis5595
+F:	Documentation/i2c/busses/i2c-sis630
+F:	Documentation/i2c/busses/i2c-sis96x
+F:	Documentation/i2c/busses/i2c-via
+F:	Documentation/i2c/busses/i2c-viapro
+F:	drivers/i2c/busses/i2c-ali1535.c
+F:	drivers/i2c/busses/i2c-ali1563.c
+F:	drivers/i2c/busses/i2c-ali15x3.c
+F:	drivers/i2c/busses/i2c-amd756.c
+F:	drivers/i2c/busses/i2c-amd756-s4882.c
+F:	drivers/i2c/busses/i2c-amd8111.c
+F:	drivers/i2c/busses/i2c-i801.c
+F:	drivers/i2c/busses/i2c-isch.c
+F:	drivers/i2c/busses/i2c-nforce2.c
+F:	drivers/i2c/busses/i2c-nforce2-s4985.c
+F:	drivers/i2c/busses/i2c-piix4.c
+F:	drivers/i2c/busses/i2c-sis5595.c
+F:	drivers/i2c/busses/i2c-sis630.c
+F:	drivers/i2c/busses/i2c-sis96x.c
+F:	drivers/i2c/busses/i2c-via.c
+F:	drivers/i2c/busses/i2c-viapro.c
+
 I2C/SMBUS STUB DRIVER
 M:	"Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
@@ -3605,9 +3648,8 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-stub.c
 
 I2C SUBSYSTEM
-M:	"Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 M:	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
-M:	"Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 W:	http://i2c.wiki.kernel.org/
 T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
@@ -3618,6 +3660,13 @@ F:	drivers/i2c/
 F:	include/linux/i2c.h
 F:	include/linux/i2c-*.h
 
+I2C-TAOS-EVM DRIVER
+M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	Documentation/i2c/busses/i2c-taos-evm
+F:	drivers/i2c/busses/i2c-taos-evm.c
+
 I2C-TINY-USB DRIVER
 M:	Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
@@ -7887,13 +7936,6 @@ M:	Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
 S:	Maintained
 F:	drivers/net/ethernet/via/via-rhine.c
 
-VIAPRO SMBUS DRIVER
-M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-S:	Maintained
-F:	Documentation/i2c/busses/i2c-viapro
-F:	drivers/i2c/busses/i2c-viapro.c
-
 VIA SD/MMC CARD CONTROLLER DRIVER
 M:	Bruce Chang <brucechang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org>
 M:	Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>

-- 
Jean Delvare
