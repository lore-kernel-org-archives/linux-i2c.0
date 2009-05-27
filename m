From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] Blackfin I2C TWI Driver: fix bug - REPEAT START mode doesn't repeat
Date: Wed, 27 May 2009 02:20:09 -0400
Message-ID: <1243405210-26227-3-git-send-email-vapier@gentoo.org>
References: <1243405210-26227-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243405210-26227-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Avoid rewrite TWI MASTER_CTL reg when issue next message
In i2c repeat transfer mode, byte count of next message should be filled
into part of the TWI MASTER_CTL reg when interrupt MCOMP of last
message transfer is triggered. But, other bits in this reg should
not be touched.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 3ab1f66..fcdb460 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -196,8 +196,6 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 			/* remove restart bit and enable master receive */
 			write_MASTER_CTL(iface,
 				read_MASTER_CTL(iface) & ~RSTART);
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) | MEN | MDIR);
 			SSYNC();
 		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
 				iface->cur_msg+1 < iface->msg_num) {
@@ -222,18 +220,19 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 			}
 
 			if (iface->pmsg[iface->cur_msg].len <= 255)
-				write_MASTER_CTL(iface,
-				iface->pmsg[iface->cur_msg].len << 6);
+					write_MASTER_CTL(iface,
+					(read_MASTER_CTL(iface) &
+					(~(0xff << 6))) |
+				(iface->pmsg[iface->cur_msg].len << 6));
 			else {
-				write_MASTER_CTL(iface, 0xff << 6);
+				write_MASTER_CTL(iface,
+					(read_MASTER_CTL(iface) |
+					(0xff << 6)));
 				iface->manual_stop = 1;
 			}
 			/* remove restart bit and enable master receive */
 			write_MASTER_CTL(iface,
 				read_MASTER_CTL(iface) & ~RSTART);
-			write_MASTER_CTL(iface, read_MASTER_CTL(iface) |
-				MEN | ((iface->read_write == I2C_SMBUS_READ) ?
-				MDIR : 0));
 			SSYNC();
 		} else {
 			iface->result = 1;
-- 
1.6.3.1
