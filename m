From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 10:46:25 +0100
Message-ID: <1433526.P5A9cIEu1z@typ>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fixes: 5a6f1566f6a0 ("i2c: rk3x: handle dynamic clock rate changes correctly")

which introduced a dependency on clock rate notifiers. Now we get compiler
errors if compiled without COMMON_CLK:

drivers/i2c/busses/i2c-rk3x.c: In function 'rk3x_i2c_clk_notifier_cb':
drivers/i2c/busses/i2c-rk3x.c:634:7: error: 'PRE_RATE_CHANGE' undeclared (first use in this function)
[...]

But the driver has always depended on COMMON_CLK even if it compiled
 - in fact it fails to probe without it. So add that as a Kconfig
dependency.

Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---

Wolfram,

here is a version with better commit msg in case you still want to take that
instead of my quick fix.

Uwe, thanks for your comments!

Cheers,
  Max

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
