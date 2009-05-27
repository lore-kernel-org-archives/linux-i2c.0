From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] Blackfin I2C/TWI Drivers: fix bug - not work well on BF537
Date: Wed, 27 May 2009 02:20:10 -0400
Message-ID: <1243405210-26227-4-git-send-email-vapier@gentoo.org>
References: <1243405210-26227-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243405210-26227-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Frank Shew <fshew-KZ3dJmXfLYruufBYgWm87A@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Frank Shew <fshew-KZ3dJmXfLYruufBYgWm87A@public.gmane.org>

We have a custom BF537 board with an I2C RTC (MAX DS3231) running
uclinux 2007R1 for some time. Recently during migration to 2008R1.5-RC3
we losted access to the RTC. The RTC driver calls 'i2c_transfer()' which
in turns calls 'bfin_twi_master_xfer()' in i2c-bfin-twi.c.

Compared with 2007R1, it looks like the 2008R1.5 version of i2c-bin-twi.c
has a new mode 'TWI_I2C-MODE_REPEAT' which corresponds to the Repeat Start
Condition described in the HRM. However, according to the HRM, at XMIT or
RECV interrupt and when the data count is 0, not only is the RESTART bit
supposed to be set, but MDIR must also be set if the next operation is a
receive sequence, and cleared if not. Currently there is no code that looks
at the I2C_M_RD bit in the flag from the next cur_msg and set/clear the MDIR
flag accordingly at the same time that the RSTART bit is set. Instead, MDIR
is set or cleared (by OR'ing with 0?) after the RESTART bit has been cleared
during handling of MCOMP interrupt.

It appears that this is causing our failure with reading the RTC, as a
quick patch to set/clear MDIR when RESTART is set seem to solve our problem.

Signed-off-by: Frank Shew <fshew-KZ3dJmXfLYruufBYgWm87A@public.gmane.org>
Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index fcdb460..f7c9793 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -104,9 +104,14 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 			write_MASTER_CTL(iface,
 				read_MASTER_CTL(iface) | STOP);
 		else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-				iface->cur_msg+1 < iface->msg_num)
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) | RSTART);
+		         iface->cur_msg + 1 < iface->msg_num) {
+			if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
+				write_MASTER_CTL(iface,
+					read_MASTER_CTL(iface) | RSTART | MDIR);
+			else
+				write_MASTER_CTL(iface,
+					(read_MASTER_CTL(iface) | RSTART) & ~MDIR);
+		}
 		SSYNC();
 		/* Clear status */
 		write_INT_STAT(iface, XMTSERV);
@@ -134,9 +139,13 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 				read_MASTER_CTL(iface) | STOP);
 			SSYNC();
 		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-				iface->cur_msg+1 < iface->msg_num) {
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) | RSTART);
+		           iface->cur_msg + 1 < iface->msg_num) {
+			if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
+				write_MASTER_CTL(iface,
+					read_MASTER_CTL(iface) | RSTART | MDIR);
+			else
+				write_MASTER_CTL(iface,
+					(read_MASTER_CTL(iface) | RSTART) & ~MDIR);
 			SSYNC();
 		}
 		/* Clear interrupt source */
-- 
1.6.3.1
