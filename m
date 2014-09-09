From: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: [PATCH] i2c-mxs: fixed PIO NACK error instead of timeout (1000ms)
Date: Tue,  9 Sep 2014 18:19:31 +0200
Message-ID: <1410279571-4552-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410279571-4552-1-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marex-ynQEQJNshbs@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2cdetect scanned i2c bus very slow if address was not occupied by any device.

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 87ee72d..35ae448 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -307,6 +307,10 @@ static int mxs_i2c_pio_wait_xfer_end(struct mxs_i2c_dev *i2c)
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
 	while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN) {
+		if (readl(i2c->regs + MXS_I2C_CTRL1) &
+				MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
+			return -ENXIO;
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 		cond_resched();
-- 
1.7.11.3
