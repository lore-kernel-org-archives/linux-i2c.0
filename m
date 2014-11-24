From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 01:32:27 +0100
Message-ID: <1499103.qTrcqP28lh@typ>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now that we are using the clk notifier framework we get compile errors
without COMMON_CLK. But the driver fails to probe without COMMON_CLK
anyways, so just add that as a Kconfig dependency.

Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---

As reported by the kbuild test robot at Intel Open Source.

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a940e33..bb66119 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -720,7 +720,7 @@ config I2C_RIIC
 
 config I2C_RK3X
 	tristate "Rockchip RK3xxx I2C adapter"
-	depends on OF
+	depends on OF && COMMON_CLK
 	help
 	  Say Y here to include support for the I2C adapter in Rockchip RK3xxx
 	  SoCs.
-- 
1.9.1
