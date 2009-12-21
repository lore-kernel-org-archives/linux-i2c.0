From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] i2c-bfin-twi: return completion in interrupt for smbus quick transfers
Date: Mon, 21 Dec 2009 09:28:33 -0500
Message-ID: <1261405713-7262-4-git-send-email-vapier@gentoo.org>
References: <1261405713-7262-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1261405713-7262-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

A smbus quick transfer has no data after the address byte.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index d157105..02a8c86 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -158,18 +158,14 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 		if (mast_stat & BUFWRERR)
 			dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
 
-		/* if both err and complete int stats are set, return proper
-		 * results.
+		/* If it is a quick transfer, only address without data,
+		 * not an err, return 1.
 		 */
-		if (twi_int_status & MCOMP) {
-			/* If it is a quick transfer, only address without data,
-			 * not an err, return 1.
-			 * If address is acknowledged return 1.
-			 */
-			if ((iface->writeNum == 0 && (mast_stat & BUFRDERR))
-				|| !(mast_stat & ANAK))
-				iface->result = 1;
-		}
+		if (iface->cur_mode == TWI_I2C_MODE_STANDARD &&
+			iface->transPtr == NULL &&
+			(twi_int_status & MCOMP) && (mast_stat & DNAK))
+			iface->result = 1;
+
 		complete(&iface->complete);
 		return;
 	}
-- 
1.6.5.4
