From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] i2c: i2c-s3c2410: Remove recently introduced performance overheads
Date: Wed, 21 Nov 2012 13:12:11 +0900
Message-ID: <1353471131-23975-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The changes in "i2c-s3c2410: use exponential back off while polling for
bus idle" remove the initial busy wait for I2C transfers to complete and
replace it with usleep_range() calls which will schedule.

Since for older SoCs I2C transfers would usually complete within an
extremely small number of CPU cycles there is a win from not having to
schedule.  This happens because on the older SoCs the cores run at a
smaller multiple of the speeds that the I2C bus is operating at; on more
modern SoCs the busy wait is less likely to be effective.

Fix the issue by restoring the busy wait, reducing the number of spins
from 20 to 3 which covers the overwhelming majority of I2C transfers on
the SoCs where the busy wait is effective.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 31f802b..25dc3e2 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -530,6 +530,7 @@ static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
 	unsigned long iicstat;
 	ktime_t start, now;
 	unsigned long delay;
+	int spins;
 
 	/* ensure the stop has been through the bus */
 
@@ -542,12 +543,23 @@ static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
 	 * end of a transaction.  However, really slow i2c devices can stretch
 	 * the clock, delaying STOP generation.
 	 *
-	 * As a compromise between idle detection latency for the normal, fast
-	 * case, and system load in the slow device case, use an exponential
-	 * back off in the polling loop, up to 1/10th of the total timeout,
-	 * then continue to poll at a constant rate up to the timeout.
+	 * On slower SoCs this typically happens within a very small number of
+	 * instructions so busy wait briefly to avoid scheduling overhead.
 	 */
+	spins = 3;
 	iicstat = readl(i2c->regs + S3C2410_IICSTAT);
+	while ((iicstat & S3C2410_IICSTAT_START) && --spins) {
+		cpu_relax();
+		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
+	}
+
+	/*
+	 * If we do get an appreciable delay as a compromise between idle
+	 * detection latency for the normal, fast case, and system load in the
+	 * slow device case, use an exponential back off in the polling loop,
+	 * up to 1/10th of the total timeout, then continue to poll at a
+	 * constant rate up to the timeout.
+	 */
 	delay = 1;
 	while ((iicstat & S3C2410_IICSTAT_START) &&
 	       ktime_us_delta(now, start) < S3C2410_IDLE_TIMEOUT) {
-- 
1.7.10.4
