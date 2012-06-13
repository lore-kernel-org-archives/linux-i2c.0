From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/8 v2] i2c: i2c-bfin-twi: Improve the patch for bug "Illegal i2c bus lock upon certain transfer scenarios".
Date: Wed, 13 Jun 2012 16:22:41 +0800
Message-ID: <1339575767-22985-2-git-send-email-sonic.adi@gmail.com>
References: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339575767-22985-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

For transfer counts > 255 bytes i2c-bfin-twi sets the data
transfer counter DCNT to 0xFF indicating unlimited transfers.
It then uses a flag iface->manual_stop to manually issue the STOP
condition, once the required amount of bytes are received.

We found that on I2C receive operation issuing the STOP condition
together with a FULL RCV FIFO (2bytes) will cause SDA and SCL be
constantly driven low.

This patch stops receiving operation immediately in last rx interrupt.
This patch also wakes up waiting process when transfer completes.
Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   43 ++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 33031f0..dbe8fa0 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -130,21 +130,25 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 			}
 			iface->transPtr++;
 			iface->readNum--;
-		} else if (iface->manual_stop) {
-			/* Temporary workaround to avoid possible bus stall -
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
+				/* Temporary workaround to avoid possible bus stall -
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
