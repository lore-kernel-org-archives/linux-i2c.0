From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/3 v2] Blackfin I2C/TWI Driver: make sure we don't end up with a CLKDIV=0
Date: Mon,  1 Jun 2009 01:37:50 -0400
Message-ID: <1243834670-32610-1-git-send-email-vapier@gentoo.org>
References: <20090527070542.GA3085@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090527070542.GA3085-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Make sure we don't end up with an invalid CLKDIV=0 in case someone
specifies 20kHz SCL or less (5 * 1024 / 20 = 0x100).

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
v2
	- fixup comment grammar pointed out by Wolfram Sang

 drivers/i2c/busses/Kconfig        |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c |   11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7f95905..1fbfd98 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -297,7 +297,7 @@ config I2C_BLACKFIN_TWI
 config I2C_BLACKFIN_TWI_CLK_KHZ
 	int "Blackfin TWI I2C clock (kHz)"
 	depends on I2C_BLACKFIN_TWI
-	range 10 400
+	range 21 400
 	default 50
 	help
 	  The unit of the TWI clock is kHz.
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 3c855ff..ea97723 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -614,6 +614,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	struct i2c_adapter *p_adap;
 	struct resource *res;
 	int rc;
+	unsigned int clkhilow;
 
 	iface = kzalloc(sizeof(struct bfin_twi_iface), GFP_KERNEL);
 	if (!iface) {
@@ -676,10 +677,14 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	/* Set TWI internal clock as 10MHz */
 	write_CONTROL(iface, ((get_sclk() / 1024 / 1024 + 5) / 10) & 0x7F);
 
+	/*
+	 * We will not end up with a CLKDIV=0 because no one will specify
+	 * 20kHz SCL or less in Kconfig now. (5 * 1024 / 20 = 0x100)
+	 */
+	clkhilow = 5 * 1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ;
+
 	/* Set Twi interface clock as specified */
-	write_CLKDIV(iface, ((5*1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ)
-			<< 8) | ((5*1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ)
-			& 0xFF));
+	write_CLKDIV(iface, (clkhilow << 8) | clkhilow);
 
 	/* Enable TWI */
 	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
-- 
1.6.3.1
