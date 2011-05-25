From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] i2c-bfin-twi: stop receive operation after last byte rx interrupt
Date: Wed, 25 May 2011 16:26:36 -0400
Message-ID: <1306355198-18530-2-git-send-email-vapier@gentoo.org>
References: <1306355198-18530-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306355198-18530-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Once the last byte has been received, we can then move on to further
processing of the transfer rather than delaying.  This improves the
response times with long transfers.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   41 ++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 5ed6c2f..aaabd5d 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -130,21 +130,25 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 			}
 			iface->transPtr++;
 			iface->readNum--;
-		} else if (iface->manual_stop) {
-			/* Avoid possible bus stall -
-			 * Flush FIFO before issuing the STOP condition
-			 */
-			read_RCV_DATA16(iface);
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) | STOP);
-		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-		           iface->cur_msg + 1 < iface->msg_num) {
-			if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) | RSTART | MDIR);
-			else
+		}
+
+		if (iface->readNum == 0) {
+			if (iface->manual_stop) {
+				/* Avoid possible bus stall -
+				 * Flush FIFO before issuing the STOP condition
+				 */
+				read_RCV_DATA16(iface);
 				write_MASTER_CTL(iface,
-					(read_MASTER_CTL(iface) | RSTART) & ~MDIR);
+					read_MASTER_CTL(iface) | STOP);
+			} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
+					iface->cur_msg + 1 < iface->msg_num) {
+				if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
+					write_MASTER_CTL(iface,
+						read_MASTER_CTL(iface) | RSTART | MDIR);
+				else
+					write_MASTER_CTL(iface,
+						(read_MASTER_CTL(iface) | RSTART) & ~MDIR);
+			}
 		}
 	}
 	if (twi_int_status & MERR) {
@@ -239,12 +243,13 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 				}
 			}
 
-			if (iface->pmsg[iface->cur_msg].len <= 255)
-					write_MASTER_CTL(iface,
+			if (iface->pmsg[iface->cur_msg].len <= 255) {
+				write_MASTER_CTL(iface,
 					(read_MASTER_CTL(iface) &
 					(~(0xff << 6))) |
-				(iface->pmsg[iface->cur_msg].len << 6));
-			else {
+					(iface->pmsg[iface->cur_msg].len << 6));
+				iface->manual_stop = 0;
+			} else {
 				write_MASTER_CTL(iface,
 					(read_MASTER_CTL(iface) |
 					(0xff << 6)));
-- 
1.7.5.rc3
