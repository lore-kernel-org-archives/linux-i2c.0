From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: [PATCH] i2c-cpm: Detect and report NAK right away instead of timing
 out.
Date: Fri, 31 Oct 2008 17:29:25 -0700
Message-ID: <490BA2E5.8010309@consentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Make the driver report an ENXIO error immediately upon NAK instead of
waiting for another interrupt and getting a timeout.

Signed-off-by: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
---
When reading from a device that is not present or declines to respond
to, e.g., a non-existent register address, CPM immediately reports a
NAK condition in the TxBD, but the driver kept waiting until a timeout,
which takes 1 second and causes an ugly console error message.

Index: linux/drivers/i2c/busses/i2c-cpm.c
===================================================================
retrieving revision 1.3
diff -u -p -r1.3 i2c-cpm.c
--- linux/drivers/i2c/busses/i2c-cpm.c	31 Oct 2008 06:36:08 -0000	1.3
+++ linux/drivers/i2c/busses/i2c-cpm.c	1 Nov 2008 00:12:45 -0000
@@ -369,6 +369,7 @@ static int cpm_i2c_xfer(struct i2c_adapt
 		pmsg = &msgs[tptr];
 		if (pmsg->flags & I2C_M_RD)
 			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
+				(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_NAK) ||
 				!(in_be16(&rbdf[rptr].cbd_sc) & BD_SC_EMPTY),
 				1 * HZ);
 		else
