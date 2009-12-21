From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] i2c-bfin-twi: fix CLKDIV calculation
Date: Mon, 21 Dec 2009 09:28:30 -0500
Message-ID: <1261405713-7262-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Calculation of the CLKDIV speed setting should be done using base 10 math
rather than base 2.  We also avoid exceeding the spec due to integer
truncation and a 50% duty cycle.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index a0efdab..758bb1f 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -712,13 +712,13 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	}
 
 	/* Set TWI internal clock as 10MHz */
-	write_CONTROL(iface, ((get_sclk() / 1024 / 1024 + 5) / 10) & 0x7F);
+	write_CONTROL(iface, ((get_sclk() / 1000 / 1000 + 5) / 10) & 0x7F);
 
 	/*
 	 * We will not end up with a CLKDIV=0 because no one will specify
-	 * 20kHz SCL or less in Kconfig now. (5 * 1024 / 20 = 0x100)
+	 * 20kHz SCL or less in Kconfig now. (5 * 1000 / 20 = 250)
 	 */
-	clkhilow = 5 * 1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ;
+	clkhilow = ((10 * 1000 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ) + 1) / 2;
 
 	/* Set Twi interface clock as specified */
 	write_CLKDIV(iface, (clkhilow << 8) | clkhilow);
-- 
1.6.5.4
