From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c:i2c-bfin-twi: Read and write the FIFO in loop.
Date: Tue, 28 May 2013 18:41:09 +0800
Message-ID: <1369737669-14226-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: buildroot-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Reported-by: Bob Maris <mail-qjpqXGGzJR7sq35pWSNszA@public.gmane.org>

TWI transfer interrupts may be lost when system is heavily handling other
interrupts, while current transfer handler depends on each accurate interrupt
and misses some data in this case. Because there are 2 2-byte FIFOs in blackfin
TWI controller, the occurrence of the data loss can be reduced by reading till
the RX FIFO is empty and writing till the TX FIFO is full.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 05080c4..13ea1c2 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -39,33 +39,40 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 	unsigned short mast_stat = read_MASTER_STAT(iface);
 
 	if (twi_int_status & XMTSERV) {
+		if (iface->writeNum <= 0) {
+			/* start receive immediately after complete sending in
+			 * combine mode.
+			 */
+			if (iface->cur_mode == TWI_I2C_MODE_COMBINED)
+				write_MASTER_CTL(iface,
+					read_MASTER_CTL(iface) | MDIR);
+			else if (iface->manual_stop)
+				write_MASTER_CTL(iface,
+					read_MASTER_CTL(iface) | STOP);
+			else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
+				iface->cur_msg + 1 < iface->msg_num) {
+				if (iface->pmsg[iface->cur_msg + 1].flags &
+					I2C_M_RD)
+					write_MASTER_CTL(iface,
+						read_MASTER_CTL(iface) |
+						MDIR);
+				else
+					write_MASTER_CTL(iface,
+						read_MASTER_CTL(iface) &
+						~MDIR);
+			}
+		}
 		/* Transmit next data */
-		if (iface->writeNum > 0) {
+		while (iface->writeNum > 0 &&
+			(read_FIFO_STAT(iface) & XMTSTAT) != XMT_FULL) {
 			SSYNC();
 			write_XMT_DATA8(iface, *(iface->transPtr++));
 			iface->writeNum--;
 		}
-		/* start receive immediately after complete sending in
-		 * combine mode.
-		 */
-		else if (iface->cur_mode == TWI_I2C_MODE_COMBINED)
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) | MDIR);
-		else if (iface->manual_stop)
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) | STOP);
-		else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-		         iface->cur_msg + 1 < iface->msg_num) {
-			if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) | MDIR);
-			else
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) & ~MDIR);
-		}
 	}
 	if (twi_int_status & RCVSERV) {
-		if (iface->readNum > 0) {
+		while (iface->readNum > 0 &&
+			(read_FIFO_STAT(iface) & RCVSTAT)) {
 			/* Receive next data */
 			*(iface->transPtr) = read_RCV_DATA8(iface);
 			if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
-- 
1.8.2.3
