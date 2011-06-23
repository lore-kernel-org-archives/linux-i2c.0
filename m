From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c-bfin-twi: abort transfer is MEM bit is reset unexpectedly
Date: Thu, 23 Jun 2011 17:07:54 -0400
Message-ID: <1308863274-29189-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Sometimes, the first I2C transmit interrupt is not serviced in time (like
when higher priority interrupts take too long).  Since the RESTART bit is
not set before the next I2C clock, when the TWI handler is finally called,
the I2C session is aborted (MEM bit is reset) and both SMITSERV and MCOMP
int status bits are set.

So when this happens, abort the transfer.

Reported-by: Isabelle Leonardi <i.leonardi-EsGXWSsajDBWj0EZb7rXcA@public.gmane.org>
Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index f2628a7..fcb041d 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -201,7 +201,13 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 		return;
 	}
 	if (twi_int_status & MCOMP) {
-		if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
+		if ((read_MASTER_CTL(iface) & MEN) == 0 &&
+			(iface->cur_mode == TWI_I2C_MODE_REPEAT ||
+			iface->cur_mode == TWI_I2C_MODE_COMBINED)) {
+			iface->result = -1;
+			write_INT_MASK(iface, 0);
+			write_MASTER_CTL(iface, 0);
+		} else if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
 			if (iface->readNum == 0) {
 				/* set the read number to 1 and ask for manual
 				 * stop in block combine mode
-- 
1.7.5.3
