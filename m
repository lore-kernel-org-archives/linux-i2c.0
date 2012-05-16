From: <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/8] i2c: i2c-bfin-twi: Stop receiving operation immediately in last rx interrupt.
Date: Wed, 16 May 2012 15:20:20 +0800
Message-ID: <1337152826-9850-2-git-send-email-sonic.zhang@analog.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337152826-9850-1-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Also wake up waiting process when transfer completes.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

git-svn-id: svn://localhost/svn/linux-kernel/trunk@9105 526b6c2d-f592-4532-a319-5dd88ccb003d
---
 drivers/i2c/busses/i2c-bfin-twi.c |   43 ++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index e6dd3c9..376e331 100644
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
@@ -245,12 +249,13 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
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
@@ -264,8 +269,8 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 			write_INT_MASK(iface, 0);
 			write_MASTER_CTL(iface, 0);
 		}
+		complete(&iface->complete);
 	}
-	complete(&iface->complete);
 }
 
 /* Interrupt handler */
-- 
1.7.0.4
