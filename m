From: "Oskar Schirmer" <oskar@scara.com>
Subject: [PATCH] i2c/imx: fix imx driver to work though signal is pending
Date: 23 Feb 2012 12:19:11 +0000
Message-ID: <1329999551-32171-1-git-send-email-oskar@scara.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Darius Augulis <augulis.darius@gmail.com>, Oskar Schirmer <oskar@scara.com>
List-Id: linux-i2c@vger.kernel.org

Interrupt a test application for I2C based mc13xxx driven
touch panel, SIGINT, causes open event file descriptor to be
closed, which in turn causes I2C activity to mask PMIC local
interrupts. This eventually ends up in i2c_imx_bus_busy to
wait for some busy flag to toggle, but while waiting it would
find a signal pending and break. The final symptom is the
device is not closed down cleanly and thus not reopenable.

Do without check for pending signal.

Signed-off-by: Oskar Schirmer <oskar@scara.com>
---
 drivers/i2c/busses/i2c-imx.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 58832e5..124d9c5 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -149,11 +149,6 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 			break;
 		if (!for_busy && !(temp & I2SR_IBB))
 			break;
-		if (signal_pending(current)) {
-			dev_dbg(&i2c_imx->adapter.dev,
-				"<%s> I2C Interrupted\n", __func__);
-			return -EINTR;
-		}
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
-- 
1.7.5.4
