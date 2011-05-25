From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] i2c-bfin-twi: work around illegal i2c bus lock with long transfers
Date: Wed, 25 May 2011 16:26:35 -0400
Message-ID: <1306355198-18530-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

For transfer counts > 255 bytes, the Blackfin TWI peripheral sets the
data transfer counter DCNT to 0xFF indicating unlimited transfers.  It
then uses a flag iface->manual_stop to manually issue the STOP condition
once the required amount of bytes are received.

It seems that if the STOP condition is issued with a full receive fifo,
the TWI logic constantly drives the SDA/SCL lines low thus locking the
bus.  So to make sure this doesn't happen, consume the fifo first.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 52b545a..5ed6c2f 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -131,6 +131,10 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 			iface->transPtr++;
 			iface->readNum--;
 		} else if (iface->manual_stop) {
+			/* Avoid possible bus stall -
+			 * Flush FIFO before issuing the STOP condition
+			 */
+			read_RCV_DATA16(iface);
 			write_MASTER_CTL(iface,
 				read_MASTER_CTL(iface) | STOP);
 		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-- 
1.7.5.rc3
