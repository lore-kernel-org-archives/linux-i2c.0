From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] drivers: i2c-gpio: move initialization code subsys_initcall()
Date: Thu, 01 Apr 2010 15:43:19 +0200
Message-ID: <1270129399-30365-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

GPIO driven I2C bus can be used for controlling the PMIC chip. The example
of such configuration is Samsung Aquila board.

This patch moves initialization code subsys_initcall() to ensure that the i2c
bus is available early so the regulators can be quicly probed and available for
other devices on their probe() call.

Such solution has been proposed by Mark Brown to fix the problem of the
regulators not beeing available on the peripheral device probe():
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.html

CC: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

---
 drivers/i2c/busses/i2c-gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 32104ea..bb1a1a8 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -210,7 +210,7 @@ static int __init i2c_gpio_init(void)
 
 	return ret;
 }
-module_init(i2c_gpio_init);
+subsys_initcall(i2c_gpio_init);
 
 static void __exit i2c_gpio_exit(void)
 {
-- 
1.6.4
