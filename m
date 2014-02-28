From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] drivers: i2c: i2c-st: Fix return in case of arbitration lost
Date: Fri, 28 Feb 2014 13:52:56 +0100
Message-ID: <1393591976-10771-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch fixes the error returned to the i2c_transfer function
to -EAGAIN in case of arbitratin lost, so that the retry mechanism
can be used.

Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 9cf715d..8720161 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -574,7 +574,7 @@ static irqreturn_t st_i2c_isr_thread(int irq, void *data)
 		writel_relaxed(it, i2c_dev->base + SSC_IEN);
 
 		st_i2c_set_bits(i2c_dev->base + SSC_I2C, SSC_I2C_STOPG);
-		c->result = -EIO;
+		c->result = -EAGAIN;
 		break;
 
 	default:
-- 
1.9.0
