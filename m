From: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-pxa: fix scheduling while atomic in
	i2c_pxa_abort()
Date: Tue, 5 Aug 2008 15:17:11 +0400
Message-ID: <20080805111711.GA4807@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c_pxa_abort can be called from the atomic context.
Change it to use mdelay and counted loop.

Signed-off-by: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index dde6ce9..9a0f788 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -188,14 +188,14 @@ static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 
 static void i2c_pxa_abort(struct pxa_i2c *i2c)
 {
-	unsigned long timeout = jiffies + HZ/4;
+	int i = 250;
 
 	if (i2c_pxa_is_slavemode(i2c)) {
 		dev_dbg(&i2c->adap.dev, "%s: called in slave mode\n", __func__);
 		return;
 	}
 
-	while (time_before(jiffies, timeout) && (readl(_IBMR(i2c)) & 0x1) == 0) {
+	while ((i > 0) && (readl(_IBMR(i2c)) & 0x1) == 0) {
 		unsigned long icr = readl(_ICR(i2c));
 
 		icr &= ~ICR_START;
@@ -205,7 +205,8 @@ static void i2c_pxa_abort(struct pxa_i2c *i2c)
 
 		show_state(i2c);
 
-		msleep(1);
+		mdelay(1);
+		i --;
 	}
 
 	writel(readl(_ICR(i2c)) & ~(ICR_MA | ICR_START | ICR_STOP),
-- 
1.5.6.3


-- 
With best wishes
Dmitry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
