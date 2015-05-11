From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] i2c: rk3x: Increase wait timeout to 1 second
Date: Mon, 11 May 2015 12:44:28 -0700
Message-ID: <1431373468-18302-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Although unlikely, it is remotely possible for an i2c command to need
more than 200ms complete. Unlike smbus, i2c devices can clock stretch
for an unspecified amount of time. The longest time I've seen
specified for a device is 144ms (bq27541 battery gas), but one could
imagine a device taking a bit slower. 1 second "ought to be enough for
anyone."

The above is not the only justifcation for going above 200ms for a
timeout, though.  It turns out that if you've got a large number of
printks going out to a serial console, interrupts on a CPU can be
disabled for hundreds of milliseconds. That's not a great situation to
be in to start with (maybe we should put a cap in vprintk_emit()) but
it's pretty annoying to start seeing unexplained i2c timeouts.

Note that to understand why we can timeout when printk has interrupts
disabled, you need to understand that on current Linux ARM kernels
interrupts are routed to a single CPU in a multicore system. Thus,
you can get:

1. CPU1 is running rk3x_i2c_xfer()
2. CPU0 calls vprintk_emit(), which disables all IRQs on CPU0.
3. I2C interrupt is ready but is set to only run on CPU0, where IRQs
   are disabled.
4. CPU1 timeout expires. I2C interrupt is still ready, but CPU0 is
   still sitting in the same vprintk_emit()
5. CPU1 sees that no interrupt happened in 200ms, so timeout.

A normal system shouldn't see i2c timeouts anyway, so increasing the
timeout should help people debugging without hurting other people
excessively.

Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v2:
- Update commit message as per Uwe

 drivers/i2c/busses/i2c-rk3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 019d542..72e97e30 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -72,7 +72,7 @@ enum {
 #define REG_INT_ALL       0x7f
 
 /* Constants */
-#define WAIT_TIMEOUT      200 /* ms */
+#define WAIT_TIMEOUT      1000 /* ms */
 #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
 
 enum rk3x_i2c_state {
-- 
2.2.0.rc0.207.ga3a616c
